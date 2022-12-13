<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/ui/extend/theme/default/style/common.css"></link>
<script type="text/javascript" src="../js/geesunOitemsWarehousingRecord_checkedSelected.js">
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
<html:form action="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table  class="tb_normal" width="100%" >
		<tr>
				<td class="td_normal_title" width="5%"><bean:message key="page.serial"/></td>
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/></td>
				<td class="td_normal_title" property="geesunOitemsListing.fdCategory.fdName"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/></td>
				<td class="td_normal_title" property="geesunOitemsListing.fdSpecification"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/></td>
				<td class="td_normal_title" property="geesunOitemsListing.fdUnit"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/></td>
				<td class="td_normal_title" property="geesunOitemsWarehousingRecord.fdCurNumber"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdCurNumber"/></td>
				<td class="td_normal_title" property="geesunOitemsWarehousingRecord.fdPrice"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdPrice"/></td>				
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsWarehousingRecordJoinList" varStatus="vstatus">
		<c:set var="geesunOitemsListingId" value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId}"/>
			<tr style="cursor:pointer" onclick="showItems('${geesunOitemsListingId}','${geesunOitemsWarehousingRecordJoinList.fdPrice}', '${geesunOitemsWarehousingRecordJoinList.fdId }');">
			    <td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" width="5%">${vstatus.index+1}</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdCategory.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdSpecification}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdUnit}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.fdCurNumber}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecordJoinList.fdPrice}" /></td>				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<script type="text/javascript">
function showItems(fdListingId,fdPrice,warehouseId){
	//var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=list&fdListingId="+fdListingId+"&fdPrice="+fdPrice;
	var url = "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_listing_ui/geesunOitemsWarehousingRecordJoin_view.jsp?fdListing="+fdListingId+"&fdPrice="+fdPrice+"&warehouseId="+warehouseId;
	Com_OpenWindow(url);
	
}
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>
