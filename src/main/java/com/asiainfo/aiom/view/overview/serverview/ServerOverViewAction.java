/**
 * @File: ServerOverViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月9日 下午3:05:10 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.overview.serverview;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.aiom.Constants;
import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerOverViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 6735652189422443541L;

	private ServerApi serverApi;

	private Map<String, int[]> rates = new HashMap<String, int[]>();
	
	public Map<String, int[]> getRates()
	{
		return rates;
	}

	public void setRates(Map<String, int[]> rates)
	{
		this.rates = rates;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		List<Server> servers = serverApi.listServers();
		Machine machine = (Machine) session.get("machine");
		servers = ServerFilterAndSorter.filterByMachine(servers, machine);

		/**
		 *  serverStatus[0] 存状态正常的服务器数量
		 *  serverStatus[1] 存状态不可达的服务器数量
		 */
		int[] serverStatus = new int[2];
		int[] serverPowerStatus = new int[4];
		int[] cpuRate = new int[5];
		int[] memoryRate = new int[5];
		int[] diskRate = new int[5];
		
		for (Server server : servers)
		{
			if (server.getPowerStatus() != null)
			{
				serverPowerStatus[server.getPowerStatus()]++;
			}

			if (server.getServerRuntime() != null && server.getServerRuntime().getStatus() == 1)
			{
				serverStatus[0]++;
			}
			else
			{
				serverStatus[1]++;
			}
			
			if (server.getMonitorType() == Constants.MonitorType.ICMP || server.getServerRuntime() == null
					|| server.getServerRuntime().getMetrics() == null)
			{
				cpuRate[0]++;
				memoryRate[0]++;
				diskRate[0]++;
			}
			else
			{
				Map<String, Metric> metrics = server.getServerRuntime().getMetrics();

				// cpu使用率
				int cpuIdle = ((Double) metrics.get("cpu_idle").getValue()).intValue();
				int cpuRateOne = 100 - cpuIdle;
				
				getNumOfRate(cpuRateOne, cpuRate);
				
				// 内存使用率
				double memTotal = (double) metrics.get("mem_total").getValue();
				double memFree = (double) metrics.get("mem_free").getValue();
				double memUsed = memTotal - memFree;
				int memoryRateOne = (int) (memUsed / memTotal * 100);

				getNumOfRate(memoryRateOne, memoryRate);
				
				// 磁盘使用率
				double diskTotal = (double) metrics.get("disk_total").getValue();
				double diskFree = (double) metrics.get("disk_free").getValue();
				double diskUsed = diskTotal - diskFree;
				int diskRateOne = (int) (diskUsed / diskTotal * 100);
				
				getNumOfRate(diskRateOne, diskRate);
			}
		}

		rates.put("serverStatus", serverStatus);
		rates.put("serverPowerStatus", serverPowerStatus);
		rates.put("cpuRate", cpuRate);
		rates.put("memoryRate", memoryRate);
		rates.put("diskRate", diskRate);
		
		return SUCCESS;
	}
	
	private void getNumOfRate(int rate, int[] num)
	{
		if (rate <= 20)
		{
			num[0]++;
		}
		else if (rate <= 40)
		{
			num[1]++;
		}
		else if (rate <= 60)
		{
			num[2]++;
		}
		else if (rate <= 80)
		{
			num[3]++;
		}
		else
		{
			num[4]++;
		}
	}
}
