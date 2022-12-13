package com.landray.kmss.geesun.annual.util.alterfield;

public class SimpleField extends BaseAlterField{
	private boolean isBoolean;

	public boolean isBoolean() {
		return isBoolean;
	}

	public void setBoolean(boolean isBoolean) {
		this.isBoolean = isBoolean;
	}
	
	public String enumsType;

	public String getEnumsType() {
		return enumsType;
	}

	public void setEnumsType(String enumsType) {
		this.enumsType = enumsType;
	}
	
}
