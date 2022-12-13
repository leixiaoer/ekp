/**
 * 传阅意见展示控件
 * @作者：liwc 
 * @日期：2019年6月13日  
 */
var t_value = {
        "sysCirculationOpinionStyleDept": "传阅意见+部门+处理人+时间",
        "sysCirculationOpinionStyleDefault": "审批意见+处理人+时间",
        "sysCirculationOpinionStyleTable": "表格显示"
};

var SysCirculationOpinionStylePlugin=function(){
	var self=this;
	this.init=function(){
		//获取扩展点中定义的样式信息
		$.ajax({
		  url: Com_Parameter.ContextPath + "sys/xform/designer/circulationOpinion/circulationOpinionShow_style.jsp",
		  type:'GET',
		  async:false,//同步请求
		  success: function(json){
		    self.extStyle=json;
		  },
		  dataType: 'json'
		});
	};
	this.GetAllExtStyle=function(){
		
		return self.extStyle;
	};
	this.GetStyleByValue=function(val){
		for(var i=0;i<self.extStyle.length;i++){
			if(self.extStyle[i].viewValue==val){
				return self.extStyle[i];
			}
		}
	};
	//设置控件属性面板选项数组
	this.GetOptionsArray=function(){
		var styleOptions=[];
		var extStyle = self.extStyle;
		for(var i=0;i<extStyle.length;i++){
			
			styleOptions.push({name: extStyle[i].order , text: extStyle[i].viewName , value: extStyle[i].viewValue});
		}
		return styleOptions;
	}
	this.init();
}

var SysCirculationOpinionStylePlugin = new SysCirculationOpinionStylePlugin();

Designer_Config.operations['circulationOpinionShow']={
		lab : "5",
		imgIndex : 72,
		title:Designer_Lang.circulationOpinionShow_name_insert,
		run : function (designer) {
			designer.toolBar.selectButton('circulationOpinionShow');
		},
		type : 'cmd',
		order: 6.5,
		shortcut : 'N',
		sampleImg : 'style/img/auditshow/auditShow.png',
		select: true,
		cursorImg: 'style/cursor/circulationOpinionShow.cur'
};

Designer_Config.controls.circulationOpinionShow={
			type : "circulationOpinionShow",
			inherit : 'base',
			storeType : 'field',
			onDraw : _Designer_Control_CirculationShow_OnDraw,
			drawXML : _Designer_Control_CirculationShow_DrawXML,
			implementDetailsTable : false,
			attrs : {
				label : Designer_Config.attrs.label,
				showStyle : {
					//展现样式
					text: Designer_Lang.circulationOpinionShow_attr_exhibitionStyle,
					value : 'sysCirculationOpinionStyleDept',
					type : 'self',
					draw: _Designer_Control_CirculationShow_Attr_ShowStyle_Self_Draw,
					opts: SysCirculationOpinionStylePlugin.GetOptionsArray(),
					onchange:'_Designer_Control_CirculationShow_Attr_ShowStyle_Change(this)',
					show: true
				},
				previewImg :{
					//预览图
					text: Designer_Lang.circulationOpinionShow_attr_preview,
					value : '',
					type: 'self',
					draw:_Designer_Control_CirculationShow_Attr_PreviewImg_Self_Draw,
					translator: showStyle_translator,
				    compareChange:showStyle_compareChange,
					show: true
				},
				sortNote:{
					//意见排序	
					text: Designer_Lang.circulationOpinionShow_attr_noteSort,
					value : 'dateUp',
					type : 'radio',
					opts:[{text:Designer_Lang.circulationOpinionShow_sortNote_DateUp,value:"dateUp"},
					      {text:Designer_Lang.circulationOpinionShow_sortNote_DateDown,value:"dateDown"},
					      {text:Designer_Lang.circulationOpinionShow_sortNote_DeptUp,value:"deptUp"},
					      {text:Designer_Lang.circulationOpinionShow_sortNote_DeptDown,value:"deptDown"}],
					show:true
				},
				width : {
					text: Designer_Lang.controlAttrWidth,
					value: "",
					type: 'text',
					show: true,
					validator: Designer_Control_Attr_Width_Validator,
					checkout: Designer_Control_Attr_Width_Checkout
				}
			},
			info:{
				//审批意见展示控件
				name:Designer_Lang.circulationOpinionShow_name,
				preview: "mutiTab.png"
			}
			,
			resizeMode : 'onlyWidth'
};
Designer_Config.buttons.tool.push("circulationOpinionShow");
Designer_Menus.tool.menu['circulationOpinionShow'] = Designer_Config.operations['circulationOpinionShow'];
function showStyle_compareChange(name,attr,oldValue,newValue) {
	var changeResult = [];
	var oldTextValue = oldValue;
	
	var newTextValue = newValue;

	if (oldTextValue != newTextValue) {
		var textValChange = {};
		textValChange.oldVal = oldTextValue;
		textValChange.newVal  = newTextValue;
		textValChange.name = "textValue";
		changeResult.push(textValChange);
	}
	
	if (changeResult.length == 0) {
		return "";
	}
	return JSON.stringify(changeResult); 
}
function showStyle_translator(change) {
	if (!change) {
		return "";
	}
	var change = JSON.parse(change);
	var html =[];
	html.push("<span>修改 (");
	for (var i = 0;i < change.length; i++) {
		var paramChange = change[i];
		if (paramChange.name === "textValue") {
			if(t_value[paramChange.oldVal]){
				paramChange.oldVal=t_value[paramChange.oldVal]
			}
			if(t_value[paramChange.newVal]){
				paramChange.newVal=t_value[paramChange.newVal]
			}
			html.push("传出参数 " + paramChange.oldVal + " 变为 " + paramChange.newVal);
		} if (paramChange.name === "hiddenValue") {
			html.push(" ;实际值 " + paramChange.oldVal + " 变为 " + paramChange.newVal);
		}
	}
	html.push(")</span>");
	return html.join("");
}
//属性面板预览图
function _Designer_Control_CirculationShow_Attr_PreviewImg_Self_Draw(name, attr, value, form, attrs, values,control){
	
	var showStyleValue = Designer.instance.control.attrs.showStyle.value;
	
	if(values.showStyle){
		showStyleValue = values.showStyle;
	}

	var styleJSON = SysCirculationOpinionStylePlugin.GetStyleByValue(showStyleValue);
	
	if(!styleJSON){
		styleJSON = SysCirculationOpinionStylePlugin.GetStyleByValue("sysCirculationOpinionStyleDept");
	}
	
	var baseHTML = _Designer_Control_CirculationShow_Attr_showStyle_replace(styleJSON.styleHtml);
	
	var arr = [];
	if (showStyleValue === "sysCirculationOpinionStyleTable"){
		arr.push("<table align='center' class='tb_normal' width='100%' >");
		arr.push(baseHTML);
		arr.push("</table>");
	}else{
		arr.push(baseHTML);
	}
	
	var html="<div id='circulationShow_reivewDiv' style='width:170px;height:60px;overflow:auto;'>" + arr.join("") + "<div>";
	
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

//展现样式值改变事件
function _Designer_Control_CirculationShow_Attr_ShowStyle_Change(showStyle){
	var styleJSON = SysCirculationOpinionStylePlugin.GetStyleByValue(showStyle.value);
	
	var baseHTML = _Designer_Control_CirculationShow_Attr_showStyle_replace(styleJSON.styleHtml);
	
	var arr = [];
	if (showStyle.value === "sysCirculationOpinionStyleTable"){
		arr.push("<table align='center' class='tb_normal' width='100%' >");
		arr.push(baseHTML);
		arr.push("</table>");
	}else{
		arr.push(baseHTML);
	}
	
	$("#circulationShow_reivewDiv").html(arr.join(""));
}

//控件绘制
function _Designer_Control_CirculationShow_OnDraw(parentNode, childNode) {
	var domElement = _CreateDesignElement('div', this, parentNode, childNode);
	domElement.className = "xform_circulationOpinionShow";
	$(domElement).css("display","inline-block");
	if(this.options.values.id == null)
		this.options.values.id = "fd_" + Designer.generateID();

	domElement.id = this.options.values.id;
	
	$(domElement).attr("label",_Get_Designer_Control_Label(this.options.values, this));
	var values = this.options.values;
	
	if (this.options.values.width ) {
		if( this.options.values.width.toString().indexOf('%') > -1){
			domElement.style.whiteSpace = 'nowrap';
			domElement.style.width = this.options.values.width;
		}
		else{
			domElement.style.width = this.options.values.width+"px";
		}
	}else{
		values.width = "100%";
		domElement.style.width = values.width;
	}
	$(domElement).attr("width",values.width);
	
	
	domElement.innerHTML = Designer_Control_CirculationShow_GetExhibitionHTML(this);
	
	//该属性为 showStyle下拉框的value值，及plugin中的viewValue
	if(!values.showStyle){
		values.showStyle = this.attrs.showStyle.value;
	}
	$(domElement).attr("exhibitionStyleClass",values.showStyle);
	
	if(!values.sortNote){
		values.sortNote = this.attrs.sortNote.value;
	}
	//设置排序类型属性
	$(domElement).attr("sortNote",values.sortNote);
}

function _Designer_Control_CirculationShow_DrawXML(){
	var values = this.options.values;
	var buf = ['<extendSimpleProperty '];
	buf.push('name="', values.id, '" ');
	buf.push('label="', values.label, '" ');
	buf.push('type="String" ');
	buf.push('store="false" ');
	buf.push('businessType="', this.type, '" ');
	buf.push('customElementProperties="',Designer.HtmlEscape(JSON.stringify(values)),'" ');
	buf.push('/>');
	return buf.join('');
		
}

//根据不同的类型获取显示格式
function Designer_Control_CirculationShow_GetExhibitionHTML(control){
	var html = [];
	
	//设置初始值为默认样式
	var showStyleValue = control.options.values.showStyle || "sysCirculationOpinionStyleDept";

	var styleJSON = SysCirculationOpinionStylePlugin.GetStyleByValue(showStyleValue);
	//动态设置图片宽度。防止无法拖动到小于图片宽度的值。
	var tempWidth = "100%";
    if(control.options.domElement.style.width){
    	tempWidth = control.options.domElement.style.width;
    }
	var baseHTML = _Designer_Control_CirculationShow_Attr_showStyle_replace(styleJSON.styleHtml);
	
	if (showStyleValue === "sysCirculationOpinionStyleTable"){
		html.push("<table align='center' class='tb_normal' width='100%' >");
		html.push(baseHTML);
		html.push("</table>");
	}else{
		html.push(baseHTML);
	}
	
	return html.join('');
}

function _Designer_Control_CirculationShow_Attr_showStyle_replace(value){
	var map={"docContent":Designer_Lang.circulationOpinionShow_msg,
			"fdOrgName":Designer_Lang.circulationOpinionShow_person,
			"fdOrgDept":Designer_Lang.circulationOpinionShow_dept,
			"width":'',
			"index":1,
			"fdReadTime":Designer_Lang.circulationOpinionShow_time,
			"handwrite":'<img height="30px" width="40px" src="style/img/auditshow/handwrite.png">',
			"fdWriteTime":Designer_Lang.circulationOpinionShow_time,
			"picPath":'<img src="style/img/auditshow/defaultSig2.png">'};
	var text = value.replace(/\$\{(\w+)\}/g,function($1,$2){
		return map[$2];
	});
	return text;
}

//属性面板展现样式
function _Designer_Control_CirculationShow_Attr_ShowStyle_Self_Draw(name, attr, value, form, attrs, values,control){	
	var html = "<select name='showStyle' class='attr_td_select' style='width:95%' onchange='_Designer_Control_CirculationShow_Attr_ShowStyle_Change(this)'>";
	var styleOptions = SysCirculationOpinionStylePlugin.GetOptionsArray();
	for(var i =0;i<styleOptions.length;i++){
		if(value){
			html += "<option value='"+styleOptions[i].value+"'" + (value == styleOptions[i].value ? "selected='selected'" : "") + ">"+styleOptions[i].text+"</option>";
		}
	}
	html += "</select>";
	html += "<input style='display:none;' type='button' value='"+Designer_Lang.circulationOpinionShow_style_custom+"' class='btnopt' onclick='_Designer_Control_CirculationShow_ToCustom();' />";
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

//样式自定义按钮点事事件
function _Designer_Control_CirculationShow_ToCustom(){
	window.open(Com_Parameter.ContextPath + "sys/xform/designer/auditshow/index.jsp");
}