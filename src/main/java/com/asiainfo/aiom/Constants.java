/**   
* @Title: Constants.java 
* @Package com.asiainfo.aiom 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangli
* @date 2015年8月12日 上午10:05:10 
* @version V1.0   
*/
package com.asiainfo.aiom;

/**
 * @author zhangli
 *
 */
public interface Constants
{
	public static interface MachineType
	{
		public static final int OCDC = 1;
		public static final int ADB = 2;
		public static final int DACP = 3;
		public static final int ORACLE = 4;
	}
	
	public static interface MonitorType
	{
		public static final int ICMP = 1;
		public static final int SSH = 2;
		public static final int AGENT = 3;
	}
}
