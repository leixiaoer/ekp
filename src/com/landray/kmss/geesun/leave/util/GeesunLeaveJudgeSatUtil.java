package com.landray.kmss.geesun.leave.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 
 * 获取时间段信息
 * 
 * @author 渣渣辉
 *
 */
public class GeesunLeaveJudgeSatUtil {

	/**
	 * 获取时间是否为周六
	 */
	public static boolean calLeaveDays(String dateTime) throws ParseException {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date bdate = format.parse(dateTime);
		Calendar cal = Calendar.getInstance();
		cal.setTime(bdate);
		if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) {
			return true;
		}
		return false;
	}

	/**
	 * 获取时间段的前,后一天 true为后一天,false为当天
	 */
	public static String getLastDay(String time, boolean boo) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Calendar calendar = Calendar.getInstance();
		Date date = null;
		try {
			date = format.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		calendar.setTime(date);
		int day = calendar.get(Calendar.DATE);
		// 此处修改为+1则是获取后一天
		if (boo == true) {
			calendar.set(Calendar.DATE, day + 1);
		} else {
			calendar.set(Calendar.DATE, day);
		}
		String lastDay = format.format(calendar.getTime()).substring(0, 10);
		lastDay += " 00:00";
		return lastDay;
	}

	/**
	 * 判断指定日期时间(yyyy-MM-dd HH:ss)是否是周一开始至周一中午十二点之间
	 * 
	 * @throws ParseException
	 */
	public static Boolean JuMonday(String dateTime) throws ParseException {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date bdate = dateFormat.parse(dateTime);
		Calendar cal = Calendar.getInstance();
		cal.setTime(bdate);
		if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.MONDAY) { // 判断是否为周一
			Long startTime = format.parse(dateTime.substring(0, 10) + " 00:00").getTime(); // 周一开始时间
			Long endTime = format.parse(dateTime.substring(0, 10) + " 12:00").getTime(); // 周一中午12点
			Long value = format.parse(dateTime).getTime(); // 传入日期的毫秒值
			if (startTime <= value && endTime >= value) { // 判断时间是否在凌晨至十二点之间
				return true;
			}
		}
		return false;
	}

}
