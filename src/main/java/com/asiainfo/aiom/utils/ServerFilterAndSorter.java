/**   
* @Title: ServerFilter.java 
* @Package com.asiainfo.aiom.utils 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年9月6日 下午3:01:08 
* @version V1.0   
*/
package com.asiainfo.aiom.utils;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.gim.client.server_manage.domain.Server;

/**
 * @author zhangli
 *
 */
public class ServerFilterAndSorter
{
	public static List<Server> filterByMachine(List<Server> servers, Machine machine)
	{
		Iterator<Server> it = servers.iterator();
		while(it.hasNext())
		{
			Server server = it.next();
			if(!StringUtils.equals(server.getProperties().get("machineId"), String.valueOf(machine.getId())))
			{
				it.remove();
			}
		}
		return servers;
	}
}
