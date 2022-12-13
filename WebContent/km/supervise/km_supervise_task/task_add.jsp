<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ page import="java.util.*"%>

<table class="tb_normal" width=95% id="TABLE_DocList" align="center" style="table-layout:fixed;">
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" style="width:5%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.xuhao"/>
		</td>
		<%--工作事项--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.workItem"/>
		</td>
		<%--协办单位--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.co-organizer"/>
		</td>
		<%--协办单位责任人--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="enums.warn.40"/>
		</td>
		<%--反馈周期--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
		</td>
		<%--计划开始--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.plan.startTime"/>
		</td>
		<%--计划结束--%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.plan.endTime"/>
		</td>
		<%-- 计划内容 --%>
		<td class="td_normal_title" style="width: 15%">
			<bean:message bundle="km-supervise" key="kmSuperviseTask.docContent"/>
		</td>
		<%--添加按钮--%>
		<td class="td_normal_title" style="width: 5%;text-align: center;">
			<a id="add2"  href="#" onclick="addRow();">
				<img src="${KMSS_Parameter_StylePath}/icons/add.gif" border="0" />
			</a>
		</td>
	</tr>
	
	<!-- 基准行 -->
	<tr KMSS_IsReferRow="1" style="display: none">
		<td KMSS_IsRowIndex="1" width="3%"></td>
		<td width="10%" >
			<html:hidden property="fdItems[!{index}].fdId" value=""/>
			<xform:text property="fdItems[!{index}].docSubject" required="true" style="width:90%" validators="maxLength(200)" />
		</td>
		<td width="10%" >
			<xform:address propertyId="fdItems[!{index}].fdOrganizerId" propertyName="fdItems[!{index}].fdOrganizerName" orgType="ORG_TYPE_DEPT" style="width:90%;" required="true"/>
		</td>
		<td width="10%" >
			<xform:address propertyId="fdItems[!{index}].fdOrganizerDutyId" propertyName="fdItems[!{index}].fdOrganizerDutyName" orgType="ORG_TYPE_PERSON" required="true" style="width:90%;" />
		</td>
		<%--反馈周期--%>
		<td width=10%>
			<xform:select property="fdItems[!{index}].fdPeriod" required="true" style="width:105px;"><xform:enumsDataSource enumsType="km_supervise_task_period" /></xform:select>
		</td>
		<td width="10%">
			<xform:datetime property="fdItems[!{index}].fdPlanStartTime" style="width:90%;" dateTimeType="datetime" required="true"/>
		</td>
		<td width="10%">
			<xform:datetime property="fdItems[!{index}].fdPlanEndTime" required="true" style="width:90%;" dateTimeType="datetime"/>
		</td>
		<td width="10%">
			<xform:textarea property="fdItems[!{index}].docContent" style="width:90%"/>
		</td>
		<!-- 删除、上移、下移按钮 -->
		<td width=5%" align="center">
			<a href="#" onclick="deleteRow();"><img
				src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
		</td>
	</tr>
	
</table>
<script type="text/javascript">
	var deleteIds = "";
	//增加行
	function addRow(){
		var fieldValues = new Object();
		<%-- fieldValues["fdItems[!{index}].fdStockerId"]="<%=UserUtil.getUser().getFdId()%>";
		fieldValues["fdItems[!{index}].fdStockerName"]="<%=UserUtil.getUser().getFdName()%>"; --%>
		/* var date=new Date();
	    var month = "";
	    var day =  "";
		if(date.getMonth() < 9){
			month = "0"+(date.getMonth()+1);
		}else{
			month = ""+(date.getMonth()+1);
		}
		if(date.getDate() < 10){
			day = "0"+date.getDate();
		}else{
			day = ""+date.getDate();
		} */
		/* if((Com_Parameter['Lang'])=="zh-cn" || (Com_Parameter['Lang'])=="zh-hk"){
		   fieldValues["fdItems[!{index}].fdStockDate"]=date.getFullYear()+"-"+month+"-"+day;
		}else if((Com_Parameter['Lang'])=="en-us"){
			fieldValues["fdItems[!{index}].fdStockDate"]=month+"/"+day+"/"+date.getFullYear();
		} */
		DocList_AddRow("TABLE_DocList");
	}
	
	//删除行
	function deleteRow(){
		var optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		var index = rowIndex-1;
		var fdId = $('#TABLE_DocList').find("tr").eq(rowIndex).find("input[name='fdItems["+index+"].fdId']").val();
		if(fdId != null && fdId.length > 0){
			if(deleteIds == null || deleteIds.length ==0){
				deleteIds = fdId;
			}else{
				deleteIds = deleteIds + "," + fdId;
			}
		}
		console.log(deleteIds);
		DocList_DeleteRow();
	}

</script>
<c:if test="${kmSuperviseMainForm.method_GET=='add'}">
	<script type="text/javascript">
	
		window.onload = function() {
			setTimeout(function(){
				addRow();
			},50);
			$('#top').hide();
		};
		
	</script>
</c:if>

<c:if test="${kmSuperviseMainForm.method_GET=='edit'}">
<script type="text/javascript">
	window.onload = function() {
		var data = new KMSSData();
		var status = "";
		var url = "${KMSS_Parameter_ContextPath}sys/task/sys_task_main/sysTaskMain.do?method=findByModelId&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain&fdModelId=${kmSuperviseMainForm.fdId }";
	    data.SendToUrl(url, function(data) {
			var results = eval("(" + data.responseText + ")");
			/* $("#TABLE_DocList tr:not(:first)").remove(); */
			if (results.length > 0) {
				lineCount = 0;
				for(var i=0;i<results.length;i++){
					
					var fieldValues = new Object();
					fieldValues["fdItems[!{index}].fdId"]=results[i].fdId;
					fieldValues["fdItems[!{index}].docSubject"]=results[i].docSubject;
					fieldValues["fdItems[!{index}].fdOrganizerId"]=results[i].fdOrganizerId;
					fieldValues["fdItems[!{index}].fdOrganizerName"]=results[i].fdOrganizerName;
					fieldValues["fdItems[!{index}].fdPeriod"]=results[i].fdPeriod;
					fieldValues["fdItems[!{index}].fdOrganizerDutyId"]=results[i].fdPerformId;
					fieldValues["fdItems[!{index}].fdOrganizerDutyName"]=results[i].fdPerformName;
					fieldValues["fdItems[!{index}].fdPlanStartTime"]=results[i].fdPlanStartTime;
					fieldValues["fdItems[!{index}].fdPlanEndTime"]=results[i].fdPlanCompleteDate + " " + results[i].fdPlanCompleteTime;
					fieldValues["fdItems[!{index}].docContent"]=results[i].docContent;
					
					DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
			   }
			}
		})
		$('#top').hide();
	};
	
</script>
</c:if>