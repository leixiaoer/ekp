Designer_Config.operations['postLevel']={
		imgIndex : 84,
		title:Designer_Lang.controlPostLevel_attr_title,
		titleTip:Designer_Lang.controlNew_AddressTitleTip,
		run : function (designer) {
			designer.toolBar.selectButton('postLevel');
		},
		type : 'cmd',
		order: 1,
		select: true,
		cursorImg: 'style/cursor/newAddress.cur'
};
Designer_Config.controls.postLevel = {
		type : "postLevel",
		storeType : 'field',
		inherit    : 'base',
		onDraw : _Designer_Post_Level_OnDraw,
		drawXML : _Designer_Control_Post_Level_DrawXML,
		implementDetailsTable : true,
		attrs : {
			label : Designer_Config.attrs.label,
			canShow : {
				text: Designer_Lang.controlAttrCanShow,
				value: "true",
				type: 'hidden',
				checked: true
			},
			readOnly : Designer_Config.attrs.readOnly,
			required: {
				text: Designer_Lang.controlAttrRequired,
				value: "true",
				type: 'checkbox',
				checked: false,
				show: true
			},
			company : {
				text :Designer_Lang.controlCostCenter_attr_company,
				value : '',
				required: true,
				type : 'self',
				draw:_Designer_Control_Attr_Cost_Center_Self_Company_Draw,
				show : true,
				checkout: function(msg, name, attr, value, values, control){
					if(!values.companyId){
						msg.push(Designer_Lang.controlPostLevel_attr_checkout_companyNull)
						return false;
					}
					return true;
				}
			},
			width : {
				text: Designer_Lang.controlAttrWidth,
				value: "",
				type: 'text',
				show: true,
				validator: Designer_Control_Attr_Width_Validator,
				checkout: Designer_Control_Attr_Width_Checkout
			},
			formula: Designer_Config.attrs.formula
		},
		onAttrLoad:_Designer_Control_Attr_Cost_Center_OnAttrLoad,
		info : {
			name: Designer_Lang.controlPostLevel_attr_title
		},
		resizeMode : 'onlyWidth'
}
Designer_Config.buttons.control.push("postLevel");
//把控件增加到右击菜单区
Designer_Menus.add.menu['postLevel'] = Designer_Config.operations['postLevel'];
function _Designer_Post_Level_OnDraw(parentNode, childNode){
	// 必须要做ID设置
	if(this.options.values.id == null)
		this.options.values.id = "fd_" + Designer.generateID();	
	var domElement = _CreateDesignElement('label', this, parentNode, childNode);
	if (this.options.values.width && this.options.values.width.toString().indexOf('%') > -1) {
		domElement.style.whiteSpace = 'nowrap';
		domElement.style.width = this.options.values.width;
		domElement.style.overflow = 'visible';
	}
	var htmlCode = _Designer_Control_Post_Level_DrawByType(this.parent, this.attrs, this.options.values, this);
	domElement.innerHTML = htmlCode;	
}

function _Designer_Control_Post_Level_DrawByType(parent,attrs,values,target){
	var width = values.width||'85%';
	if(width.indexOf('%')==-1){
		width+='px';
	}
	var props = {width:width,id:values.id,subject:values.label,companyId:values.companyId};
	if(values.required=='true'){
		props.required = true;
	}
	if(values.readOnly=='true'){
		props.readOnly = values.readOnly;
	}
	var htmlCode = '<div class="inputselectsgl" style="width:'+width+';">'
	htmlCode+='<input name="'+values.id+'.id" type="hidden">'
	htmlCode+='<div class="input"><input subject="" name="'+values.id+'.name" props="'+JSON.stringify(props).replace(/\"/g,"'")+'" type="text" ' ;
	htmlCode+=' readonly></div><div class="selectitem"></div></div>';
	if(values.required=='true'){
		htmlCode+='<span class="txtstrong">*</span>';
	}
	return htmlCode;
}
function _Designer_Control_Post_Level_DrawXML() {	
	var values = this.options.values;
	var buf = [];//mutiValueSplit	
	buf.push('<extendSimpleProperty ');
	buf.push('name="', values.id, '" ');
	buf.push('label="', values.label, '" ');
	buf.push('type="String" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('/>');
	buf.push('<extendSimpleProperty ');
	buf.push('name="', values.id, '_name" ');
	buf.push('label="', values.label,Designer_Lang.control_property_name, '" ');
	buf.push('type="String" ');
	if (values.required == "true") {
		buf.push('notNull="true" ');
	}
	if (values.formula != '' && values.formula != null) {
		buf.push('formula="true" ');
		buf.push('defaultValue="', values.formula, '" ');
		if (values.reCalculate == 'true') {
			buf.push('recalculateOnSave="true" ');
		}
	} else if (values.defaultValue != '' && values.defaultValue != null) {
		buf.push('defaultValue="', values.defaultValue, '" ');
	}
	buf.push('/>');
	return buf.join('');
};
function _Designer_Control_Attr_Cost_Center_OnAttrLoad(form,control){
	
}

function _Designer_Control_Attr_Cost_Center_Self_Company_Draw(name, attr,
		value, form, attrs, values, control) {
	var html=[];
	var textValue=values.companyName?values.companyName:"";
	var idValue=values.companyId?values.companyId:"";
	html.push("<input name='companyName' style='width:73%;' value='"+textValue+"' readonly></input>" +
			"<input type='hidden' name='companyId' value='"+idValue+"'></input>" +
					"<a href='javascript:void(0)' onclick=\"_Relation_Rule_DestDomControlsChoose('companyId','companyName');\">"+Designer_Lang.relation_rule_choose+"</a>");
	return Designer_AttrPanel.wrapTitle(name, attr, value, html.join(""));
}


function Designer_Cost_Center_DefaultValue_Validator(){
	return true;
}

function Designer_Cost_Center_DefaultValue_Checkout(){
	return true;
}
