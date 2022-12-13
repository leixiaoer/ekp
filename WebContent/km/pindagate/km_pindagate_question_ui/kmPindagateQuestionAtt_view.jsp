<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.KmssMessageWriter,com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" >
	<template:replace name="body">
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
				<tr>
					<td><%= msgWriter.DrawTitle() %><br style="font-size:10px"><%= msgWriter.DrawMessages() %></td>
				</tr>
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
								<c:param name="fdModelName"	value="com.landray.kmss.km.pindagate.model.KmPindagateMain"/>
							</c:import>
						</td>
					</tr>
				</table>
			</html:form>
		</center>
		<script type="text/javascript"> 
			Com_IncludeFile("jquery.js");
			//自适应高度
			/* $(document).ready(function(){
				var frame = parent.document.getElementById("attFrame");
				if(frame &&frame.contentWindow){
					if(frame.height != frame.contentWindow.document.body.scrollHeight){
						frame.height = frame.contentWindow.document.body.scrollHeight+10;	
					}
				}
			}); */
			function dyniframesize(){
				var frame = getthisIframe();
				if(frame && frame.contentWindow){
					if(frame.height != frame.contentWindow.document.body.scrollHeight){
						frame.height = frame.contentWindow.document.body.scrollHeight+10;	
					}
				}
				//setTimeout("dyniframesize()", 5000);
			}
			function getthisIframe(){
				var iframe,
					iframes = $('iframe',parent.document),
					body = $('body')[0];
				iframes.each(function(){
			        if(body.ownerDocument === this.contentWindow.document) {
			            iframe = this;
			        }
			        return !iframe;
			    });
				return iframe;
			}
			
			//window.setTimeout(dyniframesize,200);
			window.setInterval(dyniframesize,500);
			
		</script>
	</template:replace>
</template:include>