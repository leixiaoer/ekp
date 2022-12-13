package com.landray.kmss.geesun.annual.util.alterfield;

/**
 * 需要记录的修改的字段
 *
 */
public abstract class BaseAlterField {
	/**
	 * 比较该对象的key
	 */
	private String key;
	
	/**
	 * 显示该字段的名字
	 */
	private String text;
	
	/**
	 * 需要比较的字段名
	 */
	private String name;
	
	/**
	 * 是否记录该字段
	 */
	private boolean isRecord;
	
	/**
	 * 如果不同，实际记录的字段名
	 */
	private String recordFieldName;
	
	/**
	 * 如果不同，实际记录的字段名
	 * @return
	 */
	public String getRecordFieldName() {
		return recordFieldName;
	}
	
	/**
	 * 如果不同，实际记录的字段名
	 * @param recordFieldName
	 */
	public void setRecordFieldName(String recordFieldName) {
		this.recordFieldName = recordFieldName;
	}
	
	/**
	 * 比较该对象的key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * 比较该对象的key
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 * 显示该字段的名字
	 */
	public String getText() {
		return text;
	}

	/**
	 * 显示该字段的名字
	 */
	public void setText(String text) {
		this.text = text;
	}

	/**
	 * 需要比较的字段名
	 */
	public String getName() {
		return name;
	}

	/**
	 * 需要比较的字段名
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * 是否记录该字段，简单字段，默认记录，复杂字段和list字段默认不记录
	 */
	public boolean isRecord() {
		return isRecord;
	}

	/**
	 * 是否记录该字段
	 */
	public void setRecord(boolean isRecord) {
		this.isRecord = isRecord;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BaseAlterField other = (BaseAlterField) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}
}
