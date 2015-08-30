/**
 * @File: MachineModuleDao.java 
 * @Package  com.asiainfo.aiom.dao
 * @Description: 
 * @author luyang
 * @date 2015年8月27日 下午2:50:04 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.dao;

import java.util.List;

import com.asiainfo.aiom.domain.MachineModule;
import com.asiainfo.aiom.domain.query.MachineModuleQueryCondition;

/**
 * @author luyang
 *
 */
public interface MachineModuleDao
{
	public List<MachineModule> liMachineModules(MachineModuleQueryCondition machineModuleQueryCondition);
}
