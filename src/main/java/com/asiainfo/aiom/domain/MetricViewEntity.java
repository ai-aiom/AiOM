package com.asiainfo.aiom.domain;

import java.util.List;

public class MetricViewEntity
{
	String name;
	String unit;
	List<Object> data;
	List<Object> xdata;
	long startTime;
	long endTime;

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public List<Object> getData()
	{
		return data;
	}

	public void setData(List<Object> data)
	{
		this.data = data;
	}

	public List<Object> getXdata()
	{
		return xdata;
	}

	public void setXdata(List<Object> xdata)
	{
		this.xdata = xdata;
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

	public String getUnit()
	{
		return unit;
	}

	public void setUnit(String unit)
	{
		this.unit = unit;
	}
	
}
