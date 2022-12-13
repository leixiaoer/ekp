<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|dialog.js|treeview.js");			
</script>
<html:form action="/km/carmng/km_carmng_application/kmCarmngApplication.do" >
	
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt"><input type="checkbox" name="List_Tongle"></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmCarmngApplication.docSubject">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.docSubject"/>
				</sunbor:column>
				<td>
					<bean:message  bundle="km-carmng" key="kmCarmng.fdUseTime"/>
				</td>	
				<sunbor:column property="kmCarmngApplication.fdUserNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdUserNumber"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngApplication" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do" />?method=view&fdId=${kmCarmngApplication.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngApplication.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20" width="10%">
					<c:out value="${kmCarmngApplication.docSubject}" />
				</td>
				<td kmss_wordlength="40" width="30%"> <kmss:showDate value="${kmCarmngApplication.fdStartTime}" type="datetime"></kmss:showDate> <bean:message bundle="km-carmng" key="kmCarmng.message.title0"/> <kmss:showDate value="${kmCarmngApplication.fdEndTime}" type="datetime"></kmss:showDate> </td>
				<td width="5%">
					<c:out value="${kmCarmngApplication.fdUserNumber}" />
				</td>	
							
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>