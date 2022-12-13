<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@page import="com.landray.kmss.km.oitems.service.IKmOitemsWarehousingRecordJoinListService"%>
<%@page import="com.landray.kmss.km.oitems.model.KmOitemsWarehousingRecordJoinList" %>
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
<%-- <ui:tabpanel id="kmOitemsShowStockCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsShowStockCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.stock.manage3') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<table id="table_id" class="tb_normal"  style="table-layout:fixed;"  width="100%"     border="0">
				<tr  style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td  width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
						</td>
						<td width="12%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
						</td>
						<td width="10%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
						</td>
						<td width="5%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
						</td>
						<td width="12%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.inprice.last"/>
						</td>
						<td width="5%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAccount.money"/>
						</td>
				</tr>
				<%
					Map kmOitemsListingMap = (Map)request.getAttribute("kmOitemsListingMap"); 
					 Iterator   iterator=kmOitemsListingMap.keySet().iterator();  
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 KmOitemsListing   kmOitemsListing=(KmOitemsListing)kmOitemsListingMap.get(key);
						 request.setAttribute("kmOitemsListing",kmOitemsListing);
						 IKmOitemsWarehousingRecordJoinListService kmOitemsWarehousingRecordJoinListService = (IKmOitemsWarehousingRecordJoinListService)SpringBeanUtil.getBean("kmOitemsWarehousingRecordJoinListService");
						 List<KmOitemsWarehousingRecordJoinList> result = kmOitemsWarehousingRecordJoinListService.findByKmOitemsListing(kmOitemsListing);
						 if(!result.isEmpty()){
							 Double amount = new Double(0);
							 for(KmOitemsWarehousingRecordJoinList record : result){
								 amount += record.getFdCurNumber()*record.getFdPrice();
							 }
							 request.setAttribute("account", amount);
						 }else{
							 request.setAttribute("account", kmOitemsListing.getFdAmount()*kmOitemsListing.getFdReferencePrice());
						 }
				%>
					<tr height="30px"  onmouseover="this.style.background='#cccccc'"
					    onmouseout="this.style.background=''">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdNo}">
							<%=kmOitemsListing.getFdNo() %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdName}">
							<%=kmOitemsListing.getFdName() %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdCategory.fdName}">
							<%if(kmOitemsListing.getFdCategory()!=null){
							%>
							<%=kmOitemsListing.getFdCategory().getFdName() %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdSpecification}">
							<%if(kmOitemsListing.getFdSpecification()!=null){
							%>
							<%=kmOitemsListing.getFdSpecification() %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdBrand}">
							<%if(kmOitemsListing.getFdBrand()!=null){
							%>
							<%=kmOitemsListing.getFdBrand() %>
							<%	
							}
							%>
						</td>
						<td>
							<%if(kmOitemsListing.getFdUnit()!=null){
							%>
							<%=kmOitemsListing.getFdUnit() %>
							<%	
							}
							%>
						</td>
						<td>
						<kmss:showNumber value="${kmOitemsListing.fdReferencePrice}" pattern="0.00#"/>
						</td>
						<td>
							<%=kmOitemsListing.getFdAmount() %>
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