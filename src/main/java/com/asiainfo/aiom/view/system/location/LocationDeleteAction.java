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

import java.util.List;

import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.api.LocationApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.gim.client.site.domain.query.CabinetQueryCondition;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class LocationDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -2816604616177215575L;
	
	private LocationApi locationApi;
	
	private CabinetApi cabinetApi;
	
	private ResultBean resultBean;
	
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
	
	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}

	public ResultBean getResultBean()
	{
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean)
	{
		this.resultBean = resultBean;
	}

	public String execute()
	{
		CabinetQueryCondition cabinetQueryCondition = new CabinetQueryCondition();
		cabinetQueryCondition.setLocationId(id);
		List<Cabinet> cabinets = cabinetApi.listCabinets(cabinetQueryCondition);
		
		if (cabinets != null && cabinets.size() > 0)
		{
			resultBean = new ResultBean(false, "此机房下存在机柜，无法删除！");
		}
		else
		{
			locationApi.deleteLocation(id);
			resultBean = new ResultBean(true, null);
		}
		return SUCCESS;
	}
}
