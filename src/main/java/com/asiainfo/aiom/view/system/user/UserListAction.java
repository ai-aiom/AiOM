/**   
 * @Title: UserListAction.java 
 * @Package com.asiainfo.aiom.view.system.user 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月17日 上午11:21:26 
 * @version V1.0   
 */
package com.asiainfo.aiom.view.system.user;

import java.util.List;

import com.asiainfo.gim.client.auth.api.UserApi;
import com.asiainfo.gim.client.auth.domain.User;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class UserListAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 1800277177688181688L;

	private UserApi userApi;
	private List<User> users;

	public List<User> getUsers()
	{
		return users;
	}

	public void setUserApi(UserApi userApi)
	{
		this.userApi = userApi;
	}

	public String execute()
	{
		users = userApi.listUsers();
		return SUCCESS;
	}
}
