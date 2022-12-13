Com_IncludeFile('json2.js');
Designer_Config.operations['auditNote']={
		lab : "5",
		imgIndex : 41,
		title:Designer_Lang.auditNote,
		run : function (designer) {
			designer.toolBar.selectButton('auditNote');
		},
		type : 'cmd',
		order: 6,
		shortcut : '',
		sampleImg : 'style/img/auditNote/auditNote.png',
		select: true,
		cursorImg: 'style/cursor/auditnote.cur'
};
Designer_Config.controls.auditNote={
			type : "auditNote",
			inherit : 'base',
			storeType : 'field',
			onDraw : _Designer_Control_auditNote_OnDraw,
			onDrawEnd : _Designer_Control_auditNote_OnDrawEnd,
			drawXML : _Designer_Control_auditNote_DrawXML,
			drawMobile : _Designer_Control_AuditNote_DrawMobile,
			//onInitialize:_Designer_Control_auditNote_DoInitialize,
			//destroyMessage:Designer_Lang.controlauditNote_msg_del,
			onAttrLoad : _Designer_Control_Attr_Tab_OnAttrLoad,
			implementDetailsTable : false,
			attrs : {
				label : Designer_Config.attrs.label,
				mould : {
					text: Designer_Lang.auditshow_attr_type,
					value : '21',
					type : 'select',
					opts: [
					    {name: 'node1', text: Designer_Lang.auditNote_flowNote, value:'21'},
						{name: 'handler1', text: Designer_Lang.auditNote_handerShowByAddress, value:'11'},
						{name: 'handler2', text: Designer_Lang.auditNote_handerShowByFormula, value:'12'}
						
					],
					onchange:'_Designer_Control_AuditNote_Attr_Mould_Change(this)',
					show: true
				},
				mouldDetail : {
 					//审批人属于
					text: Designer_Lang.auditNote_chooseNode,
					value : '',
					type: 'self',
					draw: _Designer_Control_AuditNote_Attr_MouldDetail_Self_Draw,
					checkout:function(msg, name, attr, value, values, control){
						if(!value||value=='~'||!values.detail_attr_value){
							msg.push(values.label+',' + Designer_Lang.auditNote_requiredAttributeNotNull);
							return false;
						}
						return true;
					},
					show: true
				},
				rejectType: {
					text: Designer_Lang.auditNote_rejectType,
					value: '0',
					type: 'radio',
					opts: [{text:Designer_Lang.auditNote_rejectTheDraftingNode,value:"0"},{text:Designer_Lang.auditNote_optionalNodeReject,value:"1"}],
					show: true
				},
				width : {
					text: Designer_Lang.controlAttrWidth,
					value: "",
					type: 'text',
					show: true,
					validator: Designer_Control_Attr_Width_Validator,
					checkout: Designer_Control_Attr_Width_Checkout
				},
				height : {
					text: Designer_Lang.controlAttrHeight,
					value: "",
					type: 'text',
					show: true,
					validator: Designer_Control_Attr_Int_Validator,
					checkout: Designer_Control_Attr_Int_Checkout
				},
				detail_attr_name :{
					skipLogChange:true,
					show: false
				},
				detail_attr_value :{
					skipLogChange:true,
					show: false
				},
				formula: Designer_Config.attrs.formula,
				reCalculate: Designer_Config.attrs.reCalculate
			},
			info:{
				//审批意见展示控件
				name:Designer_Lang.auditNote,
				preview: "mutiTab.png"
			}
			,
			resizeMode : 'onlyWidth'
};
Designer_Config.buttons.tool.push("auditNote");
Designer_Menus.tool.menu['auditNote'] = Designer_Config.operations['auditNote'];

function _Designer_Control_auditNote_OnDraw(parentNode, childNode) {
	var domElement = _CreateDesignElement('div', this, parentNode, childNode);
	domElement.className="xform_auditNote";
	if(this.options.values.id == null)
		this.options.values.id = "fd_" + Designer.generateID();

	domElement.id = this.options.values.id;
	
	domElement.label=_Get_Designer_Control_Label(this.options.values, this);
	
	domElement.style.border="0px solid #DFDFDF";
	$(domElement).css("display","inline-block");
	var values =this.options.values;
	
	
	if (this.options.values.width) {
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
	$(domElement).attr("rejectType",values.rejectType);
	$(domElement).attr("mould",values.mould);
	$(domElement).attr("mouldDetail",values.mouldDetail);
	if (this.options.values.height) {
		if( this.options.values.height.toString().indexOf('%') > -1){
			domElement.style.whiteSpace = 'nowrap';
			domElement.style.height = this.options.values.height;
		}
		else{
			//作者 曹映辉 #日期 2015年8月20日 +30像素是考虑在设计器的时候把按钮放到div里面去，高度作用在div上。在运行时直接把高度作用在文本域上
			domElement.style.height = (parseInt(this.options.values.height)+30)+"px";
		}
	}
	else{
		values.height = "60";
		domElement.style.height=(parseInt(values.height)+30)+"px";
	}
	$(domElement).attr("height",values.height);
	var textarea="<textarea style='width:100%;height:"+(values.height)+"px;margin-top:0px'>";
	textarea +="</textarea>";
	
	var btnSubmit="<input type='button' class='btnopt' style='width:60px;height:25px' value='"+Designer_Lang.auditNote_pass+"' disabled='disabled'>";
	btnSubmit +="</input>";
	var btnReject="<input type='button' class='btnopt' style='width:60px;height:25px' value='"+Designer_Lang.auditNote_refuse+"' disabled='disabled'>";
	btnReject +="</input>";
	
	var usageSelect="<label>"+Designer_Lang.auditNote_commonOpinion+"</label>&nbsp<select disabled='disabled'><option>=="+Designer_Lang.auditNote_select+"==</option></select>";
	
	domElement.innerHTML=textarea+"<br/>"+btnSubmit+"&nbsp;"+btnReject+"&nbsp;&nbsp;"+usageSelect;
}
function _Designer_Control_auditNote_DrawXML(){
}
function _Designer_Control_auditNote_OnDrawEnd(){
}
function _Designer_Control_AuditNote_Attr_Mould_Change(mouldSelect){
	
	var html=_GetHTMLByHanderType(mouldSelect.value);
	
	$("#auditnote_mouldDetail_html").html(html);
}
function _Designer_Control_AuditNote_Attr_MouldDetail_Self_Draw(name, attr, value, form, attrs, values,control){	
	var mouldValue = attrs.mould.value;
	if(values.mould){
		mouldValue=values.mould;
	}
	html="<div id='auditnote_mouldDetail_html'>"+_GetHTMLByHanderType(mouldValue,value)+"</div>";
	return Designer_AttrPanel.wrapTitle(name, attr, value, html);
}
function _GetHTMLByHanderType(mouldValue,val){
	var html=[];
	var names="";
	var labels="";
	if(val){
		names=val.split("~")[0];
		labels=val.split("~")[1];
	}
	switch(mouldValue)
	{
		case '11':
		{
			//onpropertychange 审批人属于
			lableText=' '+Designer_Lang.auditNote_handlerBelongsTo;
			html.push("<input type='text' id='detail_attr_name' name='detail_attr_name' readonly='true'  class='inputsgl' value='"+labels+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			html.push("<input type='hidden' id='detail_attr_value' name='detail_attr_value' value='"+names+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Dialog_Address(true, 'detail_attr_value','detail_attr_name', ';',ORG_TYPE_ALL,After_MouldDetailSelect_Set);_Designer_Control_Attr_Address_defaultValue_afterClick();\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '12':
		{
			//审批人属于
			lableText=' '+Designer_Lang.auditNote_handlerBelongsTo;
			html.push("<input type='text' id='detail_attr_name' name='detail_attr_name' readonly='true'  class='inputsgl' value='"+labels+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			html.push("<input type='hidden' id='detail_attr_value' name='detail_attr_value'  value='"+names+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Formula_Dialog('detail_attr_value','detail_attr_name',Designer.instance.getObj(true),'Object',After_MouldDetailSelect_Set,null,Designer.instance.control.owner.owner._modelName);\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
		case '21':
		{
			//选择展示节点
			lableText=' ' + Designer_Lang.auditNote_chooseNode;
			html.push("<input type='text' id='detail_attr_name' name='detail_attr_name'   readonly='true'  class='inputsgl' value='"+labels+"'/>");
			html.push("<span class='txtstrong'>*</span>");
			html.push("<input type='hidden' id='detail_attr_value' name='detail_attr_value'  value='"+names+"'/>");
			html.push("<a href='javascript:void(0)' id='handlerSelect' onclick=\"Dialog_List_ShowNode('detail_attr_value','detail_attr_name', ';','',After_MouldDetailSelect_Set,false);\">"+Designer_Lang.auditshow_choose+"</a>");
			break;
		}
	}
	
	//设置mouldDetail Label
	if($("#auditnote_mouldDetail_html")[0]){
		//<tr><td width="25%" class="panel_td_title">' + attr.text + '</td><td>' + html + '</td></tr>'
		
		$("#auditnote_mouldDetail_html").parent().prev().text(lableText);
	}
	html=html.join('');
	return html;
}
function After_MouldDetailSelect_Set(rtnvalue){
	if(!rtnvalue){
		return;
	}
	var control=Designer.instance.attrPanel.panel.control;
	var values=control.options.values;
	
	var names=[];
	var labels=[];
	
	for(var i=0;i<rtnvalue.data.length;i++){
		names.push(rtnvalue.data[i].id);
		labels.push(rtnvalue.data[i].name);
	}
	if(names.length>0){
		values.mouldDetail=names.join(";")+"~"+labels.join(";");
	}
	else{
		values.mouldDetail="";
	}
}