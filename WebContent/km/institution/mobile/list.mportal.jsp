<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.util.*,com.landray.kmss.km.institution.util.EmojiUtil"%>
<list:data>
	<list:data-columns var="model" list="${queryPage.list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
	    <%-- 主题--%>	
		<list:data-column col="label" escape="false" title="${ lfn:message('km-institution:kmInstitution.docSubject') }">
			<c:out value="${model.docSubject}"/>
		</list:data-column>
      	<%-- 发布时间--%>
      	<list:data-column col="created" title="${ lfn:message('sys-notify:sysNotifyTodo.fdCreateDate') }">
	        <kmss:showDate value="${model.docPublishTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		      /km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=${model.fdId}
		</list:data-column>
		<list:data-column col="creator" escape="false">
		     <c:out value="${model.docDept.fdName}"/>
		</list:data-column>
		
		<c:if test="${model.docStatus=='30' ||model.docStatus=='40'}">
			<list:data-column col="otherText" escape="false">
		       <c:out value="${model.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>