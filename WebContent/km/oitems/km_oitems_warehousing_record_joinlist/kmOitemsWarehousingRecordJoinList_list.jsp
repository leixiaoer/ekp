<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/ui/extend/theme/default/style/common.css"></link>
<script type="text/javascript" src="../js/kmOitemsWarehousingRecord_checkedSelected.js">
</script>
<script type="text/javascript">
window.onload =function (){
	setTimeout(dyniFrameSize,100);
}; 
	function dyniFrameSize() {
	try {
		// 调整高度
		var arguObj = document.getElementsByTagName("table")[0];
		if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
			window.frameElement.style.height = (arguObj.offsetHeight + 40) + "px";
		}
	} catch (e) {}
};
</script>
<html:form action="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table  class="tb_normal" width="100%" >
		<tr>
				<td class="td_normal_title" width="5%"><bean:message key="page.serial"/></td>
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/></td>
				<td class="td_normal_title" property="kmOitemsListing.fdCategory.fdName"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/></td>
				<td class="td_normal_title" property="kmOitemsListing.fdSpecification"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/></td>
				<td class="td_normal_title" property="kmOitemsListing.fdUnit"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/></td>
				<td class="td_normal_title" property="kmOitemsWarehousingRecord.fdCurNumber"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdCurNumber"/></td>
				<td class="td_normal_title" property="kmOitemsWarehousingRecord.fdPrice"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdPrice"/></td>				
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsWarehousingRecordJoinList" varStatus="vstatus">
		<c:set var="kmOitemsListingId" value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdId}"/>
			<tr style="cursor:pointer" onclick="showItems('${kmOitemsListingId}','${kmOitemsWarehousingRecordJoinList.fdPrice}', '${kmOitemsWarehousingRecordJoinList.fdId }');">
			    <td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" width="5%">${vstatus.index+1}</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdCategory.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdSpecification}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.kmOitemsListing.fdUnit}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.fdCurNumber}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecordJoinList.fdPrice}" /></td>				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<script type="text/javascript">
function showItems(fdListingId,fdPrice,warehouseId){
	//var url="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=list&fdListingId="+fdListingId+"&fdPrice="+fdPrice;
	var url = "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_listing_ui/kmOitemsWarehousingRecordJoin_view.jsp?fdListing="+fdListingId+"&fdPrice="+fdPrice+"&warehouseId="+warehouseId;
	Com_OpenWindow(url);
	
}
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>