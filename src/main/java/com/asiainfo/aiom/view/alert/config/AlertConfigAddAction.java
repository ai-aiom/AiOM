/**
 * @File: AlertConfigAddAction.java 
 * @Package  com.asiainfo.aiom.view.alert.config
 * @Description: 
 * @author luyang
 * @date 2015年9月24日 上午11:49:32 
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
public class AlertConfigAddAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -3640994451300924205L;
	
	private AlertConfigApi alertConfigApi;
	
	private AlertConfig alertConfig;
	
	public AlertConfig getAlertConfig()
	{
		return alertConfig;
	}

	public void setAlertConfig(AlertConfig alertConfig)
	{
		this.alertConfig = alertConfig;
	}

	public void setAlertConfigApi(AlertConfigApi alertConfigApi)
	{
		this.alertConfigApi = alertConfigApi;
	}

	public String execute()
	{
		alertConfig = alertConfigApi.addAlertConfig(alertConfig);
		return SUCCESS;
	}
}
