<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecord"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>

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
<%-- <ui:tabpanel id="geesunOitemsInCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsInCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.reporting1') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
						</td>
						<td width="12%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
						</td>
						<td width="9%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
						</td>
						<td width="9%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
						</td>
						
						<td width="10%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.inprice"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.number"/>
						</td>
						<td width="5%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
						</td>
						<td width="12%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount.money"/>
						</td>
				
				</tr>
				<%
					Map geesunOitemsWarehousingRecordMap = (Map)request.getAttribute("geesunOitemsWarehousingRecordMap"); 
					if(geesunOitemsWarehousingRecordMap == null){
						return;
					}
					Iterator   iterator=geesunOitemsWarehousingRecordMap.keySet().iterator();  
					
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 GeesunOitemsWarehousingRecord   geesunOitemsWarehousingRecord=(GeesunOitemsWarehousingRecord)geesunOitemsWarehousingRecordMap.get(key);
						 request.setAttribute("geesunOitemsWarehousingRecord",geesunOitemsWarehousingRecord);
				%>
					<tr height="30px" kmss_href="<c:url value="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do" />?method=list&fdListingId=${geesunOitemsWarehousingRecord.geesunOitemsListing.fdId}&fdStartTime=${fdStartTime}&fdEndTime=${fdEndTime}&fdPrice=${geesunOitemsWarehousingRecord.fdPrice}">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsWarehousingRecord.geesunOitemsListing.fdNo}">
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdNo()) %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsWarehousingRecord.geesunOitemsListing.fdName}">
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdName())%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsWarehousingRecord.geesunOitemsListing.fdCategory.fdName}">
							<%if(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdCategory()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdCategory().getFdName()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsWarehousingRecord.geesunOitemsListing.fdSpecification}">
							<%if(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdSpecification()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdSpecification()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsWarehousingRecord.geesunOitemsListing.fdBrand}">
							<%if(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdBrand()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdBrand()) %>
							<%	
							}
							%>
						</td>
						
						<td>
							<kmss:showNumber value="${geesunOitemsWarehousingRecord.fdPrice}" pattern="0.00#"/>				
						</td>
						<td>
							<%=geesunOitemsWarehousingRecord.getFdNumber() %>
						</td>
						<td>
							<%if(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdUnit()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsWarehousingRecord.getGeesunOitemsListing().getFdUnit()) %>
							<%	
							}
							%>
						</td>
						<td>
							<kmss:showNumber value="${geesunOitemsWarehousingRecord.fdNumber*geesunOitemsWarehousingRecord.fdPrice}" pattern="0.00#"/>			
						</td>
					</tr>
				<% number++;} %>
			</table>
			</div>
			</center>
		</div>
	<%-- </ui:content>
</ui:tabpanel>	 --%>	
</html:form>
	</template:replace>
</template:include>
