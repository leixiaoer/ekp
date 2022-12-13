package com.landray.kmss.geesun.annual.forms;

import com.landray.kmss.common.forms.ExtendForm;
import com.landray.kmss.geesun.annual.FindXML;
import com.landray.kmss.geesun.annual.interfaces.IGeesunAnnualAlterForm;

public abstract class BaseGeesunAnnualAlterForm extends ExtendForm implements IGeesunAnnualAlterForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 修改记录字段配置文件路径
	public String getAlterFieldXMLPath() {
		return FindXML.alterRecordPath;
	}

	// 修改记录配置id
	public String getAlterFieldXMLFieldsId() {
		return getModelClass().getName();
	}

	int historyRowsSize = 0;

	public int getHistoryRowsSize() {
		return historyRowsSize;
	}

	public void setHistoryRowsSize(int size) {
		this.historyRowsSize = size;
	}

}
