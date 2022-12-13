<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:py.RenWuZhiPai') }
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-edit.css"/>
		<style type="text/css">
			.muiFlowInfoW.muiFormContent{
				margin-top: 0;
			}
		</style>
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
		
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
			<div data-dojo-type="mui/view/DocScrollableView" 
						data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
						<div class="muiFlowInfoW muiFormContent">
							<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
								<tr  data-dojo-type="mui/form/Template"  KMSS_IsReferRow="1" style="display:none;" border='0'>
									<td  class="detail_wrap_td">
								<%-- 	<xform:text showStatus="noShow" property="fdItems.value(${objId}.${rowIndex}.fdId)" /> --%>
										<table class="muiSimple">
											<tr celltr-title="true">
												<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
													<div class="muiDetailDisplayOpt muiDetailDown"   onclick="expandRow(this);"></div>
													<span   onclick="expandRow(this);">
														${lfn:message('km-supervise:mobile.RenWu')}!{index}
													</span>
													<xform:editShow>
														<div class="muiDetailTableDel" onclick="deleteRow(this);">
															<bean:message key="button.delete" />
														</div>
													</xform:editShow>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseMain.workItem')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:text property="fdItems[!{index}].docSubject" showStatus="edit" subject="${lfn:message('km-supervise:kmSuperviseMain.workItem')}" required="true" mobile="true"></xform:text>
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseMain.co-organizer')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:address propertyName="fdItems[!{index}].fdOrganizerName" propertyId="fdItems[!{index}].fdOrganizerId" subject="${lfn:message('km-supervise:kmSuperviseMain.co-organizer')}" showStatus="edit" orgType="ORG_TYPE_ORGORDEPT" mobile="true" required="true"/>
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
														${lfn:message('km-supervise:enums.warn.40')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:address propertyName="fdItems[!{index}].fdOrganizerDutyName" propertyId="fdItems[!{index}].fdOrganizerDutyId" subject="${lfn:message('km-supervise:enums.warn.40')}" showStatus="edit" orgType="ORG_TYPE_PERSON" mobile="true" required="true"/>
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseMain.feedback.time')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:select property="fdItems[!{index}].fdPeriod" subject="${lfn:message('km-supervise:kmSuperviseMain.feedback.time')}" required="true" style="width:115px;" mobile="true"><xform:enumsDataSource enumsType="km_supervise_task_period" /></xform:select>
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseMain.plan.startTime')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:datetime property="fdItems[!{index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseMain.plan.startTime')}" showStatus="edit" required="true" mobile="true"/>	
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseMain.plan.endTime')}
												</td>
												<td>
													<xform:config  orient="none">
														<xform:datetime property="fdItems[!{index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseMain.plan.endTime')}" showStatus="edit" required="true" mobile="true"/>	
													</xform:config>
												</td>
											</tr>
											<tr data-celltr="true">
												<td class="muiTitle">
													${lfn:message('km-supervise:kmSuperviseTask.docContent')}
												</td>
												<td>
													<xform:config orient="none">
														<xform:textarea property="fdItems[!{index}].docContent" mobile="true" />
													</xform:config>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								
							</table>
							
							<div 
								data-dojo-type="sys/xform/mobile/controls/DetailTableAddButton" 
								onclick="window.detail_add(event)">
								${lfn:message('km-supervise:mobile.XinZeng')}
							</div>
							
						</div>
								
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
					
					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
						data-dojo-props='colSize:1,href:"javascript:submitForm();"'>${lfn:message('button.update')}</li>
					
				</ul>
			</div>

		</html:form>
		</xform:config>
	</template:replace>
</template:include>
<script type="text/javascript">Com_IncludeFile('doclist.js');</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<script type="text/javascript">
	
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading){
		
		//校验对象
		var validorObj = null;
		
		//防止重复提交
		var isSubmit = false;
		
		var docSubject = "${kmSuperviseMainForm.docSubject }";
		var fdLeadId = "${kmSuperviseMainForm.fdLeadId }";
		var fdLeadName = "${kmSuperviseMainForm.fdLeadName }";
		var fdSponsorId = "${kmSuperviseMainForm.fdSponsorId }";
		var fdAppointName = "${kmSuperviseMainForm.fdSponsorName }";
		var fdModelId = "${kmSuperviseMainForm.fdId }";
		var fdModelName = "com.landray.kmss.km.supervise.model.KmSuperviseMain";
		var fdSourceUrl = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId="+fdModelId;
		
		ready(function(){
			validorObj = registry.byId('scrollView');
			DocListFunc_Init();
			detail_addRow("TABLE_DocList");
		});
		
		
		window.detail_add = function(event) {
			event = event || window.event;
			if (event.stopPropagation)
				event.stopPropagation();
			else
				event.cancelBubble = true;
			detail_addRow("TABLE_DocList");
		};
		window.detail_addRow = function(tableId, callbackFun) {
			var newRow = DocList_AddRow(tableId);
			newRow.dojoClick = true;
			parser.parse(newRow).then(function(){
				var tabInfo = DocList_TableInfo[tableId];
				if(tabInfo['_getcols']== null){
					tabInfo.fieldNames=[];
					tabInfo.fieldFormatNames=[];
					DocListFunc_AddReferFields(tabInfo, newRow, "INPUT");
					DocListFunc_AddReferFields(tabInfo, newRow, "TEXTAREA");
					DocListFunc_AddReferFields(tabInfo, newRow, "SELECT");
					tabInfo['_getcols'] = 1;
				}
				detail_fixNo();
				//topic.publish('/mui/form/valueChanged',null,{row:newRow,tableId:'${objId}'});
				topic.publish("/mui/list/resize",newRow);
				if(callbackFun)callbackFun(newRow);
			});
		}
		
		window.detail_fixNo = function() {
			$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
				$(this).children('span').text("任务" + (i + 1));
			});
		}
		
		window.deleteRow = function(domNode) {
			var td = $(domNode).closest('.detail_wrap_td')[0];
			DocList_DeleteRow_ClearLast(td.parentNode);
			topic.publish('/mui/form/valueChanged');
			topic.publish("/mui/list/resize",td.parentNode);
			detail_fixNo();
		};
		
		window.expandRow = function(domNode){
			var domTable = $(domNode).closest('table')[0];
			var display = domAttr.get(domTable,'data-display'),
				newdisplay = (display == 'none' ? '' : 'none');
			domAttr.set(domTable,'data-display',newdisplay);
			var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]',domTable);
			for(var i = 0; i < items.length; i++){
				if(newdisplay == 'none'){
					domStyle.set(items[i],'display','none');
				}else{
					domStyle.set(items[i],'display','');
				}
			}
			var opt = query('.muiDetailDisplayOpt',domTable)[0];
			if(newdisplay == 'none'){
				domClass.add(opt,'muiDetailUp');
				domClass.remove(opt,'muiDetailDown');
			}else{
				domClass.add(opt,'muiDetailDown');
				domClass.remove(opt,'muiDetailUp');
			}
		};
		
		
		window.submitForm = function(){
			if(!validorObj.validate()){
				return;
			}
			var arrayObj = getTABLE_DocList();
			console.log(arrayObj);
			if(!arrayObj){
				Tip.fail({
					text : "${lfn:message('km-supervise:mobile.validation.tip1')}"
				});
				return;
			}
			if(null == arrayObj || arrayObj.length == 0){
				Tip.fail({
					text : "${lfn:message('km-supervise:mobile.validation.tip1')}"
				});
				return;
			}
			if(!isSubmit){
				isSubmit = true;
			}else{
				return ;
			}
			var url = "${LUI_ContextPath}/sys/task/sys_task_main/sysTaskMain.do?method=batchSave";
			request.post(url, {
				data : {"data":JSON.stringify(arrayObj)},
				handleAs : 'json',
				sync: true
			}).then(function(data){
				if('0' == data.result ){
	            	addDynamic();
	            	return true;
	            }else{
	            	Tip.fail({
						text : "${lfn:message('km-supervise:mobile.validation.tip1')}"
					});
	                return false;
	            }
			},function(data){
			});

		};
		
		window.getTABLE_DocList = function(){
			 var arrayObj = new Array();
			 var checkTime = true;
			query("#TABLE_DocList tr table").forEach(function(node, index, array){ 
				var fdName = document.getElementsByName("fdItems["+index+"].docSubject")[0].value;
				
				var fdOrganizerId = document.getElementsByName("fdItems["+index+"].fdOrganizerId")[0].value;
				var fdOrganizerName = document.getElementsByName("fdItems["+index+"].fdOrganizerName")[0].value;
		        
		        var fdOrganizerDutyId = document.getElementsByName("fdItems["+index+"].fdOrganizerDutyId")[0].value;
		        var fdOrganizerDutyName = document.getElementsByName("fdItems["+index+"].fdOrganizerDutyName")[0].value;
		        
		        var fdPlanStartTime = document.getElementsByName("fdItems["+index+"].fdPlanStartTime")[0].value;
		        var fdPlanEndTime = document.getElementsByName("fdItems["+index+"].fdPlanEndTime")[0].value;
		        
		        if(!checkFinishTime(fdPlanStartTime, fdPlanEndTime)){
		        	checkTime = false;
		        }
		        
		        var fdPeriod = document.getElementsByName("fdItems["+index+"].fdPeriod")[0].value;
		        var docContent = document.getElementsByName("fdItems["+index+"].docContent")[0].value;
		        var data={};
		        data["docSubject"] = fdName;
		        data["fdPerformId"] = fdOrganizerDutyId;
		        data["fdPerformName"] = fdOrganizerDutyName;
		        data["fdAppointId"] = fdSponsorId;
		        data["fdAppointName"] = fdAppointName;
		        data["fdSourceSubject"] = docSubject;
		        data["fdSourceUrl"] = fdSourceUrl;
		        data["fdPlanEndTime"] = fdPlanEndTime;
		        data["fdModelId"] = fdModelId;
		        data["fdModelName"] = fdModelName;
		      	//扩展字段
		        data["fdOrganizerId"] = fdOrganizerId;
		        data["fdOrganizerName"] = fdOrganizerName;
		        data["fdPeriod"] = fdPeriod;
		        data["fdPlanStartTime"] = fdPlanStartTime;
		        //督办领导
		        data["fdLeadId"] = fdLeadId;
		        data["fdLeadName"] = fdLeadName;
		        //计划内容
		        data["docContent"] = docContent;
		        arrayObj.push(data);
			});
			if(checkTime){
				return arrayObj;
			}else{
				return false;
			}
		};
		window.checkFinishTime = function(startTime, endTime){
			if(new Date(startTime.replace(/\-/g, '/')) >= new Date(endTime.replace(/\-/g, '/'))){
				return false;
			}
			return true;
		};
		
	 	window.addDynamic = function(){
			dojo.xhrPost({
			  	url: '${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addDynamic',
				form: document.forms[0],
				load: function(data){
					Tip.success({
						text: "${lfn:message('km-supervise:mobile.success.tip1')}",
						callback: function(){
							history.back();
						}
					});
				},
				error: function(error){
					alert(error);
				}
			});
		}

		
	});
	

</script>