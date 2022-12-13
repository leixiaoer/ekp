<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ page import="
	com.landray.kmss.util.KmssMessageWriter,
	com.landray.kmss.util.KmssReturnPage" %>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
Com_IncludeFile("jquery.js", null, "js");
</script>
<script type="text/javascript">
Com_IncludeFile("document.css", "style/"+Com_Parameter.Style+"/doc/");
</script>
<body>
<script type="text/javascript" src="geesun_oitems_shopping_trolley_number.js">
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
			window.frameElement.style.height = (arguObj.offsetHeight + 20) + "px";
		}
	} catch (e) {}
};

</script>
<center>
<html:form action="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do">
	<table class="tb_normal" width="100%" style="table-layout:fixed">
		<tr width="100%">
				<td  class="td_normal_title" style="width:5%;text-align:center"><bean:message key="page.serial"/></td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</td>
				<td class="td_normal_title"  style="width:20%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</td>
				<td class="td_normal_title" style="width:13%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</td>
				<td class="td_normal_title" style="width:10%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</td>
				<td class="td_normal_title" style="width:7%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.fdApplicationNumber"/>
				</td>
				<td class="td_normal_title" style="width:8%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitems.button.operation"/>
				</td>

		</tr>
		<c:forEach items="${valueList}" var="geesunOitemsShoppingTrolley" varStatus="vstatus">
			<tr width="100%">
			
				<td>${vstatus.index+1}</td>
				<c:choose>
				<c:when test="${geesunOitemsBudgerApplicationForm.method_GET=='edit'}">
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}" >
					<c:out value="${geesunOitemsShoppingTrolley.fdNo}" />
				</td>
				</c:when>
				<c:otherwise>			
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}" >
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}" />
				</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${opertype=='edit'}">
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}" >
					<c:out value="${geesunOitemsShoppingTrolley.fdName}" />
				</td>
				</c:when>
				<c:otherwise>				
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}" >
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}" />
				</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${opertype=='edit'}">
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"  
				title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}">
					<c:out value="${geesunOitemsShoppingTrolley.fdCategoryName}" />
				</td>
				</c:when>
				<c:otherwise>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"  
				title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}" />
				</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${opertype=='edit'}">
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 	title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdSpecification}">
					<c:out value="${geesunOitemsShoppingTrolley.fdSpecification}" />
				</td>
				</c:when>
				<c:otherwise>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 	title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdSpecification}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdSpecification}" />
				</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${opertype=='edit'}">
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" 
					title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdBrand}">
					<c:out value="${geesunOitemsShoppingTrolley.fdBrand}" />
				</td>
				</c:when>
				<c:otherwise>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" 
					title="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdBrand}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdBrand}" />
				</td>
				</c:otherwise>
				</c:choose>
				<c:choose>
				<c:when test="${opertype=='edit'}">
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdUnit}" />
				</td>
				</c:when>
				<c:otherwise>
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdUnit}" />
				</td>
				</c:otherwise>
				</c:choose>
				
				<td>
					<kmss:showNumber value="${geesunOitemsShoppingTrolley.fdReferencePrice}" pattern="###,##0.00"/>
					<input name="fdReferencePrice${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdReferencePrice}">
				</td>
				
				<td>
					<c:out value="${geesunOitemsShoppingTrolley.fdAmount}" />
					<input name="fdAmount${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdAmount}">
					<input name="fdApplicationListingId${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdId}">
				</td>
				<td>
				    <c:if test="${geesunOitemsShoppingTrolley.fdAmount-geesunOitemsShoppingTrolley.fdApplicationNumber<0}">
					<input class="inputsgl" style="width:50px" type="text" name="fdNumber${vstatus.index}" onblur="changeAmount(${vstatus.index},'${JsParam.type }');" value="${geesunOitemsShoppingTrolley.fdApplicationNumber}" style="color: red">
					</c:if>
					<c:if test="${geesunOitemsShoppingTrolley.fdAmount-geesunOitemsShoppingTrolley.fdApplicationNumber>=0}">
					<input class="inputsgl" style="width:50px" type="text" name="fdNumber${vstatus.index}" onblur="changeAmount(${vstatus.index},'${JsParam.type }');" value="${geesunOitemsShoppingTrolley.fdApplicationNumber}">
					</c:if>
				</td>
				<td>
					<input type="button" class="btnopt" value="<bean:message  bundle="geesun-oitems" key="geesunOitems.button.cancle"/>"
						onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do" />?method=cancle&orderby=fdNo&fdId=${geesunOitemsShoppingTrolley.fdId}&fdApplicationId=${JsParam.fdApplicationId}&operation=1','_self');">
				</td>
			</tr>
		</c:forEach>
	</table>
 <script>
 function initAmout(){
	 var totalAmount =0;
	    var fdNumber = $("input[name^='fdNumber']");
	    for(var i=0;i<fdNumber.length;i++){
	        var fdReferencePrice = $("input[name=fdReferencePrice"+i+"]");
	    	totalAmount += fdReferencePrice[0].value*fdNumber[i].value;
	    }
	    parent.document.getElementsByName("fdTotalAmount")[0].value = totalAmount;
}
 $(document).ready(function(){
	 initAmout();
 });
 function changeAmount(index,type){
	 requestxml(index,type);
	 initAmout();
 }
 </script>
</html:form>
</center>
<%@ include file="/resource/jsp/edit_down.jsp"%>
