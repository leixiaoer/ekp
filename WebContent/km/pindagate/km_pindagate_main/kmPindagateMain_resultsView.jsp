<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<link href="${KMSS_Parameter_ContextPath}km/pindagate/pindagate.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
Com_IncludeFile("jquery.js|json2.js|vbar.js|circle.js");

function showMaskLayer(divDialog,divDialogContent,dialogContent,isDispaly){ 
	if(isDispaly)
		$("#"+divDialog).css({display:"block"});
	else
		$("#"+divDialog).css({display:"none"});
	$("#"+divDialogContent).html(dialogContent); 
}

</script>
<script type="text/javascript" src='<c:url value="/km/pindagate/resource/progress.js"/>'></script>
<kmss:windowTitle
			subjectKey=""
			moduleKey="km-pindagate:table.kmPindagateMain" />
<!-- 提示信息 -->
<div id="dialog"> 
	<div id="dialog_content"></div> 
</div> 

<script>
	var dialogContent = "<div style='text-align:center;vertical-align: middle'><img src='${KMSS_Parameter_StylePath}icons/loading.gif' border='0'><bean:message bundle='km-pindagate' key='kmPindagateResponse.loading'/></div>";
	showMaskLayer('dialog','dialog_content',dialogContent);//显示遮罩层
</script>
<div class="pi_container">
<div class="pi_box">
	<div class="pi_content" id="Div_Statistic_Questions" >
		<input type="hidden" id="fdParticipantNum" value="${kmPindagateMainForm.fdParticipantNum}">
		<c:if test="${canViewResult}" >
		<%int serialNum = 0; %>
		<c:forEach items="${kmPindagateMainForm.fdItems}" var="kmPindagateQuestionForm" varStatus="vstatus">
			<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
				<% serialNum++; %>
			</c:if>
			<div id="questions${vstatus.index}">
				<input type="hidden" id="fdQuestionDef${vstatus.index}" value="${kmPindagateQuestionForm.fdQuestionDefView}" >
				<input type="hidden" id="fdStatistic${vstatus.index}" value="${kmPindagateQuestionForm.fdStatisticView}" >
				<input type="hidden" id="fdType${vstatus.index}" value="${kmPindagateQuestionForm.fdType}">
				<input type="hidden" id="fdSplit${vstatus.index}" name="fdSplit"  value="${kmPindagateQuestionForm.fdSplit}">
				<input type="hidden" id="serialNum${vstatus.index}" value="<%=serialNum%>">
				<input type="hidden" id="fdTitle${vstatus.index}" value="${kmPindagateQuestionForm.fdName}">
				<input type="hidden" id="quesTypeName${vstatus.index}" value="${kmPindagateQuestionForm.fdTypeName}">
				<input type="hidden" id="questionId${vstatus.index}" value="${kmPindagateQuestionForm.fdId}">
				<c:if test="${kmPindagateQuestionForm.fdSplit != 'true'}">
				<c:import url="/${kmPindagateQuestionForm.resultsViewUrl}" charEncoding="UTF-8">
					<c:param name="index" value="${vstatus.index}" />
					<c:param name="divId" value="${kmPindagateQuestionForm.fdType}${vstatus.index}" />
				</c:import>
				</c:if>
			</div>
		</c:forEach>
		</c:if>
	</div>
</div>
</div>
<!-- 按钮面板 start -->
<div id="rigimg" style="position:absolute;right:0px;top:104px;width:188px">
	<div id="toolControl" class="toolControlBlock" onclick="toolControl('rigimg', 'toolControl', 'toolControlBut','188px');"><span><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.control1"/><br /><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.control2"/></span></div>
	<div id="toolControlBut" style="display:block">
		<div style="border:1px solid #fff">
			<ul>
				<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=viewProperties&fdId=${kmPindagateMainForm.fdId}">
					<li class="butGreen"><a href="<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=view&fdId=${kmPindagateMainForm.fdId}" target="_blank"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.quesProperty"/></a></li>
				</kmss:auth>
				<c:if test="${isShow==true }">
					<li class="butGreen"><a href="#" onclick="window.open('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=viewIndagatePersonInfo&fdId=${kmPindagateMainForm.fdId}');"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.participantsInfo"/></a></li>
				</c:if>
				<li class="butGreen"><a href="#" onclick="window.open('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=resultsView&fdId=${kmPindagateMainForm.fdId}&forward=dataAnalysis');"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.surveyDataAnalysis"/></a></li>
				<c:if test="${isShow==true }">
					<li class="butGreen"><a href="#" onclick="window.open('<c:url value="/km/pindagate/km_pindagate_response/kmPindagateResponse.do" />?method=resultsDetail&fdMainId=${kmPindagateMainForm.fdId}');"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.analysisResponses"/></a></li>
				</c:if>
				<li class="butGreen"><a href="<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=exportResultExcel&fdId=${kmPindagateMainForm.fdId}"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.export"/></a></li>
				<li class="cTop"><a href="#" onclick="window.close();"><bean:message key="button.close"/></a></li>
			</ul>
		</div>
	</div>
</div>
<!-- 按钮面板 end -->
<script language="javascript">window.setInterval("heartBeat()",1);</script>
<DIV id="dHTMLToolTip" 
style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px">
</DIV>
<%@ include file="/resource/jsp/edit_down.jsp"%>
<script type="text/javascript">
/**
 * 题型定义数组（每个题型的题型定义的属性名跟questiontype包下面各个题型的QuestionType类里面的属性相对应）
 * 例如：单选题的fdQuestionDef.willAnswer 对应 SingleSelectType类里面的willAnswer属性
 */
var fdQuestionDef = new Array();
/**
 * 统计结果定义数组
 *
 */
var fdStatistic = new Array();
$(document).ready(function (){
	if("${canViewResult}" == "false"){
		var dialogContent = "<div style='text-align:center;vertical-align: middle'><img src='${KMSS_Parameter_StylePath}icons/alerts.gif' height='14px' width='14px' border='0'>&nbsp;<bean:message bundle="km-pindagate" key="kmPindagateMain.not.participation"/></div>";
		showMaskLayer('dialog','dialog_content',dialogContent);//显示遮罩层
		return;
	}
	var txttitle = '<p class="txttitle" style="border-bottom: 1px solid #EBF1F7;width: 98%;padding-bottom: 12px;padding-top: 20px;position:relative;">';
	
	txttitle += getParticipantNumHtml();
	txttitle += getPageHtml();
	txttitle += getPageButtonHTML();
	txttitle += '${kmPindagateMainForm.docSubject}';
	txttitle += '<br><br><br></p>';
	
	$('#Div_Statistic_Questions').prepend(txttitle);

	var bottomDiv = '<p style="width: 98%;position:relative;height: 16px;text-align: center;">';
	bottomDiv += getPageHtml();
	bottomDiv += getPageButtonHTML();
	bottomDiv += '</p>';
	$('#Div_Statistic_Questions').append(bottomDiv);
	changePage();
	showMaskLayer('dialog','dialog_content','',false);
	<c:if test="${kmPindagateMainForm.docStatus=='31'}">
		alert('<bean:message bundle="km-pindagate" key="kmPindagateQuestion.alert"/>');
	</c:if>
});
/**
 * 返回页数HTML
 */
function getPageHtml(){
	var pageNumHTML = '<span style="position:absolute;left:0px;bottom:0px;font-size: 11px;font-weight: normal;"><bean:message key="page.the"/>&nbsp;<span name="currentPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;';
	pageNumHTML += '<bean:message key="page.total"/>&nbsp;<span name="totalPage">1</span>&nbsp;<bean:message key="page.page"/>&nbsp;&nbsp;</span>';
	return pageNumHTML;
}
//返回总调查人数
function getParticipantNumHtml(){
	var participantNumHtml = '<span style="position:absolute;center:0px;bottom:20px;font-size: 11px;font-weight: normal;"><bean:message bundle="km-pindagate" key="kmPindagateQuestionRes.participantNum"/>'+$("#fdParticipantNum").val()+'</span>';
	return participantNumHtml
}

function getPageButtonHTML(){
	var pageButtonHTML = '<span style="position:absolute;right:0px;bottom:0px;">';
	pageButtonHTML += '<input type="button" class="btnopt" value="<bean:message key="page.prev"/>" onclick="changePage(\'prev\');">&nbsp;&nbsp;&nbsp;&nbsp;';
	pageButtonHTML += '<input type="button" class="btnopt" value="<bean:message key="page.next"/>" onclick="changePage(\'next\');">';
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
function changePage(_method){
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
	var index = 0;
	$('input[name="fdSplit"]').each(function (){
		divID = "questions"+index;
		
		if(this.value == "true"){
			totalPage++;
			$('#'+divID).hide();
		}else{
			if(totalPage == currentPage){
				if(pagesInit.get(index)!=true)
				{
					window.eval('function_'+index+'();');
					pagesInit.put(index,true);
				}
				$('#'+divID).show();
			}else{
				$('#'+divID).hide();
			}
		}
		index++;
	});
	$('span[name="currentPage"]').html(currentPage);
	$('span[name="totalPage"]').html(totalPage);
}
lastScrollY=0;
function heartBeat(){ 
	var diffY;
	if (document.documentElement && document.documentElement.scrollTop){
		diffY = document.documentElement.scrollTop;
	}else if (document.body){
		diffY = document.body.scrollTop
	}
	percent=.1*(diffY-lastScrollY); 
	if(percent>0){
		percent=Math.ceil(percent); 
	}else{
		percent=Math.floor(percent);
	}
	document.getElementById("rigimg").style.top=parseInt(document.getElementById("rigimg").style.top)+percent+"px";
	lastScrollY=lastScrollY+percent; 
}
function toolControl(mainObjId, toolObjId, butObjId, mainWidth){
	var mainObj = document.getElementById(mainObjId);
	var butObj = document.getElementById(butObjId);
	var toolObj = document.getElementById(toolObjId)
	var butBoxDisplay = butObj.style.display;
	var butBoxWidth = butObj.style.width;
	if(butBoxDisplay == "block"){
		butObj.style.display="none";
		toolObj.className="toolControlNone";
		mainObj.style.width=butBoxWidth;
	}else{
		butObj.style.display="block";
		toolObj.className="toolControlBlock";
		mainObj.style.width=mainWidth;
	}
}
function openWin(url){
	var obj = new Object;
	obj.totalNum = $("#fdParticipantNum").val();
	//obj.participateNum = "${alreadyNames}".split(";").length;
	//obj.notInvolvedNum = "${absentNames}".split(";").length;
	//obj.participateList = "${alreadyNames}".replace(/;/g,"; ");
	//obj.notInvolvedList = "${absentNames}".replace(/;/g,"; ");
	window.showModalDialog(url, obj,"dialogWidth=600px;dialogHeight=500px");
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
<!--[if IE]><script type="text/javascript" src="${KMSS_Parameter_ResPath}js/excanvas.js"></script><![endif]-->