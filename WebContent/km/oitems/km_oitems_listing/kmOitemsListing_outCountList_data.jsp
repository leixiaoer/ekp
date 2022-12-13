<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsShoppingTrolley"%>
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
<%-- <ui:tabpanel id="kmOitemsOutCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsOutCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.reporting2') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
			<table id="table_id" class="tb_normal" style="table-layout:fixed;"   width="100%" >
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td  width="5%"><bean:message key="page.serial"/></td>
						<td  width="8%">
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
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.outprice"/>
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
					Map kmOitemsShoppingTrolleyMap = (Map)request.getAttribute("kmOitemsShoppingTrolley");
				     if(kmOitemsShoppingTrolleyMap == null){
				    	 return;
				     }
					 Iterator   iterator = kmOitemsShoppingTrolleyMap.keySet().iterator();  
					 int number=1 ;
					 while(iterator.hasNext()){ 
						 String      key=(String)iterator.next();   
						 KmOitemsShoppingTrolley  kmOitemsShoppingTrolley=(KmOitemsShoppingTrolley)kmOitemsShoppingTrolleyMap.get(key);
						 request.setAttribute("kmOitemsShoppingTrolley",kmOitemsShoppingTrolley);
				%>
					<tr height="30px"   kmss_href="<c:url value="/km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do" />?method=listForFdListingId&fdListingId=${kmOitemsShoppingTrolley.kmOitemsListing.fdId}&fdStartTime=${fdStartTime}&fdEndTime=${fdEndTime}&fdDeptId=${fdDeptId}&fdPrice=${kmOitemsShoppingTrolley.fdReferencePrice}">
						<td><%=number %></td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsShoppingTrolley.kmOitemsListing.fdNo}" >
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getKmOitemsListing().getFdNo())%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsShoppingTrolley.kmOitemsListing.fdName}">
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getKmOitemsListing().getFdName()) %>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsShoppingTrolley.kmOitemsListing.fdCategory.fdName}">
							<%if(kmOitemsShoppingTrolley.getKmOitemsListing().getFdCategory()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getKmOitemsListing().getFdCategory().getFdName()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsShoppingTrolley.fdSpecification}">
							<%if(kmOitemsShoppingTrolley.getFdSpecification()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getFdSpecification()) %>
							<%	
							}
							%>
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsShoppingTrolley.fdBrand}">
							<%if(kmOitemsShoppingTrolley.getFdBrand()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getFdBrand()) %>
							<%	
							}
							%>
						</td>
						<td>
							<%--=kmOitemsListing.getFdReferencePrice() --%>
							<kmss:showNumber value="${kmOitemsShoppingTrolley.fdReferencePrice}" pattern="0.00#"/>
						</td>
						<td>
							<%=kmOitemsShoppingTrolley.getFdApplicationNumber() %>
						</td>
						<td>
							<%if(kmOitemsShoppingTrolley.getFdUnit()!=null){
							%>
							<%=StringEscapeUtils.escapeHtml(kmOitemsShoppingTrolley.getFdUnit()) %>
							<%	
							}
							%>
						</td>
						<td>
							<kmss:showNumber value="${kmOitemsShoppingTrolley.fdApplicationNumber*kmOitemsShoppingTrolley.fdReferencePrice}" pattern="0.00#"/>
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