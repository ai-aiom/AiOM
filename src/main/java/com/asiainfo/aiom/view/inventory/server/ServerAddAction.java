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
}
