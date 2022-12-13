<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,java.util.*"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page import="com.landray.kmss.web.Globals" %>
<script type="text/javascript"> 
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("doclist.js|docutil.js|optbar.js|jquery.js|json2.js|jquery.form.js");
</script>
<script type="text/javascript">
	var jt=0;
	//选择模板题目
	function btCategory(){
		Dialog_TreeList(false,'fdQuestionTempId','fdQuestionTempName',';',
										 'kmPindagateMainTempTitleTreeService&parentId=!{value}', 
										 '<bean:message bundle="km-pindagate" key="dialog.tree.title"/>', 'kmPindagateMainTempNameTreeService&fdCategoryId=!{value}', null, 'kmPindagateMainTempNameSearchService&keyword=!{keyword}', null,false, false,"问卷模板");
		if($("input[name='fdQuestionTempId']").val() == ""){
			return false;
		}
		//加载模板题目
		changeQuestion();
		//选择完成后将模板ID设为空
		$("input[name='fdQuestionTempId']").val("");
	}
</script>
<center>
<table id="TABLE_DocList" class="tb_normal" width=100%>
	<xform:text property="docCategoryName" showStatus="noShow" value="${docCategoryName }"/>
	<input type="hidden" name="docCategoryId"  value="${docCategoryId }">
	<input type="hidden" id="questions">
	<input type="hidden" name="questionTypes">
	<tr>
		<td colspan="6"><em><bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectTmpTip"/></em><br>
		<em><bean:message bundle="km-pindagate" key="kmPindagateQuestion.copyTmpTip"/></em><br>
		<input type="hidden" name="fdQuestionTempId"> <input
			type="hidden" name="fdQuestionTempName">
		<input type="button"
			class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.selectQuestionTmp"/>"
			onclick="btCategory();">	
		<input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.previewPage"/>" onclick="previewIndatate();">

		<input type="button" class="btnopt" title="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.saveTmpTip"/>" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.copyQuestionTmp"/>"
			onclick='if(checkSaveAsTemplate()){$("form").submit();}'></td>
	</tr>
	<tr>
		<td KMSS_IsRowIndex="1" width="3%" class="td_normal_title"></td>
		<td class="tr_normal_title" width="3%"><bean:message
			key="page.serial" /></td>
		<td align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.question"/></td>
		<td width="20%" align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.fdType"/></td>
		<td width="10%" align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.fdOrder"/></td>
		<td width="10%" align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.operation"/></td>
	</tr>
	<!--基准行-->
	<tr KMSS_IsReferRow="1" style="display: none">
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
			alt="up" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
		<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down"
			onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
			src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del"
			onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
		</td>
		<td align="center"><a href="#"
			onclick="alert('fdItems[!{index}].fdQuestionDef');openWin('<c:url value="/km/pindagate/question_type/singleselect/singleselect_edit.jsp" />',document.getElementsByName('fdItems[!{index}].fdQuestionDef')[0],'edit')"><bean:message key="button.edit"/></a>
		</td>
	</tr>
	<!--内容行-->
	<%
		int index = 1;
	%>
	<c:forEach items="${kmPindagateMainForm.fdItems}"
		var="kmPindagateTitleForm" varStatus="vstatus">
		<c:choose>
			<c:when test="${kmPindagateTitleForm.fdSplit}">
				<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;">
					<td><input type="hidden"
						name="fdItems[${vstatus.index}].kmPindagateMainId"
						value="${kmPindagateMainForm.fdId}"> <input type="hidden"
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
					<td>${kmPindagateTitleForm.fdName}</td>
					<td>${kmPindagateTitleForm.fdName}</td>
					<td>
					<center><img src="${KMSS_Parameter_StylePath}icons/up.gif"
						alt="up" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
					<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down"
						onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
						src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del"
						onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
					</td>
					<td></td>
				</tr>
			</c:when>
			<c:otherwise>
				<tr KMSS_IsContentRow="1">
					<td><input type="hidden"
						name="fdItems[${vstatus.index}].kmPindagateMainId"
						value="${kmPindagateMainForm.fdId}"> <input type="hidden"
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
					<td><input
						style="width: 90%; border: 0px; background: transparent;"
						readonly="readonly" name="fdItems[${vstatus.index}].fdName"
						value="${kmPindagateTitleForm.fdName}"></td>
					<td>${kmPindagateTitleForm.fdTypeName}</td>
					<td>
					<center><img src="${KMSS_Parameter_StylePath}icons/up.gif"
						alt="up" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
					<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down"
						onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; <img
						src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del"
						onclick="deleteRow();" style="cursor: hand">&nbsp;&nbsp;</center>
					</td>
					<td>
					<center><input type="button"
						id="fdItems[${vstatus.index}].fdQuestionDef" class="btnopt"
						value="<bean:message key="button.edit"/>" onclick="edit('${kmPindagateTitleForm.fdType}',this);">
					</center>
					</td>
				</tr>
				<%
					index++;
				%>
				<script>
					jt++;
				</script>
			</c:otherwise>
		</c:choose>
	</c:forEach><%--
	<tr>
		<td colspan="5"><select name="questionTypeselect" id="select">
			<option>---<bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionTypeSelect"/>---</option>
		</select> <input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertQuestion"/>"
			onclick="addQuestion('insert');"> <input type="button"
			class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addPageBreak"/>"
			onclick="addQuestion('insert','pagination');"> <input
			type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addQuestion"/>"
			onclick="changeQueslistDiv();"></td>
	</tr>--%>
	
	<tr>
		<td colspan="2">
			<strong><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addQuestion"/>:</strong>
		</td>
		<td colspan="4">
			<table border="0" id="Add_question_TB"></table>
		</td>
	</tr>
	<%--
	<tr>
		<td colspan="2">
			<strong><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertQuestion"/>:</strong>
		</td>
		<td colspan="4"><select name="questionTypeselect" id="select">
			<option>---<bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionTypeSelect"/>---</option>
		</select> 
			<input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertQuestion"/>"
			onclick="addQuestion('insert');">
			<input type="button"
			class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addPageBreak"/>"
			onclick="addQuestion('insert','pagination');"> <input
			type="button" class="btnopt" value="新增题目"
			onclick="changeQueslistDiv();"></td>
	</tr>--%>
</table>
<table border="0" width="90%">
	<tr>
	<td align="right">
	<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.description"/></b>
	</td>
	<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder1"/>
	<bean:message bundle="km-pindagate" key="kmPindagateQuestion.click"/>
	<img src="${KMSS_Parameter_StylePath}icons/up.gif">
	<bean:message bundle="km-pindagate" key="kmPindagateQuestion.or"/>
	<img src="${KMSS_Parameter_StylePath}icons/down.gif">
	<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder"/>
	</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder2"/></td>
	</tr>
</table><%--
<div id="queslist_div" style="display: none; position: absolute;">
<table class="tb_normal" width=220>
	<tr>
		<td height="1" colspan="1" align="center" bgcolor="#AECFF7"></td>
	</tr>
	<tr>
		<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectQuestionType"/></td>
	</tr>
	<tr>
		<td height="1" colspan="0" align="center" bgcolor="#AECFF7"></td>
	</tr>
	<tr>
		<td>
		<table border="0" id="Add_question_TB"></table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="2" align="center" bgcolor="#AECFF7"></td>
	</tr>
</table>
</div>--%>
</center>

<script type="text/javascript">
var tbInfo = null;
$(document).ready(function loadQuestionType(){
	/**
	 * 采用jquery.form的方式异步提交表单
	 */
	var options={
			url:  "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=saveAsTemplate",
			type: "post",		
			success:    saveAsTemplateSuccess
	};
	   $('form[name="kmPindagateMainForm"]').submit(function() { 
	        $(this).ajaxSubmit(options); 
	        return false; 
	    }); 
		
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
			var editUrl = obj['editUrl']+"?kmPindagateMainFdId=${kmPindagateMainForm.fdId}";
			var previewUrl = obj['previewUrl'];
			var jsUrl = obj['jsUrl'];
			questionTypes[i] = {'quesTypeId':quesTypeId,
								'quesTypeName':quesTypeName,
								'editUrl':editUrl,
								'previewUrl':previewUrl,
								'jsUrl':jsUrl};
			//$('select[name="questionTypeselect"]').append('<option value="'+quesTypeId+'">'+quesTypeName+'</option>');			
			//var oOption = document.createElement("OPTION");
			//oOption.text=quesTypeName;
			//oOption.value=quesTypeId;						
			//document.getElementById("select").add(oOption);
			if(i == 0)
				str += "<tr>";
			str +='<td><input type="button" class="btnopt" value="'+quesTypeName+'" onclick="addQuestion(\'insert\',\''+quesTypeId+'\',\''+quesTypeName+'\',\''+editUrl+'\');"></td>';
			if((i+1)%
			<%
			//为了正常显示英文状态下的题目类型按钮，特根据方言来判断分行
			//张乐志 alter 2013年1月15日
			//默认显示10个再换行，中文状态下也为10个换行，英文及其他语言状态下为5个换行
			Object obj=session.getAttribute(Globals.LOCALE_KEY);
			if(obj!=null)
			{
				Locale locale=(Locale)obj;
				if(locale.getLanguage().indexOf("en")>-1)
				{
					out.print("5");
				}
				else if(locale.getLanguage().indexOf("zh")>-1)
				{
					out.print("10");
				}
				else
				{
					out.print("5");
				}
			}
			else
			{
				out.print("10");
			}
			%>
			==0)
				str += "</tr>"+"<tr>";
		}
		str += '<td><input type="button" class="btnopt" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" onclick="addQuestion(\'insert\',\'pagination\');"></td>';
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
		var confirmMsg = '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.thisLocation"/>';
		for(var i=0;i<tbInfo.lastIndex-1;i++){
			obj = document.getElementsByName("fdItems["+i+"].checkbox")[0];
			if(obj && obj.checked){
				insertIndex = i+2;
				confirmMsg = '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.beforeSelect"/>';
				break;
			}
		}
		if(questionType == "pagination"){
			//判断是否是选择位置插入
			if(obj && obj.checked){
				if(confirm('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.sureTo"/>'+confirmMsg+'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.insertPageBreak"/>')){
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
				//alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectQuesType"/>');
				//return;
			//}
			url = getEditUrl(questionType);
			//判断是否是选择位置插入
			if(obj && obj.checked){
				if(confirm('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.sureTo"/>'+confirmMsg+'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.insertQuestion"/>'))	{
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
	//var selectObj = document.getElementsByName("questionTypeselect")[0];
	//var quesTypeText = "";
	//for(var i=0;i<selectObj.options.length;i++){
		//if(selectObj.options[i].value == quesTypeVal){
			//quesTypeVal = selectObj.options[i].value;
			//quesTypeText = selectObj.options[i].text;
			quesTypeVal = quesTypeVal;
			quesTypeText = quesTypeName;
		//}
	//}
	var obj = new Object();
	var rtnValue = openWin(url,obj);
	if(rtnValue != null && rtnValue != ""){
		var openUrl = "'"+url+"'";
		var obj = "document.getElementsByName(this.id)[0]";
		var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder"><input type="hidden" name="fdItems[!{index}].fdSplit"><input type="hidden" name="fdItems[!{index}].fdQuestionDef">',
	            '',
	            '<input style="width:90%;border:0px;background: transparent;" readonly="readonly" name="fdItems[!{index}].fdName" >',
	            ''+quesTypeText+'<input type="hidden" name="fdItems[!{index}].fdType" value="'+quesTypeVal+'">',
	            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
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
	}
}
/**
 * 插入分页标记
 *		insertIndex 插入位置   为空时在最后一行插入
 */
function insertPagination(insertIndex){
	var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder">',
			            '',
			            '<input style="width:90%;border:0px;background: transparent;" readonly="readonly" name="fdItems[!{index}].fdName" value=\'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/>\' >',
			            '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<bean:message bundle="km-pindagate" key=""/><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
			            '');
	addRow("TABLE_DocList", content,"pagination",insertIndex,"1");
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
function addRow(optTB, content,questionType,insertIndex,flg){
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
	if(flg==1){
		jt++;
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
	jt--;
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
		var fields = tbInfo.DOMElement.rows[i].getElementsByTagName("INPUT");
		for(var j=0; j<fields.length; j++){
			var fieldName = fields[j].name.replace(/\d+/g, i-2);
			var fieldId = fields[j].id.replace(/\d+/g, i-2);
			if(Com_Parameter.IE){
				fields[j].outerHTML = fields[j].outerHTML.replace("name=" + fields[j].name, "name="+fieldName);
				fields[j].outerHTML = fields[j].outerHTML.replace("id=" + fields[j].id, "id="+fieldId);
			}
			else{
				fields[j].name = fieldName;
				fields[j].id = fieldId;
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
function openWin(url,obj,type){
	url = '<c:url value = "/'+url+'" />';
	if(obj == null)
	 window.showModalDialog(url, "","dialogWidth=600px;dialogHeight=500px");
	else
		window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px");
	if(type == "edit" && obj.value != null && obj.value != ""){
		var selecttype = eval("("+(obj.value)+")");
		var subject = selecttype.subject.replace(/&nbsp;/g," ");
		document.getElementsByName(obj.name.replace("fdQuestionDef","fdName"))[0].value = $("<div></div>").append(subject).text();
	}
	return obj.value;
}
 
/**
* 预览
*/
function previewIndatate(){
	var questions = new Array();
	var question = null;
	var questionTypes = $('input[name="questionTypes"]').val();
	var lastIndex = $('#TABLE_DocList tr').length - 4;
	for(var index = 0; index<lastIndex; index++){
		question = {'fdQuestionDef':$('input[name="fdItems['+index+'].fdQuestionDef"]').val(),
				'fdType':$('input[name="fdItems['+index+'].fdType"]').val(),
				'fdSplit':$('input[name="fdItems['+index+'].fdSplit"]').val(),
				'fdOrder':$('input[name="fdItems['+index+'].fdOrder"]').val(),
				'fdTitle':$('input[name="fdItems['+index+'].fdName"]').val(),
				'questionTypes':questionTypes};
		questions[index] = question;
	}
	var url = '<c:url value = "/km/pindagate/km_pindagate_question/kmPindagateQuestion_preview.jsp?param=edit" />';
	var obj = $('#questions');
	var obj = document.getElementById("questions");
	obj.value = JSON.stringify(questions);
	window.showModalDialog(url , obj,"dialogWidth=1024px;dialogHeight=768px");
	if(obj.value != ''){
		questions = eval("("+(obj.value)+")");
		afterPreview(questions);
	}
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
function edit(questionType,_this){
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
//保存题目模板前的相关校验
function checkSaveAsTemplate(){
	if($("input[name='docSubject']").val()==""||$("input[name='docSubject']").val()==null){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject"/><bean:message bundle="km-pindagate" key="kmPindagateResponse.notNull"/>');
		return false;
	}
	//选择模板存放位置
	Dialog_Tree(false,'docCategoryId','docCategoryName',';','kmPindagateMainTempTitleTreeService&parentId=!{value}','<bean:message bundle="km-pindagate" key="kmPindagateMain.category"/>',false,null,null,false,false,'<bean:message bundle="km-pindagate" key="kmPindagateMain.category"/>');

	if(document.getElementsByName("docCategoryId")[0].value == ""){
		return false;
	}
	return true;
}
/**
* 保存为题目模板成功后的操作
*/


function saveAsTemplateSuccess(){
	$("input[name='docCategoryId']").val("");
	alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.saveSuccess"/>');
}
/**
* 选择题目模板后通过ajax调用后台Service取的对应模板题目数据
*/
function changeQuestion(){
	var fdQuestionTempId=$("input[name='fdQuestionTempId']").val();
	//打开要选择的题目列表窗口
	var url='<c:url value="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=selectQuestionList&fdId="/>'+fdQuestionTempId;
	var rtnVal=window.showModalDialog(url,'','dialogWidth:500px; dialogHeight:600px; status:0;scroll:1; help:0');
	var data = new KMSSData();
	var urls="kmPindagateMainTempQuestionService&questionIds="+rtnVal+"&fdQuestionTempId="+fdQuestionTempId;
	data.SendToBean(urls,resetQuestion);
	
}
/**
* 选择题目模板后生成题目
*/
function resetQuestion(rtnData){
	if(rtnData.GetHashMapArray().length==0)return;
	if(rtnData){
		//清除原来的题目行	
		if(tbInfo == null)
			tbInfo = DocList_TableInfo['TABLE_DocList'];
		//var optTB=document.getElementById('TABLE_DocList');
		//var lastIndex=tbInfo.lastIndex;
		//for(var i=2;i<lastIndex;i++){	
		  // optTB.deleteRow(2);
		  // tbInfo.lastIndex--;
		//}
		//refreshIndex(tbInfo);
		//加载模板题目
		
		for(var i=0; i<rtnData.GetHashMapArray().length; i++){
			var obj = rtnData.GetHashMapArray()[i];
			var editObj = "document.getElementsByName(this.id)[0]";
			var openUrl="'"+getEditUrl(obj["fdType"])+"'";
			//判断是否为分页标记
			var content = null;
			if(obj["fdSplit"]=="false")
			  	content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox">'
					  	+'<input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}">'
					  	+'<input type="hidden" value="'+parseInt(obj["fdOrder"])+'" name="fdItems[!{index}].fdOrder">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdSplit" value="'+obj["fdSplit"]+'">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdQuestionDef" value="">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdFromTmp" value="true">',
		            '',
		            '<input style="width:90%;border:0px;background: transparent;" readonly="readonly" name="fdItems[!{index}].fdName" value="'
		            	+obj["fdName"]+'" >',
		            ''+obj["fdTypeName"]+'<input type="hidden" name="fdItems[!{index}].fdType" value="'+obj["fdType"]+'">',
		            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;'
		            	+'<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;'
		            	+'<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
		            '<input type="button" id="fdItems[!{index}].fdQuestionDef" class="btnopt" value=\'<bean:message key="button.edit"/>\' onclick="openWin('+openUrl+','+ editObj +',\'edit\');">');
			else//分页符
				content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" value="'+parseInt(obj["fdOrder"])+'" name="fdItems[!{index}].fdOrder">',
			            '',
			            '<input style="width:90%;border:0px;background: transparent;" readonly="readonly" name="fdItems[!{index}].fdName" value=\'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/>\' >',
			            '<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
			            '');
            //在addRow中已经对tbInfo的lastIndex进行了更新，这里不需要再做
			addRow("TABLE_DocList", content,obj["fdSplit"]=="false"?null:"pagination",null,"2");
			$('input[name="fdItems['+(i+jt)+'].fdQuestionDef"]').val(obj["fdQuestionDef"]);		
		}
		refreshIndex(tbInfo);
		jt = jt + rtnData.GetHashMapArray().length;
	}
	
}
</script>