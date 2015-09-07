/**
 * @File: ServerSummaryIpmiAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server.detail
 * @Description: 
 * @author luyang
 * @date 2015年9月2日 下午3:13:49 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.inventory.server.detail;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Ipmi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class ServerSummaryIpmiAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -6818342675429578056L;
	
	private ServerApi serverApi;
	
	private String id;
	
	private Ipmi ipmi;

	private Server server;
	
	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public Ipmi getIpmi()
	{
		return ipmi;
	}

	public void setIpmi(Ipmi ipmi)
	{
		this.ipmi = ipmi;
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
		server = serverApi.updateIpmi(id, ipmi);
		return SUCCESS;
	}
}
