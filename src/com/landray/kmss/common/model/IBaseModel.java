package com.landray.kmss.common.model;

import java.util.Map;

import com.landray.kmss.common.convertor.ModelToFormPropertyMap;
import com.landray.kmss.sys.config.dict.SysDictModel;

public interface IBaseModel {

	/**
	 * @return ID
	 */
	public abstract String getFdId();

	/**
	 * 设置ID
	 * 
	 * @param id
	 */
	public abstract void setFdId(String id);

	/**
	 * 重新计算字段值
	 */
	public abstract void recalculateFields();

	/**
	 * 数据字典对象，供SysDictLoader使用
	 * 
	 * @return
	 */
	public abstract SysDictModel getSysDictModel();

	/**
	 * 数据字典对象，供SysDictLoader使用
	 * 
	 * @param sysDictModel
	 */
	public abstract void setSysDictModel(SysDictModel sysDictModel);

	/**
	 * 获取Form模型的Class
	 * 
	 * @return form class
	 */
	public abstract Class getFormClass();

	/**
	 * @return 域模型到Form模型的特殊属性转换映射表
	 */
	public abstract ModelToFormPropertyMap getToFormPropertyMap();

	public Map<String, String> getDynamicMap();

	/**
	 * 动态自定义单表字段
	 * 
	 * @return
	 */
	public Map<String, Object> getCustomPropMap();


	/**
	 * 机制类
	 */
	Map<String, Object> getMechanismMap();

	void setMechanismMap(Map<String, Object> mechanismMap);
}