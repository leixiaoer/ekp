<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<frameset cols="20%,80%"> 
	<frame name="category" src="<%=request.getContextPath() %>/km/oitems/km_oitems_budger_application/km_oitems_budger_application_manager_tree.jsp?fdApplicationId=${HtmlParam.fdApplicationId}" > 
	<frameset rows="60%,40%">
		<frame name="chacked" src="<%=request.getContextPath()%>/km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&fdApplicationId=${HtmlParam.fdApplicationId}"> 
		<frame name="oitems" src="<%=request.getContextPath()%>/km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=list&orderby=fdNo&fdApplicationId=${HtmlParam.fdApplicationId}&rowsize=50" > 	 
	</frameset>
</frameset>
