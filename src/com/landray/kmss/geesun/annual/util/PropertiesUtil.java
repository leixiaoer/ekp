package com.landray.kmss.geesun.annual.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;

/**
 * 配置文件读取工具类
 */

public class PropertiesUtil {
	/**
	 * 读取数据库连接信息
	 * 用于ActivitiEngineRejector
	 *  @param key
	 *  @return
	 *  String
	 */
	public static String getPropertyVal(String key) {
		Properties pps = new Properties();
		try {
//			InputStream in = new BufferedInputStream(new FileInputStream("src/database.properties"));
			InputStream in = PropertiesUtil.class.getResourceAsStream("/database.properties");	
			pps.load(in);
			String value = pps.getProperty(key);
//			System.out.println(key + " = " + value);
			return value;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	/**
	 * 根据文件路径和配置名称取得配置的值
	 *  @param filepath
	 *  @param key
	 *  @return
	 *  String
	 */
	public static String getPropertyVal(String filepath,String key) {
		Properties pps = new Properties();
		try {
//			InputStream in = new BufferedInputStream(new FileInputStream("src/database.properties"));
			InputStream in = PropertiesUtil.class.getResourceAsStream(filepath);	
			pps.load(in);
			String value = pps.getProperty(key);
//			System.out.println(key + " = " + value);
			return value;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}	
	
	public static void setPropertyVal(String proppath,String key,String value) {
		Properties pps = new Properties();
		//System.out.println(proppath);
		try {
//			InputStream in = new BufferedInputStream(new FileInputStream("src/database.properties"));
			/*InputStream in = PropertiesUtil.class.getResourceAsStream(proppath);	
			pps.load(in);*/
			OutputStream out = new FileOutputStream(proppath);
			pps.setProperty(key,value);
			pps.store(out, "");
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}	
	
	/**
	 * 去除小数点
	 * @param input
	 * @return
	 */
	public static String removePoint(Object input){
		String inputString=String.valueOf(input);
		if(!inputString.contains(".")){
			return inputString;
		}else{
			return (inputString.split("\\."))[0];
		}
	}
	
	
	/**
	 * 确保所有的钱都是保留2位小数
	 */
	public static String formDouble(Object object){
		if(object==null||String.valueOf(object).equals("null")){
			return "0.00";
		}
		if(!String.valueOf(object).contains(".")){
			return String.valueOf(object)+".00";
		}
		String value=String.valueOf(object);
		String[] values=value.split("\\.");
		if(values[1].length()<2){
			return String.valueOf(object)+"0";
		}else if(values[1].length()>2){
			int i=Integer.parseInt(String.valueOf(values[1].charAt(2)));
			if(i>4){
				int j=Integer.parseInt(String.valueOf(values[1].charAt(1)));
				j++;
				char c=values[1].charAt(0);
				return values[0]+"."+j+c;
			}else{
				int location=value.indexOf(".");
				return value.substring(0, location+3);
			}
		}else{
			return value;
		}
	}
	
	
	
	
	public static void main(String[] args){		
		System.out.println(removePoint("20024.0"));
		//String val = PropertiesUtil.getPropertyVal("jsdw02_133.url");
		//System.out.println(val);
	}
}
