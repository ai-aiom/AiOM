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

import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class MachineDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 4684575477384845672L;

	private MachineManagementService machineManagementService;

	private Integer id;
	
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

	public String execute()
	{
		machineManagementService.deleteMachine(id);
		return SUCCESS;
	}
}
