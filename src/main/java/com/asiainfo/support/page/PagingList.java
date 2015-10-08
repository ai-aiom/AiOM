/**
 * @File: PagingList.java 
 * @Package  com.asiainfo.aio.aaa.utils
 * @Description: 
 * @author luyang
 * @date 2015年9月23日 上午10:26:17 
 * @version V1.0
 * 
 */
package com.asiainfo.support.page;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

/**
 * @author luyang
 *
 * @param <T>
 */
@JsonSerialize(using = PagingList.PageListJsonSerializer.class)
public class PagingList<T> implements List<T>
{
	private int count;
	
	private List<T> proxy;
	
	public PagingList(int count, Collection<T> c)
	{
		proxy = new ArrayList<T>(c);
		this.count = count;
	}
	
	public int getCount()
	{
		return count;
	}

	public void setCount(int count)
	{
		this.count = count;
	}

	@Override
	public int size()
	{
		return proxy.size();
	}

	@Override
	public boolean isEmpty()
	{
		return proxy.isEmpty();
	}

	@Override
	public boolean contains(Object o)
	{
		return proxy.contains(o);
	}

	@Override
	public Iterator<T> iterator()
	{
		return proxy.iterator();
	}

	@Override
	public Object[] toArray()
	{
		return proxy.toArray();
	}

	@Override
	public <T> T[] toArray(T[] a)
	{
		return proxy.toArray(a);
	}

	@Override
	public boolean add(T e)
	{
		return proxy.add(e);
	}

	@Override
	public boolean remove(Object o)
	{
		return proxy.remove(o);
	}

	@Override
	public boolean containsAll(Collection<?> c)
	{
		return proxy.containsAll(c);
	}

	@Override
	public boolean addAll(Collection<? extends T> c)
	{
		return proxy.addAll(c);
	}

	@Override
	public boolean addAll(int index, Collection<? extends T> c)
	{
		return proxy.addAll(index, c);
	}

	@Override
	public boolean removeAll(Collection<?> c)
	{
		return proxy.removeAll(c);
	}

	@Override
	public boolean retainAll(Collection<?> c)
	{
		return proxy.retainAll(c);
	}

	@Override
	public void clear()
	{
		proxy.clear();
	}

	@Override
	public T get(int index)
	{
		return proxy.get(index);
	}

	@Override
	public T set(int index, T element)
	{
		return proxy.set(index, element);
	}

	@Override
	public void add(int index, T element)
	{
		proxy.add(index, element);
	}

	@Override
	public T remove(int index)
	{
		return proxy.remove(index);
	}

	@Override
	public int indexOf(Object o)
	{
		return proxy.indexOf(o);
	}

	@Override
	public int lastIndexOf(Object o)
	{
		return proxy.lastIndexOf(o);
	}

	@Override
	public ListIterator<T> listIterator()
	{
		return proxy.listIterator();
	}

	@Override
	public ListIterator<T> listIterator(int index)
	{
		return proxy.listIterator(index);
	}

	@Override
	public List<T> subList(int fromIndex, int toIndex)
	{
		return proxy.subList(fromIndex, toIndex);
	}
	
	public static class PageListJsonSerializer extends JsonSerializer<PagingList>
	{
		public void serialize(PagingList list, JsonGenerator jg, SerializerProvider arg2) throws IOException,
				JsonProcessingException
		{
			jg.writeStartObject();
			jg.writeNumberField("total", list.count);
			jg.writeObjectField("rows", list.proxy);
			jg.writeEndObject();
		}
	}
}
