<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.TagUtils,java.util.*"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ page import="
	com.landray.kmss.util.KmssMessageWriter,
	com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js", null, "js");
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
<script type="text/javascript"> 
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("doclist.js|docutil.js|optbar.js|jquery.js|json2.js|jquery.form.js|rightmenu.js");
function adjustHeight(){
	var frame = parent.document.getElementById("attFrame");
	if(frame.contentWindow){
		if(frame.height != frame.contentWindow.document.body.scrollHeight){
			frame.height = frame.contentWindow.document.body.scrollHeight;	
		}
	}
}
</script>
<center>
<html:form action="/km/pindagate/km_pindagate_question/kmPindagateQuestion.do">
<table id="TABLE_DocList" class="tb_normal" onresize="adjustHeight();" width=100%>
	<tr>
		<td
			class="td_normal_title"
			width=15%>
			<bean:message
			bundle="km-pindagate"
			key="kmPindagateQuestion.attachment" />
		</td>
		<td colspan="3">
			<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="fdAttType" value="byte" />
				<c:param name="fdMulti" value="true" />
				<c:param name="fdKey" value="questionAtt" />
				<c:param name="formBeanName" value="kmPindagateQuestionForm" />
			    <c:param name="fdModelName"	value="com.landray.kmss.km.pindagate.model.KmPindagateMain"/>
			    <c:param name="fdModelId" value="${kmPindagateMainFdId}" />
			    <c:param name="fdSupportLarge" value="false"></c:param>
			</c:import>
		</td>
	</tr>
</table>
</html:form>
</center>
</body>
</html>
