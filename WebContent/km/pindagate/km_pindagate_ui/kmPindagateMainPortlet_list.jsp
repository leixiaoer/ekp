<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateMain" list="${queryPage.list }">
		<%--ID--%>
		<list:data-column  property="fdId" ></list:data-column>
		
		<%--主题--%>
		<list:data-column  col="docSubject" title="${ lfn:message('km-pindagate:kmPindagateMain.docSubject') }"   style="text-align:left" escape="false">
			<a class="com_subject textEllipsis" title="${kmPindagateMain.docSubject}" href="${LUI_ContextPath}/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId=${kmPindagateMain.fdId}" target="_blank">
			  <c:out value="${kmPindagateMain.docSubject}"/>
			</a>
		</list:data-column>
		
		<%--文档状态--%>
		<list:data-column  headerClass="width80" styleClass="width80" col="docStatus" title="${ lfn:message('page.state') }">
				<sunbor:enumsShow value="${kmPindagateMain.docStatus}" enumsType="kmPindagate_status" />
		</list:data-column>
		
		<%--调查开始时间--%>
		<list:data-column headerClass="width120" styleClass="width120" property="docStartTime" title="${ lfn:message('km-pindagate:kmPindagateMain.docStartTime') }">
		</list:data-column>
		
		<%--调查结束时间--%>
		<list:data-column headerClass="width120" styleClass="width120"  col="docFinishedTime" title="${ lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }">
			<c:if test="${not empty  kmPindagateMain.docFinishedTime}">
				<kmss:showDate value="${kmPindagateMain.docFinishedTime}" />
			</c:if>
			<c:if test="${empty  kmPindagateMain.docFinishedTime}">
				<bean:message bundle="km-pindagate" key="kmPindagateMain.null.not.limit.time" />
			</c:if>
		</list:data-column>
		
		
	</list:data-columns>
</list:data>