package com.landray.kmss.geesun.annual.util.alterfield.interfaces;

import java.util.List;

import com.landray.kmss.geesun.annual.util.alterfield.ComplexField;
import com.landray.kmss.geesun.annual.util.alterfield.DateField;
import com.landray.kmss.geesun.annual.util.alterfield.ListField;
import com.landray.kmss.geesun.annual.util.alterfield.ModelField;
import com.landray.kmss.geesun.annual.util.alterfield.SimpleField;

public interface ISimCopListFeild {

	void setSimpleFields(List<SimpleField> simpleFields);
	
	void setModelFields(List<ModelField> modelFields);

	void setComplexFields(List<ComplexField> complexFields);

	void setListFields(List<ListField> listFields);
	
	List<DateField> getDateFields();

	void setDateFields(List<DateField> dateFields); 
	
	List<SimpleField> getSimpleFields();
	
	List<ModelField> getModelFields();
	
	List<ComplexField> getComplexFields();
	
	List<ListField> getListFields();
}