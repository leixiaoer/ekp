<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script>
/* var Com_Parameter = {
	ContextPath:parent.dialogArguments.Window.Com_Parameter.ContextPath,
	ResPath:parent.dialogArguments.Window.Com_Parameter.ResPath,
	Style:parent.dialogArguments.Window.Com_Parameter.Style,
	JsFileList:new Array,
	StylePath:parent.dialogArguments.Window.Com_Parameter.StylePath
}; */
// 多语言对象
LangObject = parent.FlowChartObject.Lang;
// 当前节点多语言对象
LangNodeObject = LangObject.Node;
</script>
<script type="text/javascript" src="../../../resource/js/common.js"></script>
<script type="text/javascript">
Com_IncludeFile("document.js", "style/" + Com_Parameter.Style + "/doc/");
Com_IncludeFile("docutil.js|doclist.js|dialog.js|data.js|formula.js");
</script>
<script>
// 必须实现的方法，供父窗口(attribute_robotnode.html)调用。
function returnValue() {
	if (!check()) return null;
	//console.log('returnValue:'+getParameterJsonByTable());
	//alert('returnValue:'+getParameterJsonByTable());
	return getParameterJsonByTable();
};

function check() {
	return true;
};
function getParameterJsonByTable() {
	var field1=document.getElementById('field1').value;
	var field2=document.getElementById('field2').value;
	var field3=document.getElementById('field3').value;
	var field4=document.getElementById('field4').value;
	var field5=document.getElementById('field5').value;
	var field6=document.getElementById('field6').value;
	var field7=document.getElementById('field7').value;
	var field8=document.getElementById('field8').value;
	var field9=document.getElementById('field9').value;
	var field10=document.getElementById('field10').value;
	var f1="{\"idField\":\""+field1+"\",\"nameField\":\""+field2+"\"},";
	var f2="{\"idField\":\""+field3+"\",\"nameField\":\""+field4+"\"},";
	var f3="{\"idField\":\""+field5+"\",\"nameField\":\""+field6+"\"},";
	var f4="{\"idField\":\""+field7+"\",\"nameField\":\""+field8+"\"},";
	var f5="{\"idField\":\""+field9+"\",\"nameField\":\""+field10+"\"}";
	return "{\"params\":[" +f1+f2+f3+f4 +f5+ "]}";
};

function getParamterJsonByRow(trElement) {
	var rtnJson = new Array();
	rtnJson.push("{");
	// 更新值
	var inputArr = getElementsByParent(trElement.cells[1], "input");
	rtnJson.push("\"idField\":\"" + parent.formatJson(inputArr[0].value) + "\"");
	rtnJson.push(",\"nameField\":\"" + parent.formatJson(inputArr[1].value) + "\"");
	// 结束
	rtnJson.push("}");
	
	return rtnJson.join('');
};

function getElementsByParent(oParent, tagName) {
	var rtnResult = new Array(), child;
	for (var i = 0, length = oParent.childNodes.length; i < length; i++) {
		child = oParent.childNodes[i];
		if (child.tagName && child.tagName.toLowerCase() == tagName)
			rtnResult.push(child);
	}
	return rtnResult;
};

function writeMessage(key) {
	document.write(LangNodeObject[key]);
};

function createInputElementHTML(value, status) {
	var _value = value || '', statusHTML = '', styleHTML = 'width:100%;';
	switch(status) {
	case 'readOnly':
		statusHTML += ' readOnly';
		break;
	case 'hidden':
		styleHTML += 'display:none;';
		break;
	}
	return '<input class=\'inputsgl\' value=\'' + _value + '\'' + statusHTML + ' style=\'' + styleHTML + '\'>';
};

function createHrefElementHTML(text, actionJs) {
	var _actionJs = actionJs || '';
	return '<a href=\'JavaScript:void(0);\' onclick=\'' + _actionJs + '\'>' + text + '</a>';
};

function createSelectElementHTML(options, checkValue, checkName) {
	var rtnResult = new Array();
	if (options == null || options.length == 0) {
		var value = checkValue || '', name = checkName || '';
		if (name != '')	rtnResult.push('<option value=\'' + value + '\' selected>' + name + '</option>');
	} else {
		for (var i = 0, length = options.length; i < length; i++) {
			var option = options[i], value = option.value || option.name;
			rtnResult.push('<option value=\'' + value + '\'');
			if (value == checkValue) rtnResult.push(' selected');
			rtnResult.push('>' + option.name + '</option>');
		}
	}
	return '<select>' + rtnResult.join('') + '</select>';
};

function transFormFieldList() {
	var rtnResult = new Array();
	var fieldList = parent.FlowChartObject.FormFieldList;
	if (!fieldList) return rtnResult;
	// 转换成option支持的格式
	for (var i = 0, length = fieldList.length; i < length; i++) {
		rtnResult.push({value:fieldList[i].name, name:fieldList[i].label});
	}
	return rtnResult;
};

function getIndexFromFieldList(value) {
	var _value = value || '';
	if (_value == '') return null;
	var fieldList = parent.FlowChartObject.FormFieldList;
	if (!fieldList) return null;
	for (var i = 0, length = fieldList.length; i < length; i++) {
		if (fieldList[i].name == value) return i;
	}
	return null;
};

// paramObject格式为：{field:'', fieldName:'', idField:'', nameField:''}
function createRow(trElement, paramObject) {
	var _paramObject = paramObject || {field:'', fieldName:'', value:'', showValue:''}
	var tdElement, html;
	// 表单字段名
	tdElement = trElement.insertCell(-1);
	tdElement.setAttribute('align', 'center');
	tdElement.innerHTML = createSelectElementHTML(transFormFieldList(), _paramObject.field, _paramObject.fieldName);
	// 更新值
	tdElement = trElement.insertCell(-1);
	html = createInputElementHTML(_paramObject.idField, 'hidden');
	html += createInputElementHTML(_paramObject.nameField, 'readOnly');
	html += '<br>' + createHrefElementHTML(LangNodeObject['selectFormList'], 'openExpressionEditor(this);');
	tdElement.innerHTML = html;
	// 删除操作
	tdElement = trElement.insertCell(-1);
	tdElement.setAttribute('align', 'center');
	tdElement.innerHTML = createHrefElementHTML(LangObject.Operation['operationDelete'], 'deleteRow(this);');
};

function openExpressionEditor(owner) {
	var idField, nameField;
	var arrElement = getElementsByParent(owner.parentNode, "input");
	if (arrElement.length < 2) return;
		idField = arrElement[0];
		nameField = arrElement[1];
	// 获取相应配置的数据类型
	var selectValue = null;
	var selectedIndex = null, fieldList = parent.FlowChartObject.FormFieldList;
	// 调用公式定义器
	Formula_Dialog(
			idField,
			nameField,
			parent.FlowChartObject.FormFieldList,
			"Object",
			null,
			null,
			parent.FlowChartObject.ModelName);
};

// 追加行
function appendRow(table, paramObject,n) {
	//alert('paramObject.idField:'+paramObject.idField);
	 document.getElementById('field'+(n*2+1)).value=paramObject.idField;
	 document.getElementById('field'+(n*2+2)).value=paramObject.nameField;
};

// 删除行
function deleteRow(owner) {
	var findNode = owner;
	for (;findNode.tagName && findNode.tagName.toLowerCase() != 'tr'; findNode = findNode.parentNode) {}
	if (findNode && findNode.tagName) findNode.parentNode.removeChild(findNode);
};

// 输出参数
function OutputParamters(params) {
	var _params = params || null;
	if (_params == null) return;
	// 输出...
	var table = document.getElementById('main');
	for (var i = 0, length = _params.length; i < length; i++) {
		appendRow(table, _params[i],i);
	}
};

function initDocument() {
	//alert('parent.NodeContent:'+parent.NodeContent);
	if(parent.NodeContent!='')
	{
	// 获得内容对象
	var json = eval('(' + parent.NodeContent + ')');
	//console.log(parent.NodeContent);
	//console.log(json.params);
	//alert(json.params);
	if(json && json.params)
		OutputParamters(json.params);
	}
};
</script>
<body onload="initDocument();">
<table id="main" width="100%" class="tb_normal">
	<tr align="center">
		<td width="30%"><script>document.write(Data_GetResourceString("km-asset:robot.cardCode"));</script></td>
		<td width="70%">
		<nobr>
		<input id="field1" name="field1" class="inputsgl" value="" style="width:10%;display:none;">
		<input id="field2" name="field2" class="inputsgl" value="" readonly="" style="width:80%;">
		<a href="JavaScript:void(0);" onclick="openExpressionEditor(this);"><script>document.write(Data_GetResourceString("km-asset:robot.formula"));</script></a>
		</nobr>
		</td>
	</tr>
	<tr align="center">
		<td><script>document.write(Data_GetResourceString("km-asset:kmAssetApplyDivertList.fdNowDept"));</script></td>
		<td>
		<nobr>
		<input id="field3" name="field3" class="inputsgl" value="" style="width:10%;display:none;">
		<input id="field4" name="field4" class="inputsgl" value="" readonly="" style="width:80%;">
		<a href="JavaScript:void(0);" onclick="openExpressionEditor(this);"><script>document.write(Data_GetResourceString("km-asset:robot.formula"));</script></a>
		</nobr>
		</td>
	</tr>
	<tr align="center">
		<td><script>document.write(Data_GetResourceString("km-asset:kmAssetApplyDivertList.fdNowPerson"));</script></td>
		<td>
		<nobr>
		<input id="field5" name="field5" class="inputsgl" value="" style="width:10%;display:none;">
		<input id="field6" name="field6" class="inputsgl" value="" readonly="" style="width:80%;">
		<a href="JavaScript:void(0);" onclick="openExpressionEditor(this);"><script>document.write(Data_GetResourceString("km-asset:robot.formula"));</script></a>
		</nobr>
		</td>
	</tr>
	<tr align="center">
		<td><script>document.write(Data_GetResourceString("km-asset:kmAssetApplyDivertList.fdNewAddress"));</script></td>
		<td>
		<nobr>
		<input id="field7" name="field7" class="inputsgl" value="" style="width:10%;display:none;">
		<input id="field8" name="field8" class="inputsgl" value="" readonly="" style="width:80%;">
		<a href="JavaScript:void(0);" onclick="openExpressionEditor(this);"><script>document.write(Data_GetResourceString("km-asset:robot.formula"));</script></a>
		</nobr>
		</td>
	</tr>
		<tr align="center">
		<td><script>document.write(Data_GetResourceString("km-asset:kmAssetApplyDivertList.Reson"));</script></td>
		<td>
		<nobr>
		<input id="field9" name="field9" class="inputsgl" value="" style="width:10%;display:none;">
		<input id="field10" name="field10" class="inputsgl" value="" readonly="" style="width:80%;">
		<a href="JavaScript:void(0);" onclick="openExpressionEditor(this);"><script>document.write(Data_GetResourceString("km-asset:robot.formula"));</script></a>
		</nobr>
		</td>
	</tr>
</table>
</body>
</html>