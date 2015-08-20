/**   
 * @Title: LoginAction.java 
 * @Package com.asiainfo.aiom.login 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月6日 下午4:15:58 
 * @version V1.0   
 */
package com.asiainfo.aiom.login;

import com.asiainfo.gim.client.auth.api.TokenApi;
import com.asiainfo.gim.client.auth.domain.Token;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class LoginAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 7105572497825376793L;

	private TokenApi tokenApi;

	private String username;
	private String password;

	private ResultBean loginResult;

	public void setTokenApi(TokenApi tokenApi)
	{
		this.tokenApi = tokenApi;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public ResultBean getLoginResult()
	{
		return loginResult;
	}

	public String execute()
	{
		Token token = tokenApi.getToken(username, password);
		session.put("token", token.getId());
		session.put("user", token.getUser());
		return SUCCESS;
	}
}
