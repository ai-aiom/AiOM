/**
 * @File: UserUpdateOwnPasswordAction.java 
 * @Package  com.asiainfo.aiom.view.system.user
 * @Description: 
 * @author luyang
 * @date 2015年8月28日 上午9:57:57 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.user;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.exception.ValidateException;
import com.asiainfo.gim.client.auth.api.UserApi;
import com.asiainfo.gim.client.auth.domain.User;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class UserUpdateOwnPasswordAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -5558591249922571082L;
	
	private UserApi userApi;
	
	private String oldPassword;
	
	private String newPassword;

	public String getNewPassword()
	{
		return newPassword;
	}

	public void setNewPassword(String newPassword)
	{
		this.newPassword = newPassword;
	}

	public String getOldPassword()
	{
		return oldPassword;
	}

	public void setOldPassword(String oldPassword)
	{
		this.oldPassword = oldPassword;
	}

	public void setUserApi(UserApi userApi)
	{
		this.userApi = userApi;
	}
	
	public String execute()
	{
		User userIn = (User) session.get("user");
		String password = (String) session.get("password");
		
		if (!StringUtils.equals(password, DigestUtils.md5Hex(oldPassword)))
		{
			throw new ValidateException("原始密码错误!");
		}
		
		userIn.setPassword(newPassword);
		userApi.updateUser(userIn);
		
		return SUCCESS;
	}
}
