/**
 * @File: ServerSummarySiteAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月2日 下午4:02:13 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.gim.client.server_manage.domain.Site;
import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummarySiteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 9206176457069690515L;
	
	private ServerApi serverApi;
	
	private CabinetApi cabinetApi;
	
	private String id;
	
	private Server server;
	
	private Site site;

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

	public Site getSite()
	{
		return site;
	}

	public void setSite(Site site)
	{
		this.site = site;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}
	
	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}

	public String execute()
	{
		server = serverApi.findServerById(id);
		server.setSite(site);
		server = serverApi.updateServer(server);
		
		Cabinet cabinet = cabinetApi.findCabinetById(server.getSite().getRack());
		server.getProperties().put("cabinetName", cabinet.getName());
		
		return SUCCESS;
	}
}
