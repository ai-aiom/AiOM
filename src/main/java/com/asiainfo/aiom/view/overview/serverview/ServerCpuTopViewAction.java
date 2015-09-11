/**
 * @File: ServerCpuTopViewAction.java 
 * @Package  com.asiainfo.aiom.view.overview.serverview
 * @Description: 
 * @author luyang
 * @date 2015年9月9日 下午2:00:52 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.overview.serverview;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.lang.math.NumberUtils;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerCpuTopViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 46245700387558956L;

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
						|| !server1.getServerRuntime().getMetrics().containsKey("cpu_idle"))
				{
					return -1;
				}
				else if (server2.getServerRuntime().getMetrics() == null
						|| !server2.getServerRuntime().getMetrics().containsKey("cpu_idle"))
				{
					return 1;
				}
				else
				{
					float cpuIdle1 = NumberUtils.toFloat(String.valueOf(server1.getServerRuntime().getMetrics()
							.get("cpu_idle").getValue()));
					float cpuIdle2 = NumberUtils.toFloat(String.valueOf(server2.getServerRuntime().getMetrics()
							.get("cpu_idle").getValue()));
					return cpuIdle1 > cpuIdle2 ? -1 : 1;
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
