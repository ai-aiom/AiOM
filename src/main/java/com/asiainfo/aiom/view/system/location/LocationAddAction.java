/**
 * @File: LocationAddAction.java 
 * @Package  com.asiainfo.aiom.view.system.location
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 上午11:39:10 
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
public class LocationAddAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 5233915182649887480L;
	
	private LocationApi locationApi;
	
	private Location location;

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
	
	public String execute()
	{
		location.setDatacenterId("1");
		location = locationApi.addLocation(location);
		return SUCCESS;
	}
}
