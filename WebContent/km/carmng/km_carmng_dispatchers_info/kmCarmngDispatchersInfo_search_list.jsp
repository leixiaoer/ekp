<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript" src="../js/tableSort.js"></script>

<script type="text/javascript">
	Com_IncludeFile("dialog.js|calendar.js", null, "js");
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
		document.getElementsByName("fdCarInfoNo")[0].value="";
	 }	
	function checkDate(){
	
		 var fdStartDate=document.getElementsByName("fdStartTime")[0].value;
			var fdEndDate = document.getElementsByName("fdEndTime")[0].value;
		    var nowDate=new Date();
		    var now=nowDate.getFullYear()+"-";
		    now = now+(nowDate.getMonth()+1)+"-";
		    now = now+nowDate.getDate();
		    now = now.replace(/-/g,"/");
		    fdStartDate=fdStartDate.replace(/-/g,"/");
		    fdEndDate = fdEndDate.replace(/-/g,"/");
			if(Date.parse(fdStartDate)-Date.parse(fdEndDate)>0){
				 alert("<bean:message bundle="km-carmng" key="kmCarmng.error.message5"/>");
				 return false; 
			 }
	}	
</script>
<script language="javascript" for="document" event="onkeydown">   
        var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;   
        if (keyCode == 13) {   
        	var clickObj = document.getElementById("ok_id"); 		  
  		 	 clickObj.click();
        }    
</script> 
		
<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do">
        <div id="optBarDiv">
        	<input type=button value="<bean:message bundle="km-carmng" key="kmCarmng.button1"/>"
			onclick="Com_SubmitNoEnabled(document.kmCarmngDispatchersInfoForm, 'saveExportExcel');">
        </div>
	    <div >
		<table width="80%" class="tb_normal">
				<tr>
					<td class="td_normal_title" width="15%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/></td>
					<td width="35%">
						<xform:datetime value="${fdStartTime }" property="fdStartTime" showStatus="edit"></xform:datetime>
					</td>
					<td class="td_normal_title" width="15%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/></td>
					<td width="35%">
							<xform:datetime property="fdEndTime" value="${fdEndTime }" showStatus="edit"></xform:datetime>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/></td>
					<td colspan="3">
						<input class="inputsgl" type="text" name="fdCarInfoNo"  value="${lfn:escapeHtml(fdCarInfoNo)}">
					</td>				
				</tr>		
		</table>
		</div>
		<div style="text-align: center;margin-top: 5px;">
		  <input type="button" value="${lfn:message('km-carmng:kmCarmng.button2') }"
		    onclick="checkDate();Com_Submit(document.kmCarmngDispatchersInfoForm, 'search');" class="btnopt" style="margin-bottom:10px">
	        &nbsp;&nbsp;&nbsp;&nbsp;
	      <input type="button" value="<bean:message bundle="km-carmng" key="kmCarmng.button3"/>" 
	         onclick="clear_data();" class="btnopt" style="margin-bottom:10px">
		</div>
</html:form>
		
<div style="width:99.8%;height:450px;">
	<table id="table_id" class="tb_normal"   width="100%" >
		<tr class="tr_normal_title" height="30px" >
			<td width="4%">
				<bean:message key="page.serial"/>
			</td>
			<td width="7%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
			</td>
			<td width="7%">
				<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
			</td>
		    <!--调度开始时间-->
		    <td width="12%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/></td>
		    <!--调度结束时间-->
			<td width="12%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/></td>
			 <!--回车开始时间-->
			<td width="12%"><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/></td>
			 <!--回车结束时间-->
			<td width="12%"><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/></td>
			<td width="7%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDestination"/>
			</td>
			<td width="10%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdTravelPath"/>
			</td>
			<!--行驶里程-->
			<td  width="6%">
				<bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
			</td>
			<td width="6%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriverId"/>
			</td>
			<td width="4%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdFlag"/>
			</td>
		</tr>
		<c:forEach items="${kmCarmngDispatchersInfoList}" var="kmCarmngDispatchersInfo" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" height="30px" onmouseover="this.style.background='#cccccc'"
				    onmouseout="this.style.background=''">
			<td>
				${vstatus.index+1}
			</td>
			<td>
				${kmCarmngDispatchersInfo.fdCarInfo.fdNo}
			</td>
			<td>
				${kmCarmngDispatchersInfo.fdCarInfo.docSubject}
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfo.fdStartTime}"/>
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfo.fdEndTime}"/>
			</td>
			
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfo.fdRegisterInfo.fdStartTime}"/>
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfo.fdRegisterInfo.fdEndTime}"/>
			</td>
			
			<td>
				${kmCarmngDispatchersInfo.fdDestination}
			</td>
			<td>
				${kmCarmngDispatchersInfo.fdTravelPath}
			</td>
			
			<td>
				${kmCarmngDispatchersInfo.fdRegisterInfo.fdMileageNumber}
			</td>
			<td>
				${kmCarmngDispatchersInfo.fdDriverName}
			</td>
			<td>
				<sunbor:enumsShow value="${kmCarmngDispatchersInfo.fdFlag}" enumsType="kmCarmngDispatchersInfo_fdFlag"/>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
<%@ include file="/resource/jsp/edit_down.jsp"%>
