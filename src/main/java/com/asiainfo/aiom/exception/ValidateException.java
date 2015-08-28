/**
 * @File: ValidateException.java 
 * @Package  com.asiainfo.aio.dashboard.support.exceptions
 * @Description: 
 * @author luyang
 * @date 2015年5月28日 下午3:02:58 
 * @version V1.0
 * 
 */
package com.asiainfo.aiom.exception;

/**
 * @author luyang
 *
 */
public class ValidateException extends RuntimeException
{
	private static final long serialVersionUID = 130839010011696322L;

	public ValidateException(String message)
	{
		super(message);
	}

}
