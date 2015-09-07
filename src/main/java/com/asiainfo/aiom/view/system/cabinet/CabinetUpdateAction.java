/**
 * @File: CabinetUpdateAction.java 
 * @Package  com.asiainfo.aiom.view.system.cabinet
 * @Description: 
 * @author luyang
 * @date 2015年8月21日 上午9:51:42 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.cabinet;

import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class CabinetUpdateAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -5653110194120376488L;
	
	private CabinetApi cabinetApi;
	
	private Cabinet cabinet;
	
	private Integer id;
	
	public Cabinet getCabinet()
	{
		return cabinet;
	}

	public void setCabinet(Cabinet cabinet)
	{
		this.cabinet = cabinet;
	}

	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
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
		cabinet = cabinetApi.findCabinetById(id);
		return SUCCESS;
	}
	
	public String execute()
	{
		cabinet = cabinetApi.updateCabinet(cabinet);
		return SUCCESS;
	}
}
