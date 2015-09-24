/**
 * @File: HistoryAlertListAction.java 
 * @Package  com.asiainfo.aiom.view.alert.history
 * @Description: 
 * @author luyang
 * @date 2015年9月22日 上午10:40:43 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.alert.history;

import java.util.ArrayList;
import java.util.List;

import com.asiainfo.aiom.Constants.AlertStatus;
import com.asiainfo.gim.client.monitor.api.AlertApi;
import com.asiainfo.gim.client.monitor.domain.Alert;
import com.asiainfo.gim.client.monitor.domain.query.AlertQueryParam;
import com.asiainfo.support.page.PagingList;
import com.asiainfo.support.page.PagingQueryActionBase;

/**
 * @author luyang
 *
 */
public class HistoryAlertListAction extends PagingQueryActionBase
{
	private static final long serialVersionUID = -9078892486724326187L;

	private AlertApi alertApi;

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
		alertQueryParam.setStatus(AlertStatus.CONFIRMED);
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
		return SUCCESS;
	}
}
