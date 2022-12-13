<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.simple">
<template:replace name="body">
<script type="text/javascript" src="../js/tableSort.js"></script>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|calendar.js", null, "js");
</script>
<script type="text/javascript">
	seajs.use(['theme!form']);
</script>
<script language="javascript" for="document" event="onkeydown">   
       var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;   
       if (keyCode == 13) {  
       	var clickObj = document.getElementById("ok_id"); 		  
 		 	 clickObj.click();
       }    
</script> 
<script>
function clear_data(){
	document.getElementsByName("fdStartTime")[0].value="";
	document.getElementsByName("fdEndTime")[0].value="";
}
</script>
		
<html:form action="/km/carmng/km_carmng_dispatchers_info_list/kmCarmngDispatchersInfoList.do">
<ui:tabpanel id="kmCarmngListUsePanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmCarmngListUseContent" title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher3') }">
	    <div style="padding-top: 20px">
			<table width="98%" class="tb_normal">
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
		<div style="text-align: center;margin-top: 10px;margin-bottom:10px">
			 <ui:button text="${lfn:message('km-carmng:kmCarmng.button2') }" order="1" onclick="Com_Submit(document.kmCarmngDispatchersInfoListForm, 'search');">
			 </ui:button>&nbsp;&nbsp;
			  <ui:button text="${lfn:message('km-carmng:kmCarmng.button3') }" order="2" onclick="clear_data();">
			 </ui:button>&nbsp;&nbsp;
			 <ui:button text="${lfn:message('km-carmng:kmCarmng.button1') }" order="3" onclick="Com_SubmitNoEnabled(document.kmCarmngDispatchersInfoListForm, 'saveExportExcel');">
			 </ui:button>
		</div>
		</ui:content>
	</ui:tabpanel>	
</html:form>
		
<div class="lui_dispatcher_search" style="height:450px;">
	<table id="table_id" class="tb_normal"   width="98%" >
		<tr class="tr_normal_title" height="30px" >
			<td width="4%">
				<bean:message key="page.serial"/>
			</td>
			<td width="8%">
				<bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId"/>
			</td>
			<td width="7%">
				<bean:message  bundle="km-carmng" key="kmCarmngInfomation.docSubject"/>
			</td>
		    <!--调度开始时间-->
		    <td width="11%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime"/></td>
		    <!--调度结束时间-->
			<td width="11%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime"/></td>
			<td width="11%"><bean:message  bundle="km-carmng" key="kmCarmngDispatchersInfo.fdTravelPath"/></td>
			 <!--回车开始时间-->
			<td width="11%"><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime"/></td>
			 <!--回车结束时间-->
			<td width="11%"><bean:message  bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime"/></td>
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
		<c:forEach items="${kmCarmngDispatchersInfoList}" var="kmCarmngDispatchersInfoList" varStatus="vstatus">
		<tr KMSS_IsContentRow="1" height="30px">
			<td>
				${vstatus.index+1}
			</td>
			<td>
				${kmCarmngDispatchersInfoList.fdCarInfoNo}
			</td>
			<td>
				${kmCarmngDispatchersInfoList.fdCarInfoName}
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfoList.fdDispatchersInfo.fdStartTime}"/>
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfoList.fdDispatchersInfo.fdEndTime}"/>
			</td>
			<td>
			 	<c:if test="${not empty pathJson[kmCarmngDispatchersInfoList.fdId]}">
                    ${pathJson[kmCarmngDispatchersInfoList.fdId]}
                 </c:if>
	         </td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfoList.fdRegisterInfo.fdStartTime}"/>
			</td>
			<td>
				<kmss:showDate value="${kmCarmngDispatchersInfoList.fdRegisterInfo.fdEndTime}"/>
			</td>
			
			<td>
				${kmCarmngDispatchersInfoList.fdRegisterInfo.fdMileageNumber}
			</td>
			<td>
				${kmCarmngDispatchersInfoList.fdDriverName}
			</td>
			<td>
				<sunbor:enumsShow value="${kmCarmngDispatchersInfoList.fdFlag}" enumsType="kmCarmngDispatchersInfo_fdFlag"/>
			</td>
		</tr>
		</c:forEach>
	</table>
	</div>
</template:replace>
</template:include>