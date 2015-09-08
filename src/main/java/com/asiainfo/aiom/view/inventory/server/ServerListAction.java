/**
 * @File: ServerListAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server
 * @Description: 
 * @author luyang
 * @date 2015年8月24日 上午10:57:24 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.Constants;
import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -403161747063312467L;
	
	private ServerApi serverApi;
	private List<Server> servers;
	
	public void setServers(List<Server> servers)
	{
		this.servers = servers;
	}

	public List<Server> getServers()
	{
		return servers;
	}
	
	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}
	
	public String listServerOutOfMachine()
	{
		List<Server> serverInDbs = new ArrayList<Server>();
		servers	= serverApi.listServers();
		for (Server server : servers)
		{
			if (server.getProperties() == null || !server.getProperties().containsKey("machineId"))
			{
				serverInDbs.add(server);
			}
		}
		servers = serverInDbs;
		return SUCCESS;
	}
	
	public String execute()
	{
		Machine machineSelected = (Machine) session.get("machine");
		servers = serverApi.listServers();
		for (Iterator<Server> iterator = servers.iterator(); iterator.hasNext();)
		{
			Server server = (Server) iterator.next();
			if (server.getProperties() == null || !StringUtils.equals(server.getProperties().get("machineId"), machineSelected.getId().toString()))
			{
				iterator.remove();
			}
			else if(server.getMonitorType() == Constants.MonitorType.ICMP || server.getServerRuntime() == null 
					|| server.getServerRuntime().getMetrics() == null)
			{
				server.getProperties().put("cpuRate", "N/A");
				server.getProperties().put("memoryRate", "N/A");
				server.getProperties().put("diskRate", "N/A");
			}
			else
			{
				Map<String, Metric> metrics = server.getServerRuntime().getMetrics();
				
				// cpu使用率
				int cpuIdle = ((Double) metrics.get("cpu_idle").getValue()).intValue();
				int cpuRate = 100 - cpuIdle;
				server.getProperties().put("cpuRate", String.valueOf(cpuRate));
				
				// 内存使用率
				double memTotal = (double) metrics.get("mem_total").getValue();
				double memFree = (double) metrics.get("mem_free").getValue();
				double memUsed = memTotal - memFree;
				int memoryRate = (int) (memUsed / memTotal * 100);
				server.getProperties().put("memoryRate", String.valueOf(memoryRate));
				
				// 磁盘
				double diskTotle = (double) metrics.get("disk_total").getValue();
				double diskFree = (double) metrics.get("disk_free").getValue();
				double diskUsed = diskTotle - diskFree;
				int diskRate = (int) (diskUsed / diskTotle * 100);
				server.getProperties().put("diskRate", String.valueOf(diskRate));
			}
		}
		return SUCCESS;
	}
	
}
