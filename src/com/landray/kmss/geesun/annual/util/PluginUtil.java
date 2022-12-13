package com.landray.kmss.geesun.annual.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.landray.kmss.framework.plugin.core.config.IExtension;
import com.landray.kmss.framework.plugin.core.config.IExtensionPoint;
import com.landray.kmss.framework.service.plugin.Plugin;

/**
 * 扩展工具类
 * 
 * @author 苏韶勇
 * @version 1.0 2012-09-05
 */
public abstract class PluginUtil {

	private static final Log logger = LogFactory.getLog(PluginUtil.class);

	public static final String EXTENSION_EXPENSE_POINT_ID = "com.landray.kmss.fs.expense";

	private static final String ITEM = "extend";

	public static final String PARAM_UUID = "unid";

	public static final String PARAM_NAME = "name";

	public static final String PARAM_FORM_NAME = "formName";

	public static final String PARAM_EDIT_FORWARD = "editForward";

	public static final String PARAM_VIEW_FORWARD = "viewForward";

	public static final String PARAM_MODIFY_FORWARD = "modifyForward";

	public static final String PARAM_CONTROLLER_SERVICE = "controllerService";

	public static final String PARAM_BUSINESS_SERVICE = "businessService";

	private static Map<String, List<Map<String, String>>> configs = new HashMap<String, List<Map<String, String>>>();

	/**
	 * 子表单扩展点
	 * 
	 * @return
	 */
	public static Map<String, List<Map<String, String>>> getConfigs(
			String extensionPointId) {
		if (null == configs.get(extensionPointId)
				|| configs.get(extensionPointId).isEmpty()) {
			synchronized (configs) {
				if (null == configs.get(extensionPointId)
						|| configs.get(extensionPointId).isEmpty()) {
					IExtensionPoint point = Plugin
							.getExtensionPoint(extensionPointId);
					IExtension[] extensions = point.getExtensions();
					List<Map<String, String>> pointConfigs = new ArrayList<Map<String, String>>();
					for (IExtension extension : extensions) {
						if (ITEM.equals(extension.getAttribute("name"))) {
							Map<String, String> params = new HashMap<String, String>();
							params.put(PARAM_UUID, Plugin.getParamValueString(
									extension, PARAM_UUID));
							params.put(PARAM_NAME, Plugin.getParamValueString(
									extension, PARAM_NAME));
							params.put(PARAM_FORM_NAME, Plugin
									.getParamValueString(extension,
											PARAM_FORM_NAME));
							params.put(PARAM_EDIT_FORWARD, Plugin
									.getParamValueString(extension,
											PARAM_EDIT_FORWARD));
							params.put(PARAM_VIEW_FORWARD, Plugin
									.getParamValueString(extension,
											PARAM_VIEW_FORWARD));
							params.put(PARAM_MODIFY_FORWARD, Plugin
									.getParamValueString(extension,
											PARAM_MODIFY_FORWARD));
							params.put(PARAM_CONTROLLER_SERVICE, Plugin
									.getParamValueString(extension,
											PARAM_CONTROLLER_SERVICE));
							params.put(PARAM_BUSINESS_SERVICE, Plugin
									.getParamValueString(extension,
											PARAM_BUSINESS_SERVICE));
							pointConfigs.add(params);
						}
					}
					configs.put(extensionPointId, pointConfigs);
				}
			}
		}
		return configs;
	}

	/***
	 * 获取扩展点uuid和name集合
	 * 
	 * @param configs
	 * @param extensionPointId
	 * @return
	 */
	public static List<Map<String, String>> getConfig(String extensionPointId) {
		List<Map<String, String>> configMaps = new ArrayList<Map<String, String>>();
		if (null == configs.get(extensionPointId)
				|| configs.get(extensionPointId).isEmpty()) {
			configs = getConfigs(extensionPointId);
		}
		for (Map<String, String> configMap : configs.get(extensionPointId)) {
			Map<String, String> map = new HashMap<String, String>();
			map.put(configMap.get(PARAM_UUID), configMap.get(PARAM_NAME));
			configMaps.add(map);
		}
		return configMaps;
	}

	/****
	 * 根据扩张id得到扩张name
	 * 
	 * @param extensionPointId
	 * @param uuid
	 * @return
	 */
	public static String getNameByUUID(String extensionPointId, String uuid) {
		List<Map<String, String>> configs = getConfig(extensionPointId);
		for (Map<String, String> map : configs) {
			for (String key : map.keySet()) {
				if (key.equals(uuid)) {
					return map.get(uuid);
				}
			}
		}
		return null;
	}

	/****
	 * 根据扩展属性名、uuid得到对应的属性值
	 * 
	 * @param extensionPointId
	 * @param uuid
	 * @param configName
	 * @return
	 */
	public static String getConfigByUUID(String extensionPointId, String uuid,
			String configName) {
		if (null == configs.get(extensionPointId)
				|| configs.get(extensionPointId).isEmpty()) {
			configs = getConfigs(extensionPointId);
		}
		for (Map<String, String> configMap : configs.get(extensionPointId)) {
			if (configMap.get(PARAM_UUID).equals(uuid)) {
				return configMap.get(configName);
			}

		}
		return null;
	}
}
