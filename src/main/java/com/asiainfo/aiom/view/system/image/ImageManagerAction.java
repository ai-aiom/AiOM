package com.asiainfo.aiom.view.system.image;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.gim.client.deploy.api.ImageApi;
import com.asiainfo.gim.client.deploy.domain.Distro;
import com.asiainfo.gim.client.deploy.domain.Image;
import com.asiainfo.gim.client.deploy.domain.IsoFile;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class ImageManagerAction extends ServletAwareActionSupport {
	
	private static final long serialVersionUID = -1334069275104700434L;
	
	private ImageApi imageApi;
	
	private List<Distro> distroList;
	
	private List<Image> imageList;
	
	private Image image;
	
	private String distroName;
	
	private List<IsoFile> isoList;
	
	private ResultBean resultBean;
	
	public String listDistro(){
		distroList = imageApi.listDistros();
		return SUCCESS;
	}
	
	public String listImage(){
		imageList = imageApi.listImages();
		return SUCCESS;
	}
	
	public String createImage(){
		if(StringUtils.isBlank(image.getOsarch())){
			image.setOsarch(null);
		}
		imageApi.createOsImage(image);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}
	
	public String deleteDistro(){
		imageApi.deleteDistro(distroName);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}
	
	public String listIsoFile(){
		isoList = imageApi.listIsoFile(null);
		return SUCCESS;
	}
	
	@Resource
	public void setImageApi(ImageApi imageApi) {
		this.imageApi = imageApi;
	}

	public List<Distro> getDistroList() {
		return distroList;
	}

	public void setDistroList(List<Distro> distroList) {
		this.distroList = distroList;
	}

	public List<Image> getImageList() {
		return imageList;
	}

	public void setImageList(List<Image> imageList) {
		this.imageList = imageList;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}

	public String getDistroName() {
		return distroName;
	}

	public void setDistroName(String distroName) {
		this.distroName = distroName;
	}

	public List<IsoFile> getIsoList() {
		return isoList;
	}

	public void setIsoList(List<IsoFile> isoList) {
		this.isoList = isoList;
	}

	public ImageApi getImageApi() {
		return imageApi;
	}

	public ResultBean getResultBean() {
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean) {
		this.resultBean = resultBean;
	}

}
