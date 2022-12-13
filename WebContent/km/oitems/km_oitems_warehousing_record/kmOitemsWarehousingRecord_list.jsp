<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
<html:form action="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do">

<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table class="tb_normal" width="100%" >
		<tr>
				<td class="td_normal_title" width="5%"><bean:message key="page.serial"/></td> 
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdNumber"/></td>
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdPrice"/></td>
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdAccountPrice"/></td>			
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdCreatorId"/></td>
				<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdCreateTime"/></td>
		</tr> 
		<c:forEach items="${queryPage.list}" var="kmOitemsWarehousingRecord" varStatus="vstatus">
			<tr>
			    <td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" width="5%">${vstatus.index+1}</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecord.fdNumber}" /></td>				
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecord.fdPrice}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;">
					<fmt:formatNumber value="${kmOitemsWarehousingRecord.fdAccountPrice}" pattern="#,##0.00"  type="number"/>
				</td>			
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecord.docCreator.fdName}" /></td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"><c:out value="${kmOitemsWarehousingRecord.docCreateTime}"/></td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>