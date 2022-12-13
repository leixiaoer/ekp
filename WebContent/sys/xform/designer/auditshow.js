/**
 * 审批意见展示控件
 * @作者：曹映辉 @日期：2012年4月13日
 */
/**
 * @param isContainDraftNode 传入false表示不包含起草节点
 */
function Dialog_List_ShowNode(idField, nameField, splitStr, isMulField,action,isContainDraftNode){
	if(window.XForm_IsExtendOpt){
		Dialog_List_ShowNode_Extend(idField, nameField, splitStr, isMulField,action,isContainDraftNode);
	}else{
		var dialog = new KMSSDialog(true, true);
		dialog.BindingField(idField, nameField, splitStr, isMulField);

		dialog.SetAfterShow(action);

		//获取流程中所有节点
		var wfNodes=(window.XForm_GetWfAuditNodes == null)?[]:XForm_GetWfAuditNodes();
		var data=new KMSSData();
		var ary = new Array();
		for(var i=0;i<wfNodes.length;i++){
			//只有审批节点和签字节点可供选择(新增起草节点)
			//审批操作不需要包含起草节点
			if (isContainDraftNode === false && 'draftNode'==wfNodes[i].type ){
				continue;
			}
			if('signNode'==wfNodes[i].type || 'reviewNode'==wfNodes[i].type || 'sendNode'==wfNodes[i].type || 'draftNode'==wfNodes[i].type){
				//设置选中节点
				var temp = new Array();
				temp["id"]= wfNodes[i].value;
				temp["name"]= wfNodes[i].value + ' ' + wfNodes[i].name;
				ary.push(temp);

			}
		}

		data.AddHashMapArray(ary);
		dialog.optionData.AddKMSSData(data);
		dialog.Show(window.screen.width*520/1366,window.screen.height*400/768);
	}
}
function Dialog_List_ShowNode_Extend(idField, nameField, splitStr, isMulField,action,isContainDraftNode){
	var dialog = new KMSSDialog(true, true);
	dialog.BindingField(idField, nameField, splitStr, isMulField);
	dialog.SetAfterShow(action);
	dialog.URL = Com_Parameter.ContextPath + "sys/xform/designer/auditshow/extend/dialog.jsp";
	dialog.parameters = {};
	dialog.parameters.Com_Parameter = window.Com_Parameter;

	//获取流程中所有节点：多个流程的情况（格式是[{id:modelid, name:name, nodes:节点列表}]）
	var allNodes=(window.XForm_GetWfAuditNodes_Extend == null)?[]:XForm_GetWfAuditNodes_Extend();
	if(!allNodes){
		alert("请先进行流程设计！");
		return;
	}
	Designer.instance.auditAllNodes = allNodes;
	var lbpms = [];
	var newAllNodes = {};
	var firstAry = null;
	var isEmpty = null;
	for(var i=0;i<allNodes.length;i++){
		var nodes = allNodes[i].nodes;
		var ary = [];
		for(var j=0; j<nodes.length; j++){
			if('signNode'==nodes[j].type || 'reviewNode'==nodes[j].type){
				//设置选中节点
				var temp = new Array();
				temp["id"]= nodes[j].value + '##' + allNodes[i].id;
				temp["name"]= nodes[j].value + ' ' + nodes[j].name;
				ary.push(temp);
			}
		}
		if(ary && ary.length > 0){
			var lbpm = {};
			lbpm.id = allNodes[i].id;
			lbpm.name = allNodes[i].name;
			lbpms.push(lbpm);

			newAllNodes[allNodes[i].id] = ary;

			if(!firstAry){
				firstAry = ary;
			}
		}
	}
	dialog.parameters.lbpms = lbpms;
	dialog.parameters.allNodes = newAllNodes;
	if(firstAry.length == 0){
		isEmpty = "empty";
	}
	dialog.parameters.isEmpty = isEmpty;
	dialog.parameters.firstAry = firstAry;
	var data=new KMSSData();
	data.AddHashMapArray(firstAry);
	dialog.optionData.AddKMSSData(data);
	dialog.Show(window.screen.width*520/1366,window.screen.height*400/768);
}
var StylePlugin=function(){
	var self=this;
	this.init=function(){
		//获取扩展点中定义的样式信息
		//this.extStyle='';
		$.ajax({
			url: Com_Parameter.ContextPath + "sys/xform/designer/auditshow_style.jsp",
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

var StylePluginInstance =new StylePlugin();

Designer_Config.operations['auditShow']={
	lab : "5",
	imgIndex : 42,
	title:Designer_Lang.auditshow_name_insert,
	run : function (designer) {
		designer.toolBar.selectButton('auditShow');
	},
	type : 'cmd',
	order: 7,
	line_splits_end:true,
	shortcut : 'N',
	sampleImg : 'style/img/auditshow/auditShow.png',
	select: true,
	cursorImg: 'style/cursor/auditshow.cur'
};
Designer_Config.controls.auditShow={
	type : "auditShow",
	inherit : 'base',
	storeType : 'field',
	onDraw : _Designer_Control_AuditShow_OnDraw,
	onDrawEnd : _Designer_Control_AuditShow_OnDrawEnd,
	drawMobile : _Designer_Control_AuditShow_DrawMobile,
	drawXML : _Designer_Control_AuditShow_DrawXML,
	//onInitialize:_Designer_Control_AuditShow_DoInitialize,
	//destroyMessage:Designer_Lang.controlAuditShow_msg_del,
	onAttrLoad : _Designer_Control_Attr_Tab_OnAttrLoad,
	implementDetailsTable : false,
	attrs : {
		label : Designer_Config.attrs.label,

		detail_attr_value:{
			//控件隐藏值
			text: Designer_Lang.auditshow_attr_hiddenValue,
			value : '',
			type: 'hidden',
			skipLogChange:true,
			show: true
		},
		detail_attr_name:{
			text: Designer_Lang.auditshow_attr_hiddenName,
			value : '',
			type: 'hidden',
			//只对隐藏的name校验必填，主要兼容 自定义模式时，value可以为空。其他模式name不为空，value必不为空
			validator: [Designer_Control_AuditShow_DetailName_Required_Validator],
			checkout: Designer_Control_AuditShow_DetailName_Required_Checkout,
			skipLogChange:true,
			show: true
		},
		detail_attr_value31:{
			//控件隐藏值
			text: Designer_Lang.auditshow_attr_hiddenValue,
			value : '',
			type: 'self',
			draw : _Designer_Control_Attr_detailHidden_self_Draw,
			skipLogChange:true,
			show: true
		},
		detail_attr_name31:{
			text: Designer_Lang.auditshow_attr_hiddenName,
			value : '',
			type: 'self',
			draw : _Designer_Control_Attr_detailHidden_self_Draw,
			//只对隐藏的name校验必填，主要兼容 自定义模式时，value可以为空。其他模式name不为空，value必不为空
			validator: [Designer_Control_Attr_Required_Validator],
			checkout: Designer_Control_AuditShow_DetailName31_Required_Checkout,
			skipLogChange:true,
			show: true
		},
		mould : {
			text: Designer_Lang.auditshow_attr_type,
			value : '11',
			type : 'select',
			opts: [
				{name: 'handler1', text: Designer_Lang.auditshow_mould_handler1, value:'11'},
				{name: 'handler2', text: Designer_Lang.auditshow_mould_handler2, value:'12'},
				{name: 'node1', text: Designer_Lang.auditshow_mould_node1, value:'21'},
				{name: 'node2', text: Designer_Lang.auditshow_mould_node2, value:'22'},
				{name: 'node1AndHandler1', text: Designer_Lang.auditshow_mould_node1AndHandler1, value:'31'},
				{name: 'custom', text: Designer_Lang.auditshow_mould_custom, value:'91'}
			],
			getVal:mould_getVal,
			translator:mould_translator,
			onchange:'_Designer_Control_Attr_Mould_Change(this)',
			show: true
		},
		mouldDetail : {
			//审批人属于
			text: Designer_Lang.auditshow_auditorOwner,
			value : '',
			type: 'self',
			draw: _Designer_Control_Attr_MouldDetail_Self_Draw,
			show: true
		},
		mouldDetail2: {
			//审批人属于
			text: Designer_Lang.auditshow_auditorOwner,
			value : '',
			type: 'self',
			draw: _Designer_Control_Attr_MouldDetail2_Self_Draw,
			show: true
		},
		showStyle : {
			//展示样式
			text: Designer_Lang.auditshow_attr_exhibitionStyle,
			value : 'auditNoteStyleDefaultOnlyHandler',
			type : 'self',
			draw: _Designer_Control_Attr_showStyle_Self_Draw,
			opts: StylePluginInstance.GetOptionsArray(),
			onchange:'_Designer_Control_Attr_ShowStyle_Change(this)',
			getVal:relationSource_getVal,
			show: true
		},
		detail_attr_name310:{
			text: Designer_Lang.auditshow_chooseExhibitionNodes,
			value : '',
			type: 'self',
			draw : _Designer_Control_Attr_detailHidden_self_Draw,

			show: true
		},
		detail_attr_name311:{
			text: Designer_Lang.auditshow_auditorOwner,
			value : '',
			type: 'self',
			draw : _Designer_Control_Attr_detailHidden_self_Draw,
			show: true
		},
		detail_attr_name2:{
			text: Designer_Lang.auditshow_auditorOwner,
			value : '',
			type: 'self',
			draw : _Designer_Control_Attr_detailHidden_self_Draw,
			show: true,
			getVal:detail_attr_name_getVal,
			translator:detail_attr_name_translator,
			tipTranslator:detail_attr_name_tipTranslator
		},
		previewImg :{
			//预览图
			text: Designer_Lang.auditshow_attr_preview,
			value : '',
			type: 'self',
			draw:_Designer_Control_Attr_PreviewImg_Self_Draw,
			show: true
		},
		filterNote:{
			//意见筛选
			text: Designer_Lang.auditshow_attr_filterNote,
			value : '',
			type : 'checkGroup',
			opts:[{name:'showDrafterPostscript',text:Designer_Lang.auditshow_filterNote_showDrafterPostscript,value:"6"},
				{name:'showHandlerPostscript',text:Designer_Lang.auditshow_filterNote_showHandlerPostscript,value:"7"},
				{name:'samePersonLast',text:Designer_Lang.auditshow_filterNote_sameHandler,value:"1"},
				{name:'sameDepartmentLast',text:Designer_Lang.auditshow_filterNote_sameDept,value:"2"},
				{name:'nullNoteHave',text:Designer_Lang.auditshow_filterNote_nullNoteHave,value:"0"},
				{name:'reviewNote',text:Designer_Lang.auditshow_filterNote_reviewNote,value:"5"},
				{name:'reviewNoteInstruction',text:Designer_Lang.auditshow_filterNote_reviewNoteInstruction,value:"8"},
				{name:'reviewNoteReading',text:Designer_Lang.auditshow_filterNote_reviewNoteReading,value:"9"}],
			show:true,
			getVal:filterNote_getVal,
		},
		noteFilter:{
			//意见过滤
			text: Designer_Lang.auditshow_attr_noteFilter,
			value : '',
			type : 'self',
			opts:[{name:'assigneeNoteOnly',text:Designer_Lang.auditshow_filterNote_assigneeNoteOnly,value:"3"},{name:'handlerNoteOnly',text:Designer_Lang.auditshow_filterNote_handlerNoteOnly,value:"4"}],
			draw:_Designer_Control_Attr_NoteFilter_Self_Draw,
			show:true,
			translator:opts_common_translator
		},
		nf_assigneeNoteOnly:{
			skipLogChange:true
		},
		nf_handlerNoteOnly:{
			skipLogChange:true
		},
		showDrafterPostscript:{
			skipLogChange:true
		},
		showHandlerPostscript:{
			skipLogChange:true
		},
		samePersonLast:{
			skipLogChange:true
		},
		sameDepartmentLast:{
			skipLogChange:true
		},
		nullNoteHave:{
			skipLogChange:true
		},
		reviewNote:{
			skipLogChange:true
		},
		reviewNoteInstruction:{
			skipLogChange:true
		},
		reviewNoteReading:{
			skipLogChange:true
		},
		sortNote:{
			//意见排序
			text: Designer_Lang.auditshow_attr_noteSort,
			value : 'asc',
			type : 'radio',
			opts:[{text:Designer_Lang.auditshow_sortNote_Asc,value:"asc"},
				{text:Designer_Lang.auditshow_sortNote_Desc,value:"desc"},
				{text:Designer_Lang.auditshow_sortNote_HandlerAsc,value:"handler_asc"},
				{text:Designer_Lang.auditshow_sortNote_HandlerDesc,value:"handler_desc"}],
				translator:opts_common_translator,
			show:true
		},
		width : {
			text: Designer_Lang.controlAttrWidth,
			value: "",
			type: 'text',
			show: true,
			validator: Designer_Control_Attr_Width_Validator,
			checkout: Designer_Control_Attr_Width_Checkout
		},
		formula: Designer_Config.attrs.formula,
		reCalculate: Designer_Config.attrs.reCalculate
	},
	info:{
		//审批意见展示控件
		name:Designer_Lang.auditshow_name,
		preview: "mutiTab.png"
	}
	,
	resizeMode : 'onlyWidth'
};
Designer_Config.buttons.tool.push("auditShow");
Designer_Menus.tool.menu['auditShow'] = Designer_Config.operations['auditShow'];

function detail_attr_name_getVal(name,attr,value,controlValue){
	if(value){
		var _val = {};
		_val.value = value;
		var _mould = controlValue.mould;
		if(_mould){
			var __mould = JSON.parse(_mould);
			if(__mould.value){
				_val.mould = __mould.value
			}
		}
		controlValue[name] = JSON.stringify(_val);
	}
}

function detail_attr_name_translator(change,obj){
	if (!change) {
		return "";
	}
	var _before = JSON.parse(change.before);
	var _after = JSON.parse(change.after);
	var html = "<span> "+Designer_Lang.from+" (" + _before.value + ") "+Designer_Lang.to+" (" + _after.value + ")</span>";
	return html;
}

function detail_attr_name_tipTranslator(change,obj,pname){
	if (!change) {
		return pname;
	}
	var _after = JSON.parse(change.after);
	if(_after.mould){
		var lableText = pname;
		switch(_after.mould)
		{
			case '11':
			{
				//onpropertychange 审批人属于
				lableText = Designer_Lang.auditshow_auditorOwner;
				break;
			}
			case '12':
			{
				//审批人属于
				lableText = Designer_Lang.auditshow_auditorOwner;
				break;
			}
			case '21':
			case '22':
			{
				//选择展示节点
				lableText = Designer_Lang.auditshow_chooseExhibitionNodes;
				break;
			}
			case '31': //按节点+按审批人(仅审批意见)
			{
				//选择展示节点(仅意见)
				lableText = Designer_Lang.auditshow_chooseExhibitionNodes;
				break;
			}
			case '91':
			{	//自定义
				lableText = Designer_Lang.auditshow_preference;
				break;
			}
		}
		return lableText;
	}
}

function mould_getVal(name,attr,value,controlValue) {
	var opts = attr["opts"];
	if(undefined==opts){
		return "";
	}
	for (var i = 0; i < opts.length; i++) {
		var opt = opts[i];
		if (opt.value === value) {
			controlValue[name] = JSON.stringify({text:opt.text,value:value});
			return opt.text;
		}
	}
	return "";
}

function mould_translator(change,obj){
	if (!change) {
		return "";
	}
	var _before = JSON.parse(change.before);
	var _after = JSON.parse(change.after);
	var html = "<span> "+Designer_Lang.from+" (" + _before.text + ") "+Designer_Lang.to+" (" + _after.text + ")</span>";
	return html;
}


function relationSource_getVal(name,attr,value,controlValue) {
	var opts = attr["opts"];
	if(undefined==opts){
		return "";
	}
	for (var i = 0; i < opts.length; i++) {
		var opt = opts[i];
		if (opt.value === value) {
			controlValue[name] = opt.text;
			return opt.text;
		}
	}
	return "";
}
function filterNote_getVal(name,attr,value,controlValue) {
	var opts = attr["opts"];
	var text ="";
	if(opts){
		for (var i = 0; i < opts.length; i++) {
			var opt = opts[i];
			if(value && value.indexOf(opt.value)!= -1 && opt.value !=null&&opt.value !='' ){
				if(text.length > 0){
					text=text+",";
				}
				text=text+opt.text;
			}
		}
	}
	controlValue[name] = text;
	return text;
}
function _Designer_Control_Attr_PreviewImg_Self_Draw(name, attr, value, form, attrs, values,control){

	var showStyleValue=Designer.instance.control.attrs.showStyle.value;

	if(values.showStyle){
		showStyleValue=values.showStyle;
	}

	var styleJSON=StylePluginInstance.GetStyleByValue(showStyleValue);

	if(!styleJSON){
		styleJSON = StylePluginInstance.GetStyleByValue("auditNoteStyleDefaultOnlyHandler");
		//{"previewPictureURL":"style/img/auditshow/auditShow.png"};
	}

	//var html="<img id='auditshow_reivewImg_url' src='"+styleJSON.previewPictureURL+"' width='170px' height='80px'/>";
	var html="<div id='auditshow_reivewDiv' style='width:170px;height:100px;overflow:auto;'>"+_Designer_Control_Attr_showStyle_replace(styleJSON.styleHtml)+"<div>";

	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}
function _Designer_Control_Attr_ShowStyle_Change(showStyle){
	var styleJSON=StylePluginInstance.GetStyleByValue(showStyle.value);

	$("#auditshow_reivewDiv").html(_Designer_Control_Attr_showStyle_replace(styleJSON.styleHtml));
	//attr("src",styleJSON.previewPictureURL);

}
function _Designer_Control_Attr_Mould_Change(mouldSelect){

	var html=_GetHTMLByMouldType(mouldSelect.value);

	$("#auditshow_mouldDetail_html").html(html);

	_Designer_Control_Attr_Mould31_change(mouldSelect);

	_Designer_Control_Attr_NoteFilter_ControlDisplay(mouldSelect.value);
}

/**
 * mould31值改变事件
 * 首先attr的moulddetail2属性会判断是不是31模式,是31才会绘制moulddetail2
 * 不是31，清除detail2和隐藏域,是31再重新绘制
 */
function _Designer_Control_Attr_Mould31_change(mouldSelect){
	if (mouldSelect.value == "31"){
		var $tr = $("#auditshow_mouldDetail_html").closest("tr");
		var html2 = _Designer_Control_MouldDetail2_Draw(mouldSelect.value);
		$tr.after(html2);
		var $nameField = $("input[type='hidden'][name='detail_attr_name']");
		$nameField.after("<input type='hidden' name='detail_attr_value31'><input type='hidden' name='detail_attr_name31'>");
		//是否为初始是的模式，如果不是则需要将控件的值设置为空
		var control = Designer.instance.control;
		if(document.getElementsByName("detail_attr_name31")[0]){
			document.getElementsByName("detail_attr_name31")[0].value=control.options.values.detail_attr_name31||"";
		}
		if(document.getElementsByName("detail_attr_value31")[0]){
			document.getElementsByName("detail_attr_value31")[0].value=control.options.values.detail_attr_value31||"";
		}
	}else{
		var $tr = $("#auditshow_mouldDetail_html2").closest("tr");
		$tr.remove();
		var $value31Field = $("input[type='hidden'][name='detail_attr_value31']");
		var $name31Field = $("input[type='hidden'][name='detail_attr_name31']");
		$value31Field.remove();
		$name31Field.remove();
	}
}

function _Designer_Control_Attr_Tab_OnAttrLoad(form,control){
	if(document.getElementsByName("detail_attr_name")[0]){
		document.getElementsByName("detail_attr_name")[0].value=control.options.values.detail_attr_name||"";
	}
	if(document.getElementsByName("detail_attr_value")[0]){
		document.getElementsByName("detail_attr_value")[0].value=control.options.values.detail_attr_value||"";
	}
	if(document.getElementsByName("detail_attr_name31")[0]){
		document.getElementsByName("detail_attr_name31")[0].value=control.options.values.detail_attr_name31||"";
	}
	if(document.getElementsByName("detail_attr_value31")[0]){
		document.getElementsByName("detail_attr_value31")[0].value=control.options.values.detail_attr_value31||"";
	}
}

function _Designer_Control_Attr_MouldDetail_Self_Draw(name, attr, value, form, attrs, values,control){
	var mouldValue = attrs.mould.value;
	if(values.mould){
		mouldValue=values.mould;
	}
	html="<div id='auditshow_mouldDetail_html'>"+_GetHTMLByMouldType(mouldValue)+"</div>";
	if (mouldValue == '31' || mouldValue == "21" || mouldValue == "22"){
		attr.text = Designer_Lang.auditshow_chooseExhibitionNodes;
	}else{
		attr.text = Designer_Lang.auditshow_auditorOwner;
	}
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}
//当mould31时,构建审批人属于dom元素,绘制attr时自动调用
function _Designer_Control_Attr_MouldDetail2_Self_Draw(name, attr, value, form, attrs, values,control){
	var mouldValue = attrs.mould.value;
	if(values.mould){
		mouldValue=values.mould;
	}
	if (mouldValue == "31"){
		var html=[];
		var control = Designer.instance.control;
		if(document.getElementsByName("detail_attr_name31")[0]){
			document.getElementsByName("detail_attr_name31")[0].value=control.options.values.detail_attr_name31||"";
		}
		if(document.getElementsByName("detail_attr_value31")[0]){
			document.getElementsByName("detail_attr_value31")[0].value=control.options.values.detail_attr_value31||"";
		}
		//审批人属于(地址本)
		html.push("<div id='auditshow_mouldDetail_html2'>");
		html.push("<input type='text' id='detail_attr_name311' name='detail_attr_name311' readonly='true'  class='inputsgl' value='"+(control.options.values.detail_attr_name31||"")+"'/>");
		html.push("<span class='txtstrong'>*</span>");
		html.push("<a href='javascript:void(0)' id='handlerSelect2' onclick=\"Dialog_Address(true, 'detail_attr_value31','detail_attr_name311', ';',ORG_TYPE_ALL,After_Select_Set_Name311);_Designer_Control_Attr_Address_defaultValue_afterClick();\">"+Designer_Lang.auditshow_choose+"</a>");
		html.push("</div>");
		html = html.join("");
		return '<tr><td width="25%" class="panel_td_title">' + Designer_Lang.auditshow_auditorOwner + '</td><td>' + html + '</td></tr>';
	}
	return '';
}


function _Designer_Control_MouldDetail2_Draw(mouldValue){
	var html=[];
	var control = Designer.instance.control;
	//审批人属于(地址本)
	html.push("<div id='auditshow_mouldDetail_html2'>");
	html.push("<input type='text' id='detail_attr_name311' name='detail_attr_name311' readonly='true'  class='inputsgl' value='"+(control.options.values.detail_attr_name31||"")+"'/>");
	html.push("<span class='txtstrong'>*</span>");
	html.push("<a href='javascript:void(0)' id='handlerSelect2' onclick=\"Dialog_Address(true, 'detail_attr_value31','detail_attr_name311', ';',ORG_TYPE_ALL,After_Select_Set_Name311);_Designer_Control_Attr_Address_defaultValue_afterClick();\">"+Designer_Lang.auditshow_choose+"</a>");
	html.push("</div>");
	html = html.join("");
	return '<tr><td width="25%" class="panel_td_title">' + Designer_Lang.auditshow_auditorOwner + '</td><td>' + html + '</td></tr>';
}

function After_Select_Set_Name(returnValue){
	document.getElementsByName("detail_attr_name")[0].value=document.getElementsByName("detail_attr_name2")[0].value;
}
function After_Select_Set_Name310(returnValue){
	document.getElementsByName("detail_attr_name")[0].value=document.getElementsByName("detail_attr_name310")[0].value;
}
function After_Select_Set_Name311(returnValue){
	document.getElementsByName("detail_attr_name31")[0].value=document.getElementsByName("detail_attr_name311")[0].value;
}
function SetBack_Detail_attr_name(obj){
	//Designer.instance.control.options.values.detail_attr_name=obj.value;
	document.getElementsByName("detail_attr_name")[0].value=obj.value;
}
function SetBack_Detail_attr_value(obj){
	//Designer.instance.control.options.values.detail_attr_value=obj.value;
	document.getElementsByName("detail_attr_value")[0].value=obj.value;
}
function _GetHTMLByMouldType(mouldValue){
	var html=[];
	var lableText="";
	var control = Designer.instance.control;
	//是否为初始是的模式，如果不是则需要将控件的值设置为空
	var isInitMould=false;
	//处理公式中含有""时报错
	control.options.values.detail_attr_value = control.options.values.detail_attr_value?control.options.values.detail_attr_value.replace(/quat;/g, "\""):"";
	control.options.values.detail_attr_name = control.options.values.detail_attr_name?control.options.values.detail_attr_name.replace(/quat;/g, "\""):"";
	//选择回初始模式时，需要将初始值重新设置回去。

	if(control.options.values.mould==mouldValue){
		isInitMould=true;


		if(document.getElementsByName("detail_attr_name")[0]){
			document.getElementsByName("detail_attr_name")[0].value=control.options.values.detail_attr_name||"";
		}
		if(document.getElementsByName("detail_attr_value")[0]){
			document.getElementsByName("detail_attr_value")[0].value=control.options.values.detail_attr_value||"";
		}

	}
	else
	{
		if(document.getElementsByName("detail_attr_name")[0]){
			document.getElementsByName("detail_attr_name")[0].value="";
		}
		if(document.getElementsByName("detail_attr_value")[0]){
			document.getElementsByName("detail_attr_value")[0].value="";
		}

	}
	switch(mouldValue)
	{
		case '11':
		{
			//onpropertychange 审批人属于
			lableText=Designer_Lang.auditshow_auditorOwner;
			html.push("<input type='text' id='detail_attr_name2' name='detail_attr_name2' readonly='true'  class='inputsgl' value='"+(isInitMould?(control.options.values.detail_attr_name||""):"")+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			//html.push("<input type='hidden' id='detail_attr_value2' name='detail_attr_value2' onchange='SetBack_Detail_attr_value(this);' onpropertychange='SetBack_Detail_attr_value(this);' value='"+(isInitMould?(control.options.values.detail_attr_value||""):"")+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Dialog_Address(true, 'detail_attr_value','detail_attr_name2', ';',ORG_TYPE_ALL,After_Select_Set_Name);_Designer_Control_Attr_Address_defaultValue_afterClick();\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '12':
		{
			//审批人属于
			lableText=Designer_Lang.auditshow_auditorOwner;
			html.push("<input type='text' id='detail_attr_name2' name='detail_attr_name2' readonly='true'  class='inputsgl' value='"+(isInitMould?(control.options.values.detail_attr_name||""):"")+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			//html.push("<input type='hidden' id='detail_attr_value2' name='detail_attr_value2' onchange='SetBack_Detail_attr_value(this);' onpropertychange='SetBack_Detail_attr_value(this);' value='"+(isInitMould?(control.options.values.detail_attr_value||""):"")+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Formula_Dialog('detail_attr_value','detail_attr_name2',Designer.instance.getObj(true),'Object',After_Select_Set_Name,null,Designer.instance.control.owner.owner._modelName);\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '21':
		case '22':
		{
			//选择展示节点
			lableText=Designer_Lang.auditshow_chooseExhibitionNodes;
			html.push("<input type='text' id='detail_attr_name2' name='detail_attr_name2'   readonly='true'  class='inputsgl' value='"+(isInitMould?(control.options.values.detail_attr_name||""):"")+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			//html.push("<input type='hidden' id='detail_attr_value2' name='detail_attr_value2' onchange='SetBack_Detail_attr_value(this);' onpropertychange='SetBack_Detail_attr_value(this);' value='"+(isInitMould?(control.options.values.detail_attr_value||""):"")+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Dialog_List_ShowNode('detail_attr_value','detail_attr_name2', ';','',After_Select_Set_Name);\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '31': //按节点+按审批人(仅审批意见)
		{
			//选择展示节点(仅意见)
			lableText=Designer_Lang.auditshow_chooseExhibitionNodes;
			html.push("<input type='text' id='detail_attr_name310' name='detail_attr_name310'   readonly='true'  class='inputsgl' value='"+(isInitMould?(control.options.values.detail_attr_name||""):"")+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Dialog_List_ShowNode('detail_attr_value','detail_attr_name310', ';','',After_Select_Set_Name310);\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '91':
		{	//自定义
			lableText=Designer_Lang.auditshow_preference;
			//参数	
			html.push(Designer_Lang.auditshow_preferenceParam+"：<input name='detail_attr_value2' id='detail_attr_value2' onkeyup='SetBack_Detail_attr_value(this);' value='"+(isInitMould?(control.options.values.detail_attr_value||""):"")+"'/><br/>");
			html.push(" Bean：<input name='detail_attr_name2' id='detail_attr_name2'  onkeyup='SetBack_Detail_attr_name(this);'   value='"+(isInitMould?(control.options.values.detail_attr_name||""):"")+"'/><span class='txtstrong'>*</span>");
			//对自定义模式的帮助描述
			html.push("<div style='color:grey;font-size:11px;'>"+Designer_Lang.auditshow_preferenceHint+"</div>");
			break;
		}
	}

	//设置mouldDetail Label
	if($("#auditshow_mouldDetail_html")[0]){
		//<tr><td width="25%" class="panel_td_title">' + attr.text + '</td><td>' + html + '</td></tr>'

		$("#auditshow_mouldDetail_html").parent().prev().text(lableText);
	}
	html=html.join('');
	return html;
}
function _Designer_Control_AuditShow_OnDraw(parentNode, childNode) {
	var domElement = _CreateDesignElement('div', this, parentNode, childNode);
	domElement.className="xform_auditshow";
	$(domElement).css("display","inline-block");
	if(this.options.values.id == null)
		this.options.values.id = "fd_" + Designer.generateID();

	domElement.id = this.options.values.id;

	$(domElement).attr("label",_Get_Designer_Control_Label(this.options.values, this));
	var values =this.options.values;

	if (this.options.values.width ) {
		if( this.options.values.width.toString().indexOf('%') > -1){
			domElement.style.whiteSpace = 'nowrap';
			domElement.style.width = this.options.values.width;
		}
		else{
			domElement.style.width = this.options.values.width+"px";
		}

	}
	else{
		values.width = "100%";
		domElement.style.width=values.width;
	}
	$(domElement).attr("width",values.width);
	if(!values.mould){
		//初始值为1
		values.mould=this.attrs.mould.value;
	}
	//设置用户选择的模式
	$(domElement).attr("mould",values.mould);

	var params=values.detail_attr_name;
	if(params){
		params=params.split(";");
	}

	domElement.innerHTML=GetExhibitionHTML(this,params);

	//该属性为 showStyle下拉框的value值，及plugin中的viewValue
	if(!values.showStyle){
		values.showStyle=this.attrs.showStyle.value;
	}
	$(domElement).attr("exhibitionStyleClass",values.showStyle);

	var checkedFilterNotes=[];
	var filterNoteOpts=this.attrs.filterNote.opts;

	for(var i=0;i<filterNoteOpts.length;i++){
		if(values[filterNoteOpts[i].name]=='true'){
			checkedFilterNotes.push(filterNoteOpts[i].value);
		}
	}
	//设置过滤类型
	$(domElement).attr("filterNote",checkedFilterNotes.join(','));
	//没有选择过滤类型 则去默认值。
	if(checkedFilterNotes.length==0){
		$(domElement).attr("filterNote",this.attrs.filterNote.value);
	}
	values.filterNote=$(domElement).attr("filterNote");

	var checkedNoteFilters=[];
	var noteFilterOpts=this.attrs.noteFilter.opts;

	for(var i=0;i<noteFilterOpts.length;i++){
		if(values["nf_" + noteFilterOpts[i].name]=='true'){
			checkedNoteFilters.push(noteFilterOpts[i].value);
		}
	}
	$(domElement).attr("noteFilter",checkedNoteFilters.join(','));
	if(checkedNoteFilters.length==0){
		$(domElement).attr("noteFilter",this.attrs.noteFilter.value);
	}
	values.noteFilter=$(domElement).attr("noteFilter");

	if(!values.sortNote){
		values.sortNote=this.attrs.sortNote.value;
	}
	//设置排序类型属性
	$(domElement).attr("sortNote",values.sortNote);
	//处理公式中含有""时报错
	if(values.detail_attr_value){
		values.detail_attr_value = values.detail_attr_value.replace(/\"/g, "quat;");
		$(domElement).attr("value",values.detail_attr_value);
	}
	if(values.detail_attr_name){
		values.detail_attr_name = values.detail_attr_name.replace(/\"/g, "quat;");
		$(domElement).attr("attr_name",values.detail_attr_name);
	}
	if(values.detail_attr_name2){
		values.detail_attr_name2 = values.detail_attr_name2.replace(/\"/g, "quat;");
	}
	if (values.mould == "31"){
		if (values.detail_attr_value31){
			var _value = values.detail_attr_value + "~" + values.detail_attr_value31;
			$(domElement).attr("value",_value);
		}
	}
	// 判断是否为签名的样式
	if ("auditNoteStyleDefaultOnlySignature" == values.showStyle
		|| "auditNoteStyleDefaultSignatureDate" == values.showStyle
		|| "auditNoteStyleDefaultSignature" == values.showStyle) {
		switch ($(domElement).attr("mould")) {
			case '11': {
				$(domElement).attr("attr_name","auditNoteDataByHandlerSignature");
				break;
			}
			case '12': {
				$(domElement).attr("attr_name","auditNoteDataByHandlerSignatureFormula");
				break;
			}
			case '21':{
				$(domElement).attr("attr_name","auditNoteDataByNodeSignature");
				break;
			}
			case '22': {
				$(domElement).attr("attr_name","auditNoteDataByNodeTableSignature");
				break;
			}
			case '31': {
				$(domElement).attr("attr_name","auditNoteDataByHandlerAndNoteSignature");
				break;
			}
		}
		$(domElement).attr("mould","91");
	}
}
function _Designer_Control_AuditShow_DrawXML(){
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
function _Designer_Control_AuditShow_OnDrawEnd(){

	//this.options.domElement.exhibitionBusinessClass=this.options.values.exhibitionBusinessClass;
	//alert(val);


}
//根据不同的类型获取显示格式
function GetExhibitionHTML(control,params){
	var html=[];
//	var baseHTML="<img id='auditshow_reivewImg_url' src='"+styleJSON.previewPictureURL+"' width='170px' height='80px'/>";

	//设置初始值为默认样式
	var showStyleValue=control.options.values.showStyle||"auditNoteStyleDefaultOnlyHandler";

	var styleJSON=StylePluginInstance.GetStyleByValue(showStyleValue);
	//动态设置图片宽度。防止无法拖动到小于图片宽度的值。
	var tempWidth="100%";
	if(control.options.domElement.style.width)
	{
		tempWidth=control.options.domElement.style.width;
	}
	var baseHTML=_Designer_Control_Attr_showStyle_replace(styleJSON.styleHtml);
	//"<img  src='"+styleJSON.previewPictureURL+"' width='"+tempWidth+"' height='80px'/>";

	switch(control.options.values.mould)
	{
		case '11':
		case '12':
		case '21':
		case '31':
		case '91':

			html.push(baseHTML);

			break;

		case '22':
			//审批节点1，审批节点2，审批节点3，
			params=params||[Designer_Lang.auditshow_auditNode+'1',Designer_Lang.auditshow_auditNode+'2',Designer_Lang.auditshow_auditNode+'3'];
			html.push("<table align='center' class='tb_normal' width='100%' >");
			for(var i=0;i<params.length;i++){
				html.push("<tr>");

				html.push("<td noWrap=true style='width:30%'>");
				html.push(params[i]);
				html.push("</td>");

				html.push("<td  style='width:70%'>");
				html.push(baseHTML);
				html.push("</td>");

				html.push("</tr>");
			}
			html.push("</table>");
			break;
	}
	return html.join('');
}

function _Designer_Control_Attr_showStyle_replace(value){
	var map={"msg":Designer_Lang.sysXformAuditshow_msg,
		"person":Designer_Lang.sysXformAuditshow_person,
		"dept":Designer_Lang.sysXformAuditshow_dept,
		"post":Designer_Lang.sysXformAuditshow_post,
		"width":'',
		"handwrite":'<img height="30px" width="40px" src="style/img/auditshow/handwrite.png">',
		"attachment":'<img src="style/img/auditshow/attachment.png">',
		"time":Designer_Lang.sysXformAuditshow_time,
		"date":Designer_Lang.sysXformAuditshow_date,
		"picPath":'<img src="style/img/auditshow/defaultSig2.png">',
		"operation":Designer_Lang.sysXformAuditshow_operation};
	var text = value.replace(/\$\{(\w+)\}/g,function($1,$2){
		return map[$2];
	});
	return text;
}

function _Designer_Control_Attr_showStyle_Self_Draw(name, attr, value, form, attrs, values,control){
	var html = "<select name='showStyle' class='attr_td_select' style='width:95%' onchange='_Designer_Control_Attr_ShowStyle_Change(this)'>";
	var styleOptions = StylePluginInstance.GetOptionsArray();
	for(var i =0;i<styleOptions.length;i++){
		if(value){
			html += "<option value='"+styleOptions[i].value+"'" + (value == styleOptions[i].value ? "selected='selected'" : "") + ">"+styleOptions[i].text+"</option>";
		}
	}
	html += "</select>";
	html += "<input type='button' value='"+Designer_Lang.auditshow_mould_custom+"' class='btnopt' onclick='_Designer_Control_AuditShow_ToCustom();' />";
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

function _Designer_Control_Attr_NoteFilter_Self_Draw(name, attr, value, form, attrs, values, control){
	var html = '<input type="hidden" value="" name="' + name + '">';
	for (var i = 0, l = attr.opts.length; i < l; i ++) {
		var opt = attr.opts[i];
		html += '<label isfor="true" style="display:block"><input type="checkbox" value="true" name="nf_' + opt.name + '"';
		if ((values["nf_" + opt.name] == null && opt.checked) || values["nf_" + opt.name] == "true") {
			html += ' checked="checked"';
		}
		html += ' onclick="_Designer_Control_Attr_NoteFilter_OnClick(this)"';
		html += '>' + attr.opts[i].text + '</label>';
	}
	setTimeout("_Designer_Control_Attr_NoteFilter_ControlDisplay(" + values.mould + ")", 0);
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}

function _Designer_Control_Attr_detailHidden_self_Draw(name, attr, value, form, attrs, values,control){
	var mouldValue = attrs.mould.value;
	if(values.mould){
		mouldValue=values.mould;
	}
	html = "";
	if (mouldValue == '31'){
		html="<input type='hidden' name='" + name +"'/>";
	}
	return html;
}

function _Designer_Control_Attr_NoteFilter_ControlDisplay(mouldValue){
	if (mouldValue == "21" || mouldValue == "22") {
		$("input[name='noteFilter']").closest('tr').show();
	} else {
		$("input[name='noteFilter']").closest('tr').hide();
		$("input[name*='nf_']").each(function(){
			this.checked = false;
		});
	}
}

function _Designer_Control_Attr_NoteFilter_OnClick(noteFilter){
	if (noteFilter.name && noteFilter.checked == true) {
		$("input[name*='nf_']").each(function(){
			if (this.name != noteFilter.name) {
				this.checked = false;
			}
		});
	}
}

function _Designer_Control_AuditShow_ToCustom(){
	window.open(Com_Parameter.ContextPath + "sys/xform/designer/auditshow/index.jsp");
}

//校验
function Designer_Control_AuditShow_DetailName_Required_Validator(elem, name, attr, value, values){
	var mould = values.mould;
	if(!mould){
		mould = $(elem).parents("table:eq(0)").find("[name='mould']").val();
	}
	//类型为41/42直接返回true
	if(!(mould && (mould == "41" || mould == "42"))){
		var lableText = "";
		switch(mould)
		{
			case '11':
			{
				//onpropertychange 审批人属于
				lableText = Designer_Lang.auditshow_auditorOwner;
				break;
			}
			case '12':
			{
				//审批人属于
				lableText = Designer_Lang.auditshow_auditorOwner;
				break;
			}
			case '21':
			case '22':
			{
				//选择展示节点
				lableText = Designer_Lang.auditshow_chooseExhibitionNodes;
				break;
			}
			case '31': //按节点+按审批人(仅审批意见)
			{
				//选择展示节点(仅意见)
				lableText = Designer_Lang.auditshow_chooseExhibitionNodes;
				break;
			}
			case '91':
			{	//自定义
				lableText = Designer_Lang.auditshow_preference;
				break;
			}
		}
		return Designer_Control_Attr_Required_Validator(elem, name, {text:lableText}, value, values);
	}
	return  true;
}

function Designer_Control_AuditShow_DetailName_Required_Checkout(msg, name, attr, value, values, control){
	if (value == null || value == '' || value.replace(/\r\n/g, '') == '') {
		msg.push(values.label,","+Designer_Lang.auditshow_auditorOwnerNotNull);
		return false;
	}
	return true;
}

function Designer_Control_AuditShow_DetailName31_Required_Checkout(msg, name, attr, value, values, control){
	if (values.mould !== '31'){
		return true;
	}
	if (value == null || value == '' || value.replace(/\r\n/g, '') == '') {
		msg.push(values.label,","+Designer_Lang.auditshow_auditorOwnerNotNull);
		return false;
	}
	return true;
}

