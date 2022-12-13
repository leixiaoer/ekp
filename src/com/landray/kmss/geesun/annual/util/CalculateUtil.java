package com.landray.kmss.geesun.annual.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;

public class CalculateUtil {

	/**
	 * double类型减法
	 * 
	 * @param d
	 *            被减数
	 * @param d2
	 *            减数 2017-7-11
	 * @author guoyp
	 */
	public static double doubleSub(double d, double d2) {
		double value = 0.0;
		Double v1 = Double.valueOf(d);
		Double v2 = Double.valueOf(d2);
		if (v1 == null) {
			v1 = 0.0;
		}
		if (v2 == null) {
			v2 = 0.0;
		}
		BigDecimal b = new BigDecimal(String.valueOf(v1));
		BigDecimal b2 = new BigDecimal(String.valueOf(v2));
		value = b.subtract(b2).doubleValue();
		return value;
	}
	
	/**
	 * string类型减法
	 * 
	 * @param d
	 * @param d2
	 * @return
	 */
	public static double sub(String d, String d2) {
		double value = 0.0;
		if(d == null){
			d = "0";
		}
		if(d2 == null){
			d2 = "0";
		}
		BigDecimal b = new BigDecimal(d);
		BigDecimal b2 = new BigDecimal(d2);
		value = b.subtract(b2).doubleValue();
		return value;
	}
	
	 /** 
     * double 相减 
     * @param d1 
     * @param d2 
     * @return 
     */ 
	public static double sub(double d1,double d2) {
		BigDecimal bd1 = new BigDecimal(Double.toString(d1)); 
	    BigDecimal bd2 = new BigDecimal(Double.toString(d2));
	  
	    return roundDecimal(bd1.subtract(bd2).doubleValue()); 
	}
	 /** 
     * double 相加 
     * @param d1 
     * @param d2 
     * @return 
     */ 
	public static double sum(double d1,double d2) {
		BigDecimal bd1 = new BigDecimal(Double.toString(d1)); 
	    BigDecimal bd2 = new BigDecimal(Double.toString(d2)); 
	    return roundDecimal(bd1.add(bd2).doubleValue()); 
	}
	/**
	 * double类型加法
	 * 
	 * @param d
	 * @param d2
	 * @return
	 * @author guoyp
	 */
	public static double sum(String d, String d2) {
		double value = 0.0;
		if(d == null){
			d = "0";
		}
		if(d2 == null){
			d2 = "0";
		}
		BigDecimal b = new BigDecimal(d);
		BigDecimal b2 = new BigDecimal(d2);

		value = b.add(b2).doubleValue();
		return value;
	}
	/**
	 * 保留两位小数
	 * @param fTemp
	 * @return
	 */
	public static double roundDecimal(double fTemp) {
		DecimalFormat df = new DecimalFormat("#.##");
		return Double.parseDouble(df.format(fTemp));
	}
	
	/**
	 * double 类型转 string 类型
	 * 
	 * @param d
	 * @return 2015-5-19
	 * @author guoyp
	 */
	public static String doubleToString(double d) {
		String str = null;
		BigDecimal b = new BigDecimal(String.valueOf(d));
		str = b.toString();
		return str;
	}

	/**
	 * string 类型转 double 类型
	 * 
	 * @param d
	 * @return 2015-5-19
	 * @author guoyp
	 */
	public static double stringToDouble(String str) {
		BigDecimal b = new BigDecimal(str);
		return b.doubleValue();
	}
	
}
