/**   
 * @File: ServletAwareActionSupport.java 
 * @Package com.asiainfo.support.struts2 
 * @Description: 
 * @author zhangli
 * @date 2014年11月13日 下午4:12:24 
 * @version V1.0   
 */
package com.asiainfo.support.struts2;

import java.util.Map;

import org.apache.struts2.interceptor.ParameterAware;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author zhangli
 *
 */
public class ServletAwareActionSupport extends ActionSupport implements SessionAware, RequestAware, ParameterAware
{
	private static final long serialVersionUID = -1507074396593417284L;

	protected Map<String, String[]> parameter;

	protected Map<String, Object> request;

	protected Map<String, Object> session;

	@Override
	public void setParameters(Map<String, String[]> parameter)
	{
		this.parameter = parameter;
	}

	@Override
	public void setRequest(Map<String, Object> request)
	{
		this.request = request;
	}

	@Override
	public void setSession(Map<String, Object> session)
	{
		this.session = session;
	}
}
