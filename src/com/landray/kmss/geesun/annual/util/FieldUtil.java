package com.landray.kmss.geesun.annual.util;

import java.lang.reflect.Method;

import com.landray.kmss.util.StringUtil;

public class FieldUtil {
	/**
	 * 从obj对象中获取fieldName属性的值，通过get方法获取，确保该属性有get方法
	 * @param obj
	 * @param fieldName
	 * @return
	 * @throws Exception
	 */
	public static Object getValue(Object obj, String fieldName) throws Exception {
		return getValue(obj, fieldName, false);
	}
	
	/**
	 * 从obj对象中获取fieldName属性的值，通过get方法获取，确保该属性有get方法
	 * @param obj
	 * @param fieldName
	 * @param isBoolean 字段的属性是不是boolean
	 * @return
	 * @throws Exception
	 */
	public static Object getValue(Object obj, String fieldName, boolean isBoolean) throws Exception{
		if(obj == null) {
			return null;
		}
		if(StringUtil.isNull(fieldName)) {
			return obj;
		}
		Method getterMethod = getterMethod(obj.getClass(), fieldName, isBoolean);
		return getterMethod.invoke(obj, null);
	}
	
	/**
	 * 比较obj1和obj2两个对象的fieldName值是否相等。如果两个属性值皆为null，返回null，该属性的不是boolean类型
	 * 如果fieldName为null，则equals比较obj1和obj2，如果obj1和obj2为null，返回null
	 * @param obj1
	 * @param obj2
	 * @param fieldName
	 * @return
	 * @throws Exception
	 */
	public static Boolean compareField(Object obj1, Object obj2, String fieldName) throws Exception{
		return compareField(obj1, obj2, fieldName, false);
	}
	
	/**
	 * 比较obj1和obj2两个对象的fieldName值是否相等。如果两个属性值皆为null，返回null
	 * 如果fieldName为null，则equals比较obj1和obj2，如果obj1和obj2为null，返回null
	 * @param obj1
	 * @param obj2
	 * @param fieldName
	 * @param isBoolean 该属性是不是boolean类型
	 * @return
	 * @throws Exception
	 */
	public static Boolean compareField(Object obj1, Object obj2, String fieldName, boolean isBoolean) throws Exception{
		if(StringUtil.isNull(fieldName)) {
			return compareObject(obj1, obj2);
		}
		Object value1 = getValue(obj1, fieldName, isBoolean);
		Object value2 = getValue(obj2, fieldName, isBoolean);
		return compareObject(value1, value2);
	}
	
	/**
	 * 比较两个对象
	 * @param obj1
	 * @param obj2
	 * @return
	 */
	private static Boolean compareObject(Object obj1, Object obj2){
		if(obj1 != null) {
			return obj1.equals(obj2);
		}
		if(obj2 != null) {
			return false;
		}
		return null;
	}
	
	/**
	 * 获取一个class的fieldName属性的get方法
	 * @param objClass
	 * @param fieldName
	 * @param isBoolean
	 * @return
	 * @throws Exception
	 */
	private static Method getterMethod(Class objClass, String fieldName, boolean isBoolean) throws Exception{
		if(objClass == null || StringUtil.isNull(fieldName)) {
			return null;
		}
		String methodName = "";
		if(isBoolean) {
			if(fieldName.startsWith("is") && fieldName.length()>2 && Character.isUpperCase(fieldName.charAt(2))){
				methodName = fieldName;
			}else {
				methodName = StringUtil.linkString("is", "", getMethodName(fieldName));
			}
		} else {
			methodName=StringUtil.linkString("get", "", getMethodName(fieldName));
		}
		return objClass.getMethod(methodName, null);
	}
	
	/**
	 * get方法生成规则
	 * @param fieldName
	 * @return
	 */
	private static String getMethodName(String fieldName) {
		if(StringUtil.isNull(fieldName)) {
			return null;
		}
		if(fieldName.length() > 1 && Character.isLowerCase(fieldName.charAt(0)) && Character.isUpperCase(fieldName.charAt(1))) {
			return fieldName;
		}
		return fieldName.substring(0, 1).toUpperCase()+fieldName.substring(1);
	}
	
}
