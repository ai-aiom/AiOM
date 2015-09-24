package com.asiainfo.aiom.view.system.scripts;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.gim.client.deploy.api.PostScriptsApi;
import com.asiainfo.gim.client.deploy.domain.PostScripts;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class PostScriptsManagerAction extends ServletAwareActionSupport {

	private static final long serialVersionUID = 851012978654422725L;
	
	private PostScriptsApi postScriptsApi;
	
	private PostScripts postScripts;
	
	private List<PostScripts> postScriptsList;
	
	private Integer id;
	
	//file fileFileName fileContentType为上传文件时接收参数
	private File file;
	
	private String fileFileName;
	
	private String fileContentType;
	
	//downloadFile defaultAttachName为下载文件返回参数
	private InputStream downloadFile;
	
	private String defaultAttachName;
	
	private ResultBean resultBean;
	
	public String findPostScriptsById(){
		postScripts = postScriptsApi.findPostScripts(id);
		return SUCCESS;
	}
	
	public String listPostScripts(){
		postScriptsList = postScriptsApi.listPostScripts();
		return SUCCESS;
	}
	
	public String createPostScripts(){
		List<PostScripts> scriptsList = postScriptsApi.listPostScripts();
		for(PostScripts scripts : scriptsList){
			if(StringUtils.equals(scripts.getName(), postScripts.getName())){
				resultBean = new ResultBean(false, "脚本名已存在，请修改！");
				return SUCCESS;
			}
		}
		String fileName = postScriptsApi.uploadPostScripts(file, null);
		postScripts.setFileName(fileName);
		postScriptsApi.createPostScripts(postScripts);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}
	
	public String deletePostScripts(){
		postScriptsApi.deletePostScripts(id);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}
	
	public String updatePostScripts(){
		postScriptsApi.updatePostScripts(postScripts);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}
	
	public String downloadPostScriptsFile(){
		PostScripts scripts = postScriptsApi.findPostScripts(id);
		defaultAttachName = scripts.getName();
		File scriptsFile = postScriptsApi.downPostScripts(scripts.getFileName());
		try {
			downloadFile = new FileInputStream(scriptsFile);
		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		}
		return SUCCESS;
	}


	@Resource
	public void setPostScriptsApi(PostScriptsApi postScriptsApi) {
		this.postScriptsApi = postScriptsApi;
	}

	public PostScripts getPostScripts() {
		return postScripts;
	}

	public void setPostScripts(PostScripts postScripts) {
		this.postScripts = postScripts;
	}

	public List<PostScripts> getPostScriptsList() {
		return postScriptsList;
	}

	public void setPostScriptsList(List<PostScripts> postScriptsList) {
		this.postScriptsList = postScriptsList;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public ResultBean getResultBean() {
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean) {
		this.resultBean = resultBean;
	}

	public InputStream getDownloadFile() {
		return downloadFile;
	}

	public void setDownloadFile(InputStream downloadFile) {
		this.downloadFile = downloadFile;
	}

	public String getDefaultAttachName() {
		return defaultAttachName;
	}

	public void setDefaultAttachName(String defaultAttachName) {
		this.defaultAttachName = defaultAttachName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
