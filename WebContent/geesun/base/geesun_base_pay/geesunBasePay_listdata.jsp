<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/list.tld" prefix="list" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<list:data>
	<list:data-columns var="geesunBasePay" list="${queryPage.list}" varIndex="index">
	    <list:data-column property="fdId">
		</list:data-column>
		<list:data-column property="fdOrderId" title="${lfn:message('geesun-base:geesunBasePay.fdOrderId')}">
        </list:data-column>
		<list:data-column col="fdYwDate" title="${lfn:message('geesun-base:geesunBasePay.fdYwDate')}">
            <kmss:showDate value="${geesunBasePay.fdYwDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdPayDate" title="${lfn:message('geesun-base:geesunBasePay.fdPayDate')}">
            <kmss:showDate value="${geesunBasePay.fdPayDate}" type="date"></kmss:showDate>
        </list:data-column>
        <list:data-column col="fdPeriod" title="${lfn:message('geesun-base:geesunBasePay.fdPeriod')}" >
        	<kmss:showPeriod value="${geesunBasePay.fdPeriod}"/>
        </list:data-column>
        <list:data-column property="fdPayBank3" title="${lfn:message('geesun-base:geesunBasePay.fdPayBank3')}">
        </list:data-column>
        <list:data-column property="fdPayMoney" title="${lfn:message('geesun-base:geesunBasePay.fdPayMoney')}" />
        <list:data-column col="docCreator.name" title="${lfn:message('geesun-base:geesunBasePay.docCreator')}" escape="false">
            <c:out value="${geesunBasePay.docCreator.fdName}" />
        </list:data-column>
        <list:data-column col="docCreator.id" escape="false">
            <c:out value="${geesunBasePay.docCreator.fdId}" />
        </list:data-column>
        <list:data-column col="docCreateTime" title="${lfn:message('geesun-base:geesunBasePay.docCreateTime')}">
            <kmss:showDate value="${geesunBasePay.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
		
	</list:data-columns>
	
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }"></list:data-paging>
	
</list:data>