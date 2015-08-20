/**
 * @File: LocationListAction.java 
 * @Package  com.asiainfo.aiom.view.system.location
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 上午10:48:27 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.location;

import java.util.List;

import com.asiainfo.gim.client.site.api.LocationApi;
import com.asiainfo.gim.client.site.domain.Location;
import com.asiainfo.gim.client.site.domain.query.LocationQueryCondition;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class LocationListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -6267869442990099420L;
	
	private LocationApi locationApi;
	
	private List<Location> locations;

	public List<Location> getLocations()
	{
		return locations;
	}

	public void setLocationApi(LocationApi locationApi)
	{
		this.locationApi = locationApi;
	}
	
	public String execute()
	{
		locations = locationApi.listLocations(new LocationQueryCondition());
		return SUCCESS;
	}
}
