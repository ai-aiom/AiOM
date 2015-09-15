/**
 * @File: ServerNetworkTopViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月10日 上午11:22:40 
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
public class ServerNetworkTopViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 5867543058218627863L;

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
						|| !server1.getServerRuntime().getMetrics().containsKey("bytes_out")
						|| !server1.getServerRuntime().getMetrics().containsKey("bytes_in"))
				{
					return -1;
				}
				else if (server2.getServerRuntime().getMetrics() == null
						|| !server2.getServerRuntime().getMetrics().containsKey("bytes_out")
						|| !server2.getServerRuntime().getMetrics().containsKey("bytes_in"))
				{
					return 1;
				}
				else
				{
					double bytesIn1 = (double) server1.getServerRuntime().getMetrics().get("bytes_out").getValue();
					double bytesOut1 = (double) server1.getServerRuntime().getMetrics().get("bytes_in").getValue();
					double bytesTotal1 = bytesIn1 + bytesOut1;

					double bytesIn2 = (double) server2.getServerRuntime().getMetrics().get("bytes_out").getValue();
					double bytesOut2 = (double) server2.getServerRuntime().getMetrics().get("bytes_in").getValue();
					double bytesTotal2 = bytesIn2 + bytesOut2;

					return bytesTotal1 > bytesTotal2 ? 1 : -1;
				}
			}
		});

		Collections.reverse(servers);
		
		if (servers.size() > 5)
		{
			servers = servers.subList(0, 5);
		}

		return SUCCESS;
	}
}
