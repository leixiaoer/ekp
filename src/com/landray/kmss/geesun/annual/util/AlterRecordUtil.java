package com.landray.kmss.geesun.annual.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;

import com.landray.kmss.common.model.IBaseModel;
import com.landray.kmss.common.service.IBaseService;
import com.landray.kmss.geesun.annual.util.alterfield.AlterFieldRecord;
import com.landray.kmss.geesun.annual.util.alterfield.BaseAlterField;
import com.landray.kmss.geesun.annual.util.alterfield.ComplexField;
import com.landray.kmss.geesun.annual.util.alterfield.DateField;
import com.landray.kmss.geesun.annual.util.alterfield.Fields;
import com.landray.kmss.geesun.annual.util.alterfield.ListField;
import com.landray.kmss.geesun.annual.util.alterfield.ModelField;
import com.landray.kmss.geesun.annual.util.alterfield.SimpleField;
import com.landray.kmss.geesun.annual.util.alterfield.interfaces.ISimCopListFeild;
import com.landray.kmss.util.ArrayUtil;
import com.landray.kmss.util.DateUtil;
import com.landray.kmss.util.EnumerationTypeUtil;
import com.landray.kmss.util.ResourceUtil;
import com.landray.kmss.util.SpringBeanUtil;
import com.landray.kmss.util.StringUtil;
import com.landray.kmss.util.UserUtil;
import com.sunbor.web.tag.enums.Type;
import com.sunbor.web.tag.enums.ValueLabel;

/**
 * 读取修改字段记录类
 * 
 * @author 黄诚芳
 */
public class AlterRecordUtil {
	private Fields fields;

	private static Map<String, Fields> fieldsMap = new HashMap<String, Fields>();;

	/**
	 * 构造器
	 * 
	 * @param xmlFileName
	 *            xml文件路径，路径格式com/landray/...
	 * @param id
	 *            fields节点的id
	 * @throws Exception
	 */
	public AlterRecordUtil(String xmlFileName, String id) throws Exception {
		Fields fields = fieldsMap.get("xmlFileName"+"-"+id);
		if(fields != null) {
			this.fields = fields;
			return;
		}
		XMLReader xmlReader = new XMLReader(xmlFileName);
		List<Element> elements = xmlReader.getRoot().elements("fields");
		this.fields = new Fields();
		Element element = null;
		if (StringUtil.isNotNull(id)) {
			for (Element e : elements) {
				if (id.equals(e.attributeValue("id"))) {
					element = e;
					break;
				}
			}
		} else {
			element = elements.get(0);
		}
		// 获取父类
		List<Element> parentElements = new ArrayList<Element>();
		getExtendsElement(parentElements, elements, element);
		for (Element e : parentElements) {
			loadAlterField(e, fields);
		}
		loadAlterField(element, this.fields);
		fieldsMap.put("xmlFileName"+"-"+id, this.fields);
	}

	/**
	 * 比较两个对象，记录下修改了的字段，返回一个AlterFieldRecord对象
	 * 
	 * @param obj1
	 *            修改前对象
	 * @param obj2
	 *            修改后对象
	 * @return
	 * @throws Exception
	 */
	public List<AlterFieldRecord> compare(Object obj1, Object obj2)
			throws Exception {
		List<AlterFieldRecord> records = new ArrayList<AlterFieldRecord>();
		parseSimCopList(obj1, obj2, this.fields, records);
		return records;
	}

	/**
	 * 比较两个对象的某个简单属性字段,即基本属性
	 * 
	 * @param obj1
	 * @param obj2
	 * @param simpleField
	 * @param records
	 * @throws Exception
	 */
	private void compareSimpleField(Object obj1, Object obj2,
			SimpleField simpleField, List<AlterFieldRecord> records)
			throws Exception {
		Boolean same = FieldUtil.compareField(obj1, obj2,
				simpleField.getName(), simpleField.isBoolean());
		if (same != null && same != true) {
			String recordName = simpleField.getRecordFieldName();
			if (StringUtil.isNull(recordName)) {
				recordName = simpleField.getName();
			}
			Object value1 = FieldUtil.getValue(obj1, recordName);
			Object value2 = FieldUtil.getValue(obj2, recordName);
			if (StringUtil.isNotNull(simpleField.getEnumsType())) {
				value1 = findEnumsLabelValue(simpleField.getEnumsType(), value1);
				value2 = findEnumsLabelValue(simpleField.getEnumsType(), value2);
			}
			// 如果两个对象的同属性不相同，记录
			AlterFieldRecord record = createAlterFieldRecord(
					simpleField.getText(), value1, value2);
			records.add(record);
		}
	}
	
	/**
	 * 比较两个对象的某个简单属性字段,即基本属性
	 * 
	 * @param obj1
	 * @param obj2
	 * @param simpleField
	 * @param records
	 * @throws Exception
	 */
	private void compareModelField(Object obj1, Object obj2,
			ModelField modelField, List<AlterFieldRecord> records)
					throws Exception {
		String idName = modelField.getId();
		String nameName = modelField.getName();
		// model的fdName
		String realName = modelField.getRealName();
		// model的class
		String className = modelField.getClassName();
		// 找出model的新id
		Object value1Temp = FieldUtil.getValue(obj2, idName);
		// 找出其对应的service
		
//		kkBaseParkService
		String serviceName=Class.forName(className).getSimpleName()+"Service";
		
		serviceName=serviceName.substring(0, 1).toLowerCase()+serviceName.substring(1);
		
//		String serviceName = SysDataDict.getInstance().getModel(className)
//				.getServiceBean();
		
		
		
		IBaseService service = (IBaseService) SpringBeanUtil
				.getBean(serviceName);
		// 获取其对应的model
		IBaseModel srcModel = service.getBaseDao().findByPrimaryKey((String)value1Temp,
				className, true);
		// 进行fdName比较
		Object value1 = FieldUtil.getValue(srcModel, realName);
		Object value2 = FieldUtil.getValue(obj1, nameName);
		Boolean same = compareObject(value1,value2);
		if (same != null && same != true) {
			// 如果两个对象的同属性不相同，记录
			AlterFieldRecord record = createAlterFieldRecord(
					modelField.getText(), value2, value1);
			records.add(record);
		}
	}
		
		/**
	 * 比较两个对象
	 * 
	 * @param obj1
	 * @param obj2
	 * @return
	 */
		private Boolean compareObject(Object obj1, Object obj2){
			if(obj1 != null) {
				return obj1.equals(obj2);
			}
			if(obj2 != null) {
				return false;
			}
			return null;
		}

	/**
	 * 比较时间
	 * 
	 * @param obj1
	 * @param obj2
	 * @param dateField
	 * @param records
	 * @throws Exception
	 */
	private void compareDateField(Object obj1, Object obj2,
			DateField dateField, List<AlterFieldRecord> records)
			throws Exception {
		String dateType = dateField.getDateType();
		boolean flag = true;
		for (String type : DateUtil.TYPE_ALL) {
			if (type.equals(dateType)) {
				flag = false;
				break;
			}
		}
		Date date1 = null;
		Date date2 = null;
		if (flag) {
			SimpleDateFormat sdf = new SimpleDateFormat(dateType);
			date1 = sdf.parse((String) FieldUtil.getValue(obj1, dateField.getName()));
			date2 = sdf.parse((String) FieldUtil.getValue(obj2, dateField.getName()));
		} else {
			date1 = DateUtil.convertStringToDate((String) FieldUtil.getValue(obj1, dateField.getName()), dateType, UserUtil
					.getKMSSUser().getLocale());
			date2 = DateUtil.convertStringToDate((String) FieldUtil.getValue(obj2, dateField.getName()), dateType, UserUtil
					.getKMSSUser().getLocale());
		}
		String date1Str = null;
		String date2Str = null;
		if (flag) {
			date1Str = DateUtil.convertDateToString(date1, dateType);
			date2Str = DateUtil.convertDateToString(date2, dateType);
		} else {
			date1Str = DateUtil.convertDateToString(date1, dateType, UserUtil
					.getKMSSUser().getLocale());
			date2Str = DateUtil.convertDateToString(date2, dateType, UserUtil
					.getKMSSUser().getLocale());
		}
		Boolean same = FieldUtil.compareField(date1Str, date2Str, null);
		if (same != null && same != true) {
			String recordName = dateField.getRecordFieldName();
			if (StringUtil.isNull(recordName)) {
				AlterFieldRecord record = createAlterFieldRecord(
						dateField.getText(), date1Str, date2Str);
				records.add(record);
			} else {
				AlterFieldRecord record = createAlterFieldRecord(
						dateField.getText(),
						FieldUtil.getValue(obj1, recordName),
						FieldUtil.getValue(obj2, recordName));
				records.add(record);
			}

		}

	}

	/**
	 * 比较两个对象的某个复杂属性字段
	 * 
	 * @param obj1
	 * @param obj2
	 * @param complexField
	 * @param records
	 * @throws Exception
	 */
	private void compareComplexField(Object obj1, Object obj2,
			ComplexField complexField, List<AlterFieldRecord> records)
			throws Exception {
		Object value1 = FieldUtil.getValue(obj1, complexField.getName());
		Object value2 = FieldUtil.getValue(obj2, complexField.getName());
		parseSimCopList(value1, value2, complexField, records);
		/*
		 * 当前该属性配置了record=true, 则直接已key值比较当前复杂属性，没有key值则使用equals比较
		 */
		if (complexField.isRecord()) {
			Boolean same = FieldUtil.compareField(value1, value2,
					complexField.getKey());
			if (same != null && same != true) {
				AlterFieldRecord record = createAlterFieldRecord(
						complexField.getText(),
						FieldUtil.getValue(value1,
								complexField.getRecordFieldName()),
						FieldUtil.getValue(value2,
								complexField.getRecordFieldName()));
				records.add(record);
			}
		}
	}

	/**
	 * 比较两个对象的某个集合属性对象，集合属性的保存的属性使用key值来比较
	 * 
	 * @param obj1
	 * @param obj2
	 * @param listField
	 * @param records
	 * @throws Exception
	 */
	private void compareListField(Object obj1, Object obj2,
			ListField listField, List<AlterFieldRecord> records)
			throws Exception {
		Collection list1 = (Collection) FieldUtil.getValue(obj1,
				listField.getName());
		Collection list2 = (Collection) FieldUtil.getValue(obj2,
				listField.getName());
		if (list1 == null && list2 == null) {
			return;
		}
		String key = listField.getKey();
		// 比较两个集合，将两个集合中相同的,增加的，删除的属性找出来
		List<Object> sameObj1List = new ArrayList<Object>();
		List<Object> sameObj2List = new ArrayList<Object>();
		List<Object> addObjList = new ArrayList<Object>();
		List<Object> deleteObjList = new ArrayList<Object>();
		compareToCollection(list1, list2, sameObj1List, sameObj2List,
				addObjList, deleteObjList, key);
		// 如果当前集合没有配置集合中保存属性的字段,则将集合中新增、删除的属性加入
		if (listField.isRecord()
				&& ArrayUtil.isEmpty(listField.getSimpleFields())
				&& ArrayUtil.isEmpty(listField.getDateFields())
				&& ArrayUtil.isEmpty(listField.getComplexFields())
				&& ArrayUtil.isEmpty(listField.getListFields())) {
			// 新增
			for (Object obj : addObjList) {
				AlterFieldRecord record = createAlterFieldRecord(
						listField.getText(), null,
						FieldUtil.getValue(obj, listField.getRecordFieldName()));
				records.add(record);
			}
			// 删除
			for (Object obj : deleteObjList) {
				AlterFieldRecord record = createAlterFieldRecord(
						listField.getText(),
						FieldUtil.getValue(obj, listField.getRecordFieldName()),
						null);
				records.add(record);
			}
			return;
		}
		// 如果集合字段中还配置该集合保存的属性的字段，则比较保存的字段，与顺序无关
		// 相同的
		for (int i = 0; i < sameObj1List.size(); i++) {
			Object sameObj1 = sameObj1List.get(i);
			Object sameObj2 = sameObj2List.get(i);
			parseSimCopList(sameObj1, sameObj2, listField, records);
		}
		// 新增的
		for (Object obj : addObjList) {
			parseSimCopList(null, obj, listField, records);
		}
		// 删除的
		for (Object obj : deleteObjList) {
			parseSimCopList(obj, null, listField, records);
		}

	}

	/**
	 * 解析两个对象的属性
	 * 
	 * @param obj1
	 * @param obj2
	 * @param simCopListField
	 * @param records
	 * @throws Exception
	 */
	private boolean parseSimCopList(Object obj1, Object obj2,
			ISimCopListFeild simCopListField, List<AlterFieldRecord> records)
			throws Exception {
		boolean flag = true;
		if (!ArrayUtil.isEmpty(simCopListField.getSimpleFields())) {
			flag = false;
			// 比较两个属性的简单属性字段
			for (SimpleField simpleField : simCopListField.getSimpleFields()) {
				compareSimpleField(obj1, obj2, simpleField, records);
			}
		}
		if (!ArrayUtil.isEmpty(simCopListField.getModelFields())) {
			flag = false;
			// 比较两个属性的简单属性字段
			for (ModelField modelField : simCopListField.getModelFields()) {
				compareModelField(obj1, obj2, modelField, records);
			}
		}
		if (!ArrayUtil.isEmpty(simCopListField.getDateFields())) {
			// Date
			flag = false;
			for (DateField dateField : simCopListField.getDateFields()) {
				compareDateField(obj1, obj2, dateField, records);
			}
		}
		if (!ArrayUtil.isEmpty(simCopListField.getComplexFields())) {
			// 复杂
			flag = false;
			for (ComplexField complexField : simCopListField.getComplexFields()) {
				compareComplexField(obj1, obj2, complexField, records);
			}
		}
		if (!ArrayUtil.isEmpty(simCopListField.getListFields())) {
			// 集合
			flag = false;
			for (ListField list : simCopListField.getListFields()) {
				compareListField(obj1, obj2, list, records);
			}
		}
		return flag;
	}

	/**
	 * 比较两个集合
	 * 
	 * @param list1
	 * @param list2
	 * @param sameObj1List
	 * @param sameObj2List
	 * @param addObjList
	 * @param deleteObjList
	 * @param key
	 * @throws Exception
	 */
	private void compareToCollection(Collection list1, Collection list2,
			List<Object> sameObj1List, List<Object> sameObj2List,
			List<Object> addObjList, List<Object> deleteObjList, String key)
			throws Exception {
		if (list1 == null && list2 == null) {
			return;
		}
		if (list1 == null) {
			addObjList.addAll(list2);
			return;
		}
		if (list2 == null) {
			deleteObjList.addAll(list1);
			return;
		}
		for (Object listObj1 : list1) {
			for (Object listObj2 : list2) {
				if (FieldUtil.compareField(listObj1, listObj2, key)) {
					sameObj1List.add(listObj1);
					sameObj2List.add(listObj2);
					continue;
				}
			}
			deleteObjList.add(listObj1);
		}
		for (Object listObj : list2) {
			for (Object sameObj : sameObj1List) {
				if (FieldUtil.compareField(listObj, sameObj, key)) {
					continue;
				}
			}
			addObjList.add(listObj);
		}
	}

	/**
	 * 初始化，获取fields下的所有配置的属性
	 */
	public void loadAlterField(Element fieldsElement, Fields fields) {
		if (fields == null) {
			return;
		}
		List<Element> simpleFieldElements = fieldsElement
				.elements("simpleField");
		
		List<Element> modelFieldElements = fieldsElement
				.elements("modelField");
		
		List<Element> dateFieldElements = fieldsElement.elements("dateField");
		List<Element> complexFieldElements = fieldsElement
				.elements("complexField");
		List<Element> listFieldElements = fieldsElement.elements("listField");
		if (!ArrayUtil.isEmpty(simpleFieldElements)) {
			List<SimpleField> simpleFields = new ArrayList<SimpleField>();
			// 配置的简单属性，直接添加
			for (Element e : simpleFieldElements) {
				simpleFields.add(createSimpleField(e));
			}
			if (fields.getSimpleFields() == null) {
				fields.setSimpleFields(new ArrayList<SimpleField>());
			}
			fields.getSimpleFields().addAll(simpleFields);
		}
		if (!ArrayUtil.isEmpty(modelFieldElements)) {
			List<ModelField> modelFields = new ArrayList<ModelField>();
			// 配置的model属性，直接添加
			for (Element e : modelFieldElements) {
				modelFields.add(createModelField(e));
			}
			if (fields.getModelFields() == null) {
				fields.setModelFields(new ArrayList<ModelField>());
			}
			fields.getModelFields().addAll(modelFields);
		}
		if (!ArrayUtil.isEmpty(dateFieldElements)) {
			// 配置的Date属性
			List<DateField> dateFields = new ArrayList<DateField>();
			for (Element e : dateFieldElements) {
				dateFields.add(createDateField(e));
			}
			if (fields.getDateFields() == null) {
				fields.setDateFields(new ArrayList<DateField>());
			}
			fields.getDateFields().addAll(dateFields);
		}
		if (!ArrayUtil.isEmpty(complexFieldElements)) {
			List<ComplexField> complexFields = new ArrayList<ComplexField>();
			// 配置的复杂属性，获取该配置下的所有属性配置
			for (Element e : complexFieldElements) {
				ComplexField complexField = new ComplexField();
				// getComplexFieldFromElement(e, complexField);
				getAlterFieldFromElement(e, complexField);
				complexFields.add(complexField);
			}
			if (fields.getComplexFields() == null) {
				fields.setComplexFields(new ArrayList<ComplexField>());
			}
			fields.getComplexFields().addAll(complexFields);
		}
		if (!ArrayUtil.isEmpty(listFieldElements)) {
			List<ListField> listFields = new ArrayList<ListField>();
			// 配置的集合属性，获取该配置下的所有属性配置
			for (Element e : listFieldElements) {
				ListField listField = new ListField();
				// getListFieldFromElement(e, listField);
				getAlterFieldFromElement(e, listField);
				listFields.add(listField);
			}
			if (fields.getListFields() == null) {
				fields.setListFields(new ArrayList<ListField>());
			}
			fields.getListFields().addAll(listFields);
		}
	}

	/**
	 * 获取配置的复杂集合属性下的配置
	 * 
	 * @param element
	 * @param parent
	 */
	private void getAlterFieldFromElement(Element element,
			ISimCopListFeild parent) {
		if (element == null || parent == null) {
			return;
		}
		setAlterFieldValue((BaseAlterField) parent, element);
		List<Element> simpleFieldElements = element.elements("simpleField");
		List<Element> complexFieldElements = element.elements("complexField");
		List<Element> dateFieldElements = element.elements("dateField");
		List<Element> listFieldElements = element.elements("listField");
		if (!ArrayUtil.isEmpty(simpleFieldElements)) {
			// 获取复杂属性下 配置的简单属性
			List<SimpleField> simpleFields = new ArrayList<SimpleField>();
			for (Element e : simpleFieldElements) {
				simpleFields.add(createSimpleField(e));
			}
			parent.setSimpleFields(simpleFields);
		}
		if (!ArrayUtil.isEmpty(dateFieldElements)) {
			// 配置的date属性
			List<DateField> dateFields = new ArrayList<DateField>();
			for (Element e : dateFieldElements) {
				dateFields.add(createDateField(e));
			}
			parent.setDateFields(dateFields);
		}
		if (!ArrayUtil.isEmpty(complexFieldElements)) {
			// 获取复杂属性下 配置的复杂属性
			List<ComplexField> complexFields = new ArrayList<ComplexField>();
			for (Element e : complexFieldElements) {
				ComplexField complexField = new ComplexField();
				getAlterFieldFromElement(e, complexField);
				complexFields.add(complexField);
			}
			parent.setComplexFields(complexFields);
		}
		if (!ArrayUtil.isEmpty(listFieldElements)) {
			// 获取复杂属性下 配置的集合属性
			List<ListField> listFields = new ArrayList<ListField>();
			for (Element e : listFieldElements) {
				ListField listField = new ListField();
				getAlterFieldFromElement(e, listField);
				listFields.add(listField);
			}
			parent.setListFields(listFields);
		}
	}

	/**
	 * 根据节点的值创建一个SimpleField对象
	 * 
	 * @param e
	 * @return
	 */
	private SimpleField createSimpleField(Element e) {
		SimpleField simpleField = new SimpleField();
		setAlterFieldValue(simpleField, e);
		if ("true".equals(e.attributeValue("isBoolean"))) {
			simpleField.setBoolean(true);
		}
		String enumsType = e.attributeValue("enumsType");
		if (StringUtil.isNotNull(enumsType)) {
			simpleField.setEnumsType(enumsType);
		}
		return simpleField;
	}
	
	/**
	 * 根据节点的值创建一个ModelField对象
	 * 
	 * @param e
	 * @return
	 */
	private ModelField createModelField(Element e) {
		ModelField modelField = new ModelField();
		setAlterFieldValue(modelField, e);
		String mid = e.attributeValue("mid");
		if (StringUtil.isNotNull(mid)) {
			modelField.setId(mid);
		}
		String className = e.attributeValue("className");
		if (StringUtil.isNotNull(className)) {
			modelField.setClassName(className);
		}
		String realName = e.attributeValue("realName");
		if (StringUtil.isNotNull(realName)) {
			modelField.setRealName(realName);
		}
		return modelField;
	}

	/**
	 * setValue
	 * 
	 * @param field
	 * @param element
	 */
	private void setAlterFieldValue(BaseAlterField field, Element element) {
		field.setKey(element.attributeValue("key"));
		field.setName(element.attributeValue("name"));
		field.setText(element.attributeValue("text"));
		field.setRecordFieldName(element.attributeValue("recordFieldName"));
		if ("true".equals(element.attributeValue("record"))) {
			field.setRecord(true);
		}
		
	}

	/**
	 * 创建一个修改记录
	 * 
	 * @param text
	 * @param beforeValue
	 * @param afterValue
	 * @return
	 */
	private AlterFieldRecord createAlterFieldRecord(String text,
			Object beforeValue, Object afterValue) {
		AlterFieldRecord record = new AlterFieldRecord();
		record.setText(text);
		record.setValueBeforAlter(beforeValue);
		record.setValueAfterAlter(afterValue);
		return record;
	}

	/**
	 * 创建一个DateField类型对象
	 * 
	 * @param e
	 * @return
	 */
	private DateField createDateField(Element e) {
		DateField dateField = new DateField();
		setAlterFieldValue(dateField, e);
		String dateType = e.attributeValue("dateType");
		if (StringUtil.isNotNull(dateType)) {
			dateField.setDateType(dateType);
		} else {
			dateField.setDateType(DateUtil.TYPE_DATETIME);
		}
		setAlterFieldValue(dateField, e);
		return dateField;
	}

	private void getExtendsElement(List<Element> parentElements,
			List<Element> rootElements, Element srcElement) {
		if (parentElements == null || rootElements == null
				|| srcElement == null) {
			return;
		}
		String extendsId = srcElement.attributeValue("extends");
		if (StringUtil.isNull(extendsId)) {
			return;
		}
		Element parentElement = null;
		for (Element e : rootElements) {
			if (extendsId.equals(e.attributeValue("id"))) {
				parentElement = e;
				break;
			}
		}
		if (parentElement != null) {
			getExtendsElement(parentElements, rootElements, parentElement);
			parentElements.add(parentElement);
		}
	}

	private String findEnumsLabelValue(String enumsType, Object value1)
			throws Exception {
		if (value1 == null) {
			return "";
		}
		Type type = EnumerationTypeUtil.newInstance().getColumnEnums()
				.findType(enumsType);
		List<ValueLabel> valueLabelList = type.getValueLabels();
		for (ValueLabel valueLabel : valueLabelList) {
			if (value1.equals(valueLabel.getValue())) {
				return ResourceUtil.getString(valueLabel.getLabelKey(),
						valueLabel.getBundle());
			}
		}
		return "";
	}
}
