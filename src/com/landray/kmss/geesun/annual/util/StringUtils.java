package com.landray.kmss.geesun.annual.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;

import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.KmssMessage;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.StringUtil;
import com.sun.star.lang.IllegalArgumentException;

public class StringUtils extends org.apache.commons.lang.StringUtils {

	
	public static <T extends Enum<T>>T getEnumFromString(Class<T> c,String string) throws IllegalArgumentException{
		T e=null;
		if(c!=null && string !=null){
			e= Enum.valueOf(c, string);
			
			
		}
		if(e==null){
			throw new IllegalArgumentException();
		}
		return e;
		
	}
	public static String getCell(Row row, int paramInt) throws Exception {

		Cell cell = row.getCell((short) paramInt);
		return changeToString(cell);
	}
	public static String getCellTrim(Row row, int paramInt) throws Exception {

		String cellValue=getCell(row,paramInt);
		if (StringUtil.isNotNull(cellValue)) {
			cellValue.trim();
		}else{
			cellValue="";
		}
		return cellValue;
		
	}

	public static String changeToString(Cell cell) throws Exception {
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
		String returnv = null;
		if (cell == null)
			return returnv;
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_FORMULA:
			try {
				returnv = String.valueOf(cell.getNumericCellValue());
			} catch (IllegalStateException e) {
				returnv = String.valueOf(cell.getRichStringCellValue());
			}
			break;
		case Cell.CELL_TYPE_NUMERIC: {
			double b = cell.getNumericCellValue();
			returnv = df.format(b);
			break;
		}
		case Cell.CELL_TYPE_STRING:
			returnv = cell.getStringCellValue();
			break;
		default:
			break;
		}
		return returnv;
	}

	public static boolean isBlankRow(Row row) throws Exception {
		boolean result = false;
		int length = 0;
		for (int i = 0; i < row.getLastCellNum(); i++) {
			Cell cell = row.getCell((short) i);
			if (StringUtil.isNull(StringUtils.changeToString(cell)))
				length++;
		}
		if (length == row.getLastCellNum())
			result = true;
		return result;
	}

	public static String changeToString(HSSFCell cell) throws Exception {
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
		String returnv = null;
		if (cell == null)
			return returnv;
		int type = cell.getCellType();
		switch (type) {
		case HSSFCell.CELL_TYPE_NUMERIC: {
			double b = cell.getNumericCellValue();
			returnv = df.format(b);
			break;
		}
		case HSSFCell.CELL_TYPE_STRING:
			returnv = cell.getStringCellValue();
			break;
		default:
			break;
		}
		return returnv;
	}

	public static String changeToString(XSSFCell cell) throws Exception {
		java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
		String returnv = null;
		if (cell == null)
			return returnv;
		int type = cell.getCellType();
		switch (type) {
		case HSSFCell.CELL_TYPE_NUMERIC: {
			double b = cell.getNumericCellValue();
			returnv = df.format(b);
			break;
		}
		case HSSFCell.CELL_TYPE_STRING:
			returnv = cell.getStringCellValue();
			break;
		default:
			break;
		}
		return returnv;
	}
	
	/**
	 * 
	 * 费用计划导出创建Cell方法 <br>
	 * 编写者：DengXu
	 * 创建时间：2014-11-12 下午2:58:03 </pre>
	 * @param 参数类型 参数名 说明
	 * @return void 说明
	 * @throws 异常类型 说明  
	 * @param row
	 * @param style
	 * @param cellIndex
	 * @param cellValue
	 */
	public static void createCell(Row row,CellStyle style,int cellIndex,String cellValue){
		Cell cell = row.createCell(cellIndex);
		cell.setCellStyle(style);
		cell.setCellValue(cellValue);
	}

	public static boolean isBlankRow(XSSFRow row) throws Exception {
		boolean result = false;
		int length = 0;
		for (int i = 0; i < row.getLastCellNum(); i++) {
			XSSFCell cell = row.getCell((short) i);
			if (StringUtil.isNull(StringUtils.changeToString(cell)))
				length++;
		}
		if (length == row.getLastCellNum())
			result = true;
		return result;
	}

	public static boolean isBlankRow(HSSFRow row) throws Exception {
		boolean result = false;
		int length = 0;
		for (int i = 0; i < row.getLastCellNum(); i++) {
			HSSFCell cell = row.getCell((short) i);
			if (StringUtil.isNull(StringUtils.changeToString(cell)))
				length++;
		}
		if (length == row.getLastCellNum())
			result = true;
		return result;
	}

	public static String listToInString(List<String> list) {
		String inStr = "";
		if (!ArrayUtil.isEmpty(list)) {
			StringBuffer ids = new StringBuffer();
			for (String id : list) {
				ids.append((String) id).append(",");
			}
			if (ids.length() > 1) {
				inStr = ids.toString()
						.substring(0, ids.toString().length() - 1);
			}
		}

		return inStr;

	}

	/**
	 * 验证是否数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str) {
		return str.matches("^[-+]?(([0-9]+)([.]([0-9]+))?|([.]([0-9]+))?)$");
	}

	/***
	 * 判断字符串是否浮点数字
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDouble(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	public static String objectToString(Object obj) {
		if (obj == null) {
			return "";
		}

		return obj.toString();
	}
	
	public static String objectArrayToString(Object obj) {
		if (obj == null) {
			return "";
		}

		if (obj instanceof String[]) {
			return StringUtils.objectToString(((String[]) obj)[0]);
		}
		return StringUtils.objectToString(obj);

	}

	/**
	 * 解决java生成excel中文名乱码问题方法
	 * 
	 * @param s
	 * @return
	 */
	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("utf-8");
				} catch (Exception ex) {
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}
	
	/** 
	*字符串的日期格式的计算 
	*/ 
	public static int daysBetween(String smdate,String bdate) throws ParseException{ 
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd"); 
		Calendar cal = Calendar.getInstance(); 
		cal.setTime(sdf.parse(smdate)); 
		long time1 = cal.getTimeInMillis(); 
		cal.setTime(sdf.parse(bdate)); 
		long time2 = cal.getTimeInMillis(); 
		long between_days=(time2-time1)/(1000*3600*24); 
	
		return Integer.parseInt(String.valueOf(between_days)); 
	} 

	/**
	 * 数字金额大写转换，思想先写个完整的然后将如零拾替换成零 要用到正则表达式
	 */
	public static String digitUppercase(double n) {
		String fraction[] = { "角", "分" };
		String digit[] = { "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖" };
		String unit[][] = { { "元", "万", "亿" }, { "", "拾", "佰", "仟" } };
		String head = n < 0 ? "负" : "";
		n = Math.abs(n);
		String s = "";
		for (int i = 0; i < fraction.length; i++) {
			s += (digit[(int) (Math.floor(n * 10 * Math.pow(10, i)) % 10)] + fraction[i])
					.replaceAll("(零.)+", "");
		}
		if (s.length() < 1) {
			s = "整";
		}
		int integerPart = (int) Math.floor(n);

		for (int i = 0; i < unit[0].length && integerPart > 0; i++) {
			String p = "";
			for (int j = 0; j < unit[1].length && n > 0; j++) {
				p = digit[integerPart % 10] + unit[1][j] + p;
				integerPart = integerPart / 10;
			}
			s = p.replaceAll("(零.)*零$", "").replaceAll("^$", "零") + unit[0][i]
					+ s;
		}
		return head
				+ s.replaceAll("(零.)*零元", "元").replaceFirst("(零.)+", "")
						.replaceAll("(零.)+", "零").replaceAll("^整$", "零元整");
	}
	
	public static String getMessageInfo(KmssMessage msg,HttpServletRequest request ) {
		Object[] params = msg.getParameter();
		if (params != null) {
			for (int i = 0; i < params.length; i++) {
				if (params[i] instanceof KmssMessage) {
					params[i] = StringUtils.getMessageInfo((KmssMessage) params[i],request);
				}
			}
			return ResourceUtil.getString(msg.getMessageKey(), null, request
					.getLocale(), params);
		} else {
			return ResourceUtil.getString(msg.getMessageKey(), request
					.getLocale());
		}
	}
	
	/**
	 * 根据传入的时间得到当前的季度
	 * @param dateTime
	 * @return
	 */
	public static int getSeasonByMonth(Date dateTime) {
		int season = 0;
		Calendar c = Calendar.getInstance();
		c.setTime(dateTime);
        int currentMonth = c.get(Calendar.MONTH) + 1;
        if (currentMonth >= 1 && currentMonth <= 3) {
            season = 1;
        } else if (currentMonth >= 4 && currentMonth <= 6) {
        	season = 2;
        } else if (currentMonth >= 7 && currentMonth <= 9) {
        	season = 3;
		} else if (currentMonth >= 10 && currentMonth <= 12) {
			season = 4;
		}
        return season;
	}
	
	/**
	 * 获取日期年份之差
	 * @param calendarBirth
	 * @param calendarNow
	 * @return
	 */
	public static int getNeturalAge(Calendar calendarBirth,Calendar calendarNow) { 
		int diffYears = 0, diffMonths, diffDays; 
		int dayOfBirth = calendarBirth.get(Calendar.DAY_OF_MONTH); 
		int dayOfNow = calendarNow.get(Calendar.DAY_OF_MONTH); 
		if (dayOfBirth <= dayOfNow) { 
			diffMonths = getMonthsOfAge(calendarBirth, calendarNow); 
			diffDays = dayOfNow - dayOfBirth; 
			if (diffMonths == 0) 
				diffDays++; 
		} else { 
			if (isEndOfMonth(calendarBirth)) { 
				if (isEndOfMonth(calendarNow)) { 
					diffMonths = getMonthsOfAge(calendarBirth, calendarNow); 
					diffDays = 0; 
				} else { 
					calendarNow.add(Calendar.MONTH, -1); 
					diffMonths = getMonthsOfAge(calendarBirth, calendarNow); 
					diffDays = dayOfNow + 1; 
				} 
			} else { 
				if (isEndOfMonth(calendarNow)) { 
					diffMonths = getMonthsOfAge(calendarBirth, calendarNow); 
					diffDays = 0; 
				} else { 
					calendarNow.add(Calendar.MONTH, -1);// 上个月 
					diffMonths = getMonthsOfAge(calendarBirth, calendarNow); 
					// 获取上个月最大的一天 
					int maxDayOfLastMonth = calendarNow.getActualMaximum(Calendar.DAY_OF_MONTH); 
					if (maxDayOfLastMonth > dayOfBirth) { 
						diffDays = maxDayOfLastMonth - dayOfBirth + dayOfNow; 
					} else { 
						diffDays = dayOfNow; 
					} 
				} 
			} 
		} 
		return diffMonths / 12; 
	} 
	
	/**  
	* 获取两个日历的月份之差  
	*   
	* @param calendarBirth  
	* @param calendarNow  
	* @return  
	*/ 
	public static int getMonthsOfAge(Calendar calendarBirth,  
			Calendar calendarNow) {  
		return (calendarNow.get(Calendar.YEAR) - calendarBirth  
			.get(Calendar.YEAR))* 12+ calendarNow.get(Calendar.MONTH)  
			- calendarBirth.get(Calendar.MONTH);  
	} 
	
	/**  
	* 判断这一天是否是月底  
	*   
	* @param calendar  
	* @return  
	*/ 
	public static boolean isEndOfMonth(Calendar calendar) {  
		int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);  
		if (dayOfMonth == calendar.getActualMaximum(Calendar.DAY_OF_MONTH))  
			return true;  
		return false;  
	}
	
}
