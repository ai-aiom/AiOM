/**
 * @File: ServerDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server
 * @Description: 
 * @author luyang
 * @date 2015年8月25日 上午9:48:44 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -7953240408350533299L;
	
	private ServerApi serverApi;
	
	private String id;

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
	
	public String execute()
	{
		serverApi.deleteServer(id);
		return SUCCESS;
	}
}
