/**   
* @Title: MachineManagementService.java 
* @Package com.asiainfo.aiom.service 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月7日 下午1:46:25 
* @version V1.0   
*/
package com.asiainfo.aiom.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.asiainfo.aiom.dao.MachineDao;
import com.asiainfo.aiom.domain.Machine;

/**
 * @author zhangli
 *
 */
@Service
public class MachineManagementService
{
	private MachineDao machineDao;

	@Resource
	public void setMachineDao(MachineDao machineDao)
	{
		this.machineDao = machineDao;
	}
	
	public List<Machine> listMachines()
	{
		return machineDao.listMachines();
	}
	
	public Machine findMachineById(int id)
	{
		return machineDao.findMachineById(id);
	}
	
	public Machine findMachineByName(String name)
	{
		return machineDao.findMachineByName(name);
	}
	
	public void addMachine(Machine machine)
	{
		machineDao.insertMachine(machine);
	}
	
	public void updateMachine(Machine machine)
	{
		machineDao.updateMachine(machine);
	}
	
	public void deleteMachine(int id)
	{
		machineDao.deleteMachine(id);
	}
}
