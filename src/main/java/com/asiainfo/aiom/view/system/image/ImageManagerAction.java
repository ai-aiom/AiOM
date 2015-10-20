package com.asiainfo.aiom.view.system.image;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;

import com.asiainfo.gim.client.deploy.api.ImageApi;
import com.asiainfo.gim.client.deploy.domain.Image;
import com.asiainfo.gim.client.deploy.domain.ImageDefaultConf;
import com.asiainfo.gim.client.deploy.domain.IsoFile;
import com.asiainfo.support.struts2.ResultBean;
import com.asiainfo.support.struts2.ServletAwareActionSupport;

public class ImageManagerAction extends ServletAwareActionSupport
{

	private static final long serialVersionUID = -1334069275104700434L;

	private ImageApi imageApi;

	private List<Image> imageList;

	private List<ImageDefaultConf> imageDefaultConfList;

	private Image image;

	private Integer imageId;

	private List<IsoFile> isoList;

	private ResultBean resultBean;

	public String listImage()
	{
		imageList = imageApi.listImages();
		return SUCCESS;
	}

	public String createImage()
	{
		List<Image> imageList = imageApi.listImages();
		for (Image img : imageList)
		{
			if (StringUtils.equals(img.getName(), image.getName()))
			{
				resultBean = new ResultBean(false, "镜像名称重复，请修改！");
				return SUCCESS;
			}
			if (StringUtils.equals(img.getOsType(), image.getOsType())
					&& StringUtils.equals(img.getOsVersion(), image.getOsVersion())
					&& StringUtils.equals(img.getOsArch(), image.getOsArch()))
			{
				resultBean = new ResultBean(false, "镜像重复，请修改！");
				return SUCCESS;
			}
		}
		imageApi.createImage(image);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}

	public String deleteImage()
	{
		imageApi.deleteImage(imageId);
		resultBean = new ResultBean(true, "success");
		return SUCCESS;
	}

	public String listImageDefaultConf()
	{
		Image image = imageApi.getImage(imageId);
		String distroName = image.getOsType() + image.getOsVersion() + "-" + image.getOsArch();
		imageDefaultConfList = imageApi.listImageDefaultConf();
		Iterator<ImageDefaultConf> it = imageDefaultConfList.iterator();
		while (it.hasNext())
		{
			ImageDefaultConf imgConf = it.next();
			if (StringUtils.equals(distroName, imgConf.getOsDistroName())
					&& StringUtils.equals("install", imgConf.getProvMethod()))
			{
				if (StringUtils.equals("kvm", imgConf.getProfile()))
				{
					imgConf.setDisplayName("kvm安装");
				}
				else if (StringUtils.equals("all", imgConf.getProfile()))
				{
					imgConf.setDisplayName("完全安装");
				}
				else if (StringUtils.equals("compute", imgConf.getProfile()))
				{
					imgConf.setDisplayName("基本服务器安装");
				}
				else
				{
					it.remove();
				}
			}
			else
			{
				it.remove();
			}
		}
		return SUCCESS;
	}

	public String listIsoFile()
	{
		isoList = imageApi.listIsoFile(null);
		return SUCCESS;
	}

	@Resource
	public void setImageApi(ImageApi imageApi)
	{
		this.imageApi = imageApi;
	}

	public List<Image> getImageList()
	{
		return imageList;
	}

	public void setImageList(List<Image> imageList)
	{
		this.imageList = imageList;
	}

	public Image getImage()
	{
		return image;
	}

	public void setImage(Image image)
	{
		this.image = image;
	}

	public List<IsoFile> getIsoList()
	{
		return isoList;
	}

	public void setIsoList(List<IsoFile> isoList)
	{
		this.isoList = isoList;
	}

	public ImageApi getImageApi()
	{
		return imageApi;
	}

	public ResultBean getResultBean()
	{
		return resultBean;
	}

	public void setResultBean(ResultBean resultBean)
	{
		this.resultBean = resultBean;
	}

	public Integer getImageId()
	{
		return imageId;
	}

	public void setImageId(Integer imageId)
	{
		this.imageId = imageId;
	}

	public List<ImageDefaultConf> getImageDefaultConfList()
	{
		return imageDefaultConfList;
	}

	public void setImageDefaultConfList(List<ImageDefaultConf> imageDefaultConfList)
	{
		this.imageDefaultConfList = imageDefaultConfList;
	}

}
