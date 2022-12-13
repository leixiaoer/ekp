<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"%>

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
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
<%-- ui:tabpanel id="geesunOitemsToReceiveCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsToReceiveCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.reporting3') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="6%"><bean:message key="page.serial"/></td>
						<td  width="6%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
						</td>
						<td width="11%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
						</td>
						<td width="10%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
						</td>
						<td width="11%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
						</td>
						<td width="6%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.application.number"/>
						</td>
						<td width="5%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.application.number.balance"/>
						</td>
						<td width="13%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.application.fdAmount.money"/>
						</td>
				
				</tr>
				
				<c:forEach items="${receiveContextList}" var="receiveContext" varStatus="vstatus">
					<tr>
						<td>${vstatus.index+1}</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdNo}">
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdNo}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdName}">
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdCategory.fdName}">
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdCategory.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdSpecification}">
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdSpecification}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdBrand}">
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdBrand}" />
						</td>
						<td>
							<kmss:showNumber value="${receiveContext.geesunOitemsWarehousingRecordJoinList.fdPrice }" pattern="0.00#"/>
						</td>
						<td>
							<c:out value="${receiveContext.fdAmount}" />					
						</td>
						
						<td>
							<c:out value="${receiveContext.fdReceiveAmount}" />					
						</td>
						<td>
							<c:out value="${receiveContext.geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdUnit}" />
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
							<kmss:showNumber value="${receiveContext.fdReceiveAmount*receiveContext.geesunOitemsWarehousingRecordJoinList.fdPrice}" pattern="0.00#"/>				
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
