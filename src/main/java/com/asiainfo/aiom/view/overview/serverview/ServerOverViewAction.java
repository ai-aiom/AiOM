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

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
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
	
	private Map<String, Integer> properties = new HashMap<String, Integer>();
	
	public Map<String, Integer> getProperties()
	{
		return properties;
	}

	public void setProperties(Map<String, Integer> properties)
	{
		this.properties = properties;
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
		
		int statusOn = 0;
		int statusOff = 0;
		for (Server s : servers)
		{
			if (s.getServerRuntime() != null && s.getServerRuntime().getStatus() == 1)
			{
				statusOn++ ;
			}
			else
			{
				statusOff++;
			}
		}
		
		properties.put("statusOn", statusOn);
		properties.put("statusOff", statusOff);
		
		return SUCCESS;
	}
}
