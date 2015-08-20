/**
 * @File: MachineUpdateAction.java 
 * @Package  com.asiainfo.aiom.view.system.machine
 * @Description: 
 * @author luyang
 * @date 2015年8月20日 上午9:34:11 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.machine;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class MachineUpdateAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 4527296710019454864L;
	
	private MachineManagementService machineManagementService;
	
	private Machine machine;
	
	private Integer id;

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
		machine = machineManagementService.findMachineById(id);
		return SUCCESS;
	}
	
	public String execute()
	{
		Machine machineInDbById = machineManagementService.findMachineById(machine.getId());
		if (!StringUtils.equals(machine.getName(), machineInDbById.getName()))
		{
			Machine machineInDbByName = machineManagementService.findMachineByName(machine.getName());
			if (machineInDbByName != null)
			{
//				throw new ValidateException("名称已经存在");
			}
		}
		
		machineManagementService.updateMachine(machine);
		return SUCCESS;
	}
}
