/**
 * @File: JsonResult.java 
 * @Package  com.asiainfo.aio.dashboard.support.struts2
 * @Description: 
 * @author luyang
 * @date 2015年5月5日 上午9:23:41 
 * @version V1.0
 * 
 */
package com.asiainfo.support.struts2;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.Result;

/**
 * @author luyang
 *
 */
public class JsonResult implements Result
{
	private static final long serialVersionUID = 6956782979001453129L;
	
	private String property;

	public void setProperty(String property)
	{
		this.property = property;
	}

	public void execute(ActionInvocation ai) throws Exception
	{
		Object obj = null;
		if(property != null)
		{
			obj = MethodUtils.invokeMethod(ai.getAction(), "get" + StringUtils.capitalize(property), null);
		}
		else
		{
			obj = new ResultBean(true, null);
		}
		
		String body = toJsonString(obj);
		send(body);
	}
	
	public void send(String body) throws Exception
	{
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		
		PrintWriter pw = response.getWriter();
		pw.write(body);
		pw.flush();
	}

	public String toJsonString(Object o)
	{
		ObjectMapper om = getObjectMapper();
		try
		{
			return om.writeValueAsString(o);
		}
		catch (JsonProcessingException e)
		{
			return String.valueOf(o);
		}
	}
	
	protected ObjectMapper getObjectMapper()
	{
		return new ObjectMapper();
	}
}
