package com.asiainfo.aiom.view.system.server;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.gim.client.deploy.api.NodeApi;
import com.asiainfo.gim.client.deploy.domain.Node;
import com.asiainfo.gim.client.server_manage.api.ServerApi;
import com.asiainfo.gim.client.server_manage.domain.Ipmi;
import com.asiainfo.gim.client.server_manage.domain.Server;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class ServerInstallOsAction extends ServletAwareActionSupport {

	private static final long serialVersionUID = -6817502128751909003L;

	private NodeApi nodeApi;

	private ServerApi serverApi;

	private String serverId;
	
	private Node node;

	private ResultBean resultBean;

	public String installOs() {
		if(node.getName().contains(".")){
			resultBean = new ResultBean(false, "主机名不能包含\".\"，请修改！");
			return SUCCESS;
		}
		Server server = serverApi.findServerById(serverId);
		Ipmi ipmi = server.getIpmi();
		String mac = server.getMac();
		String ip = server.getIp();
		if(StringUtils.isEmpty(mac) || StringUtils.isEmpty(ip)){
			resultBean = new ResultBean(false, "主机ip或mac不能为空，请补充！");
			return SUCCESS;
		}
		List<Node> nodeList = nodeApi.listNodes("compute");
		for (Node n : nodeList) {
			if (StringUtils.equalsIgnoreCase(mac, n.getMac())) {
				nodeApi.remodeNode(n.getName());
			}else if (StringUtils.equals(node.getName(), n.getName())) {
				resultBean = new ResultBean(false, "主机名已存在，请更改！");
				return SUCCESS;
			}
		}
		//补充node信息
		node.setGroups("compute");
		node.setIntf("eth0");
		node.setNetboot("pxe");
		node.setInstallnic("mac");
		node.setPrimarynic("mac");
		node.setPower("ipmi");
		node.setMgt("ipmi");
		node.setBmc(ipmi.getHost());
		node.setBmcusername(ipmi.getUsername());
		node.setBmcpassword(ipmi.getPassword());
		node.setMac(mac);
		node.setIp(ip);
		nodeApi.addNode(node);
		nodeApi.installos(node);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}

	@Resource
	public void setNodeApi(NodeApi nodeApi) {
		this.nodeApi = nodeApi;
	}

	@Resource
	public void setServerApi(ServerApi serverApi) {
		this.serverApi = serverApi;
	}

	public String getServerId() {
		return serverId;
	}

	public void setServerId(String serverId) {
		this.serverId = serverId;
	}

	public Node getNode() {
		return node;
	}

	public void setNode(Node node) {
		this.node = node;
	}

	public ResultBean getResultBean() {
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean) {
		this.resultBean = resultBean;
	}

}
