package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.gim.client.monitor.api.AlertApi;
import com.asiainfo.gim.client.monitor.domain.Alert;
import com.asiainfo.gim.client.monitor.domain.query.AlertQueryParam;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.page.PagingList;
import com.asiainfo.support.page.PagingQueryActionBase;

public class AlertListAction extends PagingQueryActionBase
{
	private static final long serialVersionUID = 5972488077839017907L;

	private AlertApi alertApi;

	private ServerApi serverApi;

	private List<Alert> alerts;

	private AlertQueryParam alertQueryParam;

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

	public AlertQueryParam getAlertQueryParam()
	{
		return alertQueryParam;
	}

	public void setAlertQueryParam(AlertQueryParam alertQueryParam)
	{
		this.alertQueryParam = alertQueryParam;
	}

	public String execute()
	{
		super.setQueryCondition(alertQueryParam);
		alerts = alertApi.listAlerts(alertQueryParam);
		if (alertQueryParam.getLimit() == Integer.MAX_VALUE)
		{
			alerts = new ArrayList<Alert>(alerts);
		}
		else
		{
			alertQueryParam.setStart(0);
			alertQueryParam.setLimit(Integer.MAX_VALUE);
			List<Alert> alertForCount = alertApi.listAlerts(alertQueryParam);
			alerts = new PagingList<Alert>(alertForCount.size(), alerts);
		}
		
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
