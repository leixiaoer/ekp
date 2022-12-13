package com.landray.kmss.common.forms;

import java.util.Map;

import com.landray.kmss.common.convertor.FormToModelPropertyMap;

public interface IExtendForm {
	/**
	 * @return id
	 */
	public abstract String getFdId();

	/**
	 * 设置id
	 * 
	 * @param id
	 */
	public abstract void setFdId(String id);

	/**
	 * @return Form对应的域模型
	 */
	public abstract Class getModelClass();

	/**
	 * @return Form到Model的特殊属性映射表
	 */
	public abstract FormToModelPropertyMap getToModelPropertyMap();

	public Map getDynamicMap();

	public Map getCustomPropMap();

	/**
	 * 机制类
	 */
	Map<String, Object> getMechanismMap();

	void setMechanismMap(Map<String, Object> mechanismMap);
}
