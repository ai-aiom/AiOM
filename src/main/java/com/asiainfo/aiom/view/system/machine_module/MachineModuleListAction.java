/**
 * @File: MachineModuleListAction.java 
 * @Package  com.asiainfo.aiom.view.system.machine_module
 * @Description: 
 * @author luyang
 * @date 2015年8月27日 下午2:58:03 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.machine_module;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.domain.MachineModule;
import com.asiainfo.aiom.domain.query.MachineModuleQueryCondition;
import com.asiainfo.aiom.service.MachineModuleService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class MachineModuleListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -7636609225249768588L;
	
	private MachineModuleService machineModuleService;
	
	private List<MachineModule> machineModules;

	public List<MachineModule> getMachineModules()
	{
		return machineModules;
	}

	public void setMachineModuleService(MachineModuleService machineModuleService)
	{
		this.machineModuleService = machineModuleService;
	}
	
	public String execute()
	{
		Machine machineSelected = (Machine) session.get("machine");
		MachineModuleQueryCondition queryCondition = new MachineModuleQueryCondition();
		queryCondition.setMachineType(machineSelected.getType());
		
		machineModules = machineModuleService.liMachineModules(queryCondition);
		return SUCCESS;
	}
}
