<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js|list.js");
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
function clear_data(){
	document.getElementsByName("fdStartTime")[0].value="";
	document.getElementsByName("fdEndTime")[0].value="";
	document.getElementsByName("fdCategoryId")[0].value="";
	document.getElementsByName("fdCategoryName")[0].value="";
	document.getElementsByName("fdDeptId")[0].value="";
	document.getElementsByName("fdDeptName")[0].value="";
	document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=receiveCountData" />';
	
 }
function isNullDate(){
	var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
	 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
	 if(fdStartTime == '' || fdEndTime == ''){
		 return true;
	 }
}	
function checkDate(){
	 if(isNullDate()){
		 dialog.alert('<bean:message bundle="km-oitems" key="kmOitems.error.message5"/>');
		 return false;
	 }
	 var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
	 var fdStartDate = fdStartTime.substr(0,10);
	 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
	 var fdEndDate = fdEndTime.substr(0,10);
	 var v3=new Date();
	 if((fdStartDate != '' && fdStartDate != undefined) && (fdEndDate != '' && fdEndDate != undefined) ) {
		 var v1 = Com_GetDate(fdStartDate);
		 var v2 = Com_GetDate(fdEndDate);
		 if(v1 <= v2 && v1 < v3 && v2 <= v3){
			 return true;
		 }else{
			 dialog.alert("<bean:message bundle="km-oitems" key="kmOitems.error.message2"/>");
			 return false;
		 }
	 }else if(fdStartDate != '' && fdStartDate != undefined){
		 var v1 = Com_GetDate(fdStartDate);
		 if(v1 >= v3){
			 dialog.alert("<bean:message bundle="km-oitems" key="kmOitems.error.message3"/>");
			 return false;
		 }else{
		     return true;
		 }
	 }else if(fdEndDate != '' && fdEndDate != undefined){
		 var v2 = Com_GetDate(fdEndDate);
		 if(v2 > v3){
			 dialog.alert("<bean:message bundle="km-oitems" key="kmOitems.error.message4"/>");
			 return false;
		 }else{
		 	return true;
		 }	 
	 }else{
		 return true;
	 }
}

window.onload =function (){
	setTimeout(dyniFrameSize,100);
	loadList();
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

function loadList(){
	if(!checkDate())
		return;
	var fdStartTime = $("input[name='fdStartTime']").val();
	var fdEndTime = $("input[name='fdEndTime']").val();
	var fdCategoryId = $("input[name='fdCategoryId']").val();
	var fdCategoryName = $("input[name='fdCategoryName']").val();
	var fdDeptId = $("input[name='fdDeptId']").val();
	var fdDeptName = $("input[name='fdDeptName']").val();
	document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=receiveCountData" />&fdStartTime='+fdStartTime+'&fdEndTime='+fdEndTime
	+'&fdCategoryId='+fdCategoryId+'&fdCategoryName='+encodeURIComponent(fdCategoryName)+'&fdDeptId='+fdDeptId+'&fdDeptName='+encodeURIComponent(fdDeptName);
}
</script>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
<ui:tabpanel id="kmOitemsToReceiveCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsToReceiveCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.reporting3') }">
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
			<div style="float:right;padding-right:30px">
					<ui:button text="${lfn:message('button.export') }" order="2" onclick="Com_SubmitNoEnabled(document.kmOitemsListingForm, 'receiveCountExport');">
					</ui:button>
			</div>
			<center>
			<div style="width:96%;padding-top:35px">	
			<table width="70%" class="tb_normal">
		           <tr>
						<td class="td_normal_title" width="15%"><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.start.time"/></td>
						<td width="25%">
						   <xform:datetime property="fdStartTime" dateTimeType="date" className="inputSgl" showStatus="edit" style="width:90%" value="${fdStartTime }"></xform:datetime>
						   <span class="txtstrong">*</span>
						</td>
						<td class="td_normal_title" width="15%"><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.end.time"/></td>
						<td width="25%">
						    <xform:datetime property="fdEndTime" dateTimeType="date" className="inputSgl" showStatus="edit" style="width:90%" value="${fdEndTime }"></xform:datetime>
						    <span class="txtstrong">*</span>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%"><bean:message  bundle="km-oitems" key="table.kmOitemsManage"/></td>
						<td width="25%">
						    <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" style="width:90%" showStatus="edit" idValue="${fdCategoryId}" nameValue="${fdCategoryName}">
					          Dialog_SimpleCategory('com.landray.kmss.km.oitems.model.KmOitemsManage','fdCategoryId','fdCategoryName',true);
					        </xform:dialog>
						</td>
						<td class="td_normal_title" width="15%"><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.dept"/></td>
						<td width="25%">
						    <xform:dialog propertyId="fdDeptId" propertyName="fdDeptName" style="width:90%" showStatus="edit" idValue="${fdDeptId}" nameValue="${fdDeptName}"> 
					          Dialog_Address(true, 'fdDeptId', 'fdDeptName', ';',ORG_TYPE_PERSON|ORG_TYPE_DEPT|ORG_TYPE_ORG);
					        </xform:dialog>
						</td>
					</tr>
			</table>
			</div>
			<br/>
				
				    <ui:button id="ok_id" text="${lfn:message('km-oitems:kmOitems.button.count') }" order="2" 
				      onclick="loadList();">
					</ui:button>&nbsp;&nbsp;
					<ui:button text="${lfn:message('km-oitems:kmOitems.button.clear') }" order="2" 
					  onclick="clear_data();">
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
