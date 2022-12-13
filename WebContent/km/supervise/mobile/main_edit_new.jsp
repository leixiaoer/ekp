<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<c:if test="${empty  kmSuperviseMainForm.docSubject}">
			<bean:message bundle="km-supervise" key="module.km.supervise" />
		</c:if>
		<c:out value="${kmSuperviseMainForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.plan" />',
			   		'moveTo':'planView'},{'text':'03  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.review" />','moveTo':'lbpmView'}]
		   		window._narStore = new Memory({data:navData});
		   		var changeNav = function(view){
		   			var wgt = registry.byId("_flowNav");
		   			for(var i=0;i<wgt.getChildren().length;i++){
		   				var tmpChild = wgt.getChildren()[i];
		   				if(view.id == tmpChild.moveTo){
		   					tmpChild.beingSelected(tmpChild.domNode);
		   					return;
		   				}
		   			}
		   		}
		   		topic.subscribe("mui/form/validateFail",function(view){
		   			changeNav(view);
		   		});
				topic.subscribe("mui/view/currentView",function(view){
					changeNav(view);
		   		});
		   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=save">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowEditFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav" data-dojo-props="store:_narStore">
						</div>
					</div>
				</div>
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
					<div class="muiFlowInfoW muiFormContent">
						<html:hidden property="fdId" />
				        <html:hidden property="docStatus" />
				        <html:hidden property="fdIsNew" value="true"/>
				        <html:hidden property="fdIsPlan"/>
				        <html:hidden property="method_GET" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
                             <tr>
                                <td colspan="2">
									<c:import url="/sys/xform/mobile/import/sysForm_mobile.jsp"
										charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseMainForm" />
										<c:param name="fdKey" value="kmSuperviseMain" />
										<c:param name="backTo" value="scrollView" />
									</c:import>
                                </td>
                            </tr>
						</table>
						<c:import url="/sys/right/mobile/edit_hidden.jsp" charEncoding="UTF-8">
							  <c:param name="formName" value="kmSuperviseMainForm" />
                       		  <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
						</c:import>
					</div>
			
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
						<c:if test="${kmSuperviseMainForm.method_GET=='add' || kmSuperviseMainForm.docStatus eq '10'}">
							<li data-dojo-type="mui/tabbar/TabBarButton" id="saveDraft"
									data-dojo-props='colSize:1,transition:"slide"'
									onclick="supervise_submit(10);"><bean:message key="button.savedraft" />
							</li>
						</c:if>
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:4,moveTo:"planView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
				
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin" id="planView">
					<div class="muiFlowInfoW muiFormContent">
						<c:import url="/km/supervise/mobile/plan_edit.jsp" charEncoding="UTF-8"></c:import>
					</div>
			
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
						<c:if test="${kmSummaryMainForm.method_GET=='add' || kmSummaryMainForm.docStatus eq '10'}">
							<li data-dojo-type="mui/tabbar/TabBarButton" id="saveDraft"
									onclick="supervise_submit(10);"><bean:message key="button.savedraft" />
							</li>
						</c:if>
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:2,moveTo:"scrollView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.prev" /></li>
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainForm" />
					<c:param name="fdKey" value="kmSuperviseMain" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="supervise_submit(20);" />
				</c:import>
				<script type="text/javascript">
				require(["mui/form/ajax-form!kmSuperviseMainForm"]);
				require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
				         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
						topic.subscribe("mui/form/validationInitFinish",function(wgt){
							var Validates = {
									'validateSuperviseTime':{
										error : '请先选择结束时间',
										test  : function(v) {
											var fdStartTime = $('[name="fdStartTime"]').val();
											var fdFinishTime = $('[name="fdFinishTime"]').val();
											var ds = Com_GetDate(fdStartTime);
											var de = Com_GetDate(fdFinishTime);
											if(de < ds){
												validator = this.getValidator('validateSuperviseTime');
												var error = '结束时间不能早于开始时间';
												validator.error = error;
												return false;
											}else{
												return true
											}
										}
									},
								'validateStartTime':{
									error : '请先选择开始时间',
									test  : function(v) {
										var fdStartTime = $('[name="fdStartTime"]').val();
										var fdFinishTime = $('[name="fdFinishTime"]').val();
										var ds = Com_GetDate(fdStartTime);
										var de = Com_GetDate(fdFinishTime);
										if(de < ds){
											validator = this.getValidator('validateStartTime');
											var error = '开始时间不能晚于结束时间';
											validator.error = error;
											return false;
										}else{
											return true
										}
									}
								},
								'validateTime':{
									error : '请先选择开始时间',
									test  : function(v,e,o) {
										var fdStartTime = $('[name="fdStartTime"]').val();
										var fdFinishTime = $('[name="fdFinishTime"]').val();
										if (fdStartTime == "" || fdFinishTime == "") {
											validator = this.getValidator('validateTime');
											var error = '督办开始时间和结束时间不能为空';
											validator.error = error;
											return false;
										}
										var ds = Com_GetDate(fdStartTime);
										var de = Com_GetDate(fdFinishTime);
										var dv = Com_GetDate(v);

										if (e.valueField.indexOf("fdPlanStartTime") > -1) {
											var fdPlanEndTime = e.valueField.replace("fdPlanStartTime","fdPlanEndTime");
											var endTime = $('[name="'+fdPlanEndTime+'"]').val();
											var end = Com_GetDate(endTime);
											if (dv < ds) {
												validator = this.getValidator('validateTime');
												var error = '计划开始时间不能早于督办开始时间';
												validator.error = error;
												return false;
											}
											if (dv > de) {
												validator = this.getValidator('validateTime');
												var error = '计划开始时间不能晚于督办结束时间';
												validator.error = error;
												return false;
											}
											if (dv > end && endTime) {
												validator = this.getValidator('validateTime');
												var error = '计划开始时间不能早于计划结束时间';
												validator.error = error;
												return false;
											}
										} else if (e.valueField.indexOf("fdPlanEndTime") > -1) {
											var fdPlanStartTime = e.valueField.replace("fdPlanEndTime", "fdPlanStartTime");
											var startTime = $('[name="' + fdPlanStartTime + '"]').val();
											var start = Com_GetDate(startTime);
											if (dv < ds) {
												validator = this.getValidator('validateTime');
												var error = '计划截止时间不能早于督办开始时间';
												validator.error = error;
												return false;
											}
											if (dv > de) {
												validator = this.getValidator('validateTime');
												var error = '计划截止时间不能晚于督办结束时间';
												validator.error = error;
												return false;
											}
											if (dv < start) {
												validator = this.getValidator('validateTime');
												var error = '计划截止时间不能早于计划开始时间';
												validator.error = error;
												return false;
											}
										}
										return true;
									}
								}
							}
							for (var type in Validates) {
								wgt._validation.addValidator(type, Validates[type].error, Validates[type].test);
							}
						});
							window.supervise_submit = function(docStatus){
								var validorObj = registry.byId('scrollView');
								var docSubject = registry.byId('docSubject');
								if(!validorObj._validation.validateElement(docSubject)){
									return false;
								}
								
								/* if(!checkFinishTime()){
									return false;
								} */
								var method = Com_GetUrlParameter(location.href,'method');
								query('[name="docStatus"]').val(docStatus);
								if(method=='add'){
									if(docStatus == '10'){
										Com_Submit(document.forms[0], 'save', null, { saveDraft : true });
									}else if(docStatus == '20'){
										Com_Submit(document.forms[0],'save');
									}
								}else{
									if(docStatus == '10'){
										Com_Submit(document.forms[0], 'update', null, { saveDraft : true });
									}else if(docStatus == '20'){
										Com_Submit(document.forms[0],'update');
									}
								}
							};
							window.checkFinishTime = function(){
								var fdStartTime = query('[name="fdStartTime"]')[0].value;
								var fdFinishTime = query('[name="fdFinishTime"]')[0].value;
								if(fdStartTime == ""){
									Tip.fail({
										text : '开始时间不能为空！'
									});
									return false;
								}
								if(fdFinishTime == ""){
									Tip.fail({
										text : '结束时间不能为空！'
									});
									return false;
								}
								if(new Date(fdStartTime.replace(/\-/g, '/')) >= new Date(fdFinishTime.replace(/\-/g, '/'))){
									Tip.fail({
										text : '结束时间要在开始时间之后！'
									});
									return false;
								}
								return true;
							};
				 });
				</script>
			</div>
		</html:form>
	</template:replace>
</template:include>
