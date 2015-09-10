/**
 * @File: ServerLoadTopViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月10日 下午2:15:20 
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
public class ServerLoadTopViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -7730115074620725318L;
	
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
						|| !server1.getServerRuntime().getMetrics().containsKey("load_five")
						|| !server1.getServerRuntime().getMetrics().containsKey("load_fifteen")
						|| !server1.getServerRuntime().getMetrics().containsKey("load_one"))
				{
					return 1;
				}
				else if (server2.getServerRuntime().getMetrics() == null
						|| !server2.getServerRuntime().getMetrics().containsKey("load_five")
						|| !server2.getServerRuntime().getMetrics().containsKey("load_fifteen")
						|| !server2.getServerRuntime().getMetrics().containsKey("load_one"))
				{
					return -1;
				}
				else
				{
					double loadFifteen1 = (double) server1.getServerRuntime().getMetrics().get("load_fifteen").getValue();

					double loadFifteen2 = (double) server2.getServerRuntime().getMetrics().get("load_fifteen").getValue();

					return loadFifteen1 > loadFifteen2 ? -1 : 1;
				}
			}
		});

		if (servers.size() > 5)
		{
			servers = servers.subList(0, 5);
		}

		return SUCCESS;
	}
}
