/**   
* @Title: MachineListAction.java 
* @Package com.asiainfo.aiom.view.system.machine 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月19日 下午2:29:24 
* @version V1.0   
*/
package com.asiainfo.aiom.view.system.machine;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class MachineListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -5152749582438208364L;

	private MachineManagementService machineManagementService;
	private List<Machine> machines;
	public List<Machine> getMachines()
	{
		return machines;
	}
	public void setMachineManagementService(MachineManagementService machineManagementService)
	{
		this.machineManagementService = machineManagementService;
	}
	
	public String execute()
	{
		machines = machineManagementService.listMachines();
		return SUCCESS;
	}
}
