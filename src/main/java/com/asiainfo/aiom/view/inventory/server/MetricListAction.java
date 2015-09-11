package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.time.FastDateFormat;

import com.asiainfo.aiom.domain.view.MetricViewEntity;
import com.asiainfo.gim.client.monitor.api.MetricApi;
import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.monitor.domain.query.MetricQueryParam;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class MetricListAction extends ServletAwareActionSupport
{

	private static final long serialVersionUID = 6051530832865896015L;

	private MetricApi metricApi;
	
	private ServerApi serverApi;

	private String serverId;
	
	private Server server;

	private long startTime;

	private long endTime;

	private String[] metricNameArray = {
			// cpu
			"cpu_idle", "cpu_system", "cpu_user", "cpu_wio",
			// memory
			"mem_buffers", "mem_cached", "mem_free", "mem_shared", "swap_free",
			// network
			"bytes_in", "bytes_out", "pkts_in", "pkts_out",
			// disk
			"disk_free", "part_max_used" };

	// 返回给前端的list
	private Map<String, MetricViewEntity> metricDataMap;

	public String getServerId()
	{
		return serverId;
	}

	public void setServerId(String serverId)
	{
		this.serverId = serverId;
	}

	public long getStartTime()
	{
		return startTime;
	}

	public void setStartTime(long startTime)
	{
		this.startTime = startTime;
	}

	public long getEndTime()
	{
		return endTime;
	}

	public void setEndTime(long endTime)
	{
		this.endTime = endTime;
	}

	public void setMetricApi(MetricApi metricApi)
	{
		this.metricApi = metricApi;
	}

	public Map<String, MetricViewEntity> getMetricDataMap()
	{
		return metricDataMap;
	}

	public void setMetricDataMap(Map<String, MetricViewEntity> metricDataMap)
	{
		this.metricDataMap = metricDataMap;
	}
	
	public Server getServer()
	{
		return server;
	}

	public void setServer(Server server)
	{
		this.server = server;
	}
	
	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String returnMetricPage()
	{
		return SUCCESS;
	}

	public String execute()
	{
		MetricQueryParam metricQueryParam = new MetricQueryParam();
		server = serverApi.findServerById(serverId);
		metricQueryParam.setIp(server.getIp());
		metricDataMap = new HashMap<String, MetricViewEntity>();
		if (startTime == 0 || endTime == 0)
		{
			return SUCCESS;
		}
		else
		{
			metricQueryParam.setStartTime(startTime);
			metricQueryParam.setEndTime(endTime);
		}
		for (String metricName : metricNameArray)
		{
			metricQueryParam.setMetricName(metricName);
			List<Metric> metricList = metricApi.listMetric(metricQueryParam);
			metricDataMap.put(metricName, parseMetric(metricList, metricQueryParam));
		}
		return SUCCESS;
	}

	private MetricViewEntity parseMetric(List<Metric> metricList, MetricQueryParam metricQueryParam)
	{
		MetricViewEntity metricViewEntity = new MetricViewEntity();
		metricViewEntity.setName(metricQueryParam.getMetricName());
		List<Object> data = new ArrayList<Object>();
		List<Object> xdata = new ArrayList<Object>();
		FastDateFormat formatter = FastDateFormat.getInstance("yyyy-MM-dd HH:mm");
		for (Metric metric : metricList)
		{
			data.add(metric.getValue());
			xdata.add(formatter.format(metric.getTime()));
			metricViewEntity.setUnit(metric.getUnit());
		}
		metricViewEntity.setData(data);
		metricViewEntity.setXdata(xdata);
		return metricViewEntity;
	}

}
