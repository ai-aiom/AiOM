/**
 * @File: AlertConfigListAction.java 
 * @Package  com.asiainfo.aiom.view.alert.config
 * @Description: 
 * @author luyang
 * @date 2015年9月24日 上午11:28:25 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.config;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.Constants.ResourceType;
import com.asiainfo.gim.client.monitor.api.AlertConfigApi;
import com.asiainfo.gim.client.monitor.domain.AlertConfig;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class AlertConfigListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -5533555388467615013L;
	
	private AlertConfigApi alertConfigApi;
	
	private ServerApi serverApi;
	
	private List<AlertConfig> alertConfigs;
	
	public List<AlertConfig> getAlertConfigs()
	{
		return alertConfigs;
	}

	public void setAlertConfigApi(AlertConfigApi alertConfigApi)
	{
		this.alertConfigApi = alertConfigApi;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		alertConfigs = alertConfigApi.getAlertConfigs();
		for (AlertConfig alertConfig : alertConfigs)
		{
			if (alertConfig.getTargetType() == ResourceType.SERVER && !StringUtils.isEmpty(alertConfig.getTargetId()))
			{
				Server server = serverApi.findServerById(alertConfig.getTargetId());
				if (server != null)
				{
					alertConfig.getProperties().put("targetName", server.getIp());
				}
			}
		}
		return SUCCESS;
	}
}
