/**
 * @File: TokenCheckInterceptor.java 
 * @Package  com.asiainfo.aiom.login
 * @Description: 
 * @author luyang
 * @date 2015年9月24日 上午9:38:10 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.login;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;

import com.asiainfo.aiom.domain.Machine;
import com.asiainfo.aiom.service.MachineManagementService;
import com.asiainfo.gim.client.ClientContext;
import com.asiainfo.gim.client.auth.api.TokenApi;
import com.asiainfo.gim.client.auth.domain.Token;
import com.asiainfo.support.struts2.AbstractInterceptor;
import com.opensymphony.xwork2.ActionInvocation;

/**
 * @author luyang
 *
 */
public class TokenCheckInterceptor extends AbstractInterceptor
{
	private static final long serialVersionUID = -7136160393375878664L;

	private TokenApi tokenApi;
	
	private MachineManagementService machineManagementService;
	
	public void setTokenApi(TokenApi tokenApi)
	{
		this.tokenApi = tokenApi;
	}
	
	public void setMachineManagementService(MachineManagementService machineManagementService)
	{
		this.machineManagementService = machineManagementService;
	}
	
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
		if (session.getAttribute("token") == null)
		{
			if (StringUtils.isEmpty(ServletActionContext.getRequest().getParameter("token")) || 
					!StringUtils.equals(ServletActionContext.getRequest().getParameter("token"), "4890d346-f9d5-4a6a-b511-5a954266064a"))
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
			else
			{
				//token
				Token token = tokenApi.getToken("admin", "admin");
				session.setAttribute("token", token.getId());
				session.setAttribute("user", token.getUser());
				
				//machine
				List<Machine> machines = machineManagementService.listMachines();
				Machine machineSelected = machines.get(0);

				session.setAttribute("machine", machineSelected);
			}
			
		}
		ClientContext.setToken((String)session.getAttribute("token"));
		return invocation.invoke();
	}

}
