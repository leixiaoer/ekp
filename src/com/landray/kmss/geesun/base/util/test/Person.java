package com.landray.kmss.geesun.base.util.test;

public class Person {

	private int id;
	
	private String name;
	
	private int sex;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	@Override
	public String toString() {
		return "TestEntity [id=" + id + ", name=" + name + ", sex=" + sex + "]";
	}

	
}
