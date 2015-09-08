/**   
 * @Title: ServerSummaryLoadAction.java 
 * @Package com.asiainfo.aiom.view.inventory.rackview 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年9月7日 上午11:35:20 
 * @version V1.0   
 */
package com.asiainfo.aiom.view.inventory.rackview;

import java.util.Map;

import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class ServerSummaryLoadAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -6039715789250603294L;

	private ServerApi serverApi;
	private Server server;

	public Server getServer()
	{
		return server;
	}

	public void setServer(Server server)
	{
		this.server = server;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		server = serverApi.findServerById(server.getId());

		Map<String, Metric> metrics = server.getServerRuntime().getMetrics();
		if (metrics == null || metrics.size() == 0)
		{
			server.getProperties().put("cpuRate", "N/A");
			server.getProperties().put("memoryRate", "N/A");
			server.getProperties().put("diskRate", "N/A");
		}
		else
		{
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
		
		return SUCCESS;
	}
}
