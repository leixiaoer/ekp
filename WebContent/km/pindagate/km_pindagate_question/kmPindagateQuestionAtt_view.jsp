<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,java.util.*"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ page import="com.landray.kmss.util.KmssMessageWriter,com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js", null, "js");
</script>
<script type="text/javascript">
window.setInterval(function(){
	if(window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
		if(window.frameElement.height != document.getElementById("TABLE_DocList").scrollHeight+10){
			window.frameElement.height = document.getElementById("TABLE_DocList").scrollHeight+10;
		}
	}
},200);
</script>
</head>
<body>
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
<script type="text/javascript">
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
	<table align=center>
		<tr><td>
			<%= msgWriter.DrawTitle() %>
			<br style="font-size:10px">
			<%= msgWriter.DrawMessages() %>
		</td></tr>
	</table>
	<% } %>
	<center>
		<html:form action="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do">
		<table id="TABLE_DocList" class="tb_normal" width=95% >
			<tr>
				<td>
					<bean:message key="kmPindagateMain.attachment" bundle="km-pindagate"/>
				</td>
				<td colspan="3">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="questionAtt" />
						<c:param name="formBeanName" value="kmPindagateQuestionForm" />
					</c:import>
				</td>
			</tr>
		</table>
		</html:form>
	</center>
</body>
</html>
