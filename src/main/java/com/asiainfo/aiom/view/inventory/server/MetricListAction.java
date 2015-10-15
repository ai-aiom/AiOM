package com.asiainfo.aiom.view.inventory.server;

import java.util.ArrayList;
import java.util.List;

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

	private String metricName;
	
	private MetricViewEntity metricViewEntity;

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

	public String getMetricName()
	{
		return metricName;
	}

	public void setMetricName(String metricName)
	{
		this.metricName = metricName;
	}

	public MetricViewEntity getMetricViewEntity()
	{
		return metricViewEntity;
	}

	public void setMetricViewEntity(MetricViewEntity metricViewEntity)
	{
		this.metricViewEntity = metricViewEntity;
	}

	public String execute()
	{
		MetricQueryParam metricQueryParam = new MetricQueryParam();
		server = serverApi.findServerById(serverId);
		metricQueryParam.setIp(server.getIp());
		if (startTime == 0 || endTime == 0)
		{
			return SUCCESS;
		}
		else
		{
			metricQueryParam.setStartTime(startTime);
			metricQueryParam.setEndTime(endTime);
		}

		// 普通指标
		if (isBaseMetric())
		{
			metricQueryParam.setMetricName(metricName);
			List<Metric> metricList = metricApi.listMetric(metricQueryParam);
			metricViewEntity = parseMetric(metricList, metricQueryParam);
		}

		// 如果是内存指标，需修改其单位,转为MB单位数据显示
		if (isMemMetric())
		{
			convertMemDataUnit();
		}

		// 内存使用率百分比
		if (StringUtils.endsWithIgnoreCase(metricName, "mem_used_per"))
		{
			metricViewEntity = createMemUsedPerDate(metricQueryParam);
		}

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


	private boolean isBaseMetric()
	{
		for (String baseMetricName : metricNameArray)
		{
			if (StringUtils.equalsIgnoreCase(baseMetricName, metricName))
			{
				return true;
			}
		}
		return false;
	}

	private boolean isMemMetric()
	{
		for (String memMetricName : memMetricNameArray)
		{
			if (StringUtils.equalsIgnoreCase(memMetricName, metricName))
			{
				return true;
			}
		}
		return false;
	}

	private void convertMemDataUnit()
	{
		metricViewEntity.setUnit("MB");
		List<Object> memDatasMB = new ArrayList<Object>();
		for (Object memData : metricViewEntity.getData())
		{
			memDatasMB.add((int) (Float.parseFloat(String.valueOf(memData)) / 1024));
		}
		metricViewEntity.setData(memDatasMB);
	}

	private MetricViewEntity createMemUsedPerDate(MetricQueryParam metricQueryParam)
	{
		metricQueryParam.setMetricName("mem_total");
		List<Metric> memTotalMetricList = metricApi.listMetric(metricQueryParam);
		metricQueryParam.setMetricName("mem_free");
		List<Metric> memFreeMetricList = metricApi.listMetric(metricQueryParam);
		MetricViewEntity memFreeMetricViewEntity = parseMetric(memFreeMetricList, metricQueryParam);
		List<Object> memUsedPerData = new ArrayList<Object>();
		if (memTotalMetricList != null && memTotalMetricList.size() != 0)
		{
			float memTotal = Float.parseFloat(String.valueOf(memTotalMetricList.get(memTotalMetricList.size() - 1)
					.getValue()));
			for (Object value : memFreeMetricViewEntity.getData())
			{
				float valueFloat = Float.parseFloat(String.valueOf(value));
				memUsedPerData.add((int) ((memTotal - valueFloat) / memTotal * 100));
			}
		}
		MetricViewEntity memUsedPerViewEntity = new MetricViewEntity();
		memUsedPerViewEntity.setData(memUsedPerData);
		memUsedPerViewEntity.setName("mem_used_per");
		memUsedPerViewEntity.setUnit("%");
		memUsedPerViewEntity.setXdata(memFreeMetricViewEntity.getXdata());
		return memUsedPerViewEntity;
	}
}
