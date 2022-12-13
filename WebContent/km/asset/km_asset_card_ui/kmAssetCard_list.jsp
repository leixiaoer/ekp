<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%><%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.asset.model.KmAssetCard"%>
<%@page import="com.landray.kmss.km.asset.service.IKmAssetCardService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
IKmAssetCardService kmAssetCardService= (IKmAssetCardService)SpringBeanUtil.getBean("kmAssetCardService");
%>
<list:data>
	<list:data-columns var="kmAssetCard" list="${queryPage.list }">
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column col="fdCode" title="${ lfn:message('km-asset:kmAssetCard.fdCode') }" style="text-align:left" escape="false">
			<c:if test="${kmAssetCard.fdIsLocked}">
			  <img src="../resource/image/lock.png">
			</c:if>
			<c:out value="${kmAssetCard.fdCode}"/>
		</list:data-column>
		<list:data-column col="fdName" title="${ lfn:message('km-asset:kmAssetCard.fdName') }" escape="false">
			<span class="com_subject"><c:out value="${kmAssetCard.fdName}"/></span>
		</list:data-column>
		<list:data-column col="assetName" title="${ lfn:message('km-asset:kmAssetCard.fdName') }">
			<c:out value="${kmAssetCard.fdName}"/>
		</list:data-column>
		<list:data-column property="fdStandard" title="${ lfn:message('km-asset:kmAssetCard.fdStandard') }">
		</list:data-column>
		<list:data-column  property="docDept.fdName" title="${ lfn:message('km-asset:kmAssetCard.docDept') }">
		</list:data-column>
		<list:data-column  col="fdResponsiblePerson.fdName" title="${ lfn:message('km-asset:kmAssetCard.fdResponsiblePerson') }" escape="false">
		  <ui:person personId="${kmAssetCard.fdResponsiblePerson.fdId}" personName="${kmAssetCard.fdResponsiblePerson.fdName}"></ui:person>
		</list:data-column>
		<list:data-column col="fdAssetAddress.fdAddress" title="${ lfn:message('km-asset:kmAssetCard.fdAssetAddress') }" escape="false">
		    <c:out value="${kmAssetCard.fdAssetAddress.fdAddress}" />
		</list:data-column>
		<list:data-column  col="fdAssetCategory.fdName" title="${ lfn:message('km-asset:kmAssetCard.fdAssetCategory') }" escape="false">
		    <c:out value="${kmAssetCard.fdAssetCategory.fdName}" />
		</list:data-column>
		<list:data-column col="fdAssetStatus" title="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }">
			<sunbor:enumsShow enumsType="kmAssetCard_fdAssetStatus" value="${kmAssetCard.fdAssetStatus}"></sunbor:enumsShow>
		</list:data-column>
		<list:data-column  col="docCreateTime" title="${ lfn:message('km-asset:kmAssetCard.docCreateTime') }">
		    <kmss:showDate value="${kmAssetCard.docCreateTime}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="docAlterTime" title="${ lfn:message('km-asset:kmAssetCard.docAlterTime') }">
		    <kmss:showDate value="${kmAssetCard.docAlterTime}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="fdLastModifiedTime" title="${ lfn:message('km-asset:kmAssetCard.fdLastModifiedTime') }">
		    <kmss:showDate value="${kmAssetCard.fdLastModifiedTime}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="fdBuyDate" title="${ lfn:message('km-asset:kmAssetCard.fdBuyDate') }">
		    <kmss:showDate value="${kmAssetCard.fdBuyDate}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="fdInDeptDate" title="${ lfn:message('km-asset:kmAssetCard.fdInDeptDate') }">
		    <kmss:showDate value="${kmAssetCard.fdInDeptDate}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="fdFirstUsedDate" title="${ lfn:message('km-asset:kmAssetCard.fdFirstUsedDate') }">
		    <kmss:showDate value="${kmAssetCard.fdFirstUsedDate}" type="dateTime"/>
		</list:data-column> 
		<list:data-column col="fdImageUrl">
			<%  Object basedocObj = pageContext.getAttribute("kmAssetCard");
			   if(basedocObj != null) { 
				   KmAssetCard kmAssetCard = (KmAssetCard)basedocObj;
					String ids = kmAssetCardService.getCardPicIdsByCardId(kmAssetCard.getFdId());
					if(StringUtil.isNotNull(ids)){
						out.print(request.getContextPath()+"/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId="+ids.split(";")[0]);
					}else{
						out.print(request.getContextPath()+"/km/asset/mobile/js/list/item/defaulthead.jpg");
					}
				}
	        %>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
