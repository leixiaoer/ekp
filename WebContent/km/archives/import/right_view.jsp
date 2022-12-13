<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<c:set var="rightForm" value="${requestScope[param.formName]}" />
<ui:content title="${ lfn:message('sys-right:right.moduleName') }">
	<table class="tb_normal" width=100%>
		<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
             <c:param name="formName" value="kmArchivesMainForm" />
             <c:param name="moduleModelName" value="com.landray.kmss.km.archives.model.KmArchivesMain" />
         </c:import>
		<tr>
			<td class="td_normal_title" width="15%">
				<bean:message bundle="km-archives" key="kmArchivesMain.authFileReaders" />
			</td>
			<td width="85%">
				<c:if test="${not empty rightForm.authFileReaderNames}">
					${rightForm.authFileReaderNames}
				</c:if>
			</td>
		</tr>
	</table>
</ui:content>
