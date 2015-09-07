/**
 * @File: ServerSummaryNoteAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月2日 下午4:36:30 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Asset;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummaryNoteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 2927262349589926538L;
	
	private ServerApi serverApi;
	
	private String id;
	
	private String note;
	
	private Server server;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getNote()
	{
		return note;
	}

	public void setNote(String note)
	{
		this.note = note;
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
		server = serverApi.findServerById(id);
		Asset asset = server.getAsset();
		if (server.getAsset() == null)
		{
			asset = new Asset();
		}
		asset.setNote(note);
		
		server = serverApi.updateAsset(id, asset);
		return SUCCESS;
	}
}
