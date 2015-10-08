/**
 * @File: CurrentAlertListAction.java 
 * @Package  com.asiainfo.aiom.view.alert.current
 * @Description: 
 * @author luyang
 * @date 2015年9月22日 上午10:39:25 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.current;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.aiom.Constants.AlertStatus;
import com.asiainfo.gim.client.monitor.api.AlertApi;
import com.asiainfo.gim.client.monitor.domain.Alert;
import com.asiainfo.gim.client.monitor.domain.query.AlertQueryParam;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class CurrentAlertListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 5109139121333029655L;

	private AlertApi alertApi;
	private ServerApi serverApi;

	private List<Alert> alerts;

	public List<Alert> getAlerts()
	{
		return alerts;
	}

	public void setAlertApi(AlertApi alertApi)
	{
		this.alertApi = alertApi;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		AlertQueryParam alertQueryParam = new AlertQueryParam();
		alertQueryParam.setStatus(AlertStatus.NEW);
		alerts = alertApi.listAlerts(alertQueryParam);

		if (alerts.size() > 0)
		{
			Map<String, String> targetDisplayMap = new HashMap<String, String>();
			for(Server server: serverApi.listServers())
			{
				targetDisplayMap.put(server.getId(), server.getIp());
			}
			
			for (Alert alert : alerts)
			{
				if (alert.getProperties() == null)
				{
					alert.setProperties(new HashMap<String, String>());
				}
				alert.getProperties().put("targetDisplay", targetDisplayMap.get(alert.getTargetId()));
			}
		}

		return SUCCESS;
	}

}
