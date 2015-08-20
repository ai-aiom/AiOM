/**
 * @File: SpringContext.java 
 * @Package  com.asiainfo.aio.dashboard.support.spring
 * @Description: 
 * @author luyang
 * @date 2015年5月13日 上午10:53:04 
 * @version V1.0
 * 
 */
package com.asiainfo.support.spring;

import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * @author luyang
 *
 */
public class SpringContext implements ApplicationContextAware
{
	public static ApplicationContext context;
	
	public static Properties properties;

	public void setApplicationContext(ApplicationContext context) throws BeansException
	{
		SpringContext.context = context;
	}

	public void setProperties(Properties properties)
	{
		SpringContext.properties = properties;
	}
	
	public static <T> T getBean(Class<T> clazz)
	{
		return context.getBean(clazz);
	}
	
	public static Object getBean(String name)
	{
		return context.getBean(name);
	}
	
	public static String getProperty(String name)
	{
		return properties.getProperty(name);
	}
}