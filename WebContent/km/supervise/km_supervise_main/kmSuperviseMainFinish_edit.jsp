<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	
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
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_main/", 'js', true);
        </script>
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--add页面的按钮--%>
			<ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('saveAddFinish');">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="closeWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	
	<%--督办办结表单--%>
	<template:replace name="content"> 
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
		    <p class="lui_form_subject">${ lfn:message('km-supervise:py.DuBanBanJie') }</p>
	        <div class="lui_form_content_frame" >
	            <table class="tb_normal" width="95%">
	            	<tr>
	            		<td class="td_normal_title">
	            			<bean:message bundle="km-supervise" key="kmSupervise.items" />
	            		</td>
	            		<td colspan="3">
	            			<xform:text property="docSubject"/>
	            		</td>
	            	</tr>
	                <tr>
						<!-- 办结人 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinisher" />
						</td>
						<td>
							<xform:address propertyName="fdOperatorName" propertyId="fdOperatorId" showStatus="readOnly" />
						</td>
						<!-- 办结单位 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishOrg" />
						</td>
						<td>
							<xform:address propertyName="fdOperatorUnitName" propertyId="fdOperatorUnitId" showStatus="edit" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" />
						</td>	
					</tr>
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishTime" />
						</td>
						<td>
							<xform:datetime property="fdFinishTime" />
						</td>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdRealFinishTime" />
						</td>
						<td>
							<xform:datetime property="fdRealFinishTime" showStatus="edit" required="true"/>
						</td>
					</tr>
					<!-- 任务进度 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
						</td>
						<td colspan="3">
							<html:text style="width:25px" property="fdSuperviseProgress" onchange="setProgress();"/>%
							<span id="fdProgreeAuto_id">
								<div id="sliderProcess" style="height:15px;margin:5px 0px 5px 0px"></div>
							</span>
						</td>
					</tr>
					<!-- 完成情况 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishDesc" />
						</td>
						<td colspan="3">
							<html:textarea property="fdFinishDesc" style="width:98%;"/>
						</td>
					</tr>
					<!-- 相关附件 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.attFinish"/>
						</td>
						<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attFinish" />
                                <c:param name="formBeanName" value="kmSuperviseMainForm" />
                                <c:param name="fdMulti" value="true" />
							</c:import>	
						</td>
					</tr>
	            </table>
	        </div>
		    <html:hidden property="fdId" />
		    <html:hidden property="method_GET" />
		    <script type="text/javascript" src="${KMSS_Parameter_ContextPath}km/supervise/resource/js/slider_extras.js"></script>
		    <script>
		        $KMSSValidation();
		        window.commitMethod = function(method){
	        		if(Com_Submit(document.kmSuperviseMainForm,method)){
	        			window.$dialog.hide("success");
	        		}
		        };
		        function closeWindow(){
		        	seajs.use('lui/dialog', function(dialog) {
						dialog.confirm(Com_Parameter.CloseInfo,
								function(value) {
									if (value) {
										_closeWindow();
									} else
										return;
								});
					});
		        }
		        function _closeWindow(){
		        	// 遍历所有父窗口判断是否存在$dialog
		        	var parent = window;
		        	while (parent) {
		        		if (typeof(parent.$dialog) != 'undefined') {
		        			parent.$dialog.hide("null");
		        			return;
		        		}
		        		if (parent == parent.parent)
		        			break;
		        		parent = parent.parent;
		        	}

		        	try {
		        		var win = window;
		        		for (var frameWin = win.parent; frameWin != null && frameWin != win; frameWin = win.parent) {
		        			if (frameWin["Frame_CloseWindow"] != null) {
		        				frameWin["Frame_CloseWindow"](win);
		        				return;
		        			}
		        			win = frameWin;
		        		}
		        	} catch (e) {
		        	}
		        	try {
		        		top.opener = top;
		        		top.open("", "_self");
		        		top.close();
		        	} catch (e) {
		        	}
		        }
		        function setProgress(){
	                var value = document.getElementsByName('fdSuperviseProgress')[0].value;
	                var type= /^[0-9]*[1-9][0-9]*$/;
	            	if(!type.test(value)){
	                    alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.fdSuperviseProgress.alert' />");
	                    document.getElementsByName('fdSuperviseProgress')[0].value = "0";
	                }
	            	sliderImage.setValue(document.getElementsByName('fdSuperviseProgress')[0].value);
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
					
					document.getElementsByName("fdSuperviseProgress")[0].value = sliderImage.getValue();
				}
				sliderImage.onchange = function () {
					document.getElementsByName("fdSuperviseProgress")[0].value = sliderImage.getValue();
				};
				sliderImage.onend = function () {
					document.getElementsByName("fdSuperviseProgress")[0].value = sliderImage.getValue();
				}
				sliderImage.create();
		        window.onload = function() {
					$('#top').hide();
					sliderImage.setValue(document.getElementsByName("fdSuperviseProgress")[0].value);
				}
		    </script>
		</html:form>
	</template:replace>
	
</template:include>