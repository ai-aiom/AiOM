/**
 * @File: AlertConfirmAction.java 
 * @Package  com.asiainfo.aiom.view.alert.current
 * @Description: 
 * @author luyang
 * @date 2015年9月28日 下午3:13:36 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.current;

import com.asiainfo.gim.client.monitor.api.AlertApi;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class AlertConfirmAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -9062236584325784530L;
	
	private AlertApi alertApi;
	
	private String id;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public void setAlertApi(AlertApi alertApi)
	{
		this.alertApi = alertApi;
	}
	
	public String execute()
	{
		alertApi.confirmAlert(id);
		return SUCCESS;
	}
}
