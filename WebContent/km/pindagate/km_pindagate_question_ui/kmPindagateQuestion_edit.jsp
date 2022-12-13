<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,java.util.*"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page import="com.landray.kmss.web.Globals" %>
<style>
.btn{
	background:url(../images/plusIcon.png) no-repeat -3px 0px;
   	cursor:pointer;
   	padding: 0px 10px;
   	border:0px;
   	font-size:12px;
   	color: inherit;
 }
 .questionTitle{
 	transform: scale(1,1);
 	max-width: 1200px;
}
 .questionTitle img{
 	max-width: 500px;
 }
</style>
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
<script>var jt=0;</script>
<xform:text property="docCategoryName" showStatus="noShow" value="${docCategoryName }"/>
<input type="hidden" name="docCategoryId"  value="${docCategoryId }" />
<input type="hidden" name="questionTypes" />
<input type="hidden" name="method_GET" />

<table id="TABLE_DocList" class="tb_normal" width=100%>
	<tr>
		<td colspan="7">
			<input type="hidden" name="fdQuestionTempId" /> 
			<input type="hidden" name="fdQuestionTempName" />
			<div style="display: none;">
				<input type="text" id="questionsValidate"  name="questionsValidate" validate="questionNotNull" />
			</div>
				<%--选择题目模板--%>
				<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.button.selectQuestionTmp') }" title="${lfn:message('km-pindagate:kmPindagateQuestion.selectTmpTip') }"
					 onclick="btCategory();">
				</ui:button>
				<%--预览问卷--%>
				<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.button.previewPage') }"  onclick="previewIndatate();">
				</ui:button>
				<%--生成题目模板--%>
				<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.button.copyQuestionTmp') }" title="${lfn:message('km-pindagate:kmPindagateQuestion.copyTmpTip') }"
					 onclick="checkSaveAsTemplate();">
				</ui:button>
		</td>
	</tr>
	<tr>
		<td KMSS_IsRowIndex="1" width="5%" class="td_normal_title"></td>
		<%--序号--%>
		<td class="td_normal_title" width="5%">
			<bean:message key="page.serial" />
		</td>
		<%--题目--%>
		<td align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.question"/>
		</td>
		<%--题型--%>
		<td width="20%" align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.fdType"/>
		</td>
		<%--关联--%>
		<td width="20%" align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.correlation"/>
		</td>
		<%--排序--%>
		<td width="15%" align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.fdOrder"/>
		</td>
		<%--操作--%>
		<td width="10%" align="center" class="td_normal_title">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.operation"/>
		</td>
	</tr>
	<%--基准行--%>
	<tr KMSS_IsReferRow="1" style="display: none" class="questionTR">
		<td>
			<input type="hidden" name="fdItems[!{index}].kmPindagateMainId">
			<input type="hidden" name="fdItems[!{index}].fdId">
			<input type="hidden" name="fdItems[!{index}].version">
			<input type="hidden" class="fdOrder" name="fdItems[!{index}].fdOrder">
			<input type="hidden" name="fdItems[!{index}].fdSplit">
			<input type="hidden" name="fdItems[!{index}].fdQuestionDef">
			<input type="hidden" name="fdItems[!{index}].fdRelationDef">
			<input type="hidden" name="fdItems[!{index}].fdRelationSign">
			<input type="hidden" name="fdItems[!{index}].fdStatistic">
			<input type="checkbox" name="fdItems[!{index}].checkbox">
		</td>
		<td KMSS_IsRowIndex="1"></td>
		<td>
		    <div id="fdItems[!{index}].fdNameShow" class="questionTitle"></div>
			<input  type="hidden" name="fdItems[!{index}].fdName">
		</td>
		<td style="text-align: center;">
            <center id="fdItems[!{index}].fdTypeText"></center>
			<input  type="hidden" name="fdItems[!{index}].fdType">
		</td>
		<td>
			<center>
				<span class="relationFont" onclick="relation('${kmPindagateTitleForm.fdType}','${kmPindagateTitleForm.fdTypeName}',this,'${vstatus.index}','!{index}');">题目关联</span>
				<%-- <span onclick="itemRelation('${kmPindagateTitleForm.fdType}','${vstatus.index}','!{index}');">选项关联</span> --%>
			</center>
			
		</td>
		<td>
			<center>
				<img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor: pointer;">&nbsp;&nbsp;
				<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor: pointer;">&nbsp;&nbsp;
				<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor: pointer;">
			</center>
		</td>
		<td>
		<center>
			<img id="fdItems[!{index}].fdQuestionDef" src="${KMSS_Parameter_StylePath}icons/edit.gif" alt="edit" onclick="openWindow('!{index}');" style="cursor: pointer;">&nbsp;&nbsp;
			<img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png" alt="copy" onclick="DocList_CopyRow();copyQuestion('!{index}');" style="cursor: pointer;">
		</center>
		</td>
	</tr>
	<%--内容行--%>
	<% int index = 1;%>
	<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateTitleForm" varStatus="vstatus">
	<c:choose>
		<c:when test="${kmPindagateTitleForm.fdSplit}">
			<tr KMSS_IsContentRow="1" style="background-color: #D5EADF;" class="questionTR">
				<td>
					<input type="hidden" name="fdItems[${vstatus.index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"> 
					<input type="hidden" class="fdId" name="fdItems[${vstatus.index}].fdId" value="${kmPindagateTitleForm.fdId}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdSplit" value="true">
					<input type="hidden" name="fdItems[${vstatus.index}].version" value="${kmPindagateTitleForm.version}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdType" value="${kmPindagateTitleForm.fdType}">
					<input type="hidden" class="fdOrder" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateTitleForm.fdOrder}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef" value="${kmPindagateTitleForm.fdQuestionDefView}">
					<input type="hidden" class="fdRelationDef" name="fdItems[${vstatus.index}].fdRelationDef" value="${kmPindagateTitleForm.fdRelationDefView}">
					<input type="hidden" class="fdOptRelDef" name="fdItems[${vstatus.index}].fdOptRelDef" value=""> 
					<input type="hidden" name="fdItems[${vstatus.index}].fdRelationSign" value="${kmPindagateTitleForm.fdRelationSign}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdStatistic" value="${kmPindagateTitleForm.fdStatisticView}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdName" value="${kmPindagateTitleForm.fdName}">
					<input type="checkbox" name="fdItems[${vstatus.index}].checkbox">
				</td>
				 <td KMSS_IsRowIndex="1"></td>
				<td><div id="fdItems[${vstatus.index}].fdNameShow" class="questionTitle">${kmPindagateTitleForm.fdName}</div></td>
				<td  style="text-align: center;"><c:out value="${kmPindagateTitleForm.fdName}"></c:out></td>
				<td>
						<!-- 分布标记不需要题目关联 -->
				</td> 			
				<td>
					<center>
						<img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor: pointer;">&nbsp;&nbsp;
						<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor: pointer;">&nbsp;&nbsp;
						<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del"onclick="deleteRow();" style="cursor: pointer;">
					</center>
				</td>
				<td></td>
			</tr>
		</c:when>
		<c:otherwise>
			<tr KMSS_IsContentRow="1" class="questionTR">
				<td>
					<input type="hidden" name="fdItems[${vstatus.index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}">
					<input type="hidden" class="fdId" name="fdItems[${vstatus.index}].fdId" value="${kmPindagateTitleForm.fdId}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdSplit" value="${kmPindagateTitleForm.fdSplit}">
					<input type="hidden" name="fdItems[${vstatus.index}].version" value="${kmPindagateTitleForm.version}"> 
					<input type="hidden" name="fdItems[${vstatus.index}].fdType" value="${kmPindagateTitleForm.fdType}"> 
					<input type="hidden" class="fdOrder" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateTitleForm.fdOrder}"> 
					<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionDef" value="${kmPindagateTitleForm.fdQuestionDefView}">
					<input type="hidden" class="fdRelationDef" name="fdItems[${vstatus.index}].fdRelationDef" value="${kmPindagateTitleForm.fdRelationDefView}"> 
					<input type="hidden" class="fdOptRelDef" name="fdItems[${vstatus.index}].fdOptRelDef" value=""> 
					<input type="hidden" name="fdItems[${vstatus.index}].fdRelationSign" value="${kmPindagateTitleForm.fdRelationSign}">
					<input type="hidden" name="fdItems[${vstatus.index}].fdStatistic" value="${kmPindagateTitleForm.fdStatisticView}"> 
					<input type="checkbox" name="fdItems[${vstatus.index}].checkbox">
				</td>
				<td KMSS_IsRowIndex="1"><%=index%></td>
				<td>
					<div id="fdItems[${vstatus.index}].fdNameShow" class="questionTitle"> 
						 ${kmPindagateTitleForm.fdName}
					</div>
					<input type="hidden"  name="fdItems[${vstatus.index}].fdName" value="<c:out value="${kmPindagateTitleForm.fdName}"/>" />
				</td>
<%-- 				<td id= style="text-align: center;"><c:out value="${kmPindagateTitleForm.fdTypeName}"></c:out></td> --%>
				<td style="text-align: center;">
                    <center id="fdItems[${vstatus.index}].fdTypeText"><c:out value="${kmPindagateTitleForm.fdTypeName}"></c:out></center>
		         </td>
		         <td>
					<center>
						<center>
							<span class="relationFont" onclick="relation('${kmPindagateTitleForm.fdType}','${kmPindagateTitleForm.fdTypeName}',this,'${vstatus.index}','!{index}');">题目关联</span>
							<%-- <span onclick="itemRelation('${kmPindagateTitleForm.fdType}','${vstatus.index}','!{index}');">选项关联</span> --%>
						</center>
					</center>
				</td> 
				<td>
					<center>
						<img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor: hand">&nbsp;&nbsp;
						<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor: hand">&nbsp;&nbsp; 
						<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor: hand">
					</center>
				</td>
				<td>
	 			  <center> 
						<img src="${KMSS_Parameter_StylePath}icons/edit.gif" id="fdItems[${vstatus.index}].fdQuestionDef" alt="edit" 
							onclick="edit('${kmPindagateTitleForm.fdType}','${kmPindagateTitleForm.fdTypeName}',this);" style="cursor: pointer;">&nbsp;&nbsp;
						<img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png"  alt="copy" 
							onclick="DocList_CopyRow();copyQuestion(${vstatus.index})" style="cursor: pointer;">
			      </center> 
				</td>
			</tr>
			<%index++;%>
		</c:otherwise>
	</c:choose>
	<script>jt++;</script>
	</c:forEach>
	<tr>
		<td colspan="2">
			<strong><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.addQuestion"/>:</strong>
		</td>
		<td colspan="5">
		    <div class="lui_toolbar_btn_def">
				<table border="0" id="Add_question_TB">
				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.description"/></b>
		</td>
		<td colspan="5">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder1"/>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.click"/>
			<img src="${KMSS_Parameter_StylePath}icons/up.gif">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.or"/>
			<img src="${KMSS_Parameter_StylePath}icons/down.gif">
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder"/>
			<br/>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder2"/>
			<br/>
			<bean:message bundle="km-pindagate" key="kmPindagateQuestion.adjustOrder3"/>
		</td>
	</tr>
</table>
<script type="text/javascript"> Com_IncludeFile("doclist.js|docutil.js|optbar.js|json2.js|jquery.js|jquery.form.js|security.js",null,"js");</script>
<script type="text/javascript">
Com_IncludeFile("jquery.js|json2.js");
seajs.use(['lui/jquery','lui/dialog'], function($,dialog){
	_dialog=dialog;
	$(document).ready(function () {
		var timer = setInterval(function() {
			/* var dialogR = $dialog;
			if (!dialogR) {
				return;
			} else {
				clearInterval(timer);
			} */
			var tbInfo = DocList_TableInfo['TABLE_DocList'];
			if (tbInfo) {
				clearInterval(timer);
			}else{
				return;
			}
			updateCoordinates("true");
			for(var q = 2; q<tbInfo.lastIndex; q++){
				var fields = $(tbInfo.DOMElement.rows[q]).find(".fdRelationDef");
				var font = $(tbInfo.DOMElement.rows[q]).find(".relationFont");
				for (var i = 0; i < fields.length; i++) {
					if (fields[i].value&&fields[i].value!="{}") {
						font[i].setAttribute("class","com_btn_link relationFont");
					}
				}
			}
		}, 100);
	}); 
});
var _dialog;
var tbInfo = null;
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
								'jsUrl':jsUrl,
								'relationUrl':"/km/pindagate/question_type_ui/relation/questionSubjectRelation.jsp"+
									"?kmPindagateMainFdId=${kmPindagateMainForm.fdId}",
								'OpRelationUrl':"/km/pindagate/question_type_ui/relation/questionOptionRelation.jsp"+
									"?kmPindagateMainFdId=${kmPindagateMainForm.fdId}"
								};
			if(i == 0){
				str += "<tr>";
				}
			str +='<td style="padding-right:5px;padding-bottom:5px;">'
				+'<div class="lui_toolbar_btn_l"><div class="lui_toolbar_btn_r"><div class="lui_toolbar_btn_c">'
				+'<input type="button" class="btn"  value="'+quesTypeName+'" title="'+quesTypeName+'" onclick="addQuestion(\'insert\',\''+quesTypeId+'\',\''+quesTypeName+'\',\''+editUrl+'\');">'
				+'</div></div></div></td>';
			if((i+1)%"${btncount}"==0){
				str += "</tr>"+"<tr>";
			  }
		}
		str += '<td style="padding-right:5px;padding-bottom:5px;">'
			+'<div class="lui_toolbar_btn_l"><div class="lui_toolbar_btn_r"><div class="lui_toolbar_btn_c">'
			+'<input type="button" class="btn" value="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" title="<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>" onclick="addQuestion(\'insert\',\'pagination\');">'
			+'</div></div></div></td>';
		str += "</tr>";
		$('#Add_question_TB').append(str);
	}
	var encoded = JSON.stringify(questionTypes); 
	$('input[name="questionTypes"]').val(encoded);
}

LUI.ready(function loadQuestionType(){
	 //采用jquery.form的方式异步提交表单
	var options={
			url:  "${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=saveAsTemplate",
			type: "post",		
			success: saveAsTemplateSuccess
	};
  $('form[name="kmPindagateMainForm"]').submit(function() { 
        $(this).ajaxSubmit(options); 
        return false; 
  }); 
  //初始化题目类型
  var data = new KMSSData();
  var url="kmPindagateQuestionTypeService";
  data.SendToBean(url,initQuesTypeVal);
});

function openWindow(index){
	optTR = DocListFunc_GetParentByTagName("TR");
	 count=$(optTR).find(".fdOrder").val();
	 if (count) {
		 index=count;
	}
	 var type=document.getElementsByName("fdItems["+index+"].fdType")[0].value;
	 var fdQuestionDef=document.getElementsByName("fdItems["+index+"].fdQuestionDef")[0];
	 var typeText = document.getElementById("fdItems["+index+"].fdTypeText").innerHTML;
	 var url="/km/pindagate/question_type_ui/"+type+"/"+type+"_edit.jsp?kmPindagateMainFdId=${kmPindagateMainForm.fdId}"
	 openWin(url,typeText,fdQuestionDef,'edit');
}

 function copyQuestion(i){
	 optTR = DocListFunc_GetParentByTagName("TR");
	 count=$(optTR).find(".fdOrder").val();
	 if (count) {
		i=count;
	}
	    var typeText = document.getElementById("fdItems["+i+"].fdTypeText").innerHTML;
	     var obj = null;
		var index = "";
		var	tbInfo = DocList_TableInfo['TABLE_DocList'];
		index = tbInfo.lastIndex-3;
		obj = document.getElementsByName("fdItems["+index+"].fdQuestionDef")[0];
	 	var selecttype = eval("("+(obj.value)+")");
		var subject = selecttype.subject.replace(/&nbsp;/g," ");
		subject = subject.replace(/<style[^>]*>[^<]*<\/style>/ig, "");
	 	document.getElementsByName("fdItems["+index+"].fdName")[0].value = $("<div></div>").append(Com_HtmlEscape(subject)).text();
		document.getElementById("fdItems["+index+"].fdNameShow").innerHTML = $("<div></div>").append(subject).text();  
		document.getElementById("fdItems["+index+"].fdTypeText").innerHTML = $("<div></div>").append(typeText).text();
		refreshIndex(tbInfo);
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
				_dialog.confirm('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.sureTo"/>'+confirmMsg+'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.insertPageBreak"/>',
					function(value){
						if(value==true){
							insertPagination(insertIndex);
						}
						else{
							return;
						}
					});
			}else{
				insertPagination(insertIndex);
			}	
		}else{
			url = getEditUrl(questionType);
			//判断是否是选择位置插入
			if(obj && obj.checked){
				_dialog.confirm('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.sureTo"/>'+confirmMsg+'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.insertQuestion"/>',
					function(value){
						if(value==true){
							insertQuestion(url,insertIndex,questionType,quesTypeName);
						}
						else{
							return;
						}
					});
			}else{
				insertQuestion(url,insertIndex,questionType,quesTypeName);
			}
		}
	}
}
 /**
  * 打开编辑模态窗口
  */
 function openWin(url,questionTypeName,obj,type){
	 if (url.substring(0, 1) != '/') {
		 url = '/'+url;
	 }
	if(obj==null) obj="";
 	top._question=obj;//传入dialog的参数
 	var editDialog=_dialog.iframe(url,questionTypeName,function(o){
 	 	top._question=null;//清空参数
 		if(type == "edit" &&o!=null&& o.value != null && o.value != ""){
 	 		var selecttype = eval("("+(o.value)+")");
 	 		var subject = selecttype.subject.replace(/&nbsp;/g," ");
 	 		subject = subject.replace(/<style[^>]*>[^<]*<\/style>/ig, "");
 	 		subject = Com_HtmlEscape(subject);
 	 		document.getElementsByName(o.name.replace("fdQuestionDef","fdName"))[0].value = $("<div></div>").append(subject).text();
 	 		document.getElementById(obj.name.replace("fdQuestionDef","fdNameShow")).innerHTML = $("<div></div>").append(subject).text();
 	 	}
 	 },{"width":700,"height":500});
 	//editDialog.content.iframeDestroy=function(){};//重写销毁方法(防止IE下报JS错误)
 }
 
 function isEmptyObject(obj){  
     for(var key in obj){ 
           return true; 
     };  
     return false;
 }; 
 /**
  * 题目关联打开编辑模态窗口
  */
 function openRelation(url,_index,copyIndex,signId){
	if (!_index) {
		 _index=copyIndex;
	}
	 if (url==null||url=="") {
		 if (signId=="1") {
			url="/km/pindagate/question_type_ui/relation/questionSubjectRelation.jsp"+"?kmPindagateMainFdId=${kmPindagateMainForm.fdId}";
		}else{
			url="/km/pindagate/question_type_ui/relation/questionOptionRelation.jsp"+"?kmPindagateMainFdId=${kmPindagateMainForm.fdId}";
		}
	}
 	var sign1="false", //如果该题目是第一题
 	 	sign2="false",//如果不是第一题，但前面的题目中不存在单选题和多选题时
 		sign3="false",//如果该题目不是第一题，且前面有单选或多选题，且该题不是单选题或多选题时
 		sign4="false",//有单选或多选
 		sign5="false",//是否是单选题
 		titleStr={},
 		fdTypeNub={};//多选：1,单选：2
 	if (_index=="0") {
 		//提示信息：第1题不能进行逻辑设置
 		sign1="true";
	}
 	if (_index>0) {
		for (var i = 0; i <_index; i++) {
			var fdType=$('input[name="fdItems['+i+'].fdType"]').val();
			if (fdType=="multiselect"||fdType=="singleselect") {
				sign4="true";
				sign3="true";
			}else{
				sign2="true";
			}
		}
		 var fdTypeIndex=$('input[name="fdItems['+_index+'].fdType"]').val();
		if (fdTypeIndex=="multiselect"||fdTypeIndex=="singleselect") {
			sign5="true";
		}else{
			sign5="false";
		}
	}
 	var questionDefs="",
 		forIndex=parseInt(_index)+parseInt("1"),
 		questDefName={};
	for (var i = 0; i < _index; i++) {
		var fdTypeDef=$('input[name="fdItems['+i+'].fdType"]').val();
		if (fdTypeDef=="multiselect"||fdTypeDef=="singleselect") {
			var questionDef = $('input[name="fdItems['+i+'].fdQuestionDef"]').val();
			questDefName[i]=questionDef;
		}
		if (fdTypeDef=="multiselect") {
			fdTypeNub[i]="1";
		}
		if (fdTypeDef=="singleselect") {
			fdTypeNub[i]="2";
		}
	}
	var fdName = $('input[name="fdItems['+_index+'].fdName"]').val(),
		fdTypeText = $('[id="fdItems['+_index+'].fdTypeText"]').html(),
		fdId = $('input[name="fdItems['+_index+'].fdId"]').val(),
		json = JSON.stringify(questDefName),
		typeJson = JSON.stringify(fdTypeNub);
		titleStr={"fdName":fdName,"fdTypeText":fdTypeText},
		subjectRelation=$('input[name="fdItems['+_index+'].fdRelationDef"]').val();
		optionRelation=$('input[name="fdItems['+_index+'].fdOptRelDef"]').val();
	var titleJson=JSON.stringify(titleStr);
	//---------------------------------
	var str="";
	if (sign1=="true") {
		_dialog.alert("第1题不能进行逻辑设置");
		return;
	}
	if (sign2=="true"&&sign4=="false") {
		_dialog.alert("此题前面没有单选题或多选题，无法进行逻辑设置");
		return;
	}
	
	//------------------------------------
	 var optNeed=$('input[name="fdItems['+_index+'].fdQuestionDef"]').val();
	if (signId=="1") {
		_dialog.iframe(url," ",function(obj){
	 		var o=window.parent.subjectRelation;
	 		$('input[name="fdItems['+_index+'].fdRelationDef"]').val(o);
	 		$('input[name="fdItems['+_index+'].fdRelationSign"]').val("1");
	 		if (o != "{}"&&o) {
	 			$(optTR).find(".relationFont").addClass('com_btn_link');
			}else{
	 			$(optTR).find(".relationFont").removeClass('com_btn_link');
			}
	 	},{"width":700,"height":700,params:{index:_index,jt:jt,questionDefs:json,typeJson:typeJson,titleJson:titleJson,subjectRelation:subjectRelation,fdId:fdId}});
	}else{
		_dialog.iframe(url," ",function(obj){
	 		var o=window.parent.optionRelation;
	 		$('input[name="fdItems['+_index+'].fdOptRelDef"]').val(o);
	 		$('input[name="fdItems['+_index+'].fdRelationSign"]').val("1");
	 	},{"width":700,"height":700,params:{index:_index,jt:jt,questionDefs:json,typeJson:typeJson,titleJson:titleJson,optionRelation:optionRelation,optNeed:optNeed,fdId:fdId}});
	}
 	
 	
 }
/**
* 插入题目   
* 		url 打开窗口url
* 		insertIndex 插入位置   为空时在最后一行插入
* 		questionType  题型类别
*/
function insertQuestion(url,insertIndex,quesTypeVal,quesTypeName){
	quesTypeText = quesTypeName;
	top._question = new Object();//传入dialog的参数
	url = '/'+url;
	var editDialog=_dialog.iframe(url,quesTypeName,function(obj){
		top._question=null;//清空参数
		if(obj!=null){
			var rtnValue=obj.value;
			if(rtnValue != null && rtnValue != ""){
				var openUrl = "'"+url+"'";
				var obj = "document.getElementsByName(this.id)[0]";
				var indexs = "";
				if(insertIndex == null || insertIndex == ""){
					indexs = tbInfo.lastIndex-2;
				}
				<%
				pageContext.setAttribute("fdIdzx", com.landray.kmss.util.IDGenerator.generateID());
				%>
				//类型，类型名称，id
				var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" class="fdId" value="${fdIdzx}'+indexs+'" name="fdItems[!{index}].fdId" value="${kmPindagateTitleForm.fdId}"><input type="hidden" class="fdRelationDef"  name="fdItems[!{index}].fdRelationDef" value=""><input type="hidden" name="fdItems[!{index}].fdRelationSign" value=""><input type="hidden" class="fdOrder" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder"><input type="hidden" name="fdItems[!{index}].fdSplit"><input type="hidden" name="fdItems[!{index}].fdQuestionDef">',
			            '',
			            '<div id="fdItems[!{index}].fdNameShow" class="questionTitle"></div><input type="hidden" name="fdItems[!{index}].fdName" >',
			            '<center id="fdItems[!{index}].fdTypeText">'+quesTypeText+'</center><input type="hidden" name="fdItems[!{index}].fdType" value="'+quesTypeVal+'">', 
			            '<tr><td><center><span class="relationFont" onclick="relation(\''+quesTypeText+'\',\''+quesTypeVal+'\','+"'1'"+',\''+indexs+'\');">题目关联</span></center></td></tr>',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:pointer;"></center>');
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
				subject = subject.replace(/<style[^>]*>[^<]*<\/style>/ig, "");
				document.getElementsByName(obj.name.replace("fdQuestionDef","fdName"))[0].value = $("<div></div>").append(Com_HtmlEscape(subject)).text();//html标签转义
				document.getElementById(obj.name.replace("fdQuestionDef","fdNameShow")).innerHTML = $("<div></div>").append(subject).html();	
			}
			_validation.validateElement(document.getElementById("questionsValidate"));						
		}
	},{"width":700,"height":700});
	//editDialog.content.iframeDestroy=function(){};//重写销毁方法(防止IE下报JS错误)
}
/**
* 插入分页标记
*/
function insertPagination(insertIndex){
	var content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" value="'+insertIndex+'" name="fdItems[!{index}].fdOrder">',
			            '',
			            '<span id="fdItems[!{index}].fdNameShow"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/></span><input type="hidden" name="fdItems[!{index}].fdName" value=\'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/>\' >',
			            '<center><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/></center><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><bean:message bundle="km-pindagate" key=""/></center><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:pointer;">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:pointer;"></center>',
			            '');
	addRow("TABLE_DocList", content,"pagination",insertIndex,"1");
	refreshIndex(tbInfo);
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
};
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
 * 删除行
 *	optTR：
 *		可选，操作行对象，默认取当前操作的当前行
 */
 function deleteRow(optTR){
	if(optTR==null)
		optTR = DocListFunc_GetParentByTagName("TR");
	var fdOrder=$(optTR).find(".fdOrder").val();
	var fdId=$('input[name="fdItems['+fdOrder+'].fdId"]').val();
	var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
	var tbInfo = DocList_TableInfo[optTB.id];
	var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
	optTB.deleteRow(rowIndex);
	tbInfo.lastIndex--;
	refreshIndex(tbInfo);
	jt--;
	//删除关联逻辑
	tbInfo = DocList_TableInfo['TABLE_DocList'];
	var count=0,
		realtionDef={};
	
	//删除关联逻辑获取逻辑中的id，进行删除
	for(var i = 2; i<tbInfo.lastIndex; i++){
		var fields = $(tbInfo.DOMElement.rows[i]).find(".fdRelationDef");
		realtionDef={};
		for(var j=0; j<fields.length; j++){
			if (fields[j].value) {
				var relationDefVal=fields[j].value;
				relationDefVal=JSON.parse(relationDefVal);
				for ( var k in relationDefVal) {
					if (relationDefVal[k].fdId==fdId) {
						delete relationDefVal[k];
					}
					if (relationDefVal[k]) {
						realtionDef[count]=relationDefVal[k];
					}
				}
			}
 		}
		$('input[name="fdItems['+count+'].fdRelationDef"]').val(JSON.stringify(realtionDef));
		count++;
	}
	updateCoordinates();
}
//修改关联题目题号 sign：有值代表初始化，没值代表删除
function updateCoordinates(sign) {
	//获取所有题目id
	tbInfo = DocList_TableInfo['TABLE_DocList'];
	var topicId={},
		count1=0,
		realtionDef={},
		count=0;
	for(var i = 2; i<tbInfo.lastIndex; i++){
		var fdId = $(tbInfo.DOMElement.rows[i]).find(".fdId");
		var fdOrder = $(tbInfo.DOMElement.rows[i]).find(".fdOrder");
		for(var j=0; j<fdId.length; j++){
			if (fdId[j].value) {
				topicId[count]={fdOrder:fdOrder[j].value,fdId:fdId[j].value};
			}
 		}
		count++;
	}
	if (sign) {
		for(var q = 2; q<tbInfo.lastIndex; q++){
			var fields = $(tbInfo.DOMElement.rows[q]).find(".fdRelationDef");
			for ( var s in fields) {
				for ( var d in topicId) {
					if (fields[s].value) {
						var relationDefVal=fields[s].value;
						relationDefVal=JSON.parse(relationDefVal);
						var topicIdSign=0;
						for ( var b in relationDefVal) {
							if (relationDefVal[b].topic==d) {
								relationDefVal[b].fdId=topicId[d].fdId;
							}
							if (relationDefVal[b]) {
								if ($('input[name="fdItems['+count1+'].fdId"]').val()==relationDefVal[b].fdId) {
									delete relationDefVal[b];
								}
								realtionDef[topicIdSign]=relationDefVal[b];
								$('input[name="fdItems['+count1+'].fdRelationDef"]').val(JSON.stringify(realtionDef));
								topicIdSign++;
							}
						}
					}
				}
			}
			count1++;
		}
	}else{
		//判断题目id题号，题号关联题号
		for(var q = 2; q<tbInfo.lastIndex; q++){
			var fields = $(tbInfo.DOMElement.rows[q]).find(".fdRelationDef");
			for ( var s in fields) {
				for ( var d in topicId) {
					if (fields[s].value) {
						var relationDefVal=fields[s].value;
						relationDefVal=JSON.parse(relationDefVal);
						realtionDef={};
						var topicIdSign=0;
						for ( var b in relationDefVal) {
							if (relationDefVal[b].fdId==topicId[d].fdId) {
								relationDefVal[b].topic=topicId[d].fdOrder;
								relationDefVal[b].currentTopic=count1;
							}
							if (relationDefVal[b]) {
								realtionDef[topicIdSign]=relationDefVal[b];
								$('input[name="fdItems['+count1+'].fdRelationDef"]').val(JSON.stringify(realtionDef));
								topicIdSign++;
							}
						}
					}
				}
			}
			count1++;
		}
	}
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
	var fdOrder=$(optTR).find(".fdOrder").val();
	fdOrdeCount=parseInt(fdOrder)-parseInt("1");
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
	var sign=$("input[name='fdItems["+fdOrder+"].fdRelationSign']").val();
	refreshIndex(tbInfo);
	
	//上移下移改变关联题号
	tbInfo = DocList_TableInfo['TABLE_DocList'];
	var topicId={},
	count1=0,
	realtionDef={},
	count=0;
	for(var i = 2; i<tbInfo.lastIndex; i++){
		var fdId = $(tbInfo.DOMElement.rows[i]).find(".fdId");
		var fdOrder = $(tbInfo.DOMElement.rows[i]).find(".fdOrder");
		for(var j=0; j<fdId.length; j++){
			if (fdId[j].value) {
				topicId[count]={fdOrder:fdOrder[j].value,fdId:fdId[j].value};
			}
		}
		count++;
	}
	
	//修改题号
	for(var q = 2; q<tbInfo.lastIndex; q++){
		var fields = $(tbInfo.DOMElement.rows[q]).find(".fdRelationDef");
		for ( var s in fields) {
			for ( var d in topicId) {
				if (fields[s].value) {
					var relationDefVal=fields[s].value;
					relationDefVal=JSON.parse(relationDefVal);
					var topicIdSign=0;
					for ( var b in relationDefVal) {
						if (relationDefVal[b].fdId==topicId[d].fdId) {
							relationDefVal[b].topic=topicId[d].fdOrder;
							relationDefVal[b].currentTopic=count1;
							if (relationDefVal[b].topic>count1) {
								relationDefVal[b].sign="false";
							}else{
								relationDefVal[b].sign="true";
							}
						}
						if (relationDefVal[b]) {
							if ($('input[name="fdItems['+count1+'].fdId"]').val()==relationDefVal[b].fdId) {
								delete relationDefVal[b];
							}
							realtionDef[topicIdSign]=relationDefVal[b];
							$('input[name="fdItems['+count1+'].fdRelationDef"]').val(JSON.stringify(realtionDef));
							topicIdSign++;
						}
					}
				}
			}
		}
		count1++;
	}
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
 * 预览
 */
 function previewIndatate(){
 	var questions = new Array();
 	var question = null;
 	var questionTypes = $('input[name="questionTypes"]').val();
 	var lastIndex = $('#TABLE_DocList .questionTR').length;//题目行
 	for(var index = 0; index<lastIndex; index++){
 		question = {'fdQuestionDef':$('input[name="fdItems['+index+'].fdQuestionDef"]').val(),
 				'fdType':$('input[name="fdItems['+index+'].fdType"]').val(),
 				'fdSplit':$('input[name="fdItems['+index+'].fdSplit"]').val(),
 				'fdOrder':$('input[name="fdItems['+index+'].fdOrder"]').val(),
 				'fdTitle':$('input[name="fdItems['+index+'].fdName"]').val(),
 				'fdRelationDef':$('input[name="fdItems['+index+'].fdRelationDef"]').val(),
 				'questionTypes':questionTypes};
 		questions[index] = question;
 	}
 	
 	var docSubject=encodeURI($("input[name='docSubject']").val());
 	var url = '/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_preview.jsp?param=edit&docSubject='+docSubject;
 	var obj = $('#questions');
 	obj.value = JSON.stringify(questions);
 	top._questions=obj;//传入dialog的参数
 	_dialog.iframe(url," ",function(obj){
 	 	top._questions=null;//清空参数
 		if(obj!=null&&obj.value != ''){
 	 		questions = eval("("+(obj.value)+")");
 	 		afterPreview(questions);
 	 	}
 	 },{"width":1024,"height":600});
 }
 /**
  * 预览页面编辑之后重新设置题目
  */
 function afterPreview(questions){
 	if(questions != null && questions != ""){
 		var tbInfo = DocList_TableInfo['TABLE_DocList'];
 		//重新加载题目
 		for(key = 0; key < questions.length;key++){
 			var fdTitle = questions[key].fdTitle;
 			fdTitle = fdTitle.replace(/<style[^>]*>[^<]*<\/style>/ig, "");
 			fdTitle = Com_HtmlEscape(fdTitle);
 			$('input[name="fdItems['+key+'].fdName"]').val($("<div></div>").append(fdTitle).text());
 			document.getElementById('fdItems['+key+'].fdNameShow').innerHTML = $("<div></div>").append(fdTitle).text();
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
 	_validation.validateElement(document.getElementById("questionsValidate"));
 }
 /**
  * 编辑
  */
 function edit(questionType,questionTypeName,_this){
 	var obj = document.getElementsByName(_this.id)[0];
 	openWin(getEditUrl(questionType),questionTypeName,obj,'edit');
 }
 /**
  * 题目关联
  */
 function relation(questionType,questionTypeName,_this,_index,copyIndex){
	 optTR = DocListFunc_GetParentByTagName("TR");
	 var fdOrder=$(optTR).find("input[name$='fdOrder']").val();
	 if(!questionType){
		 questionType = $(optTR).find("td").eq(3).text();
	 }
 	openRelation(getRelationUrl(questionType,"1"),fdOrder,copyIndex,"1");
 }
 
 /**
 *选项关联
 */
 function itemRelation(questionType,_index,copyIndex,questionTypeName) {
	 if (questionType=="singleselect"||questionType=="multiselect") {
		 openRelation(getRelationUrl(questionType,"2"),_index,copyIndex,"2");
	}
	 
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
function getRelationUrl(questionType,id){
	var questionTypeObj = $('input[name="questionTypes"]');
	var questionTypes = eval("("+(questionTypeObj.val())+")");
	for(key in questionTypes){
		if(questionType == questionTypes[key].quesTypeId){
			if (id=="1") {
				return questionTypes[key].relationUrl;
			}else{
				return questionTypes[key].OpRelationUrl;
			}
		}
	}
}

//保存题目模板前的相关校验
function checkSaveAsTemplate(){
	if($("input[name='docSubject']").val()==""||$("input[name='docSubject']").val()==null){
		_dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateMain.docSubject'/><bean:message bundle='km-pindagate' key='kmPindagateResponse.notNull'/>");
		return;
	}
	//选择模板存放位置
	_dialog.category({
		modelName:'com.landray.kmss.km.pindagate.model.KmPindagateMainTemp',
		idField:'docCategoryId',
		nameField:'docCategoryName',
		isShowTemp:false,
		action:function(result,dialog,ctx){
			if(result && result.id){
				$.ajax({
					url : '${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do?method=saveAsTemplate&fdCategoryId='+result.id,
					type: 'POST',
					data: $('form[name="kmPindagateMainForm"]').serialize(),
					cache : false,
					dataType: 'json',
					error : function(data){
						if(data && data.status == '403'){
							_dialog.failure('<bean:message bundle="km-pindagate" key="kmPindagateTemplate.noAuth.tip" />');
						}else{
							_dialog.failure('<bean:message key="return.optFailure" />');
						}
					},
					success : function(data) {
						if(data.status==true){
							saveAsTemplateSuccess();
						}
					}
				});
			}
		}
	});
}
/**  
* 保存为题目模板成功后的操作
*/
function saveAsTemplateSuccess(){
	$("input[name='docCategoryId']").val("");
	_dialog.success('<bean:message key="return.optSuccess" />');
}
/**
* 选择题目模板后通过ajax调用后台Service取的对应模板题目数据
*/
function changeQuestion(){
	var fdQuestionTempId=$("input[name='fdQuestionTempId']").val();
	//打开要选择的题目列表窗口
	var checkUrl = Com_Parameter.ContextPath+"km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=checkSelectAll&fdId="+fdQuestionTempId;
	LUI.$.ajax({
		url : checkUrl,
		method : "GET",
		success : function(flag){
			if(flag == 'false'){
				var url="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=selectQuestionList&fdId="+fdQuestionTempId;
				_dialog.iframe(url," ",function(values){
						if(values!=""&&values!=null){
							var data = new KMSSData();
							var urls="kmPindagateMainTempQuestionService&questionIds="+values+"&fdQuestionTempId="+fdQuestionTempId;
							data.SendToBean(urls,resetQuestion);
					}
				},{width:500,height:500});
			}else{
				var data = new KMSSData();
				var urls="kmPindagateMainTempQuestionService&questionIds=undefined&selectAll=true&fdQuestionTempId="+fdQuestionTempId;
				data.SendToBean(urls,resetQuestion);
			}
		}
	});
}
/**
* 选择题目模板后生成题目
*/
function resetQuestion(rtnData){
	if(rtnData.GetHashMapArray().length==0)
		return;
	if(rtnData){
		//清除原来的题目行	
		if(tbInfo == null)
			tbInfo = DocList_TableInfo['TABLE_DocList'];
		var countOpt="";
		index = tbInfo.lastIndex-3;
		for(var i=0; i<rtnData.GetHashMapArray().length; i++){
			var obj = rtnData.GetHashMapArray()[i];
			var editObj = "document.getElementsByName(this.id)[0]";
			var openUrl="'"+getEditUrl(obj["fdType"])+"'";
			//判断是否为分页标记
			var content = null;
			if(obj["fdSplit"]=="false")
			  	content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox">'
					  	+'<input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}">'
					  	+'<input type="hidden" class="fdOrder" value="'+parseInt(obj["fdOrder"])+'" name="fdItems[!{index}].fdOrder">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdSplit" value="'+obj["fdSplit"]+'">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdQuestionDef" value="">'
					  	+'<input type="hidden" class="fdRelationDef" name="fdItems[!{index}].fdRelationDef" value="">'
					  	+'<input type="hidden" name="fdItems[!{index}].fdFromTmp" value="true">',
		            '',
		            '<input  type="hidden" name="fdItems[!{index}].fdName" value="'+obj["fdName"]+'" ><span id="fdItems[!{index}].fdNameShow">'+obj["fdName"]+'</span>',
		            '<center id="fdItems[!{index}].fdTypeText">'+obj["fdTypeName"]+'</center><input type="hidden" name="fdItems[!{index}].fdType" value="'+obj["fdType"]+'">',
		        	'<center><span class="relationFont" onclick="relation(\''+obj["fdTypeName"]+'\',\''+obj["fdType"]+'\','+"''"+',\''+countOpt+'\',\'!{index}\');">题目关联</span></center>',
		            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:pointer">&nbsp;&nbsp;&nbsp;'
		            	+'<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:pointer">&nbsp;&nbsp;&nbsp;'
		            	+'<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:pointer"></center>',
		           		 '<center><img  id="fdItems[!{index}].fdQuestionDef" src="${KMSS_Parameter_StylePath}icons/edit.gif" alt="edit" onclick="openWin('+openUrl+',\''+obj["fdTypeName"]+'\','+editObj+',\'edit\');" style="cursor:pointer;" />&nbsp;&nbsp; <img src="${KMSS_Parameter_StylePath}/icons/icon_copy.png"  alt="copy" onclick="DocList_CopyRow();copyQuestion(!{index});" style="cursor: pointer;"></center>');
			else//分页符
				content = new Array('<input type="checkbox" name="fdItems[!{index}].checkbox"><input type="hidden" name="fdItems[!{index}].kmPindagateMainId" value="${kmPindagateMainForm.fdId}"><input type="hidden" value="'+parseInt(obj["fdOrder"])+'" name="fdItems[!{index}].fdOrder">',
			            '',
			            '<span><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/></span><input type="hidden" name="fdItems[!{index}].fdName" value=\'<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/>\' >',
			            '<center><bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.pageBreak"/></center><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><bean:message bundle="km-pindagate" key=""/></center><input type="hidden" name="fdItems[!{index}].fdSplit" value="true">',
			            '<center><img src="${KMSS_Parameter_StylePath}icons/up.gif" alt="up" onclick="moveRow(-1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/down.gif" alt="down" onclick="moveRow(1);" style="cursor:hand">&nbsp;&nbsp;&nbsp;<img src="${KMSS_Parameter_StylePath}icons/delete.gif" alt="del" onclick="deleteRow();" style="cursor:hand">&nbsp;&nbsp;</center>',
			            '');
            //在addRow中已经对tbInfo的lastIndex进行了更新，这里不需要再做
			addRow("TABLE_DocList", content,obj["fdSplit"]=="false"?null:"pagination",null,"2");
			$('input[name="fdItems['+((i+1)+index)+'].fdQuestionDef"]').val(obj["fdQuestionDef"]);		
		}
		refreshIndex(tbInfo);
		jt = jt + rtnData.GetHashMapArray().length;
		_validation.validateElement(document.getElementById("questionsValidate"));
	}
}
//选择模板题目
function btCategory(){
	Dialog_TreeList(false,'fdQuestionTempId','fdQuestionTempName',';',
					'kmPindagateMainTempTitleTreeService&parentId=!{value}', 
					'<bean:message bundle="km-pindagate" key="dialog.tree.title"/>', 
					'kmPindagateMainTempNameTreeService&fdCategoryId=!{value}', function(rtnData){
						if($("input[name='fdQuestionTempId']").val() == ""){
							return;
						}
						//加载模板题目
						changeQuestion();
						//选择完成后将模板ID设为空
						$("input[name='fdQuestionTempId']").val("");
					},
					'kmPindagateMainTempNameSearchService&keyword=!{keyword}', null,false, false,"问卷模板");
}

//提交前转为base64
window.fdQuestionDefHasEncode = false;
Com_Parameter.event["submit"].push(function(){
	if(!window.fdQuestionDefHasEncode){
		$('input[name$="fdQuestionDef"]').each(function(index){
			var value = base64Encode($(this).val());
			$(this).val(value);
		});
		window.fdQuestionDefHasEncode = true;
	}
	return true;
});
function SplitValidate(){
 	var questions = new Array();
 	var question = null;
 	var questionTypes = $('input[name="questionTypes"]').val();
 	var lastIndex = $('#TABLE_DocList .questionTR').length;//题目行
 	for(var index = 0; index<lastIndex; index++){
 		question = {'fdQuestionDef':$('input[name="fdItems['+index+'].fdQuestionDef"]').val(),
 				'fdType':$('input[name="fdItems['+index+'].fdType"]').val(),
 				'fdSplit':$('input[name="fdItems['+index+'].fdSplit"]').val(),
 				'fdOrder':$('input[name="fdItems['+index+'].fdOrder"]').val(),
 				'fdTitle':$('input[name="fdItems['+index+'].fdName"]').val(),
 				'questionTypes':questionTypes};
 		questions[index] = question;
 	}
 	var flag = false;
	var k = -1;
	for(var i = 0; i < questions.length; i++){
		if(questions[i].fdSplit == "true"){
			if(index == questions.length-1){
				questions[i].fdQuestionDef = "delete";
			}
			if(flag){
				flag = false;
				k = i;
			}else{
				questions[i].fdQuestionDef = "delete";
			}
		}else{
			if(questions[i].fdQuestionDef != "delete"){
				flag = true;
			}
		}
	}
	if(!flag && k!=-1){
		questions[k].fdQuestionDef = "delete";
	} 
 	if(questions != null && questions != ""){
 		var tbInfo = DocList_TableInfo['TABLE_DocList'];
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
</script>