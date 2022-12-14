Com_IncludeFile('json2.js');
Com_IncludeFile("relationFormula.js",Com_Parameter.ContextPath + "sys/xform/designer/relation/formula/","js",true);

Designer_Config.operations['relationCheckbox'] = {
	lab : "5",
	imgIndex : 55,
	title : Designer_Lang.relation_checkbox_name,
	run : function(designer) {
		designer.toolBar.selectButton('relationCheckbox');
	},
	type : 'cmd',
	order: 1.2,
	shortcut : '',
	select : true,
	isAdvanced: true,
	cursorImg : 'style/cursor/relationCheck.cur'
};
Designer_Config.controls.relationCheckbox = {
	type : "relationCheckbox",
	storeType : 'field',
	inherit : 'relationCommonBase',
	onDraw : _Designer_Control_RelationCheckbox_OnDraw,
	drawMobile : _Designer_Control_RelationCheckbox_DrawMobile,
	drawXML : _Designer_Control_RelationCheckbox_DrawXML,
	onInitialize : _Designer_Control_RelationCheckbox_OnInitialize,
	onInitializeDict : _Designer_Control_DisplayText_OnInitializeDict,
	attrs : {
		mobileRenderType:{
			text: Designer_Lang.controlAttrMobileRenderType,
			value: 'normal',
			type: 'radio',
			opts: [{text:Designer_Lang.controlAttrMobileRenderTypeNormal,value:"normal"},{text:Designer_Lang.controlAttrMobileRenderTypeBlock,value:"block"}],
			show: true						
		},
		alignment: {
			text: Designer_Lang.controlAttrAlignment,
			value: 'H',
			type: 'radio',
			opts: [{text:Designer_Lang.controlAttrAlignmentH,value:"H"},{text:Designer_Lang.controlAttrAlignmentV,value:"V"}],
			show: true
		}
	},
	info : {
		name : Designer_Lang.relation_checkbox_name
	},
	resizeMode : 'onlyWidth'
};
Designer_Config.buttons.tool.push("relationCheckbox");
Designer_Menus.tool.menu['relationCheckbox'] = Designer_Config.operations['relationCheckbox'];

function _Designer_Control_RelationCheckbox_OnInitialize(){
	this.onInitializeDict();
}

function _Designer_Control_RelationCheckbox_OnDraw(parentNode, childNode) {
	if (this.options.values.id == null){
		this.options.values.id = "fd_" + Designer.generateID();
	}
	var domElement = _CreateDesignElement('div', this, parentNode, childNode);
	domElement.className="xform_relation_checkbox";
	domElement.label=_Get_Designer_Control_Label(this.options.values, this);
	domElement.style.width ='auto';
	var values = this.options.values;

	var divDom = document.createElement("div");
	
	$(divDom).attr("required",this.options.values.required == 'true' ? 'true'
			: 'false');
	$(divDom).attr("_required", this.options.values.required == 'true' ? 'true'
			: 'false');
	
	divDom.id = this.options.values.id;
	$(divDom).attr("label",domElement.label);
	
	if (values.outputParams) {
		$(divDom).attr("outputParams", values.outputParams);
	}
	if (values.inputParams) {
		$(divDom).attr("inputParams",values.inputParams);
	}
	if (values.source) {
		$(divDom).attr("source",values.source);
	}
	if (values.funKey) {
		$(divDom).attr("funKey", values.funKey);
	}
	if(values.defValue){
		$(divDom).attr("defValue", values.defValue);
	}
	//????????????
	if(values.summary == "true"){
		$(divDom).attr("summary", "true");
	}else{
		$(divDom).attr("summary", "false");
	}
	// ?????????????????????
	if (values.mobileRenderType) {
		$(divDom).attr("mobileRenderType", values.mobileRenderType);
	}
	var isHorizontal = true;
	if(values.alignment ){
		if(values.alignment == 'V'){
			isHorizontal = false;	
		}
		$(divDom).attr("alignment", values.alignment);
	}
		
	$(divDom).html(Designer_Control_RelationCheckbox_getInputCheckbox(isHorizontal));

	// ????????????
	if (this.options.values.required == 'true') {
		divDom.innerHTML += '<span class=txtstrong>*</span>&nbsp;';
	}
	domElement.appendChild(divDom);
}

/*
 * ??????input checkbox??????
 * */
function Designer_Control_RelationCheckbox_getInputCheckbox(isHorizontal){
	var initNum = 3;
	var html = "";
	for(var i = 0; i < initNum; i++){
		html += "<label>";
		html += "<input type='checkbox' onclick='return false;'/>" + Designer_Lang.relation_checkbox_option + (i + 1);
		html += "</label>";
		if(i < (initNum-1) && !isHorizontal){
			html += '</br>';
		}
	}
	return html;
}

function _Designer_Control_RelationCheckbox_DrawXML() {
	var values = this.options.values;
	buf=[];
	var customElementProperties = {};
	customElementProperties.isShow = "false";
	buf.push( '<extendSimpleProperty ');
	buf.push('name="', values.id, '" ');
	buf.push('label="', values.label, '" ');
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	if (values.defValue != null && values.defValue != '') {
		buf.push('defaultValue="', values.defValue, '" ');
	}
	// ????????????????????????
	if (values.encrypt == 'true') {
		buf.push('encrypt="true" ');
		buf.push('encryptionMethod="AES" ');
	}
	buf.push('/>');	
	
	buf.push( '<extendSimpleProperty ');
	buf.push('name="', values.id+"_text", '" ');
	buf.push('label="', values.label + Designer_Lang.controlDisplayValueMessage, '" ');
	buf.push('type="', values.dataType ? values.dataType : 'String', '" ');
	buf.push('customElementProperties="', Designer.HtmlEscape(JSON.stringify(customElementProperties)), '" ');
	// ????????????????????????
	if (values.encrypt == 'true') {
		buf.push('encrypt="true" ');
		buf.push('encryptionMethod="AES" ');
	}
	//????????????
	if(values.summary == 'true'){
		buf.push('summary="true" ');
	}
	buf.push('/>');

	return buf.join('');
}
