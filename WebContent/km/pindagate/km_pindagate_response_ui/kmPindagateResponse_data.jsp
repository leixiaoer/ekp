<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateResponse" list="${queryPage.list }">
		<%--ID--%>
		<list:data-column  property="fdId" ></list:data-column>
		<%--主题--%>
		<list:data-column  property="fdQuetionair.docSubject" title="${ lfn:message('km-pindagate:kmPindagateResponse.fdQuetionair') }"   style="text-align:left" escape="false">
		</list:data-column>
		<%--创建时间--%>
		<list:data-column  col="fdCreateTime" title="${ lfn:message('km-pindagate:kmPindagateResponse.fdCreateTime') }">
			<kmss:showDate value="${kmPindagateResponse.fdCreateTime}" />
		</list:data-column>
		<%--创建者--%>
		<list:data-column  property="docCreator.fdName" title="${ lfn:message('km-pindagate:kmPindagateResponse.docCreator') }">
		</list:data-column>
	</list:data-columns>
</list:data>