package com.landray.kmss.common.dao;

import java.io.Serializable;

import org.hibernate.type.Type;

import com.landray.kmss.util.ObjectUtil;

public class HQLParameter implements Serializable {

	private static final long serialVersionUID = 7814195598186899508L;

	private String name;

	private Object value;

	private Type type;

	/**
	 * 是否已经转义过
	 */
	private Boolean escaped;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public Object getValue() {
		return value;
	}

	public Boolean getEscaped() {
		return escaped;
	}

	public void setEscaped(Boolean escaped) {
		this.escaped = escaped;
	}

	public void setValue(Object value) {
		// 如果参数值有变化，需要重新转义
		if (!ObjectUtil.equals(this.value, value)) {
			this.escaped = null;
		}
		this.value = value;
	}

	public HQLParameter(String name, Object value) {
		super();
		this.name = name;
		this.value = value;
	}

	public HQLParameter(String name, Object value, Type type) {
		super();
		this.name = name;
		this.value = value;
		this.type = type;
	}

	@Override
	public String toString() {
		return "HQLParameter{" +
				"name='" + name + '\'' +
				", value=" + value +
				", type=" + type +
				'}';
	}
}
