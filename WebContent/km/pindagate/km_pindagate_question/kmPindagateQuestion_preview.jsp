<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.pindagate.util.*" language="java"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ page import="
	com.landray.kmss.util.KmssMessageWriter,
	com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js|optbar.js", null, "js");
</script>
</head>
<body>
<br>
<% if(request.getAttribute("KMSS_RETURNPAGE")==null){ %>
<logic:messagesPresent>
	<table align=center><tr><td>
		<font class="txtstrong"><bean:message key="errors.header.vali"/></font>
		<bean:message key="errors.header.correct"/>
		<html:messages id="error">
			<br><img src='${KMSS_Parameter_StylePath}msg/dot.gif'>&nbsp;&nbsp;<bean:write name="error"/>
		</html:messages>
	</td></tr></table>
	<hr />
</logic:messagesPresent>
<% }else{
	KmssMessageWriter msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
%>
<script>
Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
function showMoreErrInfo(index, srcImg){
	var obj = document.getElementById("moreErrInfo"+index);
	if(obj!=null){
		if(obj.style.display=="none"){
			obj.style.display="block";
			srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
		}else{
			obj.style.display="none";
			srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
		}
	}
}
</script>
<table align=center><tr><td>
	<%= msgWriter.DrawTitle() %>
	<br style="font-size:10px">
	<%= msgWriter.DrawMessages() %>
</td></tr></table>
<hr />
<% } %>
<link href="${KMSS_Parameter_ContextPath}km/pindagate/pindagate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("jquery.js|json2.js|ajaxupload.3.6.js");
</script>
<script type="text/javascript" src="${KMSS_Parameter_ResPath}fckeditor/fckeditor.js"></script>
<div id="optBarDiv" style="float: left;margin-left: 0px;">  
	<c:if test="${param.param == 'edit'}">
		<input type=button value="<bean:message key="button.save"/>" onclick="save();">
		<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
	</c:if>
</div>
<input type="hidden" id="questions" >
<div class="pi_container">
	<div class="pi_box">
		<div class="pi_content" id="Div_Preview_Questions" ></div>
	</div>
</div>
<script type="text/javascript">
var serialNum = 0;
$(document).ready(function (){
	var obj = window.dialogArguments;
	$('#questions').val(eval("("+obj.value+")"));
	window.questions = eval("("+obj.value+")");
	preview_init(eval("("+obj.value+")"));
});
function preview_init(questions){
	var flag = false;
	var k = -1;
	for(var index = 0 in questions){
		if(questions[index].fdSplit == "true"){			
			if(index == questions.length-1){
				questions[index].fdQuestionDef = "delete";
			}
			if(flag){
				flag = false;
				k = index;
			}else{
				questions[index].fdQuestionDef = "delete";
			}
			
		}else{
			if(questions[index].fdQuestionDef != "delete"){
				flag = true;
			}
		}
	}
	if(!flag && k!=-1){
		questions[k].fdQuestionDef = "delete";
	}
	/*
	for(var index=questions.length-1; index>=0; index--){
		if(questions[index].fdQuestionDef == "delete"){
			questions = arrayDel(questions,index);
		}
	}
	*/
	$('#questions').val(JSON.stringify(questions));
	
	serialNum = 0;
	if(questions != null && questions != "")
		$('#questions').val(JSON.stringify(questions));
	$('#Div_Preview_Questions').html("");
	var txttitle = '<p class="txttitle" style="border-bottom: 1px solid #EBF1F7;width: 98%;padding-bottom: 12px;padding-top: 20px;position:relative;">';
	txttitle += getPageHtml();
	txttitle += getPageButtonHTML();
	txttitle += '<bean:message bundle="km-pindagate" key="table.kmPindagateQuestion"/></p>';
	$('#Div_Preview_Questions').append(txttitle);
	for(var index = 0 in questions){
		var questionTypes = eval("("+questions[index].questionTypes+")");
		var questionType = "";
		for(var key = 0 in questionTypes){
			if(questions[index].fdType == questionTypes[key].quesTypeId)
				questionType = questionTypes[key];
		}
		var divId = questions[index].fdType+index;
		var loadHTML = '<div name="div_'+questions[index].fdType+'">';
		loadHTML += '<input type="hidden" id="fdQuestionDef'+index+'" >';
		loadHTML += '<input type="hidden" id="fdType'+index+'" >';
		loadHTML += '<input type="hidden" id="fdSplit'+index+'" >';
		loadHTML += '<input type="hidden" id="serialNum'+index+'" >';
		loadHTML += '<input type="hidden" id="fdOrder'+index+'" >';
		loadHTML += '<input type="hidden" id="fdTitle'+index+'" >';
		loadHTML += '<input type="hidden" id="fdSubjectImg'+index+'" >';
		loadHTML += '<input type="hidden" id="quesTypeId'+index+'" >';
		loadHTML += '<input type="hidden" id="quesTypeName'+index+'" >';
		loadHTML += '<input type="hidden" id="editUrl'+index+'" >';
		loadHTML += '<div id="'+divId+'" class="pi_question"';
		<c:if test="${param.param == 'edit'}">
			loadHTML += ' onMouseOver="div_onMouseOver(this);" onMouseOut="div_onMouseOut(this);"';
		</c:if>
		loadHTML += '></div></div>';
		$('#Div_Preview_Questions').append(loadHTML);
		setInputVal(index,questions[index],questionType);//设置每道题目的题型定义等信息
		$('#'+divId).load('<c:url value = "/'+questionType.previewUrl+'?&index='+index+'&divId='+divId+'" />');
	}
	var bottomDiv = '<p style="width: 98%;position:relative;height: 16px;text-align: center;">';
	bottomDiv += getPageHtml();
	bottomDiv += getPageButtonHTML();
	bottomDiv += '</p>';
	$('#Div_Preview_Questions').append(bottomDiv);
	changePage("current");
}
/**
 * 返回页数HTML
 */
function getPageHtml(){
	var pageNumHTML = '<span style="position:absolute;left:0px;bottom:0px;font-size: 11px;font-weight: normal;"><bean:message key="page.the"/>&nbsp;<span name="currentPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;';
	pageNumHTML += '<bean:message key="page.total"/>&nbsp;<span name="totalPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;</span>';
	return pageNumHTML;
}
function getPageButtonHTML(){
	var pageButtonHTML = '<span style="position:absolute;right:0px;bottom:0px;">';
	pageButtonHTML += '<input type="button" class="btnopt" value="<bean:message key="page.prev"/>" onclick="changePage(\'prev\');">&nbsp;&nbsp;&nbsp;&nbsp;';
	pageButtonHTML += '<input type="button" class="btnopt" value="<bean:message key="page.next"/>" onclick="changePage(\'next\');">';
	pageButtonHTML += '</span>';
	return pageButtonHTML;
}
function setInputVal(index,questionObj,questionType){
	$('#fdQuestionDef'+index).val(questionObj.fdQuestionDef);
	$('#fdType'+index).val(questionObj.fdType);
	$('#fdSplit'+index).val(questionObj.fdSplit);
	if(questionObj.fdSplit != "true")
		$('#serialNum'+index).val(++serialNum);
	$('#fdOrder'+index).val(questionObj.fdOrder);
	
	//$('#fdTitle'+index).val(questionObj.fdTitle);
	try{		
		var obj = eval("("+questionObj.fdQuestionDef+")")
		$('#fdTitle'+index).val(obj.subject);
		$('#fdSubjectImg'+index).val(obj.subjectImg);
	}catch(e){}
	
	$('#quesTypeId'+index).val(questionType.quesTypeId);
	$('#quesTypeName'+index).val(questionType.quesTypeName);
	$('#editUrl'+index).val(questionType.editUrl);
}
function div_onMouseOver(_this){
	_this.style.borderWidth = "1px";
	_this.style.borderColor	= "#CA0C00";
	_this.style.borderStyle	= "solid";
	var tipDiv = $('p[name="tip"]',$(_this));
	tipDiv.show();
}
function div_onMouseOut(_this){
	_this.style.borderWidth = "0px";
	_this.style.borderBottomWidth = "1px";
	_this.style.borderBottomColor	= "#d5e8f5";
	_this.style.borderBottomStyle = "dotted";
	var tipDiv = $('p[name="tip"]',$(_this));
	tipDiv.hide();
}
function modifyTitleVal(_this){
	return 0;
	var span = $(_this);
	var input = $('<input type="text" class="pi_txtTitle"/>');
	span.click(function(){return false});
	input.click(function(){return false});
	var spanVal = span.html();
	span.html('');
	input.css('width','600px').css('background','transparent').val(spanVal).appendTo(span);
	input.trigger('focus').trigger('select');
	input.blur(function(){
		span.html(input.val());
		var fdTitleId = span.attr("id");
		var index = fdTitleId.replace("fdTitle","");
		var questions = eval("("+($('#questions').val())+")");
		var questionDefObj = eval("("+(questions[index].fdQuestionDef)+")");
		questionDefObj.subject = input.val();//重新设置题型定义里面subject的值;
		questions[index].fdTitle = input.val();//重新设置题目的值
		questions[index].fdQuestionDef = JSON.stringify(questionDefObj);
		$('#fdQuestionDef'+index).val(JSON.stringify(questionDefObj));
		$('#questions').val(JSON.stringify(questions));
	});
}
/**
 * 换页
 * 	   _method : prev(上一页)、next(下一页)、current(当前页)
 */
function changePage(_method){
	if($('#questions').val() == null || $('#questions').val() == '')
		return;
	var questions = eval("("+($('#questions').val())+")");
	var currentPage = $('span[name="currentPage"]').html();
	var totalPage = $('span[name="totalPage"]').html();
	if(_method == "prev")
		currentPage = parseInt(currentPage)-1;
	else if(_method == "next")
		currentPage = parseInt(currentPage)+1;
	else
		currentPage = parseInt(currentPage);
	if(currentPage == 0){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheFirstPage"/>');
		return;
	}
	if(currentPage > parseInt(totalPage)){
		alert('<bean:message bundle="km-pindagate" key="kmPindagateResponse.alreadyTheEndPage"/>');
		return;
	}
	var divID = "";
	totalPage = 1;
	for(var index in questions){
		divID = questions[index].fdType+index;
		if(questions[index].fdSplit == "true" ){
			if(questions[index].fdQuestionDef != "delete"){
			totalPage++;
			}
			$('#'+divID).hide();
			continue;
		}
		if(totalPage == currentPage){
			$('#'+divID).show();
		}else{
			$('#'+divID).hide();
		}
	}
	$('span[name="currentPage"]').html(currentPage);
	$('span[name="totalPage"]').html(totalPage);
}
/**
 * 删除
 */
function deleteQuestion(index){
	var questions = eval("("+($('#questions').val())+")");
	questions[index].fdQuestionDef = "delete";
	//questions = arrayDel(questions,index)
	$('#questions').val(JSON.stringify(questions));
	preview_init(questions);
}
/**
 * 题目编辑之后重新设置题型定义的值
 */
function setFdQuestionDef(fdQuestionDef,index){
	var questions = eval("("+($('#questions').val())+")");
	questions[index].fdQuestionDef = JSON.stringify(fdQuestionDef);
	var subject = $("<div></div>").append(fdQuestionDef.subject).text();
	questions[index].fdTitle = subject;
	$('#questions').val(JSON.stringify(questions));
}
//保存操作重新设置相关变量的值
function save(){
	var obj = window.dialogArguments;
	var questions = document.getElementById("questions");
	 obj.value = questions.value;
	window.close();
}
function arrayDel(arr,n) {  	
	  if(n<0)  
	    return arr;
	  else
	    return arr.slice(0,n).concat(arr.slice(n+1,arr.length));	    
}

function getContextPath(){
	return "${KMSS_Parameter_ContextPath}";
}
function hideTooltip()
{
	var divObj = document.getElementById("dHTMLToolTip");
	divObj.style.visibility="hidden"
	divObj.style.left = 1;
	divObj.style.top = 1;
	return false
}
function showTooltip(e, tipContent)
{
	//window.clearTimeout(tipTimer);
	var divObj = document.getElementById("dHTMLToolTip");
	
	divObj.style.top=document.body.scrollTop+event.clientY+15
	divObj.innerHTML='<img src="'+tipContent+'">';
	
	if ((e.x + divObj.clientWidth) > (document.body.clientWidth + document.body.scrollLeft)){
		divObj.style.left = (document.body.clientWidth + document.body.scrollLeft) - divObj.clientWidth-10;
	}else{
		divObj.style.left=document.body.scrollLeft+event.clientX
	}
	divObj.style.visibility="visible"
	//tipTimer=window.setTimeout("hideTooltip('"+divId+"')", displaytime);
	return true;	
}
</script>
<DIV id="dHTMLToolTip" 
style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
</DIV>
<%@ include file="/resource/jsp/edit_down.jsp"%>