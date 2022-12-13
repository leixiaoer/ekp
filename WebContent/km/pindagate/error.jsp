<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<script>
	Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
	Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
</script>
</head>
<BODY style="margin-left:10px">
<br><br>
<table align=center>
	<tr>
		<td><img src="${KMSS_Parameter_StylePath}icons/blank.gif" height=1 width=20></td>
		<td>
			<table width=400 border=0 cellspacing=1 cellpadding=0 bgcolor=#000033>
				<tr> 
					<td height=18 class=barmsg><bean:message key="return.systemInfo"/></td>
				</tr>
				<tr>
					<td>
						<table bgcolor="#FFFFFF" border=0 cellspacing=0 cellpadding=0 width=100%>
							<tr>
								<td width=20><img src="${KMSS_Parameter_StylePath}icons/blank.gif" height=1 width=20></td>
								<td>
									<br><bean:message key="return.title"/><br>
									<br style="font-size:10px;">
									<font style="color: red;font-weight: bold;">
										${min}<bean:message bundle="km-pindagate" key="kmPindagateResponse.error.part1"/>
										<bean:message bundle="km-pindagate" key="kmPindagateResponse.error.part2"/>
									</font>
									<br><br>
									<div align=center>
										<input type="button" value='<bean:message bundle="km-pindagate" key="kmPindagateResponse.button.viewLastResult"/>' class="btnopt" onclick="Com_OpenWindow('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=resultsView&fdId=${kmPindagateMainForm.fdId}','_self');">
										<input type="button" value='<bean:message key="button.close"/>' class="btnopt" onclick="Com_CloseWindow();">
									</div>
									<br style="font-size:10px">
								</td>
								<td width=20><img src="${KMSS_Parameter_StylePath}icons/blank.gif" height=1 width=20></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
		<td><img src="${KMSS_Parameter_StylePath}icons/blank.gif" height=1 width=20></td>
	</tr>
</table>
<br><br>
</BODY>
</html>