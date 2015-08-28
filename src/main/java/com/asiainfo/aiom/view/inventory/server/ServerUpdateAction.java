/**
 * @File: ServerUpdateAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server
 * @Description: 
 * @author luyang
 * @date 2015年8月25日 上午10:26:07 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerUpdateAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 337241269758846888L;
	
	private ServerApi serverApi;
	
	private Server server;
	
	private String id;

	public Server getServer()
	{
		return server;
	}

	public void setServer(Server server)
	{
		this.server = server;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}
	
	public String initUpdate()
	{
		server = serverApi.findServerById(id);
		return SUCCESS;
	}
	
	public String execute()
	{
		server = serverApi.updateServer(server);
		return SUCCESS;
	}
}
