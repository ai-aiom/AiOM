/**
 * @File: PagingQueryActionBase.java 
 * @Package  com.asiainfo.support.struts2
 * @Description: 
 * @author luyang
 * @date 2015年9月23日 上午9:54:37 
 * @version V1.0
 * 
 */
package com.asiainfo.support.page;

import com.asiainfo.gim.client.auth.domain.query.QueryCondition;
import com.asiainfo.support.struts2.ServletAwareActionSupport;


/**
 * @author luyang
 *
 */
public class PagingQueryActionBase extends ServletAwareActionSupport
{
	private static final long serialVersionUID = -445209334624447578L;

	private int page = 0;

	private int rows = Integer.MAX_VALUE;

	public void setQueryCondition(QueryCondition queryCondition)
	{
		queryCondition.setStart(page > 0 ? (page - 1) * rows : 0);
		queryCondition.setLimit(rows);
	}

	public Integer getPage()
	{
		return page;
	}

	public void setPage(Integer page)
	{
		this.page = page;
	}

	public Integer getRows()
	{
		return rows;
	}

	public void setRows(Integer rows)
	{
		this.rows = rows;
	}
}
