/**
 * @File: ServerSummarySshAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月2日 下午3:13:31 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.gim.client.server_manage.domain.Ssh;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummarySshAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 5615400082698205895L;
	
	private ServerApi serverApi;
	
	private String id;
	
	private Ssh ssh;

	private Server server;
	
	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public Ssh getSsh()
	{
		return ssh;
	}

	public void setSsh(Ssh ssh)
	{
		this.ssh = ssh;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}
	
	public Server getServer()
	{
		return server;
	}

	public void setServer(Server server)
	{
		this.server = server;
	}

	public String execute()
	{
		server = serverApi.updateSsh(id, ssh);
		return SUCCESS;
	}
}
