/**
 * @File: MachineModuleService.java 
 * @Package  com.asiainfo.aiom.service
 * @Description: 
 * @author luyang
 * @date 2015年8月27日 下午2:55:11 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.asiainfo.aiom.dao.MachineModuleDao;
import com.asiainfo.aiom.domain.MachineModule;
import com.asiainfo.aiom.domain.query.MachineModuleQueryCondition;

/**
 * @author luyang
 *
 */
@Service
public class MachineModuleService
{
	private MachineModuleDao machineModuleDao;

	@Resource
	public void setMachineModuleDao(MachineModuleDao machineModuleDao)
	{
		this.machineModuleDao = machineModuleDao;
	}
	
	public List<MachineModule> liMachineModules(MachineModuleQueryCondition machineModuleQueryCondition)
	{
		return machineModuleDao.liMachineModules(machineModuleQueryCondition);
	}
}
