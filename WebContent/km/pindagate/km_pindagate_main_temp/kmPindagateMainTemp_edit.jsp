<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.questiontype.*" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.web.Globals" %>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%
	//为了正常显示英文状态下的题目类型按钮，特根据方言来判断分行
	//张乐志 alter 2013年1月15日
	//默认显示10个再换行，中文状态下也为10个换行，英文及其他语言状态下为5个换行
	Object obj=session.getAttribute(Globals.LOCALE_KEY);
	if(obj!=null){
		Locale locale=(Locale)obj;
		if(locale.getLanguage().indexOf("en")>-1){
			request.setAttribute("btncount",5);
		}
		else if(locale.getLanguage().indexOf("zh")>-1){
			request.setAttribute("btncount",10);
		}
		else{
			request.setAttribute("btncount",5);
		}
	}
	else{
		request.setAttribute("btncount",10);
}%>
<script type="text/javascript"
	src="${KMSS_Parameter_ResPath}js/jquery.js"></script>
<script type="text/javascript"
	src="${KMSS_Parameter_ResPath}js/json2.js"></script>
<style>
.btn{background-image: url(../images/plusIcon.png);
	 background-repeat: no-repeat;
	 background-position: -2px;
	 padding: 0px 10px !important;
	 padding: 0px 2px ;
    }
</style>
<script>
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("calendar.js|dialog.js|doclist.js|docutil.js|optbar.js");
function submitForm(method, status){
	if(validateSubject() && validateQuetion(0)){
		Com_Submit(document.kmPindagateMainTempForm, method);
	}
}
//校验标题
function validateSubject(){
	if(trim($('input[name="docSubject"]').val()) == ""){
		alert('<bean:message key="kmPindagateMainTemp.docSubject" bundle="km-pindagate"/><bean:message key="kmPindagate.validate.message.notNull" bundle="km-pindagate"/>');
		return false;
	}else{
		return true;
	}
}
//校验题目是否为空
function validateQuetion(index){
	if($('input[name="fdItems['+index+'].fdSplit"]').val() == 'true'){
		index++;
		return validateQuetion(index);
	}else if(!$("input[name='fdItems["+index+"].fdQuestionDef']").val() || $("input[name='fdItems["+index+"].fdQuestionDef']").val() == ""){
		alert('<bean:message key="kmPindagateMain.fdQuestionDef.not.null" bundle="km-pindagate" />')
		return false;
	}else{
		return true;
	}
}
function Cate_CheckNotReaderFlag(el){
	document.getElementById("Cate_AllUserId").style.display=el.checked?"none":"";
	document.getElementById("Cate_AllUserNote").style.display=el.checked?"none":"";
	el.value=el.checked;
}
</script>
<script type="text/javascript">
var tbInfo = null;
$(document).ready(function loadQuestionType(){	
	  var data = new KMSSData();
	  var url="kmPindagateQuestionTypeService";
	  data.SendToBean(url,initQuesTypeVal);
});
/**
 * 初始化题型类别信息
 */
function initQuesTypeVal(rtnData){
	var questionTypes = {};
	var str = "";
	if(rtnData){
		for(var i=0; i<rtnData.GetHashMapArray().length; i++){
			var obj = rtnData.GetHashMapArray()[i];
			var quesTypeId = obj['quesTypeId'];
			var quesTypeName = obj['quesTypeName'];
			var editUrl = obj['editUrl']+"?kmPindagateMainFdId=${kmPindagateMainTempForm.fdId}&isTemp=1";;
			var previewUrl = obj['previewUrl'];
			var jsUrl = obj['jsUrl'];
			questionTypes[i] = {'quesTypeId':quesTypeId,
								'quesTypeName':quesTypeName,
								'editUrl':editUrl,
								'previewUrl':previewUrl,
								'jsUrl':jsUrl};
			//$('select[name="questionTypeselect"]').append('<option value="'+quesTypeId+'">'+quesTypeName+'</option>');
			if(i == 0)
				str += "<tr>";
			str +='<td><input type="button" class="btnopt btn" value="'+quesTypeName+'" title="'+quesTypeName+'" onclick="addQuestion(\'insert\',\''+quesTypeId+'\',\''+quesTypeName+'\',\''+editUrl+'\');"></td>';
			if((i+1)%"${btncount}"==0){
				str += "</tr>"+"<tr>";
			}
		}
		//str += '<td><input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" onclick="addQuestion(\'add\',\'pagination\');"></td>';
		str += '<td><input type="button" class="btnopt btn"  title="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" onclick="addQuestion(\'insert\',\'pagination\');"></td>';
		str += "</tr>";
		$('#Add_question_TB').append(str);
	}
	var encoded = JSON.stringify(questionTypes); 
	$('input[name="questionTypes"]').val(encoded);
}
/**
 * 显示或隐藏新增问题的题型列表层
 */
function changeQueslistDiv(){
   var obj_div =document.getElementById('queslist_div');
   with(obj_div.style){
	   obj_div.style.top = document.body.scrollTop + event.clientY + 10 + "px";
	   obj_div.style.left = document.body.scrollLeft + event.clientX + 1 + "px";
   }
   if(obj_div.style.display=='none'){
	   obj_div.style.display='block';
   }else{
	   obj_div.style.display='none';
   }
}
/**
 * 添加或插入一条题目
 */
function addQuestion(method,questionType,quesTypeName,url){
	if(method == "add"){
		if(questionType == "pagination"){
			insertPagination();
		}else{
			insertQuestion(url,null,questionType);
		}
		changeQueslistDiv();
	}else if(method == "insert"){
		if(tbInfo == null)
			tbInfo = DocList_TableInfo['TABLE_DocList'];
		var insertIndex = null;
		var obj = null;
		var confirmMsg = '<bean:message key="kmPindagateQuestion.thisLocation" bundle="km-pindagate"/>';
		for(var i=0;i<tbInfo.lastIndex-1;i++){
			obj = document.getElementsByName("fdItems["+i+"].checkbox")[0];
			if(obj && obj.checked){
				insertIndex = i+2;
				confirmMsg = '<bean:message key="kmPindagateQuestion.beforeSelect" bundle="km-pindagate"/>';
				break;
			}
		}
		if(questionType == "pagination"){
			//判断是否是选择位置插入
			if(obj && obj.checked){
				if(confirm('<bean:message key="kmPindagateQuestion.sureTo" bundle="km-pindagate"/>'+confirmMsg+'<bean:message key="kmPindagateQuestion.insertPageBreak" bundle="km-pindagate"/>')){
					insertPagination(insertIndex);
				}else{
					return;
				}
			}else{
				insertPagination(insertIndex);
			}
			
		}else{
			//var selectObj = document.getElementsByName("questionTypeselect")[0];
			//questionType = selectObj.value;
			//if(selectObj.value == null || selectObj.value ==''){
				//alert("请选择要插入的题型！");
				//return;
			//}
			url = getEditUrl(questionType);
			
			//判断是否是选择位置插入
			if(obj && obj.checked){
				if(confirm('<bean:message key="kmPindagateQuestion.sureTo" bundle="km-pindagate"/>'+confirmMsg+'<bean:message key="kmPindagateQuestion.insertQuestion" bundle="km-pindagate"/>'))	{
				    //if(document.getElementsByName("fdItems["+i+"].checkbox")[0]){
					insertQuestion(url,insertIndex,questionType,quesTypeName);
				}else{
					return;
				}
			}else{
				insertQuestion(url,insertIndex,questionType,quesTypeName);
			}
		}
	}
}
/**
* 插入题目   
* 		url 打开窗口url
* 		insertIndex 插入位置   为空时在最后一行插入
* 		questionType  题型类别
*/
function insertQuestion(url,insertIndex,quesTypeVal,quesTypeName){
	quesTypeVal = quesTypeVal;
	quesTypeText = quesTypeName;
	var obj = new Object();
	openWin(url,obj,null,function(rtnValue){
		if(rtnValue != null && rtnValue != ""){
			var openUrl = "'"+url+"'";
			var obj = "document.getElementsByName(this.id)[0]";
			var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainTempId" value="${kmPindagateMainTempForm.fdId}"><input type="hidden" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder"><input type="hidden" name="fdItems[!{index}].fdSplit"><input type="hidden" name="fdItems[!{index}].fdQuestionDef">',
		            '',
		            '<span id="fdItems[!{index}].fdNameShow"></span><input type="hidden" name="fdItems[!{index}].fdName" >',
		            ''+quesTypeText+'<input type="hidden" name="fdItems[!{index}].fdType" value="'+quesTypeVal+'">',
		            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="${lfn:message('button.moveup')}" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="${lfn:message('button.movedown')}" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="${lfn:message('doclist.delete')}" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
		            '<input type="button" id="fdItems[!{index}].fdQuestionDef" class="btnopt" value=\'<bean:message key="button.edit"/>\' onclick="openWin('+openUrl+','+obj+',\'edit\');">');
			addRow("TABLE_DocList", content,null,insertIndex,"1");
			refreshIndex(tbInfo);
			var obj = null;
			var index = "";
			if(insertIndex == null || insertIndex == ""){
				if(tbInfo == null)
					tbInfo = DocList_TableInfo['TABLE_DocList'];
				index = tbInfo.lastIndex-3;
			}else{
				index = insertIndex - 2;
			}
			obj = document.getElementsByName("fdItems["+index+"].fdQuestionDef")[0];
			obj.value = rtnValue;
			var selecttype = eval("("+(obj.value)+")");
			var subject = selecttype.subject.replace(/&nbsp;/g," ");
			document.getElementsByName(obj.name.replace("fdQuestionDef","fdName"))[0].value = $("<div></div>").append(subject).text();
			document.getElementById(obj.name.replace("fdQuestionDef","fdNameShow")).innerHTML = $("<div></div>").append(subject).text();
		}
	});	
}
/**
 * 插入分页标记
 *		insertIndex 插入位置   为空时在最后一行插入
 */
function insertPagination(insertIndex){
	var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainTempId" value="${kmPindagateMainTempForm.fdId}"><input type="hidden" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder">',
			            '',
			            '<span id="fdItems[!{index}].fdNameShow"><bean:message key="kmPindagateQuestion.button.pageBreak" bundle="km-pindagate"/></span><input type="hidden" name="fdItems[!{index}].fdName" value="<bean:message key="kmPindagateQuestion.button.pageBreak" bundle="km-pindagate"/>" >',
			            '<bean:message key="kmPindagateQuestion.button.pageBreak" bundle="km-pindagate"/><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="${lfn:message('button.moveup')}" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="${lfn:message('button.movedown')}" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="${lfn:message('doclist.delete')}" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
			            '');
	addRow("TABLE_DocList", content,"pagination",insertIndex);
	refreshIndex(tbInfo);
}
/**
* 增加一个动态行
* 		optTR：
*			可选，操作行对象，默认取当前操作的当前行
*		content：
*			可选，HTML代码数组，往每个单元格塞的内容，默认从基准行中取数据
*			若希望只提供几个单元格的数据时，只需要将其他单元格对应数组元素设置为null
*		questionType 
*			题型类别：singleselect、multiselect、singlematrix、multimatrix、essayquestion、score、pagination等等
*		insertIndex 
*			插入位置   为空时在最后一行插入
*/
function addRow(optTB, content,questionType,insertIndex){
	if(optTB==null)
		optTB = DocListFunc_GetParentByTagName("TABLE");
	else if(typeof(optTB)=="string")
		optTB = document.getElementById(optTB);
	if(content==null)
		content = new Array;
	var tbInfo = DocList_TableInfo[optTB.id];
	var index = tbInfo.lastIndex - tbInfo.firstIndex;
	var htmlCode, newCell;
	var newRow = null;
	if(insertIndex != null && insertIndex != "")
		newRow = optTB.insertRow(insertIndex);
	else
		newRow = optTB.insertRow(tbInfo.lastIndex);
	if(questionType == 'pagination')
		newRow.style.backgroundColor = "#D5EADF";
	tbInfo.lastIndex++;
	newRow.className = tbInfo.className;
	for(var i=0; i<tbInfo.cells.length; i++){
		newCell = newRow.insertCell(-1);
		newCell.className = tbInfo.cells[i].className;
		newCell.align = tbInfo.cells[i].align ? tbInfo.cells[i].align : '';
		var isIndexVal = index+1;
		for(var j=0; j<index; j++){
			var fdSplit = document.getElementsByName("fdItems["+j+"].fdSplit")[0];
			if(fdSplit && fdSplit.value){
				isIndexVal--;
			}
		}
		if(tbInfo.cells[i].isIndex){
			if(questionType == 'pagination')
				htmlCode = "";
			else 
				htmlCode = isIndexVal;
		}
		else{
			htmlCode = DocListFunc_ReplaceIndex(content[i]==null?tbInfo.cells[i].innerHTML:content[i], index);
		}
		newCell.innerHTML = htmlCode;
	}
	return newRow;
}
/**
 * 移动行
 *	 direct：
 *		必选，1：下移动，-1上移动
 *	 optTR：
 *		可选，操作行对象，默认取当前操作的当前行
 */
function moveRow(direct, optTR){
	if(optTR==null)
		optTR = DocListFunc_GetParentByTagName("TR");
	var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
	var tbInfo = DocList_TableInfo[optTB.id];
	var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
	var tagIndex = rowIndex + direct;
	if(direct==1){
		if(tagIndex>=tbInfo.lastIndex)
			return;
		optTB.rows[rowIndex].parentNode.insertBefore(optTB.rows[tagIndex], optTB.rows[rowIndex]);
	}else{
		if(tagIndex<tbInfo.firstIndex)
			return;
		optTB.rows[rowIndex].parentNode.insertBefore(optTB.rows[rowIndex], optTB.rows[tagIndex]);
	}
	refreshIndex(tbInfo);
}
/**
 * 删除行
 *	optTR：
 *		可选，操作行对象，默认取当前操作的当前行
 */
function deleteRow(optTR){
	if(optTR==null)
		optTR = DocListFunc_GetParentByTagName("TR");
	var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
	var tbInfo = DocList_TableInfo[optTB.id];
	var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
	optTB.deleteRow(rowIndex);
	tbInfo.lastIndex--;
	refreshIndex(tbInfo);
}
/**
* 刷新排序号
*	tbInfo：
*		刷新表格对象
*/
function refreshIndex(tbInfo){
	if(tbInfo == null)
		tbInfo = DocList_TableInfo['TABLE_DocList'];
	var index = 1;
	for(var i = 2; i<tbInfo.lastIndex; i++){
		var fields = $(tbInfo.DOMElement.rows[i]).find("[id^='fdItems'],[name^='fdItems']");
		for(var j=0; j<fields.length; j++){
			if(fields.eq(j).prop("name")){
 	 			var fieldName=fields.eq(j).prop("name").replace(/\d+/g, i-2);
 	 			fields.eq(j).prop("name",fieldName);
 	 	 	}
 	 	 	if(fields.eq(j).prop("id")){
 	 			var fieldId = fields.eq(j).prop("id").replace(/\d+/g, i-2);
 				fields.eq(j).prop("id",fieldId);
 	 	 	 }
		}
		var fdSplit = document.getElementsByName("fdItems["+(i-2)+"].fdSplit")[0];
		if(fdSplit && fdSplit.value != "true"){
			for(var n = 0; n < tbInfo.cells.length; n ++){
				if (tbInfo.cells[n].isIndex) {
					tbInfo.DOMElement.rows[i].cells[n].innerHTML = index;
					index++;
				}
			}
		}
		$('input[name="fdItems['+(i-2)+'].fdOrder"]').val((i-2));
	}
}
/**
 * 打开编辑模态窗口
 */
function openWin(url,obj,type,cb){
	url = '<c:url value = "/'+url+'" />';
	var width=700;var height=500;
	var left = (screen.width-width)/2;
	var top = (screen.height-height)/2;
	var winStyle = "width="+width+",height="+height+",dependent=yes,alwaysRaised=1,resizable=1,scrollbars=1"+",left="+left+",top="+top;
	if(obj == null){
		obj ="";
	}
	
	window._question=obj;
	window._closeDialog=function(obj){
		if(type == "edit" && obj.value != null && obj.value != ""){
			var selecttype = eval("("+(obj.value)+")");
			var subject = selecttype.subject.replace(/&nbsp;/g," ");
			document.getElementsByName(obj.name.replace("fdQuestionDef","fdName"))[0].value = $("<div></div>").append(subject).text();
			document.getElementById(obj.name.replace("fdQuestionDef","fdNameShow")).innerHTML = $("<div></div>").append(subject).text();
		}
		if(!!cb){
			cb(obj.value);
		}
	};
	window.open(url,"_blank",winStyle);
	//return obj.value;
}
/**
* 预览
*/
function preview(){
	var questions = new Array();
	var question = null;
	var questionTypes = $('input[name="questionTypes"]').val();
	var lastIndex = $('#TABLE_DocList .questionTR').length;	
	for(var index = 0; index<lastIndex; index++){	
		if($('input[name="fdItems['+index+'].fdName"]').val() != ""){	
			question = {'fdQuestionDef':$('[name="fdItems['+index+'].fdQuestionDef"]').val(),
					'fdType':$('[name="fdItems['+index+'].fdType"]').val(),
					'fdSplit':$('[name="fdItems['+index+'].fdSplit"]').val(),
					'fdOrder':$('[name="fdItems['+index+'].fdOrder"]').val(),
					'fdTitle':$('[name="fdItems['+index+'].fdName"]').val(),
					'questionTypes':questionTypes};
			questions[index] = question;
		}
	}
	var url = '<c:url value = "/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_preview.jsp?param=edit" />';
	var obj = $('#questions');
	obj.value = JSON.stringify(questions);
	var width=1024;var height=768;
	var left = (screen.width-width)/2;
	var top = (screen.height-height)/2;
	var winStyle = "width="+width+",height="+height+",dependent=yes,alwaysRaised=1,resizable=1,scrollbars=1"+",left="+left+",top="+top;
	window._questions=obj;
	window._closeDialog=function(obj){
		questions = eval("("+(obj.value)+")");
		afterPreview(questions);
	};
	window.open(url,"_blank",winStyle);
	//window.showModalDialog(url , obj,"dialogWidth=1024px;dialogHeight=768px");
}
/**
 * 预览页面编辑之后重新设置题目
 */
function afterPreview(questions){
	if(questions != null && questions != ""){
		var tbInfo = DocList_TableInfo['TABLE_DocList'];
		//重新加载题目
		for(var key in questions){
			$('input[name="fdItems['+key+'].fdName"]').val($("<div></div>").append(questions[key].fdTitle).text());
			$('span[id="fdItems['+key+'].fdNameShow"]').html(questions[key].fdTitle);
			$('input[name="fdItems['+key+'].fdQuestionDef"]').val(questions[key].fdQuestionDef);
		}
		var delCount = 0; 
		for(var key in questions){
			if(questions[key].fdQuestionDef == "delete"){
				var rowIndex = 2+parseInt(key);
				var optTB=document.getElementById('TABLE_DocList');
				optTB.deleteRow(rowIndex-delCount);
				tbInfo.lastIndex--;
				delCount++;
				refreshIndex(tbInfo);
			}
		}
	}
}
/**
 * 编辑
 */
function edit(questionType,_this)
{
	var obj = document.getElementsByName(_this.id)[0];
	openWin(getEditUrl(questionType),obj,'edit');
}
/**
* 根据题型返回编辑页面URL
*/
function getEditUrl(questionType){
	var questionTypeObj = $('input[name="questionTypes"]');
	var questionTypes = eval("("+(questionTypeObj.val())+")");
	for(key in questionTypes){
		if(questionType == questionTypes[key].quesTypeId){
			return questionTypes[key].editUrl;
		}
	}
}
</script>
<html:form action="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do" >
<div id="optBarDiv">
	<c:if test="${kmPindagateMainTempForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="submitForm('update',30);">
	</c:if>
	<c:if test="${kmPindagateMainTempForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="submitForm('save',30);">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="submitForm('saveadd',30);">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="km-pindagate" key="table.kmPindagateMainTemp" /></p>
<center>
<table id="TABLE_DocList" class="tb_normal" width=95%>
    <%-- <c:set var="selectEmpty" value="true" />--%>
	<input type="hidden" id="questions">
	<input type="hidden" name="questionTypes">
	<tr>
		<td colspan="6">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateMainTemp.docSubject" /></td>
					<td colspan="3"><html:text property="docSubject" style="width:50%;"/><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdCatoryName" /></td>
					<td colspan="3"><html:hidden property="fdCategoryId" /> <html:text
						property="fdCategoryName" readonly="true" styleClass="inputsgl"
						style="width:50%;" /> <span class="txtstrong">*</span>&nbsp;&nbsp;&nbsp;<a
						href="#"
						onclick="Dialog_Category('com.landray.kmss.km.pindagate.model.KmPindagateMainTemp','fdCategoryId','fdCategoryName');"><bean:message
						key="dialog.selectOther" /></a>
						<c:if test="${not empty noAccessCategory}">
							<script language="JavaScript">
								function closeWindows(rtnVal){
									if(rtnVal==null){
										window.close();
									}
								}
								if(!confirm("<bean:message arg0="${noAccessCategory}" key="error.noAccessCreateTemplate.alert" />")){
									window.close();
								}else{
									Dialog_Category('com.landray.kmss.km.pindagate.model.KmPindagateMainTemp','fdCategoryId','fdCategoryName',null,null,null,null,closeWindows, true);
								}
							</script>
						</c:if>		</td>
					
				</tr>
				<tr>
				<!-- 排序号 -->
					<td class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.fdOrder" /></td>
					<td colspan="3"><html:text property="fdOrder" style="width:50%;" /></td>
				</tr>
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                    <c:param name="id" value="${kmPindagateMainTempForm.authAreaId}"/>
                </c:import> 
				<tr>
					<!-- 创建人 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.docCreatorId" /></td>
					
					<td width=35%>
						<html:hidden property="docCreatorId" />
						<html:text property="docCreatorName" readonly="true" style="width:50%;" /></td>
					<!-- 创建时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.docCreateTime" /></td>
					<td width=35%><html:text property="docCreateTime"
						readonly="true" style="width:50%;" /></td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="button" class="btnopt" value="<bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.button.previewPage"/>" onclick="preview();">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td KMSS_IsRowIndex="1" width="5%" class="td_normal_title"></td>
		<td class="tr_normal_title" width="5%"><bean:message
			key="page.serial" /></td>
		<td align="center" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.question"/></td>
		<td width="20%" align="center" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.fdType"/></td>
		<td width="10%" align="center" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.fdOrder"/></td>
		<td width="10%" align="center" class="td_normal_title"><bean:message
						bundle="km-pindagate" key="kmPindagateQuestion.operation"/></td>
	</tr>
	<!--基准行-->
	<tr KMSS_IsReferRow="1" style="display: none" class="questionTR">
		<td><input type="hidden" name="fdItems[!{index}].fdId"> <input
			type="hidden" name="fdItems[!{index}].version"> <input
			type="hidden" name="fdItems[!{index}].fdOrder"> <input
			type="hidden" name="fdItems[!{index}].fdSplit"> <input
			type="hidden" name="fdItems[!{index}].fdQuestionDef"> <input
			type="hidden" name="fdItems[!{index}].fdStatistic"> <input
			type="checkbox" name="fdItems[!{index}].checkbox"></td>
		<td KMSS_IsRowIndex="1"></td>
		<td><input
			style="width: 90%; border: 0px; background: transparent;"
			readonly="readonly" name="fdItems[!{index}].fdTitle"></td>
		<td><input
			style="width: 90%; border: 0px; background: transparent;"
			readonly="true" name="fdItems[!{index}].fdType"></td>
		<td>
		<center><img src="${KMSS_Parameter_StylePath}icons/up.gif"
			alt="${lfn:message('button.moveup')}" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
		<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="${lfn:message('button.movedown')}"
			onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
			src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="${lfn:message('doclist.delete')}"
			onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
		</td>
		<td align="center"><a href="#"
			onclick="openWin('<c:url value="/km/pindagate/question_type/singleselect/singleselect_edit.jsp" />',document.getElementsByName('fdItems[!{index}].fdQuestionDef')[0])">编辑</a>
		</td>
	</tr>
	<!--内容行-->
	<%
		int index = 1;
	%>
	<c:forEach items="${kmPindagateMainTempForm.fdItems}"
		var="kmPindagateTitleForm" varStatus="vstatus">
		<c:choose>
			<c:when test="${kmPindagateTitleForm.fdSplit}">
				<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;" class="questionTR">
					<td><input type="hidden"
						name="fdItems[${vstatus.index}].kmPindagateMainTempId"
						value="${kmPindagateMainTempForm.fdId}"> <input type="hidden"
						name="fdItems[${vstatus.index}].fdId"
						value="${kmPindagateTitleForm.fdId}"> <input type="hidden"
						name="fdItems[${vstatus.index}].fdSplit" value="true"> <input
						type="hidden" name="fdItems[${vstatus.index}].version"
						value="${kmPindagateTitleForm.version}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdType"
						value="${kmPindagateTitleForm.fdType}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdOrder"
						value="${kmPindagateTitleForm.fdOrder}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef"
						value="${kmPindagateTitleForm.fdQuestionDefView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdStatistic"
						value="${kmPindagateTitleForm.fdStatisticView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}"> <input
						type="checkbox" name="fdItems[${vstatus.index}].checkbox">
					</td>
					<td KMSS_IsRowIndex="1"></td>
					<td><span id="fdItems[${vstatus.index}].fdNameShow">${kmPindagateTitleForm.fdName}</span></td>
					<td>${kmPindagateTitleForm.fdName}</td>
					<td>
					<center><img src="${KMSS_Parameter_StylePath}icons/up.gif"
						alt="${lfn:message('button.moveup')}" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
					<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="${lfn:message('button.movedown')}"
						onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
						src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="${lfn:message('doclist.delete')}"
						onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
					</td>
					<td></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr KMSS_IsContentRow="1" class="questionTR">
					<td><input type="hidden"
						name="fdItems[${vstatus.index}].kmPindagateMainTempId"
						value="${kmPindagateMainTempForm.fdId}"> <input type="hidden"
						name="fdItems[${vstatus.index}].fdId"
						value="${kmPindagateTitleForm.fdId}"> <input type="hidden"
						name="fdItems[${vstatus.index}].fdSplit"
						value="${kmPindagateTitleForm.fdSplit}"> <input
						type="hidden" name="fdItems[${vstatus.index}].version"
						value="${kmPindagateTitleForm.version}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdType"
						value="${kmPindagateTitleForm.fdType}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdOrder"
						value="${kmPindagateTitleForm.fdOrder}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef"
						value="${kmPindagateTitleForm.fdQuestionDefView}"> <input
						type="hidden" name="fdItems[${vstatus.index}].fdStatistic"
						value="${kmPindagateTitleForm.fdStatisticView}"> <input
						type="checkbox" name="fdItems[${vstatus.index}].checkbox">
					</td>
					<td KMSS_IsRowIndex="1"><%=index%></td>
					<td><span id="fdItems[${vstatus.index}].fdNameShow"><c:out value="${kmPindagateTitleForm.fdName}" /></span>
						<input type="hidden" name="fdItems[${vstatus.index}].fdName"
							value="${kmPindagateTitleForm.fdName}"></td>
					<td>${kmPindagateTitleForm.fdTypeName}</td>
					<td>
					<center><img src="${KMSS_Parameter_StylePath}icons/up.gif"
						alt="${lfn:message('button.moveup')}" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
					<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="${lfn:message('button.movedown')}"
						onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
						src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="${lfn:message('doclist.delete')}"
						onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
					</td>
					<td>
					<center><input type="button"
						id="fdItems[${vstatus.index}].fdQuestionDef" class="btnopt"
						value="<bean:message  key="button.edit"/>" onclick="edit('${kmPindagateTitleForm.fdType}',this);">
					</center>
					</td>
				</tr>
				<%
					index++;
				%>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<tr>
		<td colspan="2">
			<strong><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addQuestion"/>:</strong>
		</td>
		<td colspan="4">
			<table border="0" id="Add_question_TB"></table>
		</td>
	</tr>
	<tr>
			<td colspan="2"><b><bean:message
				key="kmPindagateQuestion.description" bundle="km-pindagate" /></b>
			</td>
			<td colspan="4"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder1"/>
				<bean:message bundle="km-pindagate" key="kmPindagateQuestion.click"/>
				<img src="${KMSS_Parameter_StylePath}icons/up.gif">
				<bean:message bundle="km-pindagate" key="kmPindagateQuestion.or"/>
				<img src="${KMSS_Parameter_StylePath}icons/down.gif">
				<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder"/>
				<br>
				<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder2"/>
			</td>
	</tr>
		<!-- 固定模板题目 -->
				<tr>
					<td colspan="2">
						<bean:message bundle="km-pindagate" key="kmPindagateMainTemp.fdSelectAll" />
					</td>
					<td width=85% colspan="4">
						<div style="position:absolute;">
							<ui:switch property="fdSelectAll" showText="false" checked="${kmPindagateMainTempForm.fdSelectAll}"></ui:switch>
						</div>
						<div style="float:left;margin-left: 50px;"><bean:message bundle="km-pindagate" key="kmPindagateMainTemp.fdSelectAll.tip" /></div>
					</td>
				</tr>
		<!-- 可使用者 -->
				<tr>
					<td class="td_normal_title" colspan="2"><bean:message
						bundle="km-pindagate" key="table.kmPindagateTemplateUser" /></td>
					<td  width=85% colspan="4">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmPindagateTemplate.tepmlateUser" bundle="km-pindagate"/>
				   </td>
				</tr>
				<!-- 可维护者 -->
				<tr>
					<td class="td_normal_title" colspan="2"><bean:message
						bundle="km-pindagate" key="table.kmPindagateTemplateEditor" /></td>
					<td width=85% colspan="4">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmPindagateTemplate.tepmlateManager" bundle="km-pindagate"/>
					</td>
				</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>