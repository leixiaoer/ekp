<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/ui/extend/theme/default/style/common.css"></link>
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
	<table class="tb_normal" width="100%" >
		<tr>
				<td class="td_normal_title" width="5%"><bean:message key="page.serial"/></td> 
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdNumber"/></td>
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdPrice"/></td>
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdAccountPrice"/></td>			
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdCreatorId"/></td>
				<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdCreateTime"/></td>
		</tr> 
		<c:forEach items="${queryPage.list}" var="geesunOitemsWarehousingRecord" varStatus="vstatus">
			<tr>
			    <td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" width="5%">${vstatus.index+1}</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecord.fdNumber}" /></td>				
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecord.fdPrice}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecord.fdAccountPrice}" /></td>			
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecord.docCreator.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${geesunOitemsWarehousingRecord.docCreateTime}"/></td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
