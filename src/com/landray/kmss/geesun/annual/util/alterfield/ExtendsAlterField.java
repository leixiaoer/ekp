package com.landray.kmss.geesun.annual.util.alterfield;

import java.util.List;

import com.landray.kmss.geesun.annual.util.alterfield.interfaces.ISimCopListFeild;

/**
 * 扩展AlterField类
 *
 */
public abstract class ExtendsAlterField extends BaseAlterField implements ISimCopListFeild{

	
	private List<SimpleField> simpleFields;
	private List<ModelField> modelFields;
	private List<ComplexField> complexFields;
	private List<ListField> listFields;
	private List<DateField> dateFields;
	
	public List<DateField> getDateFields() {
		return dateFields;
	}

	public void setDateFields(List<DateField> dateFields) {
		this.dateFields = dateFields;
	}

	public List<SimpleField> getSimpleFields() {
		return simpleFields;
	}

	public void setSimpleFields(List<SimpleField> simpleFields) {
		this.simpleFields = simpleFields;
	}

	public List<ComplexField> getComplexFields() {
		return complexFields;
	}

	public void setComplexFields(List<ComplexField> complexFields) {
		this.complexFields = complexFields;
	}

	public List<ListField> getListFields() {
		return listFields;
	}

	public void setListFields(List<ListField> listFields) {
		this.listFields = listFields;
	}

	public List<ModelField> getModelFields() {
		return modelFields;
	}

	public void setModelFields(List<ModelField> modelFields) {
		this.modelFields = modelFields;
	}
}
