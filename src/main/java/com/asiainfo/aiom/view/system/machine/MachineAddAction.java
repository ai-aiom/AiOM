/**   
 * @Title: MachineAddAction.java 
 * @Package com.asiainfo.aiom.view.system.machine 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月19日 下午4:17:02 
 * @version V1.0   
 */
package com.asiainfo.aiom.view.system.machine;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class MachineAddAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 3773788501137618002L;

	private MachineManagementService machineManagementService;
	private Machine machine;

	public Machine getMachine()
	{
		return machine;
	}

	public void setMachine(Machine machine)
	{
		this.machine = machine;
	}

	public void setMachineManagementService(MachineManagementService machineManagementService)
	{
		this.machineManagementService = machineManagementService;
	}

	public String execute()
	{
		Machine machineInDbByName = machineManagementService.findMachineByName(machine.getName());
		if (machineInDbByName != null)
		{
//			throw new ValidateException("名称已经存在");
		}
		machineManagementService.addMachine(machine);
		return SUCCESS;
	}
}
