/**
 * @File: ServerDiskTopViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月10日 上午10:57:29 
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
public class ServerDiskTopViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 2850461489578473385L;

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
						|| !server1.getServerRuntime().getMetrics().containsKey("disk_total")
						|| !server1.getServerRuntime().getMetrics().containsKey("disk_free"))
				{
					return -1;
				}
				else if (server2.getServerRuntime().getMetrics() == null
						|| !server2.getServerRuntime().getMetrics().containsKey("disk_total")
						|| !server2.getServerRuntime().getMetrics().containsKey("disk_free"))
				{
					return 1;
				}
				else
				{
					double diskTotal1 = (double) server1.getServerRuntime().getMetrics().get("disk_total").getValue();
					double diskFree1 = (double) server1.getServerRuntime().getMetrics().get("disk_free").getValue();
					double diskUsed1 = diskTotal1 - diskFree1;
					int diskRate1 = (int) (diskUsed1 / diskTotal1 * 100);

					double diskTotal2 = (double) server2.getServerRuntime().getMetrics().get("disk_total").getValue();
					double diskFree2 = (double) server2.getServerRuntime().getMetrics().get("disk_free").getValue();
					double diskUsed2 = diskTotal2 - diskFree2;
					int diskRate2 = (int) (diskUsed2 / diskTotal2 * 100);

					return diskRate1 - diskRate2;
				}
			}
		});

		Collections.reverse(servers);
		
		if (servers.size() > 5)
		{
			servers = servers.subList(0, 5);
		}

		for (Server server : servers)
		{
			if (server.getServerRuntime().getMetrics() != null
					&& server.getServerRuntime().getMetrics().containsKey("disk_total")
					&& server.getServerRuntime().getMetrics().containsKey("disk_free"))
			{
				double diskTotal = (double) server.getServerRuntime().getMetrics().get("disk_total").getValue();
				double diskFree = (double) server.getServerRuntime().getMetrics().get("disk_free").getValue();
				double diskUsed = diskTotal - diskFree;
				int diskRate = (int) (diskUsed / diskTotal * 100);
				server.getProperties().put("diskRate", String.valueOf(diskRate));
			}
		}
		
		return SUCCESS;
	}
}
