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
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");	
</script>
<script type="text/javascript" src="../js/tableSort.js"></script>
<script type="text/javascript">
Com_AddEventListener(document,"keydown",function(){
	var eventObj = Com_GetEventObject();
	var keyCode = eventObj.keyCode;  
    if (keyCode == 13) {   
    	var clickObj = document.getElementById("ok_id"); 		  
		 	 clickObj.click();
    }   
});
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
 });

function findOitems(){
	var fdCategoryId = document.getElementsByName("fdCategoryId")[0].value ; 
	var fdCategoryName = document.getElementsByName("fdCategoryName")[0].value ;
	var fdOitemsName = document.getElementsByName("fdOitemsName")[0].value ; 
	var fdOitemsNumber = document.getElementsByName("fdOitemsNumber")[0].value; 
	//Com_Submit(document.geesunOitemsListingForm, 'stockCount');
	//Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do" />?method=stockCount&categoryId='+fdCategoryId+'&categoryName='+fdCategoryName+'&fdOitemsName='+fdOitemsName+'&fdOitemsNumber='+fdOitemsNumber,'_self');
	document.getElementById("listIframe").src = '<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=stockCount" />&fdCategoryId='+fdCategoryId+'&fdCategoryName='+encodeURIComponent(fdCategoryName)
	+'&fdOitemsName='+encodeURIComponent(fdOitemsName)+'&fdOitemsNumber='+encodeURIComponent(fdOitemsNumber);
}		
function clear_value(){
	document.getElementsByName("fdCategoryId")[0].value = "";
	document.getElementsByName("fdCategoryName")[0].value = "";
	document.getElementsByName("fdOitemsName")[0].value = "";
	document.getElementsByName("fdOitemsNumber")[0].value = "";
	//location.href="${LUI_ContextPath }/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=showStockCount";
	document.getElementById("listIframe").src = '<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=stockCount" />';
}

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
<ui:tabpanel id="geesunOitemsShowStockCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsShowStockCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.stock.manage3') }">
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<div style="float:right;padding-right:30px">
				<ui:button text="${lfn:message('button.export') }" order="2" onclick="Com_SubmitNoEnabled(document.geesunOitemsListingForm, 'stockCountExport');">
				</ui:button>
			</div>
			<center>
			
			<div style="width:98%;padding-top:35px">
			<table width="70%" class="tb_normal">
				<tr>
				    <td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
					</td>
					<td><input class="inputsgl" type="text" name="fdOitemsName" style="width:95%" value="${lfn:escapeHtml(fdOitemsName)}"></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
					</td>
					<td><input class="inputsgl" type="text" style="width:95%" name="fdOitemsNumber" value="${lfn:escapeHtml(fdOitemsNumber)}"></td>		
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsManage"/>
					</td>
					<td colspan="3"> 
					   <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" style="width:98%" showStatus="edit" idValue="${fdCategoryId}" >
					          Dialog_SimpleCategory('com.landray.kmss.geesun.oitems.model.GeesunOitemsManage','fdCategoryId','fdCategoryName',true);
					   </xform:dialog>
					</td>
				</tr>
			</table>
			<br/>
			    <ui:button id="ok_id" text="${lfn:message('geesun-oitems:geesunOitems.button.search') }" order="2" onclick="findOitems();">
			    </ui:button>&nbsp;&nbsp;
			    <ui:button text="${lfn:message('geesun-oitems:geesunOitems.button.clear') }" order="2" onclick="clear_value();">
				</ui:button>
			<br/><br/>
			<div style="width:96%">
			
			<div>
				<iframe id="listIframe" width=100% height=100% frameborder=0  scrolling=no ></iframe>
			</div>
			
			</div>
			</center>
		</div>
	</ui:content>
</ui:tabpanel>		
</html:form>
	</template:replace>
</template:include>
