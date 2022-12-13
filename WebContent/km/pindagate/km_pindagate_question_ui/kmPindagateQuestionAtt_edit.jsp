<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.KmssMessageWriter,com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/common.jsp"%>
<template:include ref="default.simple" >
	<template:replace name="body"> 
		<style>
			.upload_list_status,.upload_list_size{
				width: 65px!important;
			}
		</style>
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
		<html:form action="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do">
			<table id="TABLE_DocList" class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-pindagate" key="kmPindagateQuestion.attachment" />
					</td>
					<td colspan="3">
						<c:set var="modelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain"/>
						<c:if test="${param.isTemp=='1'}">
							<c:set var="modelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMainTemp"/>
						</c:if>
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
							<c:param name="fdAttType" value="byte" />
							<c:param name="fdMulti" value="true" />
							<c:param name="fdKey" value="questionAtt" />
							<c:param name="formBeanName" value="kmPindagateQuestionForm" />
						    <c:param name="fdModelName"	value="${modelName}"/>
						    <c:param name="fdModelId" value="${kmPindagateMainFdId}" />
						    <c:param name="fdSupportLarge" value="false"></c:param>
						</c:import>
					</td>
				</tr>
			</table>
		</html:form>
	</template:replace>
</template:include>
<script type="text/javascript"> 
	seajs.use(['theme!form']);
	Com_IncludeFile("jquery.js");
	//自适应高度
	//$(document).ready(function(){
	//	dyniframesize();
	//});
	//$(document).resize(dyniframesize);
	//window.onload=dyniframesize;
	//window.onresize=dyniframesize;
	function dyniframesize(){
		var frame = parent.document.getElementById("attFrame");
		if(frame && frame.contentWindow){
			if(frame.height != frame.contentWindow.document.body.scrollHeight){
				frame.height = frame.contentWindow.document.body.scrollHeight+10;	
			}
		}
		//setTimeout("dyniframesize()", 5000);
	}
	//window.setTimeout(dyniframesize,200);
	window.setInterval(dyniframesize,500);
</script>