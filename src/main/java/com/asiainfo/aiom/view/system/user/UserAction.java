/**
 * @File: UserAction.java 
 * @Package  com.asiainfo.aiom.view.system.user
 * @Description: 
 * @author luyang
 * @date 2015年8月17日 下午4:42:51 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.user;

import com.asiainfo.gim.client.auth.api.UserApi;
import com.asiainfo.gim.client.auth.domain.User;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class UserAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 2152778698918542867L;
	
	private UserApi userApi;
	
	private User user;
	
	private Integer id;

	public void setUserApi(UserApi userApi)
	{
		this.userApi = userApi;
	}
	
	public User getUser()
	{
		return user;
	}

	public void setUser(User user)
	{
		this.user = user;
	}

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String addUser()
	{
		user = userApi.addUser(user);
		return SUCCESS;
	}
	
	public String initUpdateUser()
	{
		user = userApi.findUserById(id);
		return SUCCESS;
	}
	
	public String initUpdateUserPassword()
	{
		user = userApi.findUserById(id);
		return SUCCESS;
	}
	
	public String updateUser()
	{
		user = userApi.updateUser(user);
		return SUCCESS;
	}
	
	public String deleteUser()
	{
		if (id != 1)
		{
			userApi.deleteUser(id);
		}
		return SUCCESS;
	}
}
