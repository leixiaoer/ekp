package com.landray.kmss.geesun.leave.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class GeesunLeaveLastDayUtil {
	/**
	 * 获取某年最后一天日期
	 * 
	 * @param year
	 *            年份
	 * @return Date
	 */
	public static String getYearLast(int year) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.roll(Calendar.DAY_OF_YEAR, -1);
		Date currYearLast = calendar.getTime();
		String lastDay = format.format(currYearLast);
		return lastDay;
	}

	/**
	 * 获取某月最后一天日期
	 * 
	 * @throws ParseException
	 */
	public static String getMonthLast(String DateTime) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date thisDate = sdf.parse(DateTime);
		Calendar cld = Calendar.getInstance();
		cld.setTime(thisDate);
		// 月份+1，天设置为0；下个月第0天，就是这个月最后一天
		cld.add(Calendar.MONTH, 1);
		cld.set(Calendar.DAY_OF_MONTH, 1);
		String lastDay = sdf.format(cld.getTime());
		return lastDay;
	}

	/**
	 * 获取某月第一天日期
	 * 
	 * @throws ParseException
	 */
	public static String getMonthStart(String DateTime) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date thisDate = sdf.parse(DateTime);
		Calendar cld = Calendar.getInstance();
		cld.setTime(thisDate);
		// 月份+1，天设置为0；下个月第0天，就是这个月最后一天
		cld.add(Calendar.MONTH, 0);
		cld.set(Calendar.DAY_OF_MONTH, 1);
		String startDay = sdf.format(cld.getTime());
		return startDay;
	}

}
