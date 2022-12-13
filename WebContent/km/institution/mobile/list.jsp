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
			<span class="muiComplexrTitle">
			<c:if test="${model.fdIsTop==true}"><span class="muiComplexrStatusBorder mui_ekp_km_doc_top" style="margin-top: 0.1rem;"><bean:message bundle="km-institution" key="kmInstitution.button.setTop"/></span></c:if>
			<c:out value="${model.docSubject}"/>
			</span>
		</list:data-column>
      	<%-- 发布时间--%>
      	<list:data-column col="docPublishTime" title="${ lfn:message('sys-notify:sysNotifyTodo.fdCreateDate') }">
	        <kmss:showDate value="${model.docPublishTime}" type="date"></kmss:showDate>
      	</list:data-column>
		<%--链接--%>
		<list:data-column col="href" escape="false">
		      /km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=${model.fdId}
		</list:data-column>
		<list:data-column col="docDeptName" escape="false">
		     <c:out value="${model.docDept.fdName}"/>
		</list:data-column>
		
      	<list:data-column col="tagNames" title="${lfn:message('km-institution:kmInstitutionKnowledge.fdTagNames') }" escape="false">		
			<c:if test="${not empty tagJson[model.fdId] }">
				<c:set var="_tags" value="${tagJson[model.fdId]}"/>
				<%
					String tags = (String)pageContext.getAttribute("_tags");
					// html过滤
					pageContext.setAttribute("_tags",StringUtil.XMLEscape(StringUtil.clearHTMLTag(tags)));
				%>
	       		${_tags}
	       	</c:if>
		</list:data-column>
      	<list:data-column col="summary" escape="false">
      		<c:if test="${not empty model.docContent }">
      			<c:set var="_summary" value="${model.docContent}"/>
      			<%
					String summary = (String)pageContext.getAttribute("_summary");
					// rtf域内容html过滤
					summary = StringUtil.XMLEscape(StringUtil.clearHTMLTag(summary));
					// 截取长度
					summary = summary != null && summary.length() > 200 ? summary.substring(0, 199): summary;
					pageContext.setAttribute("_summary",EmojiUtil.filterEmoji(summary));
				%>
				${_summary}
      		</c:if>
		</list:data-column>
		<c:if test="${model.docStatus=='30' ||model.docStatus=='40'}">
			<list:data-column col="docReadCount" escape="false">
		       <c:out value="${model.docReadCount}" escapeXml="false"/>
			</list:data-column>
		</c:if>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>