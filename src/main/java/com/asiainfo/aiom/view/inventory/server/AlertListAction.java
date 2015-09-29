package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.Constants.ResourceType;
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

	private String serverId;

	private AlertQueryParam alertQueryParam;

	public List<Alert> getAlerts()
	{
		return alerts;
	}

	public String getServerId()
	{
		return serverId;
	}

	public void setServerId(String serverId)
	{
		this.serverId = serverId;
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
		if (alertQueryParam == null)
		{
			alertQueryParam = new AlertQueryParam();
		}
		alertQueryParam.setTargetId(serverId);
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
		for (Alert alert : alerts)
		{
			if (alert.getTargetType() == ResourceType.SERVER && !StringUtils.isEmpty(alert.getTargetId()))
			{
				Server server = serverApi.findServerById(alert.getTargetId());
				if (server != null)
				{
					alert.getProperties().put("targetName", server.getIp());
				}
			}
		}
		return SUCCESS;
	}
}
