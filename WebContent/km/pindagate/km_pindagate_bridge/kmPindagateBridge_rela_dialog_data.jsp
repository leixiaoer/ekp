<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<%--
docSubject;docStatus;kmPindagateTemplate.fdName;docFinishedTime
 --%>
<list:data>
	<list:data-columns var="kmPindagateMain" list="${queryPage.list }">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--主题--%>
		<list:data-column col="docSubject" escape="false"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docSubject') }"
			style="text-align:left">
			<span class="com_subject"><c:out value="${kmPindagateMain.docSubject}"></c:out></span>
		</list:data-column>
		<%--文档状态--%>
		<list:data-column headerStyle="width:100px" col="docStatus"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docStatus') }">
			<sunbor:enumsShow value="${kmPindagateMain.docStatus}"
				enumsType="kmPindagate_status" />
		</list:data-column>
		<%--所属模板--%>
		<list:data-column headerStyle="width:180px;"
			property="kmPindagateTemplate.fdName"
			title="${ lfn:message('km-pindagate:kmPindagateMain.template') }">
		</list:data-column>
		<%--调查结束时间--%>
		<list:data-column headerStyle="width:150px;" col="docFinishedTime"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docFinishedTime') }">
			<c:if test="${not empty  kmPindagateMain.docFinishedTime}">
				<kmss:showDate value="${kmPindagateMain.docFinishedTime}" />
			</c:if>
			<c:if test="${empty  kmPindagateMain.docFinishedTime}">
				<bean:message bundle="km-pindagate"
					key="kmPindagateMain.null.not.limit.time" />
			</c:if>
		</list:data-column>
		<%--调查开始时间--%>
		<list:data-column col="docStartTime"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docStartTime') }">
			<kmss:showDate value="${kmPindagateMain.docStartTime}" />
		</list:data-column>
		<list:data-column col="docPublishTime"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docPublishTime') }">
			<kmss:showDate value="${kmPindagateMain.docPublishTime}" type="date"/>
			<kmss:showDate value="${kmPindagateMain.docPublishTime}" type="time"/>
		</list:data-column>
		<%--更新时间--%>
		<list:data-column col="fdLastModifiedTime"
			title="${ lfn:message('km-pindagate:kmPindagateMain.fdLastModifiedTime') }">
			<kmss:showDate value="${kmPindagateMain.fdLastModifiedTime}" />
		</list:data-column>
		<%--录入时间--%>
		<list:data-column col="docCreateTime"
			title="${ lfn:message('km-pindagate:kmPindagateMain.docCreateTime') }">
			<kmss:showDate value="${kmPindagateMain.docCreateTime}" />
		</list:data-column>
		<%--调查类型--%>
		<list:data-column col="fdPindagateType"
			title="${ lfn:message('km-pindagate:kmPindagateMain.fdPindagateType')}"
			escape="false">
			<c:if test="${kmPindagateMain.fdPindagateType eq 'normal' }">
				<bean:message bundle="km-pindagate" key="kmPindagateMain.normal" />
			</c:if>
			<c:if test="${kmPindagateMain.fdPindagateType eq 'code' }">
				<bean:message bundle="km-pindagate" key="kmPindagateMain.code" />
			</c:if>
		</list:data-column>
		
		<list:data-column 
			headerClass="width100" col="operations" 
			title="${ lfn:message('km-pindagate:kmPindagateMain.qrcode') }"
			escape="false">
			<!--二维码查看-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<a class="btn_txt" style="color:#4285f4;"
						target="_blank"
						href="${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=view&fdId=${kmPindagateMain.fdId}">${lfn:message('km-pindagate:kmPindagateResponse.view')} </a>
				</div>
			</div>
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>

</list:data>