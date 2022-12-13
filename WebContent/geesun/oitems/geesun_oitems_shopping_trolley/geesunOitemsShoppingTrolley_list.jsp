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
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js|jquery.js", null, "js");
</script>
<body>
<br>
<% if(request.getAttribute("KMSS_RETURNPAGE")==null){ %>
<logic:messagesPresent>
	<table align=center><tr><td>
		<font class="txtstrong"><bean:message key="errors.header.vali"/></font>
		<bean:message key="errors.header.correct"/>
		<html:messages id="error">
			<br><img src='${KMSS_Parameter_StylePath}msg/dot.gif'>&nbsp;&nbsp;<bean:write name="error"/>
		</html:messages>
	</td></tr></table>
	<hr />
</logic:messagesPresent>
<% }else{
	KmssMessageWriter msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
%>
<script>
Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
function showMoreErrInfo(index, srcImg){
	var obj = document.getElementById("moreErrInfo"+index);
	if(obj!=null){
		if(obj.style.display=="none"){
			obj.style.display="block";
			srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
		}else{
			obj.style.display="none";
			srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
		}
	}
}
</script>

<% } %>
<script type="text/javascript" src="geesun_oitems_shopping_trolley_number.js">
</script>
<html:form action="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do">
<center>
	<table class="tb_normal" width="100%" style="table-layout:fixed;">
		<tr>
				<td class="td_normal_title" style="width:6%;text-align:center"><bean:message key="page.serial"/></td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</td>
				<td class="td_normal_title" style="width:13%;text-align:center"> 
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</td>
				<td class="td_normal_title" style="width:9%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</td>
				<td class="td_normal_title" style="width:13%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</td>
				<td class="td_normal_title" style="width:7%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</td>
				<td class="td_normal_title" style="width:6%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</td>
				<td class="td_normal_title" style="width:7%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</td>
				<td class="td_normal_title" style="width:9%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
				</td>
				<td class="td_normal_title" style="width:10%;text-align:center">
					<bean:message  bundle="geesun-oitems" key="geesunOitems.button.operation"/>
				</td>

		</tr>
		<input id="TotalAmount" type="hidden" value=""/>
		<c:forEach items="${queryPage.list}" var="geesunOitemsShoppingTrolley" varStatus="vstatus">
			<tr>
				<td>${vstatus.index+1}</td>
				<td  style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdNo}" />
				</td>
				<td  style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				 title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdName}" />
				</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}" >
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdCategory.fdName}" />
				</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				title = "${geesunOitemsShoppingTrolley.geesunOitemsListing.fdSpecification}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdSpecification}" />
				</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;" 
				title ="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdBrand}" >
					<c:out value="${geesunOitemsShoppingTrolley.fdBrand}" />
				</td>
				<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
				  title ="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdUnit}">
					<c:out value="${geesunOitemsShoppingTrolley.geesunOitemsListing.fdUnit}" />
				</td>
				<td style="overflow:hidden;white-space: nowrap;"
				  title ="<kmss:showNumber value='${geesunOitemsShoppingTrolley.fdReferencePrice}' pattern='0.00#'/>">
					<kmss:showNumber value='${geesunOitemsShoppingTrolley.fdReferencePrice}' pattern='0.00#'/>
					<input name="fdReferencePrice${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdReferencePrice}">
				</td>
				<td >
					<c:out value="${geesunOitemsShoppingTrolley.fdAmount}" />
					<input name="fdAmount${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdAmount}">
					<input name="fdApplicationListingId${vstatus.index}" type="hidden" value="${geesunOitemsShoppingTrolley.fdId}">
				</td>
				<input class="inputsgl" size="5" type="hidden" name="fdNumber_${geesunOitemsShoppingTrolley.fdId}_${vstatus.index}" value="${geesunOitemsShoppingTrolley.fdApplicationNumber}">
				<td>
					<input type="button" class="btnopt" value="<bean:message  bundle="geesun-oitems" key="geesunOitems.button.cancle"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do" />?method=cancle&orderby=fdNo&fdId=${geesunOitemsShoppingTrolley.fdId}&fdApplicationId=${JsParam.fdApplicationId}','_self');">
				</td>
			</tr>
		</c:forEach>		
	</table>
	<br/>
	<center>
	    <input type=button class="btnopt" value="<bean:message key="button.ok"/>" onclick="closeDialog();">
	</center>
</center>
 <script>
  function closeDialog(){
	  var rtn = {};
	  var fdNumber = $("input[name^='fdNumber']");
	    for(var i=0;i<fdNumber.length;i++){
	    	var tArray = fdNumber[i].name.split("_") ;
			rtn[tArray[1]] = fdNumber[i].value;
	    }
    parent.$dialog.hide(rtn);
  }
</script>
</html:form>

<%@ include file="/resource/jsp/edit_down.jsp"%>
