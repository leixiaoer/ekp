<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>

<script type="text/javascript">
window.onload =function (){
	setTimeout(dyniFrameSize,100);
}; 
	function dyniFrameSize() {
	try {
		// 调整高度
		var arguObj = document.getElementById("contentDiv");
		if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
			window.frameElement.style.height = (arguObj.offsetHeight + 40) + "px";
		}
	} catch (e) {}
};
</script>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
<%-- ui:tabpanel id="kmOitemsToReceiveCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsToReceiveCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.reporting3') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="6%"><bean:message key="page.serial"/></td>
						<td  width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
						</td>
						<td width="11%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
						</td>
						<td width="10%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
						</td>
						<td width="11%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.application.number"/>
						</td>
						<td width="5%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.application.number.balance"/>
						</td>
						<td width="13%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.application.fdAmount.money"/>
						</td>
				
				</tr>
				
				<c:forEach items="${receiveContextList}" var="receiveContext" varStatus="vstatus">
					<tr>
						<td>${vstatus.index+1}</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdNo}">
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdNo}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdName}">
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdCategory.fdName}">
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdCategory.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdSpecification}">
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdSpecification}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdBrand}">
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdBrand}" />
						</td>
						<td>
							<kmss:showNumber value="${receiveContext.kmOitemsWarehousingRecordJoinList.fdPrice }" pattern="0.00#"/>
						</td>
						<td>
							<c:out value="${receiveContext.fdAmount}" />					
						</td>
						
						<td>
							<c:out value="${receiveContext.fdReceiveAmount}" />					
						</td>
						<td>
							<c:out value="${receiveContext.kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdUnit}" />
						</td>
						<td>
							<c:if test= "${(receiveContext.fdAmount - receiveContext.fdReceiveAmount) <= 0}">
								<font color="red"><B><c:out value="${receiveContext.fdAmount - receiveContext.fdReceiveAmount}" /></B></font>	
							</c:if>
							<c:if test = "${receiveContext.fdAmount - receiveContext.fdReceiveAmount > 0}">
								<font color="greed"><B><c:out value="${receiveContext.fdAmount - receiveContext.fdReceiveAmount}" /></B></font>	
							</c:if>				
						</td>
						<td>
							<kmss:showNumber value="${receiveContext.fdReceiveAmount*receiveContext.kmOitemsWarehousingRecordJoinList.fdPrice}" pattern="0.00#"/>				
						</td>				
					</tr>
				</c:forEach>
				
			
			</table>
			</div>
			</center>
		</div>
<%-- 	</ui:content>
</ui:tabpanel> --%>
</html:form>
	</template:replace>
</template:include>
