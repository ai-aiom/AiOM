/**   
 * @Title: RackViewAction.java 
 * @Package com.asiainfo.aiom.view.inventory.server 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年9月6日 上午11:43:22 
 * @version V1.0   
 */
package com.asiainfo.aiom.view.inventory.rackview;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.gim.client.site.domain.Cabinet;
import com.asiainfo.gim.client.site.domain.query.CabinetQueryCondition;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class RackViewAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 5346272537340615989L;

	private CabinetApi cabinetApi;
	private ServerApi serverApi;
	private List<Cabinet> cabinets;
	private List<Server> servers;

	public List<Cabinet> getCabinets()
	{
		return cabinets;
	}

	public List<Server> getServers()
	{
		return servers;
	}

	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public String execute()
	{
		cabinets = cabinetApi.listCabinets(new CabinetQueryCondition());
		servers = serverApi.listServers();
		
		Machine machine = (Machine) session.get("machine");
		servers = ServerFilterAndSorter.filterByMachine(servers, machine);
		
		return SUCCESS;
	}
}
