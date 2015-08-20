/**   
* @Title: MachineDao.java 
* @Package com.asiainfo.aiom.dao 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月7日 下午1:37:43 
* @version V1.0   
*/
package com.asiainfo.aiom.dao;

import java.util.List;

import com.asiainfo.aiom.domain.Machine;

/**
 * @author zhangli
 *
 */
public interface MachineDao
{
	public List<Machine> listMachines();
	
	public Machine findMachineById(int id);
	
	public Machine findMachineByName(String name);
	
	public void insertMachine(Machine machine);
	
	public void updateMachine(Machine machine);
	
	public void deleteMachine(int id);
}
