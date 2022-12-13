package com.landray.kmss.geesun.ehr.utils;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

public class PropertiesUtil {

	    /**
	     * 读取配置文件
	     */
	    public static String readProperties(String key,String fileName,String rootPath) throws IOException{
	        	Properties props = new Properties();
	    		String path = rootPath+"/"+fileName;
	    		path = path.replace("\\", File.separator);
	    		path = path.replace("/", File.separator);
	            InputStream is = new BufferedInputStream(new FileInputStream(path));
	            BufferedReader bf = new BufferedReader(new  InputStreamReader(is,"UTF-8"));//解决读取properties文件中产生中文乱码的问题
	            props.load(bf);
	            String value = props.getProperty(key);
	            return value;
	    }

	    /***
	    *
	    @author: huangzhuanglai
	    @createDate: 2022/8/9
	    @description: 读取配置文件，返回properties对象
	    */
	public static Properties readProperties(String fileName,String rootPath) throws IOException{
		Properties props = new Properties();
		String path = rootPath+"/"+fileName;
		path = path.replace("\\", File.separator);
		path = path.replace("/", File.separator);
		InputStream is = new BufferedInputStream(new FileInputStream(path));
		BufferedReader bf = new BufferedReader(new  InputStreamReader(is,"UTF-8"));//解决读取properties文件中产生中文乱码的问题
		props.load(bf);
		return props;

	}

	}
		
