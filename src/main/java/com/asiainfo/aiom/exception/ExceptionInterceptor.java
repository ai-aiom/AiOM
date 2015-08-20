/**   
* @Title: ExceptionInterceptor.java 
* @Package com.asiainfo.aiom.exception 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月6日 下午5:06:58 
* @version V1.0   
*/
package com.asiainfo.aiom.exception;

import javax.ws.rs.ProcessingException;

import org.apache.struts2.ServletActionContext;

import com.asiainfo.gim.client.exception.UnAuthorizedException;
import com.asiainfo.support.struts2.AbstractInterceptor;
import com.opensymphony.xwork2.ActionInvocation;

/**
 * @author zhangli
 *
 */
public class ExceptionInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = -5286691435538576795L;

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
		try
		{
			return invocation.invoke();
		}
		catch (Exception e)
		{
			return handleException(e);
		}
	}

	private String handleException(Exception e)
	{
		if(e instanceof ProcessingException)
		{
			if(e.getCause() instanceof UnAuthorizedException)
			{
				ServletActionContext.getResponse().setStatus(401);
				if(isAjax())
				{
					return null;
				}
				else
				{
					return "no-login";
				}
			}
			else
			{
				return null;
			}
		}
		else
		{
			return null;
		}
	}
}
