package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

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

	private String[] memMetricNameArray = { "mem_buffers", "mem_cached", "mem_free", "mem_shared", "swap_free" };

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
		// 内存使用率百分比
		createMemUsedPerDate(metricQueryParam);
		// 将内存相关的指标转为MB单位数据显示
		ConvertMemDataUnit();
		return SUCCESS;
	}

	private MetricViewEntity parseMetric(List<Metric> metricList, MetricQueryParam metricQueryParam)
	{
		MetricViewEntity metricViewEntity = new MetricViewEntity();
		metricViewEntity.setName(metricQueryParam.getMetricName());
		List<Object> data = new ArrayList<Object>();
		List<Object> xdata = new ArrayList<Object>();
		for (Metric metric : metricList)
		{
			data.add(metric.getValue());
			xdata.add(metric.getTime());
			metricViewEntity.setUnit(metric.getUnit());
		}
		metricViewEntity.setData(data);
		metricViewEntity.setXdata(xdata);
		return metricViewEntity;
	}

	private void createMemUsedPerDate(MetricQueryParam metricQueryParam)
	{
		// 定义新的指标名称 ：内存使用百分比
		String metricName = "mem_used_per";
		metricQueryParam.setMetricName("mem_total");
		List<Metric> memTotalMetricList = metricApi.listMetric(metricQueryParam);
		List<Object> memUsedPerData = new ArrayList<Object>();
		MetricViewEntity memFreeMetricViewEntity = metricDataMap.get("mem_free");
		if(memTotalMetricList != null && memTotalMetricList.size() != 0){
			float memTotal = Float.parseFloat(String.valueOf(memTotalMetricList.get(0).getValue()));
			for (Object value : memFreeMetricViewEntity.getData())
			{
				float valueFloat = Float.parseFloat(String.valueOf(value));
				memUsedPerData.add((int) ((memTotal - valueFloat) / memTotal * 100));
			}
		}
		MetricViewEntity memUsedPerViewEntity = new MetricViewEntity();
		memUsedPerViewEntity.setData(memUsedPerData);
		memUsedPerViewEntity.setName(metricName);
		memUsedPerViewEntity.setUnit("%");
		memUsedPerViewEntity.setXdata(memFreeMetricViewEntity.getXdata());
		metricDataMap.put(metricName, memUsedPerViewEntity);
	}

	private void ConvertMemDataUnit()
	{
		Set<String> metricNames = metricDataMap.keySet();
		for (String metricName : metricNames)
		{
			for (String memMetricName : memMetricNameArray)
			{
				if (StringUtils.equalsIgnoreCase(metricName, memMetricName))
				{
					MetricViewEntity memMetricViewEntity = metricDataMap.get(memMetricName);
					memMetricViewEntity.setUnit("MB");
					List<Object> memDatasMB = new ArrayList<Object>();
					for (Object memData : memMetricViewEntity.getData())
					{
						memDatasMB.add((int) (Float.parseFloat(String.valueOf(memData)) / 1024));
					}
					memMetricViewEntity.setData(memDatasMB);
				}
			}
		}
	}

}
