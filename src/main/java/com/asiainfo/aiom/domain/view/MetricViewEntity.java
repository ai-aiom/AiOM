package com.asiainfo.aiom.domain.view;

import java.util.List;

public class MetricViewEntity
{
	String name;
	String unit;
	List<Object> data;
	List<Object> xdata;

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

	public String getUnit()
	{
		return unit;
	}

	public void setUnit(String unit)
	{
		this.unit = unit;
	}
	
}
