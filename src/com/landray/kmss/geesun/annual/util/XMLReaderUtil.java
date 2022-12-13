package com.landray.kmss.geesun.annual.util;

import java.util.HashMap;
import java.util.Map;

import org.dom4j.DocumentException;

/**
 * XMLReader工具类，将XMLReader对象放入该工具类中
 * @author 黄诚芳
 *
 */
public class XMLReaderUtil {
	
	private static Map<String, XMLReader> xmlReaders = new HashMap<String, XMLReader>();
	
	/**
	 * 以指定的key获取一个XMLReader对象
	 * @param key
	 * @return
	 */
	public static XMLReader get(String key){
		return xmlReaders.get(key);
	}
	
	/**
	 * 以指定的key放入一个XMLReader对象
	 * @param key
	 * @param xmlReader
	 */
	public static void put(String key, XMLReader xmlReader){
		xmlReaders.put(key, xmlReader);
	}
	
	/**
	 * 以指定key删除存放的XMLReader对象
	 * @param key
	 */
	public static void remove(String key) {
		xmlReaders.remove(key);
	}
	
	/**
	 * 重新加载以key存放的XMLReader
	 * @param key
	 * @throws DocumentException
	 */
	public static void reload(String key) throws DocumentException {
		XMLReader xmlReader = xmlReaders.get(key);
		if(xmlReader != null) {
			xmlReader.reload();
		}
	}
}
