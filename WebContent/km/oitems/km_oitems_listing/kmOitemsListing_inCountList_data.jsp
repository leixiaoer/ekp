<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsWarehousingRecord"%>
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
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
<%-- <ui:tabpanel id="kmOitemsInCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsInCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.reporting1') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
						</td>
						<td width="12%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
						</td>
						<td width="9%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
						</td>
						<td width="9%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
						</td>
						
						<td width="10%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.inprice"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.number"/>
						</td>
						<td width="5%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
						</td>
						<td width="12%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount.money"/>
						</td>
				
				</tr>
				<%
					Map kmOitemsWarehousingRecordMap = (Map)request.getAttribute("kmOitemsWarehousingRecordMap"); 
					if(kmOitemsWarehousingRecordMap == null){
						return;
					}
					Iterator   iterator=kmOitemsWarehousingRecordMap.keySet().iterator();  
					
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 KmOitemsWarehousingRecord   kmOitemsWarehousingRecord=(KmOitemsWarehousingRecord)kmOitemsWarehousingRecordMap.get(key);
						 request.setAttribute("kmOitemsWarehousingRecord",kmOitemsWarehousingRecord);
				%>
					<tr height="30px" kmss_href="<c:url value="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do" />?method=list&fdListingId=${kmOitemsWarehousingRecord.kmOitemsListing.fdId}&fdStartTime=${fdStartTime}&fdEndTime=${fdEndTime}&fdPrice=${kmOitemsWarehousingRecord.fdPrice}">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsWarehousingRecord.kmOitemsListing.fdNo}">
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdNo()) %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsWarehousingRecord.kmOitemsListing.fdName}">
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdName())%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsWarehousingRecord.kmOitemsListing.fdCategory.fdName}">
							<%if(kmOitemsWarehousingRecord.getKmOitemsListing().getFdCategory()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdCategory().getFdName()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsWarehousingRecord.kmOitemsListing.fdSpecification}">
							<%if(kmOitemsWarehousingRecord.getKmOitemsListing().getFdSpecification()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdSpecification()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsWarehousingRecord.kmOitemsListing.fdBrand}">
							<%if(kmOitemsWarehousingRecord.getKmOitemsListing().getFdBrand()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdBrand()) %>
							<%	
							}
							%>
						</td>
						
						<td>
							<kmss:showNumber value="${kmOitemsWarehousingRecord.fdPrice}" pattern="0.00#"/>				
						</td>
						<td>
							<%=kmOitemsWarehousingRecord.getFdNumber() %>
						</td>
						<td>
							<%if(kmOitemsWarehousingRecord.getKmOitemsListing().getFdUnit()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsWarehousingRecord.getKmOitemsListing().getFdUnit()) %>
							<%	
							}
							%>
						</td>
						<td>
							<kmss:showNumber value="${kmOitemsWarehousingRecord.fdNumber*kmOitemsWarehousingRecord.fdPrice}" pattern="0.00#"/>			
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