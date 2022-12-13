<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<list:data>
	<list:data-columns var="sysOrgPerson" list="${list}" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<list:data-column property="fdName" title="${ lfn:message('sys-organization:sysOrgPerson.fdName') }" escape="false">
		</list:data-column>
		<list:data-column col="fdParent" title="${ lfn:message('sys-organization:sysOrgPerson.fdParent') }" >
		 ${sysOrgPerson.fdParent.fdName}
		</list:data-column>
		<list:data-column col="icon" escape="false">
				<%-- /sys/person/image.jsp?personId=${kmAssignPersonnel.fdId}&size=null --%>
			    <person:headimageUrl contextPath="true" personId="${sysOrgPerson.fdId}" size="m" />
		</list:data-column>
	</list:data-columns>
	
	<list:data-paging  totalSize="${fn:length(list)}">
	</list:data-paging>
</list:data>