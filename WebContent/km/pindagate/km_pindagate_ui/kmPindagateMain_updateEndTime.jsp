<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog" >
	<template:replace name="content" >
	<script>Com_IncludeFile("calendar.js|jquery.js");</script>
	<script type="text/javascript">
		seajs.use(['lui/dialog', 'lui/jquery'],function(dialog,$) {
			//初始化结束调查时间
			LUI.ready(function(){ 	
				$("#docFinishedTime").val("${JsParam.docFinishedTime}");
				window.returnValue = null;
			});
			//确认
			window.btn_ok=function(){
				var dom = $('#docFinishedTime');
				if(!validationTime(dom))
					return;
				$dialog.hide( $("#docFinishedTime").val());
			};
			window.validationTime = function(){
				//调查完成时间
				var val=Date.parse( $("#docFinishedTime").val().replace(/\-/g,'/') );		
				var fdFinishDate = new Date(val);
				//当前时间
				var currentTime = new Date();
				var dom = $("#docFinishedTimeContainer");
				if(currentTime > fdFinishDate){
					window.showErrorMsg(dom,"<bean:message bundle='km-pindagate' key='kmPindagateMain.endDate.no.lt.currentDate'/>");
					return false;
				}else{
					$("#validate_desc").remove();
				}
				return true;
			};
			window.showErrorMsg = function(dom, message) {
				if($("#validate_desc").length == 0) {
					$(dom).parent().append('<div class="validation-advice" id="validate_desc" _reminder="true"><table class="validation-table"><tbody><tr><td><div class="lui_icon_s lui_icon_s_icon_validator"></div></td><td class="validation-advice-msg">'+message+'</td></tr></tbody></table></div>');
				}
			};
			//取消
			window.btn_cancel=function(){
				$dialog.hide(null);
			};
		});
	</script>
	<center>
	<br/>
	<p class="txttitle">
		<bean:message bundle="km-pindagate" key="button.updateIndagateEndTime"/>
	</p>
	<table class="tb_normal" width=90%  style="margin: 15px auto;">
		<tr>
			<td class="td_normal_title">
				<%--调查结束时间--%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.docFinishedTime"/>
			</td>
			<td>
				<div id="docFinishedTimeContainer" class="inputselectsgl" onclick="selectDateTime('docFinishedTime')" style="width:55%">
					<div class="input"><input type="text" id="docFinishedTime" name="docFinishedTime" onblur="validationTime(this)"></div>
					<div class="inputdatetime"></div>
				</div>
				<br>
				<font color="red"><bean:message bundle="km-pindagate" key="kmPindagateMain.tip.null.not.limit.time"/></font>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<ui:button text="${lfn:message('button.ok') }" onclick="btn_ok();"></ui:button>
				<ui:button text="${lfn:message('button.cancel') }" onclick="btn_cancel();" styleClass="lui_toolbar_btn_gray"></ui:button>
			</td>
		</tr>
	</table>
	<div style="height: 100px;"></div>
	</center>
	</template:replace>
</template:include>