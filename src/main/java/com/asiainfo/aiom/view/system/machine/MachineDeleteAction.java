/**
 * @File: MachineDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.system.machine
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 上午9:26:26 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.machine;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.aiom.utils.ServerFilterAndSorter;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class MachineDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 4684575477384845672L;

	private MachineManagementService machineManagementService;

	private ResultBean resultBean;
	
	private Integer id;
	
	private ServerApi serverApi;
	
	public void setMachineManagementService(MachineManagementService machineManagementService)
	{
		this.machineManagementService = machineManagementService;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
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
		List<Server> servers = serverApi.listServers();
		Machine machine = machineManagementService.findMachineById(id);
		servers = ServerFilterAndSorter.filterByMachine(servers, machine);
		if (servers != null && servers.size() > 0)
		{
			resultBean = new ResultBean(false, "此一体机下存在服务器，无法删除！");
		}
		else
		{
			machineManagementService.deleteMachine(id);
			resultBean = new ResultBean(true, null);
		}
		return SUCCESS;
	}
}
