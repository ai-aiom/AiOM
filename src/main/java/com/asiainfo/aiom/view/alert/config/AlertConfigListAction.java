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

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		if (alertConfigs.size() > 0)
		{
			Map<String, String> targetDisplayMap = new HashMap<String, String>();
			for(Server server: serverApi.listServers())
			{
				targetDisplayMap.put(server.getId(), server.getIp());
			}
			
			for (AlertConfig alertConfig : alertConfigs)
			{
				if (alertConfig.getTargetType() == ResourceType.SERVER && !StringUtils.isEmpty(alertConfig.getTargetId()))
				{
					if (alertConfig.getProperties() == null)
					{
						alertConfig.setProperties(new HashMap<String, String>());
					}
					alertConfig.getProperties().put("targetDisplay", targetDisplayMap.get(alertConfig.getTargetId()));
				}
			}
		}
		return SUCCESS;
	}
}
