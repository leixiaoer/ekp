<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript" src="../js/kmOitemsWarehousingRecord_checkedSelected.js">
</script>
<script type="text/javascript">
Com_IncludeFile("document.css", "style/"+Com_Parameter.Style+"/doc/");
</script>
<div class="input_search" style="border:0">
 <input type="text"  name="keywords"  size="20" onkeydown="searchEnter();" />
   <input type="button" class="btnopt" value="<bean:message key="button.search"/>" onclick="dosearch();">
</div>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt"></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="kmOitemsListing.fdNo">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdCategory.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdSpecification">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdBrand">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdUnit">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdReferencePrice">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsListing.fdAmount">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsListing" varStatus="vstatus">
			<tr onclick="showHistory('${vstatus.index+1}','${JsParam.fdApplicationId}',null,'${kmOitemsListing.fdId}');">
				<td>
					<input type="checkbox" name="List_Selected" id="id${kmOitemsListing.fdId}"  value="${kmOitemsListing.fdId}" onclick="showHistory(null,'${JsParam.fdApplicationId}',this,'${kmOitemsListing.fdId}');">
				</td>
				<td>${vstatus.index+1}</td>
				<td title="${kmOitemsListing.fdNo}">
					<c:out value="${kmOitemsListing.fdNo}" />
				</td>
				<td kmss_wordlength="20" title="${kmOitemsListing.fdName}">
					<c:out value="${kmOitemsListing.fdName}" />
				</td>
				<td title="${kmOitemsListing.fdCategory.fdParentsName}">
					<c:out value="${kmOitemsListing.fdCategory.fdName}" />
				</td>
				<td kmss_wordlength="10" title="${kmOitemsListing.fdSpecification}">
					<c:out value="${kmOitemsListing.fdSpecification}" />
				</td>
				<td kmss_wordlength="10" title="${kmOitemsListing.fdBrand}">
					<c:out value="${kmOitemsListing.fdBrand}" />
				</td>
				<td kmss_wordlength="5" title="${kmOitemsListing.fdUnit}">
					<c:out value="${kmOitemsListing.fdUnit}" />
				</td>
				<td title="<kmss:showNumber value='${kmOitemsListing.fdReferencePrice}' pattern='0.00#'/>">
					<kmss:showNumber value='${kmOitemsListing.fdReferencePrice}' pattern='0.00#'/>
				</td>
				<td title="${kmOitemsListing.fdAmount}">
					<c:out value="${kmOitemsListing.fdAmount}" />
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
<%@ include file="/resource/jsp/list_down.jsp"%>
<script>
Com_IncludeFile("data.js");
</script>
<script type="text/javascript">
window.onload=function(){
	var oldUrl = location.href;
	//搜索关键字
	var keywords = Com_GetUrlParameter(oldUrl,'keywords');
	if(keywords != null &&  keywords != '')
		document.getElementsByName("keywords")[0].value = keywords;
};
function dosearch(){
	var keywords = document.getElementsByName("keywords")[0].value;
	//去除首尾空格
	keywords = keywords.replace(/(^\s*)|(\s*$)/g,"");
	keywords = encodeURI(keywords); //中文两次转码
	if("${fdCategoryId}" != ""){
	   window.location.href ="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&categoryId=${fdCategoryId}&type=all&fdApplicationId=${JsParam.fdApplicationId}&keywords="+keywords;
	}else{
	   window.location.href ="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&fdApplicationId=${JsParam.fdApplicationId}&keywords="+keywords;
	}  
}
 function showHistory(index,fdApplicationId,flag,kmOitemsListingId){
	 var  obj;
	 if(flag!=null){
		 obj=flag;
	 }else{
	     obj=document.getElementById("id"+kmOitemsListingId);
	     obj.checked=!obj.checked;
	 }
	 if(obj.checked){
			var data = new KMSSData();
	   	    var url="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=checkNum&kmOitemsListingId="+kmOitemsListingId; 
	   	   	data.SendToUrl(url,function(data){
	   	    var results =  eval("("+data.responseText+")");
	   	    if(results['moreThanOne']=="false"){
	   	   	   var kmOitemsWarehousingRecordJoinListId = results['kmOitemsWarehousingRecordJoinListId'];
	   	       var fdPrice = results['fdPrice'];
	   	       var curNum = results['curNum']; 
	   	       var kmOitemsListingId = results['kmOitemsListingId']; 

	      	  requestxml(obj,null,kmOitemsListingId,'${JsParam.fdApplicationId}',kmOitemsWarehousingRecordJoinListId,fdPrice,curNum,'',true);
	   		}else{
	   		    var href =Com_GetCurDnsHost()+ "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=listRecord&fdListingId="+obj.value+"&fdApplicationId="+fdApplicationId;
	   			top.dialog.iframe(href,'选择物品',function(rtnData){
	   				if(rtnData=="1"){
	   			   		obj.checked=false;
	   			    } 
	   				setTimeout(function(){
	   			   		window.parent.frames[2].location.href = "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=list&orderby=fdNo&fdApplicationId="+fdApplicationId+"&data="+encodeURIComponent(new Date())+"&rowsize=200";
			   		},100);
	   			},{width:900,height:600});
	   	   	}
	   	},false);
	 }else{
		 requestxml(obj,null,obj.value,'${JsParam.fdApplicationId}','','','','',true);
	 }
}
function searchEnter(event){
	event = event || window.event;
	if (event.keyCode == 13){
		dosearch();
	}
}
	</script>