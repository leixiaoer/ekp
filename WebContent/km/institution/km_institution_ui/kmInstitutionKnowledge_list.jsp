<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"%>
<%@ page import="com.landray.kmss.km.institution.util.AbolishUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<list:data>
	<list:data-columns var="kmInstitutionKnowledge" list="${queryPage.list }" varIndex="status">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--序号--%>
		<list:data-column col="index">${status+1 }</list:data-column>
		<%--主题--%>
		<list:data-column col="docSubject" escape="false" title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
			<span class="com_subject"><c:out value="${kmInstitutionKnowledge.docSubject}"></c:out></span>
		</list:data-column>
		<!-- 主题摘要视图-->
		<list:data-column col="row_docSubject" escape="false"  title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
			<c:if test="${kmInstitutionKnowledge.fdIsTop==true}">
					<i class="lui_article_status_top_border lui_article_status_top"><bean:message key="kmInstitutionKnowledge.fdIsTop" bundle="km-institution"/></i>
		       </c:if>
		    <span title="<c:out value="${kmInstitutionKnowledge.docSubject}"></c:out>">
		      <c:out value="${kmInstitutionKnowledge.docSubject}"></c:out> 
		    </span>  
		</list:data-column>
		<%--文件编号--%>
		<list:data-column headerStyle="width:120px;" property="fdNumber" title="${ lfn:message('km-institution:kmInstitution.fdNumber') }">
		</list:data-column>
		<%--文档状态--%>
		<list:data-column col="status">${kmInstitutionKnowledge.docStatus}</list:data-column>
		<list:data-column col="docStatus" headerStyle="width:80px;"  title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus') }">
			<sunbor:enumsShow value="${kmInstitutionKnowledge.docStatus}" enumsType="kmInstitutionKnowledge_docStaus" />
		</list:data-column>
			<%--文档类型--%>
		<%-- <list:data-column  col="docType" title="${ lfn:message('km-institution:kmInstitution.docType')}" escape="false">
			<c:out value="${kmInstitutionKnowledge.docType}"/>
		</list:data-column> --%>
		<%--所属部门--%>
		<list:data-column headerStyle="width:120px;" property="docDept.fdName" title="${ lfn:message('sys-doc:sysDocBaseInfo.docDept') }">
		</list:data-column>
		<%--录入人--%>
		<list:data-column headerStyle="width:120px;"  col="docCreator" title="${ lfn:message('sys-doc:sysDocBaseInfo.docCreator') }" escape="false">
			<ui:person personId="${kmInstitutionKnowledge.docCreator.fdId}" personName="${kmInstitutionKnowledge.docCreator.fdName}"></ui:person>
		</list:data-column>
		<%--发布时间--%>
		<list:data-column  headerStyle="width:120px;" col="docPublishTime" title="${ lfn:message('km-institution:kmInstitution.docPublishTime') }">
			<kmss:showDate value="${kmInstitutionKnowledge.docPublishTime}" type="date" />
		</list:data-column>
		<!-- 是否置顶-->
	    <list:data-column headerStyle="width:60px" col="fdTopDays" escape="false" title="${ lfn:message('km-institution:kmInstitutionKnowledge.fdIsTop') }">       
		       <c:if test="${kmInstitutionKnowledge.fdIsTop==true}">
					<i class="lui_article_status_top_border lui_article_status_top"><bean:message key="kmInstitutionKnowledge.fdIsTop" bundle="km-institution"/></i>
		       </c:if>
		</list:data-column>	
		<%--失效时间--%>
		<list:data-column  headerStyle="width:120px;" col="fdAbolishTime" title="${ lfn:message('km-institution:kmInstitution.fdAbolishTime') }">
			<kmss:showDate value="${kmInstitutionKnowledge.fdAbolishTime}" type="date" />
		</list:data-column>
		<%--过期时间--%>
		<list:data-column  headerStyle="width:120px;" col="fdOverdue" title="${ lfn:message('km-institution:kmInstitution.fdOverdue') }">
			<kmss:showDate value="${kmInstitutionKnowledge.fdOverdue}" type="date" />
		</list:data-column>
		<%--录入时间--%>
		<list:data-column  headerStyle="width:120px;" col="docCreateTime" title="${ lfn:message('km-institution:kmInstitutionKnowledge.docCreateTime') }">
			<kmss:showDate value="${kmInstitutionKnowledge.docCreateTime}" type="datetime" />
		</list:data-column>
		<%--最后修改时间--%>
		<list:data-column  headerStyle="width:120px;" col="docAlterTime" title="${ lfn:message('sys-doc:sysDocBaseInfo.docAlterTime') }">
			<kmss:showDate value="${kmInstitutionKnowledge.docAlterTime}" type="datetime" />
		</list:data-column>
		<%--失效链接--%>
		<list:data-column  headerStyle="width:120px;" col="fdAbolishLink" title="${ lfn:message('km-institution:kmInstitution.fdAbolishLink') }" escape="false">
			<%
				String abolishId = null;
				KmInstitutionKnowledge knowledge = (KmInstitutionKnowledge)pageContext.getAttribute("kmInstitutionKnowledge");
				if("50".equals(knowledge.getDocStatus())) {
					abolishId = AbolishUtil.getAbolishId(knowledge);
				}
			%>
			<% if(abolishId != null) { %>
			<a class="btn_txt" href="javascript:void(0);" onclick="window.open('${LUI_ContextPath}/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=view&fdId=<%=abolishId%>')">${ lfn:message('km-institution:tree.abolish.kmdoc') }</a>
			<% } else { %>
			<a class="btn_txt" href="javascript:void(0);" onclick="alert('${ lfn:message('km-institution:kmInstitution.fdAbolish.noExisted') }');">${ lfn:message('km-institution:tree.abolish.kmdoc') }</a>
			<% } %>
		</list:data-column>
		<%--发布时间摘要视图--%>
		<list:data-column headerStyle="width:80px" col="docPublishTime_row" title="${ lfn:message('km-institution:kmInstitution.docPublishTime') }" escape="false">
		   <c:if test="${not empty kmInstitutionKnowledge.docPublishTime}">
		    ${ lfn:message('km-institution:kmInstitution.docPublishTime') }：<kmss:showDate value="${kmInstitutionKnowledge.docPublishTime}" type="date" /> 
		    </c:if>
		</list:data-column>
		<%--内容,用于摘要试图--%>
		<list:data-column headerStyle="width:115px" property="docContent" title="内容" escape="false">
		</list:data-column>
		<%--标签,用于摘要试图--%>
		<list:data-column headerStyle="width:80px"  col="fdTagNames" title="${lfn:message('km-institution:kmInstitutionKnowledge.fdTagNames') }" escape="false">
			<c:if test="${not empty tagJson[kmInstitutionKnowledge.fdId] }">
	       	${lfn:message('km-institution:kmInstitutionKnowledge.fdTagNames') }：${tagJson[kmInstitutionKnowledge.fdId]}
	       	</c:if>
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>