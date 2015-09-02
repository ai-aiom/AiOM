/**
 * @File: LocationUpdateAction.java 
 * @Package  com.asiainfo.aiom.view.system.location
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 下午2:35:31 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.location;

import com.asiainfo.gim.client.site.api.LocationApi;
import com.asiainfo.gim.client.site.domain.Location;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class LocationUpdateAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 1570323102837977215L;
	
	private LocationApi locationApi;
	
	private Location location;
	
	private Integer id;

	public Location getLocation()
	{
		return location;
	}

	public void setLocation(Location location)
	{
		this.location = location;
	}

	public void setLocationApi(LocationApi locationApi)
	{
		this.locationApi = locationApi;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}
	
	public String initUpdate()
	{
		location = locationApi.findLocationById(id);
		return SUCCESS;
	}
	
	public String execute()
	{
		location = locationApi.updateLocation(location);
		return SUCCESS;
	}
}
