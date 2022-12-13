<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<list:data>
    <list:data-columns var="kmSuperviseConcern" list="${queryPage.list}" varIndex="status">
        <list:data-column col="fdSuperviseId">
        	${kmSuperviseConcern.fdSupervise.fdId}
        </list:data-column>
        <list:data-column col="index">
            ${status+1}
        </list:data-column>

        <list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSuperviseMain.docSubject')}" >
        	<c:out value="${kmSuperviseConcern.fdSupervise.docSubject }" />
        </list:data-column>
        <list:data-column col="fdLead" title="${lfn:message('km-supervise:kmSuperviseMain.fdLead')}" >
        	<c:out value="${kmSuperviseConcern.fdSupervise.fdLead.fdName }" />
        </list:data-column>
        <list:data-column col="fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseConcern.fdSupervise.fdFinishTime }" type="datetime"/>
        </list:data-column>
        <list:data-column col="fdStatus" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}">
        	<c:choose>
        		<c:when test="${kmSuperviseConcern.fdSupervise.docStatus=='30' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.30" />
        		</c:when>
        		<c:when test="${kmSuperviseConcern.fdSupervise.docStatus=='40' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.40" />
        		</c:when>
        		<c:when test="${kmSuperviseConcern.fdSupervise.docStatus=='50' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.50" />
        		</c:when>
        		<c:otherwise>
        			<kmss:message bundle="km-supervise" key="enums.doc_status.20" />
        		</c:otherwise>
        	</c:choose>
        </list:data-column>
        <list:data-column col="fdSuperviseProgress" title="${lfn:message('km-supervise:kmSuperviseMain.fdSuperviseProgress')}" escape="false">
        	<style>
				.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;margin:auto;}
				.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
				.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
			</style>
			<c:choose>
				<c:when test="${empty kmSuperviseConcern.fdSupervise.fdSuperviseProgress}">
					0%
				</c:when>
				<c:otherwise>
					<c:out value="${kmSuperviseConcern.fdSupervise.fdSuperviseProgress}" />%
				</c:otherwise>
			</c:choose>
			<div class='pro_barline'>
				<c:if test="${kmSuperviseConcern.fdSupervise.fdSuperviseProgress=='100' }">
					<div class='complete' style="width:${kmSuperviseConcern.fdSupervise.fdSuperviseProgress}%"></div>
				</c:if>
				<c:if test="${empty kmSuperviseConcern.fdSupervise.fdSuperviseProgress }">
					<div class='uncomplete' style="width:0%"></div>
				</c:if>
				<c:if test="${not empty kmSuperviseConcern.fdSupervise.fdSuperviseProgress && kmSuperviseConcern.fdSupervise.fdSuperviseProgress!='100' }">
					<div class='uncomplete' style="width:${kmSuperviseConcern.fdSupervise.fdSuperviseProgress}%"></div>
				</c:if>
			</div>
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}">
            <kmss:showDate value="${kmSuperviseConcern.fdSupervise.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
