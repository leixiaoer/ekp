<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsShoppingTrolley"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js|list.js");
</script>
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

function isNullDate(){
		var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
		 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
		 if(fdStartTime == '' || fdEndTime == ''){
			 return true;
		 }
}
 function clear_data(){
	document.getElementsByName("fdStartTime")[0].value="";
	document.getElementsByName("fdEndTime")[0].value="";
	document.getElementsByName("fdCategoryId")[0].value="";
	document.getElementsByName("fdCategoryName")[0].value="";
	document.getElementsByName("fdDeptId")[0].value="";
	document.getElementsByName("fdDeptName")[0].value="";
	document.getElementById("listIframe").src = '<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=outCountData" />';
 }
 function checkDate(){
	 if(isNullDate()){
		 dialog.alert('<bean:message bundle="geesun-oitems" key="geesunOitems.error.message5"/>');
		 return false;
	 }
	 var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
	 var fdStartDate = fdStartTime.substr(0,10);
	 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
	 var fdEndDate = fdEndTime.substr(0,10);
	 var v3=new Date();
	 if((fdStartDate != '' && fdStartDate != undefined) && (fdEndDate != '' && fdEndDate != undefined) ) {
		 /* var v1;
		 var v2;
		 var d1Arr=fdStartDate.split('-');
		 var d2Arr=fdEndDate.split('-');
		 if(d1Arr.length<3&&d2Arr.length<3){
			 d1Arr=fdStartDate.split('/');
			 d2Arr=fdEndDate.split('/');
			 v1=new Date(d1Arr[2],d1Arr[0]-1,d1Arr[1]);
			 v2=new Date(d2Arr[2],d2Arr[0]-1,d2Arr[1]);
	     }else{
			  v1=new Date(d1Arr[0],d1Arr[1]-1,d1Arr[2]);
			  v2=new Date(d2Arr[0],d2Arr[1]-1,d2Arr[2]);
	     }
		 if(v1 <= v2 && v1 < v3 && v2 <= v3){
			 return true;
		 }else{
			 dialog.alert("<bean:message bundle="geesun-oitems" key="geesunOitems.error.message2"/>");
			 return false;
		 } */
	  	var start=new Date(fdStartTime.replace("-", "/").replace("-", "/"));  
   	    var end=new Date(fdEndTime.replace("-", "/").replace("-", "/"));  
   	    if(end>=start && start < v3 && end <= v3){  
   	        return true;  
   	    }else{
			 dialog.alert("<bean:message bundle="geesun-oitems" key="geesunOitems.error.message2"/>");
			 return false;
		} 
	 }else if(fdStartDate != '' && fdStartDate != undefined){
		 var v1;
		 var d1Arr=fdStartDate.split('-');
		 if(d1Arr.length<3){
			 d1Arr=fdStartDate.split('/');
			 v1=new Date(d1Arr[2],d1Arr[0]-1,d1Arr[1]);
	     }else{
		    v1=new Date(d1Arr[0],d1Arr[1]-1,d1Arr[2]);
	     }
		 if(v1 >= v3){
			 dialog.alert("<bean:message bundle="geesun-oitems" key="geesunOitems.error.message3"/>");
			 return false;
		 }else{
		     return true;
		 }
	 }else if(fdEndDate != '' && fdEndDate != undefined){
		 var v2;
		 var d2Arr=fdEndDate.split('-');
		 if(d2Arr.length<3){
			 d2Arr=fdStartDate.split('/');
			 v2=new Date(d1Arr[2],d1Arr[0]-1,d1Arr[1]);
	     }else{
		     v2=new Date(d2Arr[0],d2Arr[1]-1,d2Arr[2]);
		 	}
		 if(v2 > v3){
			 dialog.alert("<bean:message bundle="geesun-oitems" key="geesunOitems.error.message4"/>");
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
			// ????????????
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
		document.getElementById("listIframe").src = '<c:url value="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=outCountData" />&fdStartTime='+fdStartTime+'&fdEndTime='+fdEndTime
		+'&fdCategoryId='+fdCategoryId+'&fdCategoryName='+encodeURIComponent(fdCategoryName)+'&fdDeptId='+fdDeptId+'&fdDeptName='+encodeURIComponent(fdDeptName);
	}
</script>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
<ui:tabpanel id="geesunOitemsOutCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsOutCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.reporting2') }">
		<div id="contentDiv" style="width:95%;min-height:500px;padding:20px">
		    <div style="float:right;padding-right:30px">
					<ui:button text="${lfn:message('button.export') }" order="2" onclick="Com_SubmitNoEnabled(document.geesunOitemsListingForm, 'outCountExport');">
					</ui:button>
			</div>
			<center>
			<div style="width:96%;padding-top:35px">	
			<table width="70%" class="tb_normal">
			       <tr>
						<td class="td_normal_title" width="15%"><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.start.time"/></td>
						<td width="25%">
						   <xform:datetime property="fdStartTime" dateTimeType="date" className="inputSgl" showStatus="edit" style="width:90%" value="${fdStartTime }"></xform:datetime>
						   <span class="txtstrong">*</span>
						</td>
						<td class="td_normal_title" width="15%"><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.end.time"/></td>
						<td width="25%">
						    <xform:datetime property="fdEndTime" dateTimeType="date" className="inputSgl" showStatus="edit" style="width:90%" value="${fdEndTime }"></xform:datetime>
						    <span class="txtstrong">*</span>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsManage"/></td>
						<td width="25%">
						   <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" style="width:90%" showStatus="edit" idValue="${fdCategoryId}" nameValue="${fdCategoryName}">
					          Dialog_SimpleCategory('com.landray.kmss.geesun.oitems.model.GeesunOitemsManage','fdCategoryId','fdCategoryName',true);
					       </xform:dialog>
						</td>
						<td class="td_normal_title" width="15%"><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.dept"/></td>
						<td width="25%">
						    <xform:dialog propertyId="fdDeptId" propertyName="fdDeptName" style="width:90%" showStatus="edit" idValue="${fdDeptId}" nameValue="${fdDeptName}">
					          Dialog_Address(true, 'fdDeptId', 'fdDeptName', ';',ORG_TYPE_PERSON|ORG_TYPE_DEPT|ORG_TYPE_ORG);
					        </xform:dialog>
						</td>
					</tr>			
			</table>
			</div>
			<br/>
				
				    <ui:button id="ok_id" text="${lfn:message('geesun-oitems:geesunOitems.button.count') }" order="2" 
				      onclick="loadList();">
					</ui:button>&nbsp;&nbsp;
					<ui:button text="${lfn:message('geesun-oitems:geesunOitems.button.clear') }" order="2" 
					  onclick="clear_data();">
					</ui:button>
				
			<br/><br/>
			
			<div style="width:96%"> 
			
			<div style="height:800px;">
				<iframe id="listIframe" width=100% height=100% frameborder=0  scrolling=no ></iframe>
			</div>
			
			</div>
			</center>
		</div>
	</ui:content>
</ui:tabpanel>		
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
