/**   
 * @Title: AuthorizationCheckInterceptor.java 
 * @Package com.asiainfo.aiom.login 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月7日 上午10:25:34 
 * @version V1.0   
 */
package com.asiainfo.aiom.login;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.web.client.RestClientException;

import com.asiainfo.gim.client.ClientContext;
import com.asiainfo.support.struts2.AbstractInterceptor;
import com.opensymphony.xwork2.ActionInvocation;

/**
 * @author zhangli
 *
 */
public class AuthorizationCheckInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = 3383476376163355647L;

	@Override
	public void destroy()
	{

	}

	@Override
	public void init()
	{

	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute("token") == null || session.getAttribute("user") == null)
		{
			ServletActionContext.getResponse().setStatus(401);
			if (isAjax())
			{
				return null;
			}
			else
			{
				return "no-login";
			}
		}
		
		ClientContext.setToken((String)session.getAttribute("token"));
		return invocation.invoke();
	}
}
