<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.util.ArrayUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.landray.kmss.km.asset.model.KmAssetCard"%>
<%@page import="com.landray.kmss.km.asset.service.IKmAssetCardService"%>
<%@page import="com.landray.kmss.sys.attachment.model.SysAttMain"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%
IKmAssetCardService kmAssetCardService= (IKmAssetCardService)SpringBeanUtil.getBean("kmAssetCardService");
%>

<list:data>
	<list:data-columns var="kmAssetCard" list="${queryPage.list }" varIndex="status" mobile="true">
		<list:data-column property="fdId">
		</list:data-column >
		<list:data-column  property="fdCode" title="${ lfn:message('km-asset:kmAssetCard.fdCode') }" style="text-align:left">
		</list:data-column>
		<list:data-column  property="fdName" title="${ lfn:message('km-asset:kmAssetCard.fdName') }">
		</list:data-column>
		<list:data-column  property="fdStandard" title="${ lfn:message('km-asset:kmAssetCard.fdStandard') }">
		</list:data-column>
		<list:data-column  property="fdMeasure" title="${ lfn:message('km-asset:kmAssetCard.fdMeasure') }">
		</list:data-column>
		<list:data-column  col="fdFirstValue" title="${ lfn:message('km-asset:kmAssetCard.fdFirstValue') }" escape="false">
		   <kmss:showNumber value="${kmAssetCard.fdFirstValue}" pattern="###,##0.00"/>
		</list:data-column>
		<list:data-column  col="fdFirstUnit" title="${ lfn:message('km-asset:kmAssetCard.fdFirstUnit') }" escape="false">
		    <c:if test="${kmAssetCard.fdFirstUnit eq 'CNY'}">
		      ¥
		    </c:if>
		     <c:if test="${kmAssetCard.fdFirstUnit eq 'HKD'}">
		     HK$
		    </c:if>
		    <c:if test="${kmAssetCard.fdFirstUnit eq 'USD'}">
		     $
		    </c:if>
		     <c:if test="${kmAssetCard.fdFirstUnit eq 'EUR'}">
		     €  
		    </c:if>
		     <c:if test="${kmAssetCard.fdFirstUnit eq 'GBP'}">
		     £
		    </c:if>
		    <c:if test="${kmAssetCard.fdFirstUnit eq 'JPY'}">
		     ¥
		    </c:if>
		</list:data-column>
		<list:data-column  col="fdAssetStatus" title="${ lfn:message('km-asset:kmAssetCard.fdAssetStatus') }" escape="false">
		    <c:if test="${kmAssetCard.fdAssetStatus eq '1'}">
		      <span class="status unused"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status1" /></span>
		    </c:if>
		     <c:if test="${kmAssetCard.fdAssetStatus eq '2'}">
		      <span class="status inuse"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status2" /></span>
		    </c:if>
		     <c:if test="${kmAssetCard.fdAssetStatus eq '3'}">
		      <span class="status borrow"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status3" /></span>
		    </c:if>
		     <c:if test="${kmAssetCard.fdAssetStatus eq '4'}">
		      <span class="status repair"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status4" /></span>
		    </c:if>
		     <c:if test="${kmAssetCard.fdAssetStatus eq '5'}">
		      <span class="status discard"><bean:message bundle="km-asset" key="fdAssetStatus.enums.status5" /></span>
		    </c:if>
		</list:data-column>
		<list:data-column col="href" escape="false">
			/km/asset/km_asset_card/kmAssetCard.do?method=view&fdId=${kmAssetCard.fdId}
		</list:data-column>
		<list:data-column col="fdImageUrl" escape="false">
			<%  Object basedocObj = pageContext.getAttribute("kmAssetCard");
			   if(basedocObj != null) { 
				   KmAssetCard kmAssetCard = (KmAssetCard)basedocObj;
					String ids = kmAssetCardService.getCardPicIdsByCardId(kmAssetCard.getFdId());
					if(StringUtil.isNotNull(ids)){
						out.print("/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId="+ids.split(";")[0]);
					}
				}
	        %>
		</list:data-column>
	</list:data-columns>
	<list:data-paging page="${queryPage }">
	</list:data-paging>
</list:data>