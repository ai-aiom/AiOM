/**   
 * @Title: Machine.java 
 * @Package com.asiainfo.aiom.domain 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author zhangli
 * @date 2015年8月7日 下午1:36:05 
 * @version V1.0   
 */
package com.asiainfo.aiom.domain;

/**
 * @author zhangli
 *
 */
public class Machine
{
	private Integer id;
	private String name;
	private String description;
	private Integer type;
	private String serviceEndpoint;

	public Integer getId()
	{
		return id;
	}

	public void setId(Integer id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getDescription()
	{
		return description;
	}

	public void setDescription(String description)
	{
		this.description = description;
	}

	public Integer getType()
	{
		return type;
	}

	public void setType(Integer type)
	{
		this.type = type;
	}

	public String getServiceEndpoint()
	{
		return serviceEndpoint;
	}

	public void setServiceEndpoint(String serviceEndpoint)
	{
		this.serviceEndpoint = serviceEndpoint;
	}
}
