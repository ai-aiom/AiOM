/**   
* @Title: LogoutAction.java 
* @Package com.asiainfo.aiom.login 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月20日 下午3:14:18 
* @version V1.0   
*/
package com.asiainfo.aiom.login;

import org.apache.struts2.ServletActionContext;

import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author zhangli
 *
 */
public class LogoutAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -6638444849514394818L;

	public String execute()
	{
		ServletActionContext.getRequest().getSession().invalidate();
		return SUCCESS;
	}
}
