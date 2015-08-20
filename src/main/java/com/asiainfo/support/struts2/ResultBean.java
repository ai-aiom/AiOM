/**
 * @File: ResultBean.java 
 * @Package  com.asiainfo.aio.dashboard.support.struts2
 * @Description: 
 * @author luyang
 * @date 2015年5月5日 上午9:17:20 
 * @version V1.0
 * 
 */
package com.asiainfo.support.struts2;

/**
 * @author luyang
 *
 */
public class ResultBean
{
	private boolean success;

	private String message;

	public ResultBean(boolean success, String message)
	{
		super();
		this.success = success;
		this.message = message;
	}

	public boolean isSuccess()
	{
		return success;
	}

	public void setSuccess(boolean success)
	{
		this.success = success;
	}

	public String getMessage()
	{
		return message;
	}

	public void setMessage(String message)
	{
		this.message = message;
	}

}
