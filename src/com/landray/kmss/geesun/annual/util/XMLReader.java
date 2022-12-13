package com.landray.kmss.geesun.annual.util;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 读取XML文件
 * @author 黄诚芳
 *
 */
public class XMLReader {
	
	private Document document;
	
	private Element root;

	private String filePath;
	
	public XMLReader(String filePath) throws DocumentException{
		load(filePath);
	}
	
	/**
	 * @return XML
	 */
	public Document getDocument() {
		return document;
	}

	/**
	 * 根节点
	 * @return
	 */
	public Element getRoot() {
		return root;
	}
	
	private void load(String filePath) throws DocumentException {
		SAXReader reader = new SAXReader();
		this.filePath = filePath;
		document = reader.read(XMLReader.class.getClassLoader().getResourceAsStream(filePath));
		root = document.getRootElement();
	}
	
	public void reload() throws DocumentException {
		load(this.filePath);
	}
}
