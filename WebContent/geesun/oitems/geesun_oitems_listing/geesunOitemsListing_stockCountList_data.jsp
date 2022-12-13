<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.geesun.oitems.service.IGeesunOitemsWarehousingRecordJoinListService"%>
<%@page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsWarehousingRecordJoinList" %>
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
<%-- <ui:tabpanel id="geesunOitemsShowStockCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsShowStockCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage3') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<table id="table_id" class="tb_normal"  style="table-layout:fixed;"  width="100%"     border="0">
				<tr  style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td  width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
						</td>
						<td width="12%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
						</td>
						<td width="10%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
						</td>
						<td width="5%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
						</td>
						<td width="12%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.inprice.last"/>
						</td>
						<td width="5%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
						</td>
						<td width="8%">
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAccount.money"/>
						</td>
				</tr>
				<%
					Map geesunOitemsListingMap = (Map)request.getAttribute("geesunOitemsListingMap"); 
					 Iterator   iterator=geesunOitemsListingMap.keySet().iterator();  
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 GeesunOitemsListing   geesunOitemsListing=(GeesunOitemsListing)geesunOitemsListingMap.get(key);
						 request.setAttribute("geesunOitemsListing",geesunOitemsListing);
						 IGeesunOitemsWarehousingRecordJoinListService geesunOitemsWarehousingRecordJoinListService = (IGeesunOitemsWarehousingRecordJoinListService)SpringBeanUtil.getBean("geesunOitemsWarehousingRecordJoinListService");
						 List<GeesunOitemsWarehousingRecordJoinList> result = geesunOitemsWarehousingRecordJoinListService.findByGeesunOitemsListing(geesunOitemsListing);
						 if(!result.isEmpty()){
							 Double amount = new Double(0);
							 for(GeesunOitemsWarehousingRecordJoinList record : result){
								 amount += record.getFdCurNumber()*record.getFdPrice();
							 }
							 request.setAttribute("account", amount);
						 }else{
							 request.setAttribute("account", geesunOitemsListing.getFdAmount()*geesunOitemsListing.getFdReferencePrice());
						 }
				%>
					<tr height="30px"  onmouseover="this.style.background='#cccccc'"
					    onmouseout="this.style.background=''">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsListing.fdNo}">
							<%=geesunOitemsListing.getFdNo() %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsListing.fdName}">
							<%=geesunOitemsListing.getFdName() %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsListing.fdCategory.fdName}">
							<%if(geesunOitemsListing.getFdCategory()!=null){
							%>
							<%=geesunOitemsListing.getFdCategory().getFdName() %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsListing.fdSpecification}">
							<%if(geesunOitemsListing.getFdSpecification()!=null){
							%>
							<%=geesunOitemsListing.getFdSpecification() %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsListing.fdBrand}">
							<%if(geesunOitemsListing.getFdBrand()!=null){
							%>
							<%=geesunOitemsListing.getFdBrand() %>
							<%	
							}
							%>
						</td>
						<td>
							<%if(geesunOitemsListing.getFdUnit()!=null){
							%>
							<%=geesunOitemsListing.getFdUnit() %>
							<%	
							}
							%>
						</td>
						<td>
						<kmss:showNumber value="${geesunOitemsListing.fdReferencePrice}" pattern="0.00#"/>
						</td>
						<td>
							<%=geesunOitemsListing.getFdAmount() %>
						</td>
						<td>
							<kmss:showNumber value="${account}" pattern="0.00#"/>
						</td>
					</tr>
				<% number++;} %>
			</table>
			</div>
			</center>
		</div>
	<%-- </ui:content>
</ui:tabpanel>		 --%>
</html:form>
	</template:replace>
</template:include>
