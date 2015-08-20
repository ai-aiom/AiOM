/**   
 * @Title: MainAction.java 
 * @Package com.asiainfo.aiom.view 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月12日 上午9:12:57 
 * @version V1.0   
 */
package com.asiainfo.aiom.view;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class MainAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 1063225562062200386L;

	private MachineManagementService machineManagementService;
	private List<Machine> machines;
	private Integer machineId;

	public List<Machine> getMachines()
	{
		return machines;
	}

	public void setMachineManagementService(MachineManagementService machineManagementService)
	{
		this.machineManagementService = machineManagementService;
	}

	public void setMachineId(Integer machineId)
	{
		this.machineId = machineId;
	}

	public String execute()
	{
		machines = machineManagementService.listMachines();
		Machine machineSelected = null;
		if (machineId == null)
		{
			machineSelected = machines.get(0);
		}
		else
		{
			for (Machine machine : machines)
			{
				if (machine.getId() == machineId)
				{
					machineSelected = machine;
					break;
				}
			}
		}

		session.put("machine", machineSelected);
		return SUCCESS;
	}
}
