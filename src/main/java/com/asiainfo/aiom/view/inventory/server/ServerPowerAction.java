/**
 * @File: ServerPowerAction.java 
 * @Package  com.asiainfo.aiom.view.inventory.server
 * @Description: 
 * @author luyang
 * @date 2015年9月16日 下午2:31:41 
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
public class ServerPowerAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 4866417361425872551L;
	
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
	
	public String powerOn()
	{
		serverApi.serverPowerOn(id);
		return SUCCESS;
	}
	
	public String powerOff()
	{
		serverApi.serverPowerOff(id);
		return SUCCESS;
	}
	
	public String powerReboot()
	{
		serverApi.serverPowerReboot(id);
		return SUCCESS;
	}
}
