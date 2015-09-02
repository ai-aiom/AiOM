/**
 * @File: LocationDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.system.location
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 下午2:31:00 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.location;

import com.asiainfo.gim.client.site.api.LocationApi;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class LocationDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -2816604616177215575L;
	
	private LocationApi locationApi;
	
	private Integer id;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public void setLocationApi(LocationApi locationApi)
	{
		this.locationApi = locationApi;
	}
	
	public String execute()
	{
		locationApi.deleteLocation(id);
		return SUCCESS;
	}
}
