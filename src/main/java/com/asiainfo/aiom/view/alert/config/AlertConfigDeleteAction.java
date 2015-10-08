/**
 * @File: AlertConfigDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.alert.config
 * @Description: 
 * @author luyang
 * @date 2015年9月24日 上午11:51:08 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.config;

import com.asiainfo.gim.client.monitor.api.AlertConfigApi;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class AlertConfigDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -7299931789430660502L;

	private AlertConfigApi alertConfigApi;

	private String id;

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public void setAlertConfigApi(AlertConfigApi alertConfigApi)
	{
		this.alertConfigApi = alertConfigApi;
	}

	public String execute()
	{
		alertConfigApi.deleteAlertConfig(id);
		return SUCCESS;
	}
}
