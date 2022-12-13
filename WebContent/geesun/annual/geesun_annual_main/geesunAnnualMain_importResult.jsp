<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<link rel="stylesheet" href="<c:url value="/geesun/annual/resource/budget.css"/>" />
<script type="text/javascript">
Com_IncludeFile("jquery.js");
</script>
<script type="text/javascript" src="<c:url value="/geesun/annual/resource/js/jquery.corner.js"/>"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#div_main").corner("destroy");
	$("#div_main").corner("13px");
});
function FS_ToggleNextELment(_this){
	$(_this).next().toggle();
	var arrow = $(_this).find("#arrow");
	if("︽" == arrow.text()){
		arrow.text("︾");
	}else if("︾" == arrow.text()){
		arrow.text("︽");
	}
}
</script><br>
<center>
<p class="FS_TxtTitle">导入结果</p>
<div id="div_main" class="FS_MsgDivMain">
	<c:forEach items="${messageList}" var="importMessage" varStatus="vstatus">
	<c:if test="${importMessage.messageType eq '0'}">
		<div class="FS_MsgFailDiv" >
			<div onclick="FS_ToggleNextELment(this)">
				<span class="FS_MsgFailSpan"></span>
				<label style="width: 93%">${importMessage.message}</label>
				<span id="arrow"><c:if test="${fn:length(importMessage.moreMessages)>0}">︽</c:if></span>
			</div>
			<table>
				<c:forEach items="${importMessage.moreMessages}" var="message" varStatus="vstatus2">
				<tr>
					<td>${vstatus2.index+1}、${message}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<c:if test="${importMessage.messageType eq '1'}">
		<div class="FS_MsgFailDiv" >
			<div onclick="FS_ToggleNextELment(this)">
				<span class="FS_MsgFailSpan"></span>
				<label style="width: 93%">${importMessage.message}</label>
				<span id="arrow"><c:if test="${fn:length(importMessage.moreMessages)>0}">︽</c:if></span>
			</div>
			<table>
				<c:forEach items="${importMessage.moreMessages}" var="message" varStatus="vstatus2">
				<tr>
					<td>${vstatus2.index+1}、${message}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	<c:if test="${importMessage.messageType eq '2'}">
		<div class="FS_MsgSuccessDiv" >
		<div onclick="FS_ToggleNextELment(this)">
			<span class="FS_MsgSuccessSpan"></span>
			<label>${importMessage.message}</label>
			<span id="arrow"><c:if test="${fn:length(importMessage.moreMessages)>0}">︽</c:if></span>
		</div>
			<table style="display: none;">
				<c:forEach items="${importMessage.moreMessages}" var="message" varStatus="vstatus2">
				<tr>
					<td>${vstatus2.index+1}、${message}</td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
	</c:forEach>
</div>
</center>
<%@ include file="/resource/jsp/list_down.jsp"%>