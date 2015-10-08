/**
 * @File: AlertConfigUpdateAction.java 
 * @Package  com.asiainfo.aiom.view.alert.config
 * @Description: 
 * @author luyang
 * @date 2015年9月24日 上午11:50:24 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.config;

import com.asiainfo.gim.client.monitor.api.AlertConfigApi;
import com.asiainfo.gim.client.monitor.domain.AlertConfig;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class AlertConfigUpdateAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -7578669795710975071L;

	private AlertConfigApi alertConfigApi;

	private String id;

	private AlertConfig alertConfig;

	public AlertConfig getAlertConfig()
	{
		return alertConfig;
	}

	public void setAlertConfig(AlertConfig alertConfig)
	{
		this.alertConfig = alertConfig;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public static long getSerialversionuid()
	{
		return serialVersionUID;
	}

	public AlertConfigApi getAlertConfigApi()
	{
		return alertConfigApi;
	}

	public void setAlertConfigApi(AlertConfigApi alertConfigApi)
	{
		this.alertConfigApi = alertConfigApi;
	}

	public String execute()
	{
		alertConfig = alertConfigApi.updateAlertConfig(alertConfig);
		return SUCCESS;
	}

	public String initUpdate()
	{
		alertConfig = alertConfigApi.findAlertConfigById(id);
		return SUCCESS;
	}
}
