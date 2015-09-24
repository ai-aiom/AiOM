/**   
* @Title: ExceptionInterceptor.java 
* @Package com.asiainfo.aiom.exception 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月6日 下午5:06:58 
* @version V1.0   
*/
package com.asiainfo.aiom.exception;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.ProcessingException;

import org.apache.struts2.ServletActionContext;

import com.asiainfo.gim.client.exception.ResourceNotFoundException;
import com.asiainfo.gim.client.exception.UnAuthorizedException;
import com.asiainfo.gim.client.exception.ValidationException;
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
				return doResult("no-login", null);
			}
			else if(e.getCause() instanceof ValidationException)
			{
				ServletActionContext.getResponse().setStatus(409);
				return doResult("validata-error", e.getMessage());
			}
			else
			{
				ServletActionContext.getResponse().setStatus(500);
				return doResult("system-error", e.getMessage());
			}
		}
		else if(e instanceof ValidateException)
		{
			ServletActionContext.getResponse().setStatus(409);
			return doResult("validata-error", e.getMessage());
		}
		else 
		{
			ServletActionContext.getResponse().setStatus(500);
			return doResult("system-error", e.getMessage());
		}
	}
	
	private String doResult(String result, String message)
	{
		if(isAjax())
		{
			if(message != null)
			{
				send(message);
			}
			return null;
		}
		else
		{
			if(message != null)
			{
				ServletActionContext.getRequest().setAttribute("message", message);
			}
			return result;
		}
	}
	
	private void send(String body)
	{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");

		PrintWriter pw = null;
		try
		{
			pw = response.getWriter();
		}
		catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		pw.write(body);
		pw.flush();
	}
}
