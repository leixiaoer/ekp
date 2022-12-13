package com.landray.kmss.geesun.annual.util.alterfield;

import com.landray.kmss.util.DateUtil;

public class DateField extends BaseAlterField{
	private String dateType = DateUtil.TYPE_DATETIME;

	public String getDateType() {
		return dateType;
	}

	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	
}
