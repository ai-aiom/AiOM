package com.asiainfo.aiom.view.inventory.metric.detail;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.asiainfo.aiom.domain.MetricViewEntity;
import com.asiainfo.gim.client.monitor.api.MetricApi;
import com.asiainfo.gim.client.monitor.domain.Metric;
import com.asiainfo.gim.client.monitor.domain.query.MetricQueryParam;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class MetricListAction extends ServletAwareActionSupport
{

	private static final long serialVersionUID = 6051530832865896015L;

	private MetricApi metricApi;

	private String ip;

	private long startTime;

	private long endTime;

	private String[] metricNameArray = {
			//cpu
			"cpu_idle", "cpu_system", "cpu_user", "cpu_wio",
			//memory
			"mem_buffers", "mem_cached", "mem_free", "mem_shared", "swap_free",
			//network
			"bytes_in", "bytes_out", "pkts_in", "pkts_out",
			//disk
			"disk_free", "part_max_used"};
	
	// 返回给前端的list
	private Map<String, MetricViewEntity> resultMap;

	public String getIp()
	{
		return ip;
	}

	public void setIp(String ip)
	{
		this.ip = ip;
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
	
	public Map<String, MetricViewEntity> getResultMap()
	{
		return resultMap;
	}

	public void setResultMap(Map<String, MetricViewEntity> resultMap)
	{
		this.resultMap = resultMap;
	}
	
	public String returnMetricPage(){
		return SUCCESS;
	}

	public String execute()
	{
		MetricQueryParam metricQueryParam = new MetricQueryParam();
		metricQueryParam.setIp(ip);
		if(startTime == 0 || endTime == 0){
			metricQueryParam.setStartTime(new Date().getTime() - 3600 * 1000);
			metricQueryParam.setEndTime(new Date().getTime());
		}else{
			metricQueryParam.setStartTime(startTime);
			metricQueryParam.setEndTime(endTime);
		}
		resultMap = new HashMap<String, MetricViewEntity>();
		for (int i=0;i<metricNameArray.length;i++)
		{
			metricQueryParam.setMetricName(metricNameArray[i]);
			List<Metric> metricList = metricApi.listMetric(metricQueryParam);
			resultMap.put(metricNameArray[i], parseMetric(metricList, metricQueryParam));
		}
		return SUCCESS;
	}

	private MetricViewEntity parseMetric(List<Metric> metricList, MetricQueryParam metricQueryParam)
	{
		MetricViewEntity ve = new MetricViewEntity();
		ve.setName(metricQueryParam.getMetricName());
		List<Object> data = new ArrayList<Object>();
		List<Object> xdata = new ArrayList<Object>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		for (Metric metric : metricList)
		{
			data.add(metric.getValue());
			xdata.add(sdf.format(metric.getTime()));
			ve.setUnit(metric.getUnit());
		}
		ve.setData(data);
		ve.setXdata(xdata);
		ve.setStartTime(metricQueryParam.getStartTime());
		ve.setEndTime(metricQueryParam.getEndTime());
		return ve;
	}

}

