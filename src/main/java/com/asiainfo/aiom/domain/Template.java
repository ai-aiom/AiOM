package com.asiainfo.aiom.domain;

import java.util.List;

import com.asiainfo.gim.client.deploy.domain.TemplateInfo;
import com.asiainfo.gim.client.deploy.domain.TemplateLogVolConf;
import com.asiainfo.gim.client.deploy.domain.TemplatePartConf;
import com.asiainfo.gim.client.deploy.domain.TemplateUserConf;
import com.asiainfo.gim.client.deploy.domain.TemplateVolGroupConf;

public class Template {
	
	private TemplateInfo tempInfo;
	
	private TemplateBasic templateBasic;
	
	private List<TemplatePartConf> tempPartList;
	
	private List<TemplateVolGroupConf> tempVGList;
	
	private List<TemplateLogVolConf> tempLVList;
	
	private List<TemplateUserConf> tempUserList;

	public TemplateInfo getTempInfo() {
		return tempInfo;
	}

	public void setTempInfo(TemplateInfo tempInfo) {
		this.tempInfo = tempInfo;
	}

	public TemplateBasic getTemplateBasic() {
		return templateBasic;
	}

	public void setTemplateBasic(TemplateBasic templateBasic) {
		this.templateBasic = templateBasic;
	}

	public List<TemplatePartConf> getTempPartList() {
		return tempPartList;
	}

	public void setTempPartList(List<TemplatePartConf> tempPartList) {
		this.tempPartList = tempPartList;
	}

	public List<TemplateVolGroupConf> getTempVGList() {
		return tempVGList;
	}

	public void setTempVGList(List<TemplateVolGroupConf> tempVGList) {
		this.tempVGList = tempVGList;
	}

	public List<TemplateLogVolConf> getTempLVList() {
		return tempLVList;
	}

	public void setTempLVList(List<TemplateLogVolConf> tempLVList) {
		this.tempLVList = tempLVList;
	}

	public List<TemplateUserConf> getTempUserList() {
		return tempUserList;
	}

	public void setTempUserList(List<TemplateUserConf> tempUserList) {
		this.tempUserList = tempUserList;
	}
	
	

}
