<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>

<%@page import="com.landray.kmss.sys.authorization.constant.ISysAuthConstant"%><link href="${KMSS_Parameter_ContextPath}km/pindagate/pindagate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	Com_IncludeFile("jquery.js|json2.js|data.js");

	var page_click_num=1;
	var page_total_num=0;
	var page_click_currNo=1;
	
	var _ResponseJsFileList=new Array();
	//表单提交
	function ComSubmitForm(method, status){
		if(page_click_num<page_total_num && status!='10')
	   	{
		   	alert("<bean:message key='kmPindagateResponse.error.canNotCommit' bundle='km-pindagate' />");
	   		return false;
		}
		
		   var pid = '${kmPindagateMainForm.fdId}';
		   var url="${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=checkIfCanRes&pid="+pid; 
		   $.post(url,function(data){
		   	 
		   	  if(data.indexOf("true")>-1){		
		   		$("input[name='docStatus']").val(status);
				submitForm(method);    		 
		   		 
		   	  } else{
		   		 alert("<bean:message key='kmPindagateMain.tip.hasResponse' bundle='km-pindagate' />");
		   		 return false;
		   	  }  	  		    		   		    	
		   });		
	}
	//提示信息
	function showMaskLayer(divDialog,divDialogContent,dialogContent,isDispaly){ 
		if(isDispaly)
			$("#"+divDialog).css({display:"block"});
		else
			$("#"+divDialog).css({display:"none"});
		$("#"+divDialogContent).html(dialogContent); 
	}
	//注册题目使用js
	function Response_RegisterJsFile(fileName){
		if(Com_ArrayGetIndex(_ResponseJsFileList, fileName)==-1)
			_ResponseJsFileList[_ResponseJsFileList.length] = fileName;
	}
	//引入题目使用js
	function Response_IncludeJsFile(fileName){
		if(Com_ArrayGetIndex(_ResponseJsFileList, fileName)==-1){
			_ResponseJsFileList[_ResponseJsFileList.length] = fileName;
			document.writeln("<script src="+fileName+"><\/script>");
		}
	}
	//对于题目中附件高度处理
	function autoResize(obj){
		obj.height = obj.contentWindow.document.body.scrollHeight + 20;	
	}
	
	//改变图片的大小
	function resizeToSmail(_this){
	  _this.style.width="300px"; 
	  _this.style.height ="300px"; 
	}
	function resizeToLarge(_this){
	  _this.style.width="14px"; 
	  _this.style.height ="14px"; 
	}
</script>

<html:form action="/km/pindagate/km_pindagate_response/kmPindagateResponse.do">
<kmss:windowTitle
			subjectKey="km-pindagate:title.km.pindagate.response"
			moduleKey="km-pindagate:table.kmPindagateMain" />
<div id="optBarDiv">  
	<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=viewProperties&fdId=${kmPindagateMainForm.fdId}">
		<input type=button value="<bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.quesProperty"/>" 
			onclick="Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=view&fdId=${kmPindagateMainForm.fdId}');">
	</kmss:auth>
	<c:if test="${isShowUpdateAndViewResultButton}">
		<kmss:authShow roles="ROLE_KMPINDAGATE_UPDATESTATISTICRESULT">
			<input type=button value='<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.updateAndViewResult"/>' 
				onclick="if(confirm('<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.updateAndViewResult.confirm"/>'))
					Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=resultsView&fdId=${kmPindagateMainForm.fdId}&flag=updateStatisticResult');">
		</kmss:authShow>
	</c:if>
	<c:if test="${isShowResultViewButton}">
		<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}">
			<input type=button value="<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.viewResult"/>" 
				onclick="Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=resultsView&fdId=${kmPindagateMainForm.fdId}');">
		</kmss:auth>
	</c:if>
	<c:if test="${canResponse}">	
		<c:if test="${kmPindagateResponseForm.method_GET=='edit'&& kmPindagateResponseForm.docStatus =='10'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="ComSubmitForm('update','10');">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="ComSubmitForm('update','30');">
		</c:if> 
		<c:if test="${kmPindagateResponseForm.method_GET=='add'}">
			<input type=button value="<bean:message key="button.savedraft"/>"
				onclick="ComSubmitForm('save','10');">
			<input type=button value="<bean:message key="button.submit"/>"
				onclick="ComSubmitForm('save','30');">
		</c:if> 
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<!-- 提示信息 -->
<div id="dialog"> 
	<div id="dialog_content"></div> 
</div> 

<script>
	var dialogContent = "<img src='${KMSS_Parameter_StylePath}icons/loading.gif' border='0'><bean:message bundle='km-pindagate' key='kmPindagateResponse.loading'/>";
	showMaskLayer('dialog','dialog_content',dialogContent);
</script>

<div class="pi_container">
<html:hidden property="fdQuetionairId"/>
<xform:text property="docStatus" showStatus="noShow" value="30" />
<% if(ISysAuthConstant.IS_AREA_ENABLED) { %> 
<input type="hidden" name="authAreaId" value="kmPindagateResponseForm.authAreaId"> 
<xform:text property="kmPindagateResponseForm.authAreaName" showStatus="noShow" />	
<% } %>
<html:hidden property="fdId"/>
<c:forEach items="${kmPindagateResponseForm.fdItems}" var="KmPindagateQuestionResForm" varStatus="vstatus">					
	<div>
		<input type="hidden" name="fdItems[${vstatus.index}].fdDraftAnswer" value="${KmPindagateQuestionResForm.fdAnswer}">
		<input type="hidden" name="fdItems[${vstatus.index}].fdDraftOther" value="${KmPindagateQuestionResForm.fdOther}">	
		<input type="hidden" name="fdItems[${vstatus.index}].fdDraftSelectReason" value="${KmPindagateQuestionResForm.fdSelectReason}">					
	</div>
</c:forEach>
<div class="pi_box">
	<div class="pi_content" id="Div_Response_Questions"><%int serialNum = 0; %>
		<span style="display:block;margin-left: 20px;
             margin-right: 20px;
             letter-spacing: 1px;
             word-spacing: 2px;
             line-height: 1.7em;
             text-indent: 20px;
             text-align: justify;">
			${kmPindagateMainForm.fdQuestionExplain}
		</span>
		<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateQuestionForm" varStatus="vstatus">
			<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
				<% serialNum++; %>
			</c:if>
			<div id="questions${vstatus.index}" <c:if test="${!canResponse}">disabled</c:if>>
				<input type="hidden" id="fdQuestionDef${vstatus.index}" value="${kmPindagateQuestionForm.fdQuestionDefView}" >
				<input type="hidden" id="fdType${vstatus.index}" value="${kmPindagateQuestionForm.fdType}">
				<input type="hidden" id="fdSplit${vstatus.index}" name="fdSplit"  value="${kmPindagateQuestionForm.fdSplit}">
				<input type="hidden" id="serialNum${vstatus.index}" value="<%=serialNum%>">
				<input type="hidden" id="fdTitle${vstatus.index}" value="${kmPindagateQuestionForm.fdName}">
				<input type="hidden" id="fdSubjectImg${vstatus.index}">
				<input type="hidden" id="quesTypeName${vstatus.index}" value="${kmPindagateQuestionForm.fdTypeName}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdQuetionairResId" value="${kmPindagateResponseForm.fdId}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdQuestionId" value="${kmPindagateQuestionForm.fdId}">
				<input type="hidden" name="fdItems[${vstatus.index}].fdOrder" value="${kmPindagateQuestionForm.fdOrder}">
				<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
					<c:import url="/${kmPindagateQuestionForm.responseUrl}" charEncoding="UTF-8">
						<c:param name="index" value="${vstatus.index}" />
						<c:param name="divId" value="${kmPindagateQuestionForm.fdType}${vstatus.index}" />
					</c:import>
				</c:if>
			</div>
		</c:forEach>
	</div>
</div>
</div>
<!-- 图形预览区域 -->
<DIV id="dHTMLToolTip" 
style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
</DIV>
</html:form>
<script type="text/javascript">
/**
 * 题型定义数组（每个题型的题型定义的属性名跟questiontype包下面各个题型的QuestionType类里面的属性相对应）
 * 例如：单选题的fdQuestionDef.willAnswer 对应 SingleSelectType类里面的willAnswer属性
 */
var fdQuestionDef = new Array();
$(document).ready(function (){
	var txttitle = '<p class="txttitle" style="border-bottom: 1px solid #EBF1F7;width: 98%;padding-bottom: 20px;padding-top: 20px;position:relative;">';
	txttitle += getPageHtml();
	txttitle += getPageButtonHTML1();
	txttitle += '${kmPindagateMainForm.docSubject}';
	txttitle += '</p>';
	$('#Div_Response_Questions').prepend(txttitle);
	 var bottomDiv1='<p style="width: 98%;position:relative;height: 25px;text-align: center;">';
 	bottomDiv1 += getPageHtml();
     bottomDiv1 += '</p>';
     $('#Div_Response_Questions').append(bottomDiv1);
	var bottomDiv2 = '<p style="width: 98%;position:relative;height: 25px;text-align: center;">';		
	bottomDiv2 += getPageButtonHTML2();
	bottomDiv2 += '</p>';
	$('#Div_Response_Questions').append(bottomDiv2);
	$('#Div_Response_Questions').append("<tr height=25px></tr>");
	changePage();
	showMaskLayer('dialog','dialog_content','',false);
	if("${canResponse}" == "false"){
		var finishTime = "${finishTime}";
		var isPindagateFinish = "${isPindagateFinish}";
		var dialogContent = "<img src='${KMSS_Parameter_ContextPath}km/pindagate/images/alerts.gif' height='14px' width='14px' border='0'>&nbsp;";
		if(isPindagateFinish=="1"){
			dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.pindagate.finish'/>";
		}else if(finishTime == "")
			dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.notInvolvedAuth'/>";
		else
			dialogContent += "<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved1'/>"+finishTime+"<bean:message bundle='km-pindagate' key='kmPindagateResponse.hasBeenInvolved2'/>";
		$("#dialog_content").css({color:"red"});
		showMaskLayer('dialog','dialog_content',dialogContent,true);
	}
});
/**
 * 返回页数HTML
 */
function getPageHtml(){
	var pageNumHTML = '<span style="position:absolute;left:0px;bottom:0px;font-size: 12px;font-weight: normal;"><bean:message key="page.the"/>&nbsp;<span name="currentPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;';
	pageNumHTML += '<bean:message key="page.total"/>&nbsp;<span name="totalPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;</span>';
	return pageNumHTML;
}
function getPageButtonHTML1(){
	var pageButtonHTML = '<span class="pageButtonSpan1">';
	pageButtonHTML += '<input id=prev1 type="button" class="pageLink" value="<bean:message key="page.thePrev"/>" onclick="changePage(\'prev\',this);">&nbsp;&nbsp;&nbsp;';
	pageButtonHTML += '<input id=next1 type="button" class="pageLink" value="<bean:message key="page.theNext"/>" onclick="changePage(\'next\',this);">';
	pageButtonHTML += '</span>';
	return pageButtonHTML;
}
function getPageButtonHTML2(){
	var pageButtonHTML = '<span class="pageButtonSpan2">';
	pageButtonHTML += '<input id=prev2 type="button" class="pageLink" value="<bean:message key="page.thePrev"/>" onclick="changePage(\'prev\',this);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
	pageButtonHTML += '<input id=next2 type="button" class="pageLink" value="<bean:message key="page.theNext"/>" onclick="changePage(\'next\',this);">';
	pageButtonHTML += '</span>';
	return pageButtonHTML;
}


function Dictionary(){
	 this.data = new Array();
	 
	 this.put = function(key,value){
	  this.data[key] = value;
	 };

	 this.get = function(key){
	  return this.data[key];
	 };

	 this.remove = function(key){
	  this.data[key] = null;
	 };
	 
	 this.isEmpty = function(){
	  return this.data.length == 0;
	 };

	 this.size = function(){
	  return this.data.length;
	 };
	}
	//存储题目是否被初始化信息
	var pagesInit= new Dictionary();


/**
* 换页
* 	   _method : prev(上一页)、next(下一页)、current(当前页)
*/
function changePage(_method,_this){
	var currentPage = $('span[name="currentPage"]').html();
	var totalPage = $('span[name="totalPage"]').html();
	if(_method == "prev")
		currentPage = parseInt(currentPage)-1;
	else if(_method == "next")
	{
		currentPage = parseInt(currentPage)+1;
		if(parseInt(currentPage)>page_click_currNo)
		{
			page_click_num=page_click_num+1;
			page_click_currNo=parseInt(currentPage);
		}
	}
	else
		currentPage = parseInt(currentPage);
	
	$("#prev1").attr("class","pageLink");
	 $("#prev2").attr("class","pageLink");
	 $("#next1").attr("class","pageLink");
	 $("#next2").attr("class","pageLink");
	 
	if(currentPage == 1){
		//alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheFirstPage"/>');
		//return;
		document.getElementById("prev1").setAttribute("disabled", "disabled");
		 document.getElementById("prev2").setAttribute("disabled", "disabled");
		 $("#prev1").attr("class","pageLink1");
		 $("#prev2").attr("class","pageLink1");         
	}else{
		var objprev1 = document.getElementById("prev1");
		var objprev2 = document.getElementById("prev2");
		if (objprev1.getAttribute('disabled')) {
			objprev1.removeAttribute('disabled');
		}
		if (objprev2.getAttribute('disabled')) {
			objprev2.removeAttribute('disabled');
		}
			// if(_method == "prev")
			//$(_this).attr("class","pageLinkRed");		 	     	
		}
		var divID = "";
		totalPage = 1;
		var index = 0;
		$('input[name="fdSplit"]').each(
				function() {
					divID = "questions" + index;
					if (this.value == "true") {
						totalPage++;
						$('#' + divID).hide();
					} else {
						if (totalPage == currentPage) {
							var type = $('#fdType' + index).val();
							var funType = '';
							if (type != '') {
								if ('singlematrix' == type) {
									funType = 'singleMatrix_init';
								} else if ('multimatrix' == type) {
									funType = 'multiMatrix_init';
								} else {
									funType = type + '_init';
								}
								if (pagesInit.get(index) != true) {
									eval(funType + '(\'' + index + '\',\''
											+ type + index + '\');');
									pagesInit.put(index, true);
								}
							}
							$('#' + divID).show();
							$(window).scrollTop(10);
						} else {
							$('#' + divID).hide();
						}
					}
					index++;
				});
		if (currentPage == parseInt(totalPage)) {
			//alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheEndPage"/>');
			//return;	
			document.getElementById("next1").setAttribute("disabled",
					"disabled");
			document.getElementById("next2").setAttribute("disabled",
					"disabled");
			$("#next1").attr("class", "pageLink1");
			$("#next2").attr("class", "pageLink1");
		} else {
			var objNext1 = document.getElementById("next1");
			var objNext2 = document.getElementById("next2");
			if (objNext1.getAttribute('disabled')) {
				objNext1.removeAttribute('disabled');
			}
			if (objNext2.getAttribute('disabled')) {
				objNext2.removeAttribute('disabled');
			}
			// if(_method == "next")
			//$(_this).attr("class","pageLinkRed");	

		}
		if (totalPage == 1) {
			document.getElementById("prev1").style.display = "none";
			document.getElementById("next1").style.display = "none";
			document.getElementById("prev2").style.display = "none";
			document.getElementById("next2").style.display = "none";
		}
		$('span[name="currentPage"]').html(currentPage);
		$('span[name="totalPage"]').html(totalPage);
		page_total_num=totalPage;
	}
	function submitForm(method) {
		var canSave = true;
		var messages = "";
		if ($("input[name='docStatus']").val() == "10") {
			Com_Submit(document.forms[0], method);
			return;
		}
		$('input[name="validateResult"]').each( function() {
			validateResult = eval('(' + (this.value) + ')');
			if (!validateResult.canSave) {
				canSave = false;
				messages += validateResult.message + "\r\n";
			}
		});
		if (canSave)
			Com_Submit(document.forms[0], method);
		else
			alert(messages);
	}
	function hideTooltip() {
		var divObj = document.getElementById("dHTMLToolTip");
		divObj.style.visibility = "hidden";
		divObj.style.left = 1;
		divObj.style.top = 1;
		return false
	}
	function showTooltip(e, tipContent) {
		//window.clearTimeout(tipTimer);
		var divObj = document.getElementById("dHTMLToolTip");

		divObj.style.top = document.body.scrollTop + event.clientY + 15;
		divObj.innerHTML = '<img src="' + tipContent + '">';

		if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)) {
			divObj.style.left = (document.body.clientWidth + document.body.scrollLeft)
					- divObj.clientWidth - 10;
		} else {
			divObj.style.left = document.body.scrollLeft + event.clientX;
		}
		divObj.style.visibility = "visible";
		//tipTimer=window.setTimeout("hideTooltip('"+divId+"')", displaytime);
		return true;
	}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>