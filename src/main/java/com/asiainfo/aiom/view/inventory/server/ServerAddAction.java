/**
 * @File: ServerAddAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server
 * @Description: 
 * @author luyang
 * @date 2015年8月24日 下午4:46:47 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerAddAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -941806903659984705L;
	
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
		Machine machineSelected = (Machine) session.get("machine");
		server.getProperties().put("machineId", machineSelected.getId().toString());
		
		server = serverApi.addServer(server);
		return SUCCESS;
	}
	
	public String serverAddByExist()
	{
		Machine machineSelected = (Machine) session.get("machine");
		
		String moduleId = server.getProperties().get("moduleId");
		String[] ids = StringUtils.split(server.getId(), ",");
		
		for (String id : ids)
		{
			Server serverInDb = serverApi.findServerById(StringUtils.trim(id));
			Map<String, String> properties = serverInDb.getProperties();
			if (properties == null)
			{
				properties = new HashMap<String, String>();
				serverInDb.setProperties(properties);
			}
			properties.put("moduleId", moduleId);
			properties.put("machineId", machineSelected.getId().toString());
			
			serverApi.updateServer(serverInDb);
		}
		return SUCCESS;
	}
}
