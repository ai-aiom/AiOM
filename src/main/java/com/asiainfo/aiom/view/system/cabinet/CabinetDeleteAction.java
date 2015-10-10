/**
 * @File: CabinetDeleteAction.java 
 * @Package  com.asiainfo.aiom.view.system.cabinet
 * @Description: 
 * @author luyang
 * @date 2015年8月21日 上午9:53:25 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.view.system.cabinet;

import java.util.List;

import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.gim.client.site.api.CabinetApi;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

/**
 * @author luyang
 *
 */
public class CabinetDeleteAction extends ServletAwareActionSupport
{
	private static final long serialVersionUID = 7820845521544123443L;

	private CabinetApi cabinetApi;

	private ServerApi serverApi;

	private ResultBean resultBean;

	private Integer id;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public void setCabinetApi(CabinetApi cabinetApi)
	{
		this.cabinetApi = cabinetApi;
	}

	public void setServerApi(ServerApi serverApi)
	{
		this.serverApi = serverApi;
	}

	public ResultBean getResultBean()
	{
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean)
	{
		this.resultBean = resultBean;
	}

	public String execute()
	{
		List<Server> servers = serverApi.listServers();
		for (Server server : servers)
		{
			if (server.getSite() != null && server.getSite().getRack() != null && server.getSite().getRack() == id)
			{
				resultBean = new ResultBean(false, "此机柜下存在服务器：" + server.getIp() + "，无法删除！");
				return SUCCESS;
			}
		}
		cabinetApi.deleteCabinet(id);
		resultBean = new ResultBean(true, null);
		return SUCCESS;
	}
}
