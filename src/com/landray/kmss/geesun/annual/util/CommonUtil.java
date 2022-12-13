package com.landray.kmss.geesun.annual.util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import com.landray.kmss.common.dao.HQLParameter;
import com.landray.kmss.common.dao.HQLWrapper;
import com.landray.kmss.util.StringUtil;

public class CommonUtil {
	
	/**
	 * double 类型转 string 类型
	 * @param d
	 * @return
	 * 2014-11-26
	 * @author guoyp
	 */
	public static String doubleToString(double d){
		String str = null;
		BigDecimal b = new BigDecimal(String.valueOf(d));
		str = b.toString();
		return str;
	}
	
	/**
	 * double类型减法
	 * @param d 被减数
	 * @param d2 减数
	 * 2014-11-26
	 * @author guoyp
	 */
	public static double doubleSub(double d,double d2){
		double value = 0.0;
		Double v1 = Double.valueOf(d);
		Double v2 = Double.valueOf(d2);
		BigDecimal b = new BigDecimal(String.valueOf(v1));
		BigDecimal b2 = new BigDecimal(String.valueOf(v2));
		value = b.subtract(b2).doubleValue();
		return value;
	}
	
	/**
	 * double类型加法
	 * @param d
	 * @param d2
	 * @return
	 * 2014-11-26
	 * @author guoyp
	 */
	public static double doublePlus(double d,double d2){
		double value = 0.0;
		Double v1 = Double.valueOf(d);
		Double v2 = Double.valueOf(d2);
		BigDecimal b = new BigDecimal(String.valueOf(v1));
		BigDecimal b2 = new BigDecimal(String.valueOf(v2));
		value = b.add(b2).doubleValue();
		return value;
	}
	
	/**
	 * double类型加法
	 * @param d
	 * @param d2
	 * @return
	 * 2014-11-26
	 * @author guoyp
	 */
	public static double doublePlus(String d,String d2){
		double value = 0.0;
		BigDecimal b = new BigDecimal(d);
		BigDecimal b2 = new BigDecimal(d2);
		value = b.add(b2).doubleValue();
		return value;
	}
	
	/**
	 * 判断double类型字段money是否为空或者小于0
	 * @param money
	 * @return
	 * 2014-11-26
	 * @author guoyp
	 */
	public static boolean checkIsNullOrZero(Double money){
		boolean flag = true;
		if(null != money && money > 0)
			flag = false;
		return flag;
	} 
	
	/**
	 * 校验orgin是否在target内
	 * @author guoyp
	 * @param orgin
	 * @param target
	 * @return
	 */
	public static boolean checkStringInArray(String orgin, String target){
		boolean flag = false;
		if(StringUtil.isNull(orgin) || StringUtil.isNull(target)){
			return flag;
		}
		String[] object = target.split("\\s*[,;]\\s*");
		for(int i=0; i<object.length; i++){
			if(orgin.equals(object[i]))
				flag = true;
		}
		return flag;
	}
	
	/**
	 * 构造not in语句，若valueList超过1000时，该函数会自动拆分成多个not in语句
	 * 
	 * @param item
	 * @param valueList
	 * @return item not in (valueList)
	 */
	public static String buildLogicNotIN(String item, List valueList) {
		int n = (valueList.size() - 1) / 1000;
		StringBuffer rtnStr = new StringBuffer();
		Object obj = valueList.get(0);
		boolean isString = false;
		if (obj instanceof Character || obj instanceof String)
			isString = true;
		String tmpStr;
		for (int i = 0; i <= n; i++) {
			int size = i == n ? valueList.size() : (i + 1) * 1000;
			if (i > 0)
				rtnStr.append(" and ");
			rtnStr.append(item + " not in (");
			if (isString) {
				StringBuffer tmpBuf = new StringBuffer();
				for (int j = i * 1000; j < size; j++) {
					tmpStr = valueList.get(j).toString().replaceAll("'", "''");
					tmpBuf.append(",'").append(tmpStr).append("'");
				}
				tmpStr = tmpBuf.substring(1);
			} else {
				tmpStr = valueList.subList(i * 1000, size).toString();
				tmpStr = tmpStr.substring(1, tmpStr.length() - 1);
			}
			rtnStr.append(tmpStr);
			rtnStr.append(")");
		}
		if (n > 0)
			return "(" + rtnStr.toString() + ")";
		else
			return rtnStr.toString();
	}
}
