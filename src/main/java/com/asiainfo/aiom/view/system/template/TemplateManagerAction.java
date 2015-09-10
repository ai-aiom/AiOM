package com.asiainfo.aiom.view.system.template;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.aiom.domain.Template;
import com.asiainfo.aiom.domain.TemplateBasic;
import com.asiainfo.gim.client.deploy.api.TemplateApi;
import com.asiainfo.gim.client.deploy.domain.TemplateBasicConf;
import com.asiainfo.gim.client.deploy.domain.TemplateConf;
import com.asiainfo.gim.client.deploy.domain.TemplateInfo;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class TemplateManagerAction extends ServletAwareActionSupport {

	private static final long serialVersionUID = -8444465773724243786L;

	private TemplateApi templateApi;

	private String templateId;

	private Template template;

	private ResultBean resultBean;

	private List<TemplateInfo> templateList;

	public String deleteTemplate() {
		templateApi.deleteTemplate(templateId);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}

	public String listTemplate() {
		templateList = templateApi.listTemplate();
		return SUCCESS;
	}

	public String createOrUpdateTemplate() {
		List<TemplateInfo> tempList = templateApi.listTemplate();
		for (TemplateInfo temp : tempList) {
			if (!StringUtils.equals(temp.getTemplateId(), template
					.getTempInfo().getTemplateId())
					&& StringUtils.equals(temp.getName(), template
							.getTempInfo().getName())) {
				resultBean = new ResultBean(false, "模板名已存在，请更改！");
				return SUCCESS;
			}
		}
		TemplateBasicConf conf1 = new TemplateBasicConf();
		conf1.setAttr("lang");
		conf1.setValue(template.getTemplateBasic().getLanguage());
		TemplateBasicConf conf2 = new TemplateBasicConf();
		conf2.setAttr("timezone");
		conf2.setValue(template.getTemplateBasic().getTimezone());
		TemplateBasicConf conf3 = new TemplateBasicConf();
		conf3.setAttr("rootpw");
		conf3.setValue(template.getTemplateBasic().getRootPw());
		List<TemplateBasicConf> basicConfs = new ArrayList<TemplateBasicConf>();
		basicConfs.add(conf1);
		basicConfs.add(conf2);
		basicConfs.add(conf3);
		TemplateConf templateConf = new TemplateConf();
		templateConf.setTempBaicList(basicConfs);
		templateConf.setTempInfo(template.getTempInfo());
		templateConf.setTempLVList(template.getTempLVList());
		templateConf.setTempPartList(template.getTempPartList());
		templateConf.setTempUserList(template.getTempUserList());
		templateConf.setTempVGList(template.getTempVGList());
		templateApi.createOrUpdateTemplate(templateConf);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}

	public String getTemplateDetail() {
		TemplateConf templateConf = templateApi.getTemplate(templateId);
		template = new Template();
		List<TemplateBasicConf> basicList = templateConf.getTempBaicList();
		TemplateBasic basicInfo = new TemplateBasic();
		for (TemplateBasicConf basic : basicList) {
			if (StringUtils.equals(basic.getAttr(), "lang")) {
				basicInfo.setLanguage(basic.getValue());
			} else if (StringUtils.equals(basic.getAttr(), "timezone")) {
				basicInfo.setTimezone(basic.getValue());
			} else if (StringUtils.equals(basic.getAttr(), "rootpw")) {
				basicInfo.setRootPw(basic.getValue());
			}
		}
		template.setTemplateBasic(basicInfo);
		template.setTempInfo(templateConf.getTempInfo());
		template.setTempLVList(templateConf.getTempLVList());
		template.setTempPartList(templateConf.getTempPartList());
		template.setTempUserList(templateConf.getTempUserList());
		template.setTempVGList(templateConf.getTempVGList());
		return SUCCESS;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	@Resource
	public void setTemplateApi(TemplateApi templateApi) {
		this.templateApi = templateApi;
	}

	public ResultBean getResultBean() {
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean) {
		this.resultBean = resultBean;
	}

	public List<TemplateInfo> getTemplateList() {
		return templateList;
	}

	public void setTemplateList(List<TemplateInfo> templateList) {
		this.templateList = templateList;
	}

	public Template getTemplate() {
		return template;
	}

	public void setTemplate(Template template) {
		this.template = template;
	}

}
