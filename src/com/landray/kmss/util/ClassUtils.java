package com.landray.kmss.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;

import com.landray.kmss.sys.config.dict.SysDataDict;

public class ClassUtils {
	
	private static final Map<String, Class<?>> commonClassCache = new HashMap<>(64);
	
	public static Class<?> forName(String className) throws ClassNotFoundException {
		
		Class<?> clazz = null;
		if (StringUtils.isNotBlank(className)) {
			clazz = commonClassCache.get(className);
			if (clazz != null) {
				return clazz;
			} else {
				clazz = forName(className, org.springframework.util.ClassUtils.getDefaultClassLoader());
				commonClassCache.put(className, clazz);
			}
		}

		return clazz;
	}

	public static Class<?> forName(String className, ClassLoader classLoader) throws ClassNotFoundException, LinkageError {
		try {
			Class<?> clazz = null;
			if (StringUtils.isNotBlank(className)) {
				clazz = commonClassCache.get(className);
				if (clazz != null) {
					return clazz;
				} else {
					clazz = org.springframework.util.ClassUtils.forName(className, classLoader);
					commonClassCache.put(className, clazz);
				}
			}
			
			return clazz;
		} catch (Exception e) {
			// 判断className是否简称
			if (!className.contains(".")) {
				className = buildModelName().get(className);
				if (StringUtils.isNotBlank(className)) {
					Class<?> clazz = null;
					if (null != className) {
						clazz = commonClassCache.get(className);
						if (clazz != null) {
							return clazz;
						} else {
							clazz = org.springframework.util.ClassUtils.forName(className, classLoader);
							commonClassCache.put(className, clazz);
						}
					}
					return clazz;
				}
			}
			throw e;
		}
	}

	private static Map<String, String> modelNames;

	private synchronized static Map<String, String> buildModelName() {
		if (modelNames == null) {
			modelNames = new ConcurrentHashMap<String, String>(16);
			List<String> list = SysDataDict.getInstance().getModelInfoList();
			if (CollectionUtils.isNotEmpty(list)) {
				for (String modelName : list) {
					int i = modelName.lastIndexOf('.');
					String simpleName = modelName;
					if (i > -1) {
						simpleName = modelName.substring(i + 1);
					}
					modelNames.put(simpleName, modelName);
				}
			}
		}
		return modelNames;
	}
}
