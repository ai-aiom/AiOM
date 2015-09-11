/**
 * @File: ServerMemoryTopViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月9日 下午5:10:07 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.overview.serverview;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerMemoryTopViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -6641598414076184171L;

	private ServerApi serverApi;

	private List<Server> servers;

	public List<Server> getServers()
	{
		return servers;
	}

	public void setServers(List<Server> servers)
	{
		this.servers = servers;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		servers = serverApi.listServers();
		Machine machine = (Machine) session.get("machine");
		servers = ServerFilterAndSorter.filterByMachine(servers, machine);

		Collections.sort(servers, new Comparator<Server>()
		{
			public int compare(Server server1, Server server2)
			{
				if (server1.getServerRuntime().getMetrics() == null
						|| !server1.getServerRuntime().getMetrics().containsKey("mem_total")
						|| !server1.getServerRuntime().getMetrics().containsKey("mem_free"))
				{
					return 1;
				}
				else if (server2.getServerRuntime().getMetrics() == null
						|| !server2.getServerRuntime().getMetrics().containsKey("mem_total")
						|| !server2.getServerRuntime().getMetrics().containsKey("mem_free"))
				{
					return -1;
				}
				else
				{
					double memTotal1 = (double) server1.getServerRuntime().getMetrics().get("mem_total").getValue();
					double memFree1 = (double) server1.getServerRuntime().getMetrics().get("mem_free").getValue();
					double memUsed1 = memTotal1 - memFree1;
					int memoryRate1 = (int) (memUsed1 / memTotal1 * 100);

					double memTotal2 = (double) server2.getServerRuntime().getMetrics().get("mem_total").getValue();
					double memFree2 = (double) server2.getServerRuntime().getMetrics().get("mem_free").getValue();
					double memUsed2 = memTotal2 - memFree2;
					int memoryRate2 = (int) (memUsed2 / memTotal2 * 100);

					return memoryRate2 - memoryRate1;
				}
			}
		});

		if (servers.size() > 5)
		{
			servers = servers.subList(0, 5);
		}

		for (Server server : servers)
		{
			if (server.getServerRuntime().getMetrics() != null
					&& server.getServerRuntime().getMetrics().containsKey("mem_total")
					&& server.getServerRuntime().getMetrics().containsKey("mem_free"))
			{
				double memTotal = (double) server.getServerRuntime().getMetrics().get("mem_total").getValue();
				double memFree = (double) server.getServerRuntime().getMetrics().get("mem_free").getValue();
				double memUsed = memTotal - memFree;
				int memoryRate = (int) (memUsed / memTotal * 100);
				server.getProperties().put("memoryRate", String.valueOf(memoryRate));
			}
		}

		return SUCCESS;
	}
}
