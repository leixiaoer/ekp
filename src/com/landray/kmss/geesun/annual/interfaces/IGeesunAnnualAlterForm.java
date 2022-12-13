package com.landray.kmss.geesun.annual.interfaces;

import com.landray.kmss.common.forms.IExtendForm;

/**
 * 需要记录字段修改记录的Form需要实现该接口
 *
 */
public interface IGeesunAnnualAlterForm extends IExtendForm {
	/**
	 * 获取alterField.xml文件路径
	 * @return
	 */
	String getAlterFieldXMLPath();
	
	/**
	 * 获取alterField.xml文件中配置的fields节点的id
	 * @return
	 */
	String getAlterFieldXMLFieldsId();
	
	int getHistoryRowsSize();
	void setHistoryRowsSize(int size);
}
