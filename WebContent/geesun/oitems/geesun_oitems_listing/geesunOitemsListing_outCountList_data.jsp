<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley"%>
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
<%-- <ui:tabpanel id="geesunOitemsOutCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsOutCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.reporting2') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td  width="8%">
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
							<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.outprice"/>
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
					Map geesunOitemsShoppingTrolleyMap = (Map)request.getAttribute("geesunOitemsShoppingTrolley");
				     if(geesunOitemsShoppingTrolleyMap == null){
				    	 return;
				     }
					 Iterator   iterator = geesunOitemsShoppingTrolleyMap.keySet().iterator();  
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 GeesunOitemsShoppingTrolley  geesunOitemsShoppingTrolley=(GeesunOitemsShoppingTrolley)geesunOitemsShoppingTrolleyMap.get(key);
						 request.setAttribute("geesunOitemsShoppingTrolley",geesunOitemsShoppingTrolley);
				%>
					<tr height="30px"   kmss_href="<c:url value="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do" />?method=listForFdListingId&fdListingId=${geesunOitemsShoppingTrolley.geesunOitemsListing.fdId}&fdStartTime=${fdStartTime}&fdEndTime=${fdEndTime}&fdDeptId=${fdDeptId}&fdPrice=${geesunOitemsShoppingTrolley.fdReferencePrice}">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}" >
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdNo())%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}">
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdName()) %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}">
							<%if(geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdCategory()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getGeesunOitemsListing().getFdCategory().getFdName()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsShoppingTrolley.fdSpecification}">
							<%if(geesunOitemsShoppingTrolley.getFdSpecification()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getFdSpecification()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${geesunOitemsShoppingTrolley.fdBrand}">
							<%if(geesunOitemsShoppingTrolley.getFdBrand()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getFdBrand()) %>
							<%	
							}
							%>
						</td>
						<td>
							<%--=geesunOitemsListing.getFdReferencePrice() --%>
							<kmss:showNumber value="${geesunOitemsShoppingTrolley.fdReferencePrice}" pattern="0.00#"/>
						</td>
						<td>
							<%=geesunOitemsShoppingTrolley.getFdApplicationNumber() %>
						</td>
						<td>
							<%if(geesunOitemsShoppingTrolley.getFdUnit()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(geesunOitemsShoppingTrolley.getFdUnit()) %>
							<%	
							}
							%>
						</td>
						<td>
							<kmss:showNumber value="${geesunOitemsShoppingTrolley.fdApplicationNumber*geesunOitemsShoppingTrolley.fdReferencePrice}" pattern="0.00#"/>
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
<script type="text/javascript">
function onRadioClick(obj){
	var a_deptObj = document.getElementById("a_dept_id");
	var a_personObj = document.getElementById("a_person_id");
	var value = obj.value;
	if(value == 1){
		a_deptObj.style.display="";
		a_personObj.style.display="none";
	}else{
		a_deptObj.style.display="none";
		a_personObj.style.display="";
	}
}
</script>
	</template:replace>
</template:include>
