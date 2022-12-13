<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	<%--标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-supervise:table.kmSuperviseBack')} - ${ lfn:message('km-supervise:module.km.supervise') }"></c:out>	
	</template:replace>
	<template:replace name="head">
        <style type="text/css">
            .lui_form_body{background:white;}
            .imageSlider { margin:0;padding:0; height:20px; width:265px; background-image:url("${KMSS_Parameter_ContextPath}km/supervise/resource/images/horizBg.png"); }
			.imageBar    { margin:0;padding:0; height:15px; width:14px; background-image:url("${KMSS_Parameter_ContextPath}km/supervise/resource/images/horizSlider.png"); }
        </style>
        <script type="text/javascript">
            var formInitData = {

            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_back/", 'js', true);
        </script>
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<c:choose>
				<%--add页面的按钮--%>
				<c:when test="${ kmSuperviseBackForm.method_GET == 'add' }">
					<ui:button text="${lfn:message('button.update') }" order="2" onclick="Com_Submit(document.kmSuperviseBackForm, 'save');">
					</ui:button>
				</c:when>
				<%--edit页面的按钮--%>
				<c:when test="${ kmSuperviseBackForm.method_GET == 'edit' }">
					<ui:button text="${lfn:message('button.update') }" order="2" onclick="Com_Submit(document.kmSuperviseBackForm, 'update');">
					</ui:button>
				</c:when>
			</c:choose>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	
	<%--督办反馈表单--%>
	<template:replace name="content"> 
		<html:form action="/km/supervise/km_supervise_back/kmSuperviseBack.do">
		    <p class="lui_form_subject">${ lfn:message('km-supervise:table.kmSuperviseBack') }</p>
	        <div class="lui_form_content_frame" >
	            <table class="tb_normal" width="95%">
	                <tr>
						<!-- 反馈人 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson" />
						</td>
						<td width="35%">
							<xform:address propertyName="fdPersonName" propertyId="fdPersonId" showStatus="readOnly"></xform:address>
						</td>
						<!-- 任务进度 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
						</td>
						<td width="35%">
							<html:text style="width:25px" property="fdProgress" onchange="setProgress();"/>%
							<span id="fdProgreeAuto_id">
								<div id="sliderProcess" style="height:15px;margin:5px 0px 5px 0px"></div>
							</span>
						</td>
					</tr>
					
					<tr>
						<!-- 反馈单位 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdUnit" />
						</td>
						<td>
							<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="readOnly" required="true"/>
						</td>
						<!-- 反馈时间 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime" />
						</td>
						<td>
							<xform:datetime property="fdFeedbackTime" />
						</td>
					</tr>
					<!-- 所属阶段 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.suoShuJieDuan" /> 
						</td>
						<td colspan="3">
							<xform:datetime property="fdStartTime" required="true"/>&nbsp;<bean:message bundle="km-supervise" key="kmSuperviseBack.suoShuJieDuan.to" />&nbsp;<xform:datetime property="fdEndTime" required="true"/>
						</td>
					</tr>
					<!-- 督办要求 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdRequire" />
						</td>
						<td colspan="3">
							<xform:textarea property="fdRequire" style="width:98%;"/>
						</td>
					</tr>
					<!-- 落实情况 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdResult" />
						</td>
						<td colspan="3">
							<xform:textarea property="fdResult" style="width:98%;"/>
						</td>
					</tr>
					<!-- 相关附件 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
						</td>
						<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attBack"/>
							</c:import>	
						</td>
					</tr>
	            </table>
	        </div>
		    <html:hidden property="fdId" />
		    <html:hidden property="method_GET" />
		    <html:hidden property="fdSuperviseId" />
		    <script type="text/javascript" src="${KMSS_Parameter_ContextPath}km/supervise/resource/js/slider_extras.js"></script>
		    <script>
		        $KMSSValidation();
		        function setProgress(){
	                var value = document.getElementsByName('fdProgress')[0].value;
	                var type= /^[0-9]*[1-9][0-9]*$/;
	            	if(!type.test(value)){
	                    alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.fdSuperviseProgress.alert' />");
	                    document.getElementsByName('fdProgress')[0].value = "0";
	                }
	            	sliderImage.setValue(document.getElementsByName('fdProgress')[0].value);
	            }
		        var sliderImage = new neverModules.modules.slider(
						{targetId: "sliderProcess",
							sliderCss: "imageSlider",
							barCss: "imageBar",
							min: 0,
							max: 100,
							hints: ""
						});
				sliderImage.onstart  = function () {
					
					document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
				}
				sliderImage.onchange = function () {
					document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
				};
				sliderImage.onend = function () {
					document.getElementsByName("fdProgress")[0].value = sliderImage.getValue();
				}
				sliderImage.create();					
		        window.onload = function() {
					$('#top').hide();
					sliderImage.setValue(document.getElementsByName("fdProgress")[0].value);
				}
		    </script>
		</html:form>
	</template:replace>
	
</template:include>