/**
 * @File: CabinetAddAction.java 
 * @Package  com.asiainfo.aiom.view.system.cabinet
 * @Description: 
 * @author luyang
 * @date 2015年8月21日 上午9:49:38 
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
public class CabinetAddAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 2256809188205324682L;
	
	private CabinetApi cabinetApi;
	
	private Cabinet cabinet;

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
	
	public String execute()
	{
		cabinet = cabinetApi.addCabinet(cabinet);
		return SUCCESS;
	}
}
