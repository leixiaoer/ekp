<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript" src="../js/geesunOitemsWarehousingRecord_checkedSelected.js">
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
				<sunbor:column property="geesunOitemsListing.fdNo">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdCategory.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdSpecification">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdBrand">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdUnit">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdReferencePrice">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsListing.fdAmount">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsListing" varStatus="vstatus">
			<tr onclick="showHistory('${vstatus.index+1}','${JsParam.fdApplicationId}',null,'${geesunOitemsListing.fdId}');">
				<td>
					<input type="checkbox" name="List_Selected" id="id${vstatus.index+1}"  value="${geesunOitemsListing.fdId}" onclick="showHistory(null,'${JsParam.fdApplicationId}',this,'${geesunOitemsListing.fdId}');">
				</td>
				<td>${vstatus.index+1}</td>
				<td title="${geesunOitemsListing.fdNo}">
					<c:out value="${geesunOitemsListing.fdNo}" />
				</td>
				<td kmss_wordlength="20" title="${geesunOitemsListing.fdName}">
					<c:out value="${geesunOitemsListing.fdName}" />
				</td>
				<td title="${geesunOitemsListing.fdCategory.fdParentsName}">
					<c:out value="${geesunOitemsListing.fdCategory.fdName}" />
				</td>
				<td kmss_wordlength="10" title="${geesunOitemsListing.fdSpecification}">
					<c:out value="${geesunOitemsListing.fdSpecification}" />
				</td>
				<td kmss_wordlength="10" title="${geesunOitemsListing.fdBrand}">
					<c:out value="${geesunOitemsListing.fdBrand}" />
				</td>
				<td kmss_wordlength="5" title="${geesunOitemsListing.fdUnit}">
					<c:out value="${geesunOitemsListing.fdUnit}" />
				</td>
				<td title="<kmss:showNumber value='${geesunOitemsListing.fdReferencePrice}' pattern='0.00#'/>">
					<kmss:showNumber value='${geesunOitemsListing.fdReferencePrice}' pattern='0.00#'/>
				</td>
				<td title="${geesunOitemsListing.fdAmount}">
					<c:out value="${geesunOitemsListing.fdAmount}" />
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
	   window.location.href ="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=checkOitemsList&categoryId=${fdCategoryId}&type=all&fdApplicationId=${JsParam.fdApplicationId}&keywords="+keywords;
	}else{
	   window.location.href ="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=checkOitemsList&fdApplicationId=${JsParam.fdApplicationId}&keywords="+keywords;
	}  
}
 function showHistory(index,fdApplicationId,flag,geesunOitemsListingId){
	 var  obj;
	 if(flag!=null){
		 obj=flag;
	 }else{
	     obj=document.getElementById("id"+index);
	     obj.checked=!obj.checked;
	 }
	 if(obj.checked){
			var data = new KMSSData();
	   	    var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_warehousing_record_joinlist/geesunOitemsWarehousingRecordJoinList.do?method=checkNum&geesunOitemsListingId="+geesunOitemsListingId; 
	   	   	data.SendToUrl(url,function(data){
	   	    var results =  eval("("+data.responseText+")");
	   	    if(results['moreThanOne']=="false"){
	   	   	   var geesunOitemsWarehousingRecordJoinListId = results['geesunOitemsWarehousingRecordJoinListId'];
	   	       var fdPrice = results['fdPrice'];
	   	       var curNum = results['curNum']; 
	   	       var geesunOitemsListingId = results['geesunOitemsListingId']; 

	      	  requestxml(obj,null,geesunOitemsListingId,'${JsParam.fdApplicationId}',geesunOitemsWarehousingRecordJoinListId,fdPrice,curNum,'',true);
	   		}else{
	   		    var href =Com_GetCurDnsHost()+ "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_warehousing_record_joinlist/geesunOitemsWarehousingRecordJoinList.do?method=listRecord&fdListingId="+obj.value+"&fdApplicationId="+fdApplicationId;
	   			top.dialog.iframe(href,'选择物品',function(rtnData){
	   				if(rtnData=="1"){
	   			   		obj.checked=false;
	   			    } 
	   				setTimeout(function(){
	   			   		window.parent.frames[2].location.href = "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=list&orderby=fdNo&fdApplicationId="+fdApplicationId+"&data="+encodeURIComponent(new Date())+"&rowsize=200";
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
