/**
 * @File: AbstractInterceptor.java 
 * @Package  com.asiainfo.aio.dashboard.support.struts2
 * @Description: 
 * @author luyang
 * @date 2015年5月28日 下午3:04:46 
 * @version V1.0
 * 
 */
package com.asiainfo.support.struts2;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * @author luyang
 *
 */
public abstract class AbstractInterceptor implements Interceptor
{
	private static final long serialVersionUID = -7175852447761569237L;

	public boolean isAjax()
	{
		String requestWith = ServletActionContext.getRequest().getHeader("X-Requested-With");
		if(StringUtils.equals("XMLHttpRequest", requestWith))
		{
			return true;
		}
		return false;
	}
}
