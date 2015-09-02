/**
 * @File: CabinetDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.system.cabinet
 * @Description: 
 * @author luyang
 * @date 2015年8月21日 上午9:53:25 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.cabinet;

import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class CabinetDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 7820845521544123443L;
	
	private CabinetApi cabinetApi;
	
	private Integer id;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}
	
	public String execute()
	{
		cabinetApi.deleteCabinet(id);
		return SUCCESS;
	}
}
