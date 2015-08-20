/**
 * @File: RoleListAction.java 
 * @Package  com.asiainfo.aiom.view.system.role
 * @Description: 
 * @author luyang
 * @date 2015年8月18日 上午9:24:34 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.role;

import java.util.List;

import com.asiainfo.gim.client.auth.api.RoleApi;
import com.asiainfo.gim.client.auth.domain.Role;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class RoleListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 6701429477562268597L;

	private RoleApi roleApi;
	private List<Role> roles;

	public List<Role> getRoles()
	{
		return roles;
	}

	public void setRoleApi(RoleApi roleApi)
	{
		this.roleApi = roleApi;
	}

	public String execute()
	{
		roles = roleApi.listRoles();
		return SUCCESS;
	}
}
