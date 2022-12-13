<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3"> 
			<c:choose>
				<c:when test="${ sysTimeLeaveAmountForm.method_GET == 'edit' }">
					<kmss:auth requestURL="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=update">
						<ui:button text="${ lfn:message('button.update') }" onclick="Com_Submit(document.sysTimeLeaveAmountForm, 'update');"></ui:button>
					</kmss:auth>
				</c:when>
				<c:when test="${ sysTimeLeaveAmountForm.method_GET == 'add' }">
					<kmss:auth requestURL="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=save">
						<ui:button text="${lfn:message('button.save') }" onclick="Com_Submit(document.sysTimeLeaveAmountForm, 'save');"></ui:button>
					</kmss:auth>
					<kmss:auth requestURL="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=saveadd">
						<ui:button text="${ lfn:message('button.saveadd') }" onclick="Com_Submit(document.sysTimeLeaveAmountForm, 'saveadd');"></ui:button>
					</kmss:auth>
				</c:when>
			</c:choose>
			<ui:button text="${ lfn:message('button.close') }" onclick="Com_CloseWindow();"></ui:button>	
		</ui:toolbar>
	</template:replace>
	<template:replace name="head">
		<style type="text/css">
		</style>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle" style="margin: 15px 0;">
			${ lfn:message('sys-time:table.sysTimeLeaveAmount') }
		</p>
		
		<html:form action="/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do">
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
		
			<div class="lui_form_content_frame" style="padding-top:20px">
				<c:choose>
					<c:when test="${ sysTimeLeaveAmountForm.method_GET == 'add' }">
						<%@ include file="/sys/time/sys_time_leave_amount/item/item_add.jsp" %>
					</c:when>
					<c:when test="${ sysTimeLeaveAmountForm.method_GET == 'edit' }">
						<%@ include file="/sys/time/sys_time_leave_amount/item/item_edit.jsp" %>
					</c:when>
				</c:choose>
			</div>	
		</html:form>
		
		<script type="text/javascript">
		var validation = $KMSSValidation(document.forms['sysTimeLeaveAmountForm']);
		seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
			
			// 改变人或年份，刷页面
			window.onChangePerson = window.onChangeYear = function() {
				var personId = $('[name="fdPersonId"]').val();
				var fdYear = $('[name="fdYear"]').val();
				if(personId && fdYear) {
					location.href = '${LUI_ContextPath}/sys/time/sys_time_leave_amount/sysTimeLeaveAmount.do?method=add'
							+ '&personId=' + personId + '&year=' + fdYear;
				}
			};
			
			// 改变总天数，更新剩余天数
			window.onChangeTotal = function(value, element){
				if(element && value){
					var fieldName = $(element).attr('name');
					var restDayName = fieldName.match(/fdAmountItems\[\d+\]/g)[0] + '.fdRestDay';
					var usedDayName = fieldName.match(/fdAmountItems\[\d+\]/g)[0] + '.fdUsedDay';
					
					var usedDay = parseFloat($('[name="'+ usedDayName +'"]').val() || '0');
					var restDay = parseFloat(value) - usedDay;
					
					$('[name="'+ restDayName +'"]').val(restDay);
				}
			};
			
			// 改变有效日期，更新有效字段
			window.onChangeVDate = function(value, element) {
				if(element && value){
					var fieldName = $(element).attr('name');
					var perfix = fieldName.match(/fdAmountItems\[\d+\]/g)[0];
					var isAvail = isAfterToday(value);
					$('[name="'+ perfix + '.fdIsAvail' +'"]').val(isAvail);
				}
			};
			
			var isAfterToday = function(date) {
				if(date) {
					var dateObj = Com_GetDate(date, 'date', Com_Parameter.Date_format);
					if(dateObj){
						var today = new Date();
						today.setHours(0,0,0,0);
						if(today.getTime() > dateObj.getTime()){
							return false;
						}
					}
				}
				return true;
			};
			
			validation.addValidator('fraction', "${ lfn:message('sys-time:sysTimeLeaveRule.atMostHalf') }", function(v, e, o){
				if(v && e){
					return /^[0-9]+(\.[05])?$/g.test(v);
				}
			});
			
			validation.addValidator('yearUnique', "${ lfn:message('sys-time:sysTimeLeaveAmount.yearUnique') }", function(){
				var personId = $('[name="fdPersonId"]').val();
				var _years = $('[name="_years"]').val();
				var fdYear = $('[name="fdYear"]').val();
				if(personId && _years && fdYear){
					var yearArr = _years.split(';');
					for(var i in yearArr){
						if(fdYear == yearArr[i]){
							return false;
						}
					}
				}
				return true;
			});
			validation.addValidator('validDateRange', "${ lfn:message('sys-time:sysTimeLeaveAmount.validDateRange') }", function(v, e, o){
				var fdYear = $('[name="fdYear"]').val();
				if(v && fdYear){
					var validDate = Com_GetDate(v, 'date', Com_Parameter.Date_format);
					if(validDate) {
						var maxDate = new Date();
						maxDate.setFullYear(parseInt(fdYear) + 1, 11, 31);
						maxDate.setHours(0,0,0,0);
						
						var minDate = new Date();
						minDate.setFullYear(parseInt(fdYear), 0, 1);
						minDate.setHours(0,0,0,0);
						if(maxDate.getTime() < validDate.getTime() || minDate.getTime() > validDate.getTime()){
							return false;
						}
					}
				}
				return true;
			});
			validation.addValidator('largerThanUsed', "${ lfn:message('sys-time:sysTimeLeaveAmount.largerThanUsed') }", function(v, e, o){
				if(v && e){
					var fieldName = $(e).attr('name');
					var usedDayFieldName = fieldName.match(/fdAmountItems\[\d+\]/g)[0] + '.fdUsedDay';
					var fdUsedDay = $('[name="'+usedDayFieldName+'"]').val();
					if(fdUsedDay){
						if(parseFloat(v) < parseFloat(fdUsedDay)){
							return false;
						}
					}
				}
				return true;
			});
		});
		</script>
	</template:replace>
</template:include>