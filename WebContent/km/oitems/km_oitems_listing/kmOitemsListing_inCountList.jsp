<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsWarehousingRecord"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js|list.js");
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
			document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=inCountData" />';
		 }
	 function isNullDate(){
			var fdStartTime =  document.getElementsByName("fdStartTime")[0].value;
			 var fdEndTime = document.getElementsByName("fdEndTime")[0].value;
			 if(fdStartTime == '' || fdEndTime == ''){
				 return true;
			 }
	 }
	function compareDate(obj1,obj2){
		var dtype1 = 'date';
		var dtype2 = 'date';
		obj1 == null || document.getElementsByName("fdStartTime")[0];
		obj2 == null || document.getElementsByName("fdEndTime")[0];
		// 日期类型的比较
		if((dtype1.indexOf("date")!=-1 && dtype2.indexOf("date")!=-1) ||
			(dtype1.indexOf("time")!=-1 && dtype2.indexOf("time")!=-1)){
			if(Trim(obj1.value.length)==0 || Trim(obj2.value.length)==0) return true;
			var format1 = dtype1.substring(dtype1.indexOf("(")+1,dtype1.indexOf(")"));	//日期时间格式
			var format2 = dtype2.substring(dtype2.indexOf("(")+1,dtype2.indexOf(")"));	//日期时间格式
			val1 = getDateByFormat(obj1.value, format1);
			val2 = getDateByFormat(obj2.value, format2);
			if(val1 > val2){
				obj1.focus();				
				dialog.alert("开始时间不能大于其结束时间！");
				return false;
			}
		}	
	}


	/*根据日期格式，将字符串转换成Date对象。
	格式：yyyy-年，MM-月，dd-日，HH-时，mm-分，ss-秒。
	（格式必须写全，例如:yy-M-d，是不允许的，否则返回null；格式与实际数据不符也返回null。）
	默认格式：yyyy-MM-dd HH:mm:ss,yyyy-MM-dd。*/
	function getDateByFormat(str){
		var dateReg,format;
		var y,M,d,H,m,s,yi,Mi,di,Hi,mi,si;
		if((arguments[1] + "") == "undefined") format = "yyyy-MM-dd HH:mm:ss";
		else format = arguments[1];
		yi = format.indexOf("yyyy");
		Mi = format.indexOf("MM");
		di = format.indexOf("dd");
		Hi = format.indexOf("HH");
		mi = format.indexOf("mm");
		si = format.indexOf("ss");
		if(yi == -1 || Mi == -1 || di == -1) return null;
		else{
			y = parseInt(str.substring(yi, yi+4),10);
			M = parseInt(str.substring(Mi, Mi+2),10);
			d = parseInt(str.substring(di, di+2),10);
		}
		if(isNaN(y) || isNaN(M) || isNaN(d)) return null;
		if(Hi == -1 || mi == -1 || si == -1) return new Date(y, M-1, d);
		else{
			H = str.substring(Hi, Hi+4);
			m = str.substring(mi, mi+2);
			s = str.substring(si, si+2);
		}
		if(isNaN(parseInt(y)) || isNaN(parseInt(M)) || isNaN(parseInt(d))) return new Date(y, M-1, d);
		else return new Date(y, M-1, d,H, m, s);
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
			document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=inCountData" />&fdStartTime='+fdStartTime+'&fdEndTime='+fdEndTime
			+'&fdCategoryId='+fdCategoryId+'&fdCategoryName='+encodeURIComponent(fdCategoryName)+'&fdDeptId='+fdDeptId+'&fdDeptName='+encodeURIComponent(fdDeptName);
		}
</script>
<script type="text/javascript" src="../js/tableSort.js"></script>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">
<ui:tabpanel id="kmOitemsInCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsInCountContent" title="${ lfn:message('km-oitems:kmOitems.tree.reporting1') }">
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<div style="float:right;padding-right:30px">
					<ui:button text="${lfn:message('button.export') }" order="2" onclick="Com_SubmitNoEnabled(document.kmOitemsListingForm, 'inCountExport');">
					</ui:button>
			</div>
			<center>
			<div  style="width:96%;padding-top:35px">	
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
						<td colspan="3">
						  <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" style="width:95%" showStatus="edit" idValue="${fdCategoryId}" nameValue="${fdCategoryName}">
					         Dialog_SimpleCategory('com.landray.kmss.km.oitems.model.KmOitemsManage','fdCategoryId','fdCategoryName',true);
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