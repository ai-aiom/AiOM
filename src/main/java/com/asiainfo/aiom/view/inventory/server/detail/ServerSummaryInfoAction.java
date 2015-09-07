/**
 * @File: ServerSummaryInfoAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月6日 下午3:13:32 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummaryInfoAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 4431340561916868258L;
	
	private ServerApi serverApi;
	
	private String id;
	
	private Server server;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

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
		Server serverInDb = serverApi.findServerById(id);
		
		serverInDb.setIp(server.getIp());
		serverInDb.setAlias(server.getAlias());
		serverInDb.setMonitorType(server.getMonitorType());
		
		server = serverApi.updateServer(serverInDb);
		return SUCCESS;
	}
}
