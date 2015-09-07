/**
 * @File: ServerSummaryAssetAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月2日 下午2:27:03 
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
public class ServerSummaryAssetAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -5041565437305753833L;
	
	private ServerApi serverApi;
	
	private String id;
	
	private Asset asset;
	
	private Server server;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public Asset getAsset()
	{
		return asset;
	}

	public void setAsset(Asset asset)
	{
		this.asset = asset;
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
		if (server.getAsset() != null)
		{
			asset.setNote(server.getAsset().getNote());
			asset.setCode(server.getAsset().getCode());
		}
		server = serverApi.updateAsset(id, asset);
		return SUCCESS;
	}
}
