<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	 //后续改成参数配置参数配置	
     pageContext.setAttribute("ImageW",300);
     pageContext.setAttribute("ImageH",100);
%>
<template:include ref="default.simple"  sidebar="auto">
	<template:replace name="body"> 
		<style>
			.pindagate_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
			.pindagate_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
		</style>
		<html:form action="/km/pindagate/km_pindagate_reject/kmPindagateRejectPerson.do" >
			<input type="hidden" value="" name="responseTime"/>
			<html:hidden property="kmPindagateId" value="${param.pindageteId}"/>
			<html:hidden property="method_GET" />
			<html:hidden property="personId" value="${KMSS_Parameter_CurrentUserId}"/>
			<div id="content" style="padding:10px 0 0 10px;">
				<div style="margin-bottom:10px;"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.writingReasons"/></div>
				<xform:textarea style="resize:none;"  htmlElementProperties="cols='77' rows='10'" required="true" property="rejectReason"></xform:textarea>
				<div id="validateErr" style="display:none;color:red;font-size:12px;">请输入拒绝调查的原因</div>	
			</div>
			<script>
				seajs.use(['lui/dateUtil'],function(dateFormat){
					window.responseTime = dateFormat.formatDate(new Date,Com_Parameter.DateTime_format);
				})
				window.commitForm = function(){
					var date = new Date();
					$("input[name=responseTime]").val(window.responseTime);
					if(!$("textarea").val()){
						$("#validateErr").show();
					}else{
						$("#validateErr").hide();
						//Com_Submit(document.kmPindagateRejectPersonForm,'save');
						$.ajax({
							url:'kmPindagateRejectPerson.do?method=save',
							type:'POST',
							data:$(document.kmPindagateRejectPersonForm).serializeArray(),
							success:function(data){
								if(data){
									window.parent.location.href="${LUI_ContextPath}/km/pindagate/km_pindagate_response/kmPindagateResponse.do?method=add&pindageteId=${param.pindageteId}";
								}
							}
						});
					}
				}
			</script>
		</html:form>
	</template:replace>
</template:include>