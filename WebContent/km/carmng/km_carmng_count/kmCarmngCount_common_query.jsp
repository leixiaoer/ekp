<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<table width="98%" class="tb_normal">
		<tr>
			<td class="td_normal_title" width="10%"><bean:message bundle="km-carmng" key="kmCarmngCount.common.query.interval"/></td>
			<td width="40%">
				<xform:radio property="fdTimeType" onValueChange="chgTimeSelect" showStatus="edit" value="${fdTimeType }" >
			            <xform:enumsDataSource enumsType="kmCarmngCount_type_withOutDay">
						</xform:enumsDataSource>
				</xform:radio>
			</td>
			<td class="td_normal_title" width="10%"><bean:message bundle="km-carmng" key="kmCarmngCount.common.query.time"/></td>
			<td id="timeScope_0" name="timeScope" width="50%">
				<input type='hidden' name='fdTimeType_5' value='5'/>
				<kmss:period property="fdStartDate_0" periodTypeName="fdTimeType_5" value="${fdStartDate }" onChangeExAfter="setCurrTimeVal();"/>
				<bean:message  bundle="km-carmng" key="kmCarmngCount.fdEveTime.to"/>
				<kmss:period property="fdEndDate_0" periodTypeName="fdTimeType_5" value="${fdEndDate}" onChangeExAfter="setCurrTimeVal();"/>
			</td>
			<td id="timeScope_1" name="timeScope" width="50%">
				<input type='hidden' name='fdTimeType_3' value='3'/>
				<kmss:period property="fdStartDate_1" periodTypeName="fdTimeType_3" value="${fdStartDate }" onChangeExAfter="setCurrTimeVal();"/>
				<bean:message  bundle="km-carmng" key="kmCarmngCount.fdEveTime.to"/>
				<kmss:period property="fdEndDate_1" periodTypeName="fdTimeType_3" value="${fdEndDate }" onChangeExAfter="setCurrTimeVal();"/>
			</td>
			<td id="timeScope_2" name="timeScope" width="50%">
				<input type='hidden' name='fdTimeType_1' value='1'/>
				<kmss:period property="fdStartDate_2" periodTypeName="fdTimeType_1" value="${fdStartDate}" onChangeExAfter="setCurrTimeVal();"/>
				<bean:message  bundle="km-carmng" key="kmCarmngCount.fdEveTime.to"/>
				<kmss:period property="fdEndDate_2" periodTypeName="fdTimeType_1"  value="${fdEndDate}" onChangeExAfter="setCurrTimeVal();"/>
			</td>
			<td id="timeScope_3" name="timeScope" width="50%">
				<input type='hidden' name='fdTimeType_7' value='7'/>
				<div class="inputselectsgl" onclick="selectDate('fdStartDate_3',null,setCurrTimeVal,setCurrTimeVal);" style="width: 30%">
					<div class="input"><input type="text" name="fdStartDate_3" value="${fdStartDate }"></div>
					<div class="inputdatetime"></div>
				</div>
				<bean:message  bundle="km-carmng" key="kmCarmngCount.fdEveTime.to"/>
				<div class="inputselectsgl" onclick="selectDate('fdEndDate_3',null,setCurrTimeVal,setCurrTimeVal);" style="width: 30%">
					<div class="input"><input type="text" name="fdEndDate_3" value="${fdEndDate }"></div>
					<div class="inputdatetime"></div>
				</div>
			</td>
		</tr>
		<c:if test="${param.type == 'dept' }">
			<tr>
				<td class="td_normal_title"><bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdDeptIds"/></td>
				<td colspan="3">
					<input class="inputsgl" type="hidden" name="fdDeptIds" value="${fdDeptIds}">
					<input class="inputsgl" type="text" name="fdDeptNames" value="${fdDeptNames}">
					<a id="a_dept_id" href="#"
						onclick="Dialog_Address(true, 'fdDeptIds', 'fdDeptNames', ';',ORG_TYPE_DEPT);"><bean:message
						key="dialog.selectOther" /></a>
					<input type="checkbox" name="deptAll" id='deptAll' value="1"><bean:message bundle="km-carmng" key="kmCarmngCount.common.query.incline" /><span class="txtstrong">*</span>
				</td>
			</tr>
		</c:if>
		
		<c:if test="${param.type == 'person' }">
			<tr>
				<td class="td_normal_title"><bean:message key="kmCarmngRegisterInfo.fdUser" bundle="km-carmng" /></td>
				<td colspan="3" >
					<input class="inputsgl" type="hidden" name="fdPersonIds" value="${fdPersonIds}">
					<input class="inputsgl" type="text" name="fdPersonNames" value="${fdPersonNames}">
					<a id="a_dept_id" href="#"
						onclick="Dialog_Address(true, 'fdPersonIds', 'fdPersonNames', ';','');"><bean:message
						key="dialog.selectOther" /></a><span class="txtstrong">*</span>
				</td>
			</tr>		
		</c:if>
		
		<c:if test="${param.type == 'driver' }">
			<tr>
				<td class="td_normal_title"><bean:message key="kmCarmngDispatchersInfo.fdDriverId" bundle="km-carmng" /></td>
				<td colspan="3">
					<input class="inputsgl" type="hidden" name="fdDriverId" value="${fdDriverId}">
					<input class="inputsgl" type="text" name="fdDriverName" value="${fdDriverName}">
					<a id="a_dept_id" href="#"
						onclick="Dialog_TreeList(true, 'fdDriverId', 'fdDriverName', ';', 
							 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
							 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>',
							 'kmCarmngDriverInfoTreeService&motorcadeId=!{value}', null,
							 null, null, null,
							 '<bean:message key="table.kmCarmngDriversInfo" bundle="km-carmng"/>')" /><bean:message key="dialog.selectOther" /></a><span class="txtstrong">*</span>
				</td>
			</tr>		
		</c:if>
		
		<c:if test="${param.type == 'carFee' }">
			<tr>
				<td class="td_normal_title"><bean:message key="kmCarmng.select" bundle="km-carmng" /></td>
				<td colspan="3">
					<input class="inputsgl" type="hidden" name="fdCarInfoId" value="${fdCarInfoId}">
					<input class="inputsgl" type="text" name="fdCarInfoNo" value="${fdCarInfoNo}">
					<a href="#"
						onclick="Dialog_TreeList(true, 'fdCarInfoId', 'fdCarInfoNo', ';', 
				 'kmCarmngMotorcadeSetTreeService&categoryId=!{value}', 
				 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>',
				 'kmCarmngInfomationTreeService&fdMotorcadeId=!{value}&kind=dispatcher', null,
				 null, null, null,
				 '<bean:message key="table.kmCarmngInfomation" bundle="km-carmng"/>')"><bean:message
						key="dialog.selectOther" /> </a><span class="txtstrong">*</span>
				</td>
			</tr>		
		</c:if>
</table>
<script type="text/javascript">
	//设置当前的设置的时间区间
	var setCurrTimeVal = function(){
		var timeType = $("input[name='fdTimeType']:checked").val();
		if(timeType!=null && timeType!=''){
			 $("input[name='fdStartDate']").val($("*[name='fdStartDate_"+timeType+"']").val());
			 $("input[name='fdEndDate']").val($("*[name='fdEndDate_"+timeType+"']").val());
		}
	}; 
	//显示当前的时间区间设置
	var chgTimeSelect = function(){
		var timeType = $("input[name='fdTimeType']:checked").val();
		$("td[name='timeScope']").hide();
		$("td[id='timeScope_"+timeType+"']").show();
		setCurrTimeVal();
	};
	
	//设置初始化时间区间显示并显示当前时间区间
	Com_AddEventListener(window,'load',function(){
		var timeType = $("input[name='fdTimeType']:checked").val();
		if(timeType=='' || timeType==null){
			timeType = '0';
			$("input[name='fdTimeType'][value='"+timeType+"']").prop("checked",true);
		}
		window.chgTimeSelect();
	});
	
	function clear_data(){
		if(document.getElementsByName("fdDriverId").length > 0){
			document.getElementsByName("fdDriverId")[0].value="";
			document.getElementsByName("fdDriverName")[0].value="";
		}
		if(document.getElementsByName("fdDeptIds").length > 0){
			document.getElementsByName("fdDeptIds")[0].value="";
			document.getElementsByName("fdDeptNames")[0].value="";
		}
		if(document.getElementsByName("fdPersonIds").length > 0){
			document.getElementsByName("fdPersonIds")[0].value="";
			document.getElementsByName("fdPersonNames")[0].value="";
		}
		if(document.getElementsByName("fdCarInfoId").length > 0){
			document.getElementsByName("fdCarInfoId")[0].value="";
			document.getElementsByName("fdCarInfoNo")[0].value="";
		}
	 }	
	
</script>
