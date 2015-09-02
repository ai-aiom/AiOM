/**
 * @File: ServerSummaryAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月1日 上午9:46:55 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.asiainfo.aiom.Constants;
import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummaryAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 909337154775659389L;
	
	private ServerApi serverApi;
	
	private CabinetApi cabinetApi;
	
	private Server server;
	
	private String serverId;

	public Server getServer()
	{
		return server;
	}

	public void setServer(Server server)
	{
		this.server = server;
	}

	public String getServerId()
	{
		return serverId;
	}

	public void setServerId(String serverId)
	{
		this.serverId = serverId;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}
	
	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}

	public String execute()
	{
		server = serverApi.findServerById(serverId);
		if (server.getMonitorType() == Constants.MonitorType.ICMP || server.getServerRuntime() == null 
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
			
			// 磁盘使用率
			double diskTotal = (double) metrics.get("disk_total").getValue();
			double diskFree = (double) metrics.get("disk_free").getValue();
			double diskUsed = diskTotal - diskFree;
			int diskRate = (int) (diskUsed / diskTotal * 100);
			server.getProperties().put("diskRate", String.valueOf(diskRate));
			
			// 启动时间
			Double boottime = (Double) metrics.get("boottime").getValue();
			boottime = boottime * 1000;
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			server.getProperties().put("boottime", sdf.format(boottime));
			
			//运行时间
			Date getTime = metrics.get("boottime").getTime();
			long runTime = getTime.getTime() - boottime.longValue();
			SimpleDateFormat sdf2 = new SimpleDateFormat("dd日 HH时mm分ss秒");
			server.getProperties().put("runtime", sdf2.format(runTime));
		}
		
		if (server.getSite() != null && server.getSite().getRack() != null)
		{
			Cabinet cabinet = cabinetApi.findCabinetById(server.getSite().getRack());
			server.getProperties().put("cabinetName", cabinet.getName());
		}
		return SUCCESS;
	}
}
