/**
 * @File: CabinetListAction.java 
 * @Package  com.asiainfo.aiom.view.system.cabinet
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 下午5:08:05 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.cabinet;

import java.util.List;

import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.gim.client.site.domain.query.CabinetQueryCondition;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class CabinetListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 6531196661700663340L;
	
	private CabinetApi cabinetApi;
	
	private List<Cabinet> cabinets;

	public List<Cabinet> getCabinets()
	{
		return cabinets;
	}

	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}
	
	public String execute()
	{
		cabinets = cabinetApi.listCabinets(new CabinetQueryCondition());
		return SUCCESS;
	}
}
