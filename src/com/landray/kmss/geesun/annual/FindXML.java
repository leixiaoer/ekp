package com.landray.kmss.geesun.annual;

import java.io.File;

/**
 * 用于定位XML文件
 * @author 黄诚芳
 *
 */
public class FindXML {
	private static final String path = FindXML.class.getPackage().getName()
			.replace('.', File.separatorChar)+File.separator;
	/**
	 * alterRecord.xml路径
	 */
	public static final String alterRecordPath = path + "alterRecord.xml";
}
