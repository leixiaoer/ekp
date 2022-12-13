<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="kmAssetCardLife" list="${queryPage.list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<list:data-column  col="fdApplyPersonName" escape="false">
		  <c:out value="${kmAssetCardLife.fdApplyPerson.fdName}"/>
		</list:data-column>
		<list:data-column  col="fdApplyPersonImg" escape="false">
		    <person:headimageUrl  personId="${kmAssetCardLife.fdApplyPerson.fdId}" size="m" />
		</list:data-column>
		<list:data-column  property="fdApplyModelid" title="${ lfn:message('km-asset:kmAssetCard.fdStandard') }">
		</list:data-column>
		<list:data-column  property="fdApplyModelname" title="${ lfn:message('km-asset:kmAssetCard.fdMeasure') }">
		</list:data-column>
		<list:data-column  property="fdApplyModelNo" title="${ lfn:message('km-asset:kmAssetCard.fdFirstValue') }">
		</list:data-column>
		<list:data-column  property="fdOperType" title="${ lfn:message('km-asset:kmAssetCard.fdFirstUnit') }">
		</list:data-column>
		<list:data-column  property="fdOperContent" title="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }">
		</list:data-column>
		<list:data-column  col="date" title="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }">
		   <kmss:showDate value="${kmAssetCardLife.fdApplyDate}" type="datetime"></kmss:showDate>
		</list:data-column>
	</list:data-columns>
	<list:data-paging page="${queryPage }">
	</list:data-paging>
</list:data>