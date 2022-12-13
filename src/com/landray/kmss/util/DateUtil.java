package com.landray.kmss.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Pattern;

import com.landray.kmss.common.exception.KmssRuntimeException;
import com.landray.kmss.sys.language.utils.SysLangUtil;

/**
 * 日期转换类 转换一个 java.util.Date 对象到一个字符串以及 一个字符串到一个 java.util.Date 对象.
 */
public class DateUtil {
	public static final long SECOND = 1000;

	public static final long MINUTE = SECOND * 60;

	public static final long HOUR = MINUTE * 60;

	public static final long DAY = HOUR * 24;

	public static final long WEEK = DAY * 7;

	public static final long MONTH = DAY * 30;

	public static final long YEAR = DAY * 365;

	public static final String TYPE_DATE = "date";

	public static final String TYPE_TIME = "time";

	public static final String TYPE_DATETIME = "datetime";
	
	public static final String TYPE_TIME_SEC = "time.sec";

	private static final ThreadLocal<Long> LASTTIME = new ThreadLocal<Long>();

	/**
	 * 模式:yyyy-MM-dd HH:mm
	 */
	public static final String PATTERN_DATETIME = ResourceUtil
			.getString("date.format.datetime");

	/**
	 * 模式:yyyy-MM-dd
	 */
	public static final String PATTERN_DATE = ResourceUtil
			.getString("date.format.date");

	private static final String DEFAULT_PATTERN = PATTERN_DATETIME;

	public static final String[] TYPE_ALL = { TYPE_DATE, TYPE_DATETIME,
			TYPE_TIME };

	/**
	 * 将字符串转换为Date类型
	 * 
	 * @param strDate
	 * @param pattern
	 *            格式
	 * @return
	 * @throws ParseException
	 */
	public static Date convertStringToDate(String strDate, String pattern) {
		
		if (StringUtil.isNull(strDate) || "on".equals(strDate))
			return null;
		if (StringUtil.isNull(pattern))
			pattern = DEFAULT_PATTERN;
		// 在多语言的打开并且打开快捷时获取的msg的信息存在[],通过正则去除[] eg:[HH:mm]->HH:mm 该问题详见ResourceUtil.getStringValue(String key, String bundle, Locale locale) 返回值 by 王进府
		String localPattern = pattern.replaceAll("\\]|\\[", "");
		SimpleDateFormat df = new SimpleDateFormat(localPattern);
		try {
			return df.parse(strDate);
		} catch (ParseException e) {
			throw new KmssRuntimeException(e);
		}
	}

	/**
	 * 将字符串转换为Date类型
	 * 
	 * @param strDate
	 * @param type
	 *            见本类中的TYPE_*常量
	 * @param locale
	 * @return
	 * @throws ParseException
	 */
	public static Date convertStringToDate(String strDate, String type,
			Locale locale) {
		if (StringUtil.isNull(strDate))
			return null;
		if (StringUtil.isNull(type))
			type = TYPE_DATETIME;
		String pattern = ResourceUtil.getString("date.format." + type, locale);
		KmssRuntimeException rtnE;
		try {
			return convertStringToDate(strDate, pattern);
		} catch (KmssRuntimeException e) {
			rtnE = e;
		}
		for (int i = 0; i < TYPE_ALL.length; i++) {
			pattern = ResourceUtil.getString("date.format." + TYPE_ALL[i],
					locale);
			try {
				return convertStringToDate(strDate, pattern);
			} catch (KmssRuntimeException e) {
			}
		}
		List<String> langList = SysLangUtil.getSupportedLangList();
		if (langList != null && !langList.isEmpty()) {
			for (int i = 0; i < langList.size(); i++) {
				pattern = ResourceUtil.getStringValue("date.format." + type,
						null, ResourceUtil.getLocale(langList.get(i)));
				try {
					return convertStringToDate(strDate, pattern);
				} catch (KmssRuntimeException e) {
				}
			}
		}
		throw rtnE;
	}

	/**
	 * 将Date转换为字符串
	 * 
	 * @param aDate
	 * @param pattern
	 *            格式
	 * @return
	 */
	public static String convertDateToString(Date aDate, String pattern) {
		if (aDate == null)
			return null;
		if (StringUtil.isNull(pattern))
			pattern = DEFAULT_PATTERN;
		// 在多语言的打开并且打开快捷时获取的msg的信息存在[],通过正则去除[] eg:[HH:mm]->HH:mm 该问题详见ResourceUtil.getStringValue(String key, String bundle, Locale locale) 返回值 by 王进府
		String localPattern = pattern.replaceAll("\\]|\\[", "");
		SimpleDateFormat df = new SimpleDateFormat(localPattern);
		return df.format(aDate);
	}

	/**
	 * 将Date转换为字符串
	 * 
	 * @param aDate
	 * @param type
	 *            见本类中的TYPE_*常量
	 * @param locale
	 * @return
	 */
	public static String convertDateToString(Date aDate, String type,
			Locale locale) {
		if (aDate == null)
			return null;
		if (type == null)
			type = TYPE_DATETIME;
		String pattern = ResourceUtil.getString("date.format." + type, locale);
		return convertDateToString(aDate, pattern);
	}

	/**
	 * 将日期、时间合并成长整型数据
	 * 
	 * @param date
	 *            日期
	 * @param time
	 *            时间
	 * @return
	 */
	public static long getDateTimeNumber(Date date, Date time) {
		Calendar dateCal = getCalendar(date);
		Calendar timeCal = getCalendar(time);
		dateCal.set(Calendar.HOUR_OF_DAY, timeCal.get(Calendar.HOUR_OF_DAY));
		dateCal.set(Calendar.MINUTE, timeCal.get(Calendar.MINUTE));
		dateCal.set(Calendar.SECOND, timeCal.get(Calendar.SECOND));
		dateCal.set(Calendar.MILLISECOND, timeCal.get(Calendar.MILLISECOND));
		return dateCal.getTimeInMillis();
	}

	/**
	 * 将日期的时间部分清除后，转换成long类型
	 * 
	 * @param date
	 * @return
	 */
	public static long getDateNumber(Date date) {
		return removeTime(date).getTimeInMillis();
	}

	/**
	 * 获取日期(获取当天日期getDate(0))
	 * 
	 * @param day
	 * @return
	 */
	public static Date getDate(int day) {
		Calendar cal = getCalendar(new Date());
		cal.add(Calendar.DATE, day);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	/**
	 * 将时间的日期部分清除后，转换成long类型
	 * 
	 * @param date
	 * @return
	 */
	public static long getTimeNubmer(Date date) {
		return getCalendar(date).getTimeInMillis() - getDateNumber(date);
	}

	/**
	 * 将一个不包含日期的时间量，转换为Date类型，其中的日期为当天
	 * 
	 * @param l
	 * @return
	 */
	public static Date getTimeByNubmer(long l) {
		return new Date(getDateNumber(new Date()) + l);
	}

	public static Calendar getCalendar(long millis) {
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis(millis);
		return cal;
	}

	public static Calendar getCalendar(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal;
	}

	public static Calendar removeTime(Calendar cal) {
		if (cal == null) {
			return null;
		}
		
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal;
	}
	
	public static Calendar removeTime(Date date) {
		if (date == null) {
			return null;
		}

		Calendar cal = getCalendar(date);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal;
	}

	public static Date getNextDay(Date date, int day) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, day);
		return cal.getTime();
	}

	/**
	 * 获取当前时间，并保证在同一线程内后面调用的时间在前面调用之后（即便同一毫秒内）
	 */
	public static Date getDateQueue() {
		long now = System.currentTimeMillis();
		Long t = LASTTIME.get();
		if (t != null) {
			if (now <= t.longValue()) {
				now = t.longValue() + 1;
			}
		}
		LASTTIME.set(now);
		return new Date(now);
	}

	/**
	 * 获取今年是哪一年
	 * 
	 * @return
	 */
	public static Integer getNowYear() {
		Date date = new Date();
		GregorianCalendar gc = (GregorianCalendar) Calendar.getInstance();
		gc.setTime(date);
		return Integer.valueOf(gc.get(1));
	}

	/*
	 * 获取某个日期的结束时间
	 * 
	 * @param d
	 * 
	 * @return
	 */
	public static Timestamp getDayEndTime(Date d) {
		Calendar calendar = Calendar.getInstance();
		if (null != d)
			calendar.setTime(d);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 23, 59, 59);
		calendar.set(Calendar.MILLISECOND, 999);
		return new Timestamp(calendar.getTimeInMillis());
	}

	/**
	 * 获取某个日期的开始时间
	 * 
	 * @param d
	 * @return
	 */
	public static Timestamp getDayStartTime(Date d) {
		Calendar calendar = Calendar.getInstance();
		if (null != d)
			calendar.setTime(d);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		calendar.set(Calendar.MILLISECOND, 0);
		return new Timestamp(calendar.getTimeInMillis());
	}

	/**
	 * 获取本年的开始时间
	 * 
	 * @return
	 */
	public static java.util.Date getBeginDayOfYear() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, getNowYear());
		cal.set(Calendar.MONTH, Calendar.JANUARY);
		cal.set(Calendar.DATE, 1);
		return getDayStartTime(cal.getTime());
	}

	/**
	 * 获取本年的结束时间
	 * 
	 * @return
	 */
	public static java.util.Date getEndDayOfYear() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, getNowYear());
		cal.set(Calendar.MONTH, Calendar.DECEMBER);
		cal.set(Calendar.DATE, 31);
		return getDayEndTime(cal.getTime());
	}

	/**
	 * 获取本月的开始时间
	 * 
	 * @return
	 */
	public static java.util.Date getBeginDayOfMonth() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);
		return getDayStartTime(cal.getTime());
	}

	/**
	 * 获取本月的结束时间
	 * 
	 * @return
	 */
	public static java.util.Date getEndDayOfMonth() {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DATE));
		return getDayEndTime(cal.getTime());
	}
	
	/**
	 * 中国一周的第一天是周一，某些国家是周日，这里根据语言做了简单区分
	 * 
	 * @return
	 */
	private static Map<String, Object> getWeekCalendar() {
		Locale locale = ResourceUtil.getLocaleByUser();
		if (locale == null) {
			locale = ResourceUtil.getLocale(
					ResourceUtil.getKmssConfigString("kmss.lang.official"));
			if (locale == null) {
				locale = Locale.CHINA;
			}
		}
		Map<String, Object> map = new HashMap<>();
		Calendar cal = Calendar.getInstance(locale);
		// 中国把周一当做一周的第一天
		if (Locale.CHINA.equals(locale)) {
			cal.setFirstDayOfWeek(Calendar.MONDAY);
			map.put("firstDayOfWeek", Calendar.MONDAY);
			map.put("lastDayOfWeek", Calendar.SUNDAY);
		} else {
			cal.setFirstDayOfWeek(Calendar.SUNDAY);
			map.put("firstDayOfWeek", Calendar.SUNDAY);
			map.put("lastDayOfWeek", Calendar.SATURDAY);
		}
		map.put("cal", cal);
		return map;
	}

	/**
	 * 获取本周的开始时间
	 * 
	 * @return
	 */
	public static java.util.Date getBeginDayOfWeek() {
		Map<String, Object> map = getWeekCalendar();
		Calendar cal = (Calendar) map.get("cal");
		cal.set(Calendar.DAY_OF_WEEK, (Integer) map.get("firstDayOfWeek"));
		return getDayStartTime(cal.getTime());
	}

	/**
	 * 获取本周的结束时间
	 * 
	 * @return
	 */
	public static java.util.Date getEndDayOfWeek() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getBeginDayOfWeek());
		cal.add(Calendar.DAY_OF_WEEK, 6);
		return getDayEndTime(cal.getTime());
	}

	/**
	 * 将字符串转换为Date类型,字段识别日期格式
	 * 
	 * @param strDate
	 * @return
	 * @throws ParseException
	 */
	public static Date convertStringToDate(String strDate) {
		if (StringUtil.isNull(strDate))
			return null;
		if(Pattern.matches("^\\d+$", strDate)) {
			//如果全是数字，则表示它是long类型的日期数据
			return new Date(Long.valueOf(strDate));
		}
		return convertStringToDate(strDate,getDateFormat(strDate));
	}

	
	/**
     * 常规自动日期格式识别
     * @param str 时间字符串
     * @return Date
     * @author dc
     */
    public static String getDateFormat(String str) {
        boolean year = false;
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
        if(pattern.matcher(str.substring(0, 4)).matches()) {
            year = true;
        }
        StringBuilder sb = new StringBuilder();
        int index = 0;
        if(!year) {
            if(str.contains("月") || str.contains("-") || str.contains("/")) {
                if(Character.isDigit(str.charAt(0))) {
                    index = 1;
                }
            }else {
                index = 3;
            }
        }
        for (int i = 0; i < str.length(); i++) {
            char chr = str.charAt(i);
            if(Character.isDigit(chr)) {
                if(index==0) {
                    sb.append("y");
                }
                if(index==1) {
                    sb.append("M");
                }
                if(index==2) {
                    sb.append("d");
                }
                if(index==3) {
                    sb.append("H");
                }
                if(index==4) {
                    sb.append("m");
                }
                if(index==5) {
                    sb.append("s");
                }
                if(index==6) {
                    sb.append("S");
                }
            }else {
                if(i>0) {
                    char lastChar = str.charAt(i-1);
                    if(Character.isDigit(lastChar)) {
                        index++;
                    }
                }
                sb.append(chr);
            }
        }
        return sb.toString();
    }

	/**
	 * 计算两个日期相差多少天
	 * 
	 * @param endDate
	 * @param beginDate
	 * @return
	 */
	public static long getDatePoor(Date endDate, Date beginDate) {
		if (null == endDate || null == beginDate) {
			return 0;
		}
		// 获得两个时间的毫秒时间差异
		long diff = endDate.getTime() - beginDate.getTime();
		long day = 0;
		if (diff >= 0) {
			// 计算差多少天
			day = diff / DAY;
			if (diff % DAY != 0) {
				day = day + 1;
			}
		}
		return day;
	}
}
