<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:py.RenWuZhiPai') }
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-edit.css"/>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.review" />',
			   		'moveTo':'lbpmView'}]
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
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do">
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
						<html:hidden property="fdId"/>
						<html:hidden property="docSubject"/>
						<html:hidden property="docStatus"/>
						<html:hidden property="fdMainId"/>
						<html:hidden property="method_GET" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<!-- 自动生成阶段 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="py.ZiDongShengChengJieDuan"/>
								</td>
								<td>
									<xform:select property="fdStageType" showPleaseSelect="false" showStatus="edit" onValueChange="stageChange(this);" mobile="true" value="0">
										<xform:enumsDataSource enumsType="km_supervise_task_stage"></xform:enumsDataSource>
									</xform:select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
										<tr data-dojo-type="mui/form/Template"  KMSS_IsReferRow="1" style="display:none;" border='0'>
											<td class="detail_wrap_td">
												<table class="muiSimple">
													<tr celltr-title="true">
														<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
															<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
															<span onclick="expandRow(this);">
																${lfn:message('km-supervise:mobile.JieDuan')}!{index}
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
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
														</td>
														<td>
															<xform:config  orient="none">
																<html:hidden property="fdTaskItems[!{index}].fdId" value=""/>
																<html:hidden property="fdTaskItems[!{index}].fdOrder" value="!{index}"/>
																<xform:text property="fdTaskItems[!{index}].docSubject" showStatus="edit" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" required="true" mobile="true"></xform:text>
															</xform:config>
														</td>
													</tr>
													<tr data-celltr="true">
														<td class="muiTitle">
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
														</td>
														<td>
															<xform:config orient="none">
																<xform:textarea property="fdTaskItems[!{index}].docContent" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}"/>
															</xform:config>
														</td>
													</tr>
													<tr data-celltr="true">
														<td class="muiTitle">
															${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
														</td>
														<td>
															<xform:config  orient="none">
																<xform:datetime property="fdTaskItems[!{index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
															</xform:config>
														</td>
													</tr>
													<tr data-celltr="true"> 
														<td class="muiTitle">
															${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
														</td>
														<td>
															<xform:config  orient="none">
																<xform:datetime property="fdTaskItems[!{index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
															</xform:config>
														</td>
													</tr>
													<!-- 主办单位 -->
													<tr data-celltr="true">
														<td class="muiTitle">
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
														</td>
														<td>
															<xform:config  orient="none">
																<c:choose>
																	<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
																		<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
																	    	 data-dojo-props='"idField":"fdTaskItems[!{index}].fdSysUnitId","nameField":"fdTaskItems[!{index}].fdSysUnitName","curIds":"","curNames":"","subject":"承办单位","title":"承办单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
																	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
																	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
																	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
																		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<xform:address propertyId="fdTaskItems[!{index}].fdUnitId" propertyName="fdTaskItems[!{index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}" required="true"/>
																	</c:otherwise>
																</c:choose>
															</xform:config>
														</td>
													</tr>
													<!-- 承办人 -->
													<tr data-celltr="true">
														<td class="muiTitle">
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
														</td>
														<td>
															<xform:config  orient="none">
																<xform:address propertyId="fdTaskItems[!{index}].fdSponsorId" propertyName="fdTaskItems[!{index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" required="true"/>
															</xform:config>
														</td>
													</tr>
													
													<!-- 协办单位 -->
													<tr data-celltr="true">
														<td class="muiTitle">
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
														</td>
														<td>
															<xform:config  orient="none">
																<c:choose>
																	<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
																		<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
																	    	 data-dojo-props='"idField":"fdTaskItems[!{index}].fdOtherUnitIds","nameField":"fdTaskItems[!{index}].fdOtherUnitNames","curIds":"","curNames":"","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
																	   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
																	    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
																	    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
																		   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<xform:address propertyId="fdTaskItems[!{index}].fdOUnitIds" propertyName="fdTaskItems[!{index}].fdOUnitNames" orgType="ORG_TYPE_PERSON" mulSelect="true" style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
																	</c:otherwise>
																</c:choose>
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
										<bean:message bundle="km-supervise" key="py.TianJiaJieDuan" />
									</div>
								</td>
							</tr>
							<!-- 阶段反馈周期 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
								</td>
								<td>
									<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" mobile="true" value="0" subject="反馈周期">
										<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
									</xform:select>
								</td>
							</tr>
							<!-- 附件上传 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
								</td>
								<td>
						           	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseMainPlanForm"/>
										<c:param name="fdKey" value="attTask" />
										<c:param name="fdMulti" value="true" />
									</c:import>
								</td>
							</tr>
						</table>
					</div>
					
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:4,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
		
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainPlanForm" />
					<c:param name="fdKey" value="kmSuperviseMakePlan" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="submitForm();" />
				</c:import>
			</div>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>
<script type="text/javascript">Com_IncludeFile('doclist.js');</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<script type="text/javascript">
	require(["mui/form/ajax-form!kmSuperviseMainPlanForm"]);
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading",'mui/dialog/Dialog',"dojo/_base/lang"], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading,Dialog,lang){
		
		//校验对象
		var validorObj = null;
		
		//防止重复提交
		var isSubmit = false;
		
		var startTime = "${kmSuperviseMainPlanForm.fdStartTime}";
		var finishTime = "${kmSuperviseMainPlanForm.fdFinishTime}";
		var fdOtherUnitIds = "${kmSuperviseMainPlanForm.fdOtherUnitIds}";
		var fdOtherUnitNames = "${kmSuperviseMainPlanForm.fdOtherUnitNames}";
		var fdOUnitIds = "${kmSuperviseMainPlanForm.fdOUnitIds}";
		var fdOUnitNames = "${kmSuperviseMainPlanForm.fdOUnitNames}";
		var fdSysUnitEnable = "${kmSuperviseMainPlanForm.fdSysUnitEnable}"
		
		ready(function(){
			validorObj = registry.byId('scrollView');
			DocListFunc_Init();
		});
		topic.subscribe("mui/form/validationInitFinish",function(wgt){
			var Validates = {
				'validateTime':{
					error : '请先选择开始时间',
					test  : function(v,e,o) {
						var fdStartTime = "${kmSuperviseMainPlanForm.fdStartTime}";
						var fdFinishTime = "${kmSuperviseMainPlanForm.fdFinishTime}";
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
				initValue(newRow);//初始化值
				topic.publish("/mui/list/resize",newRow);
				if(callbackFun)callbackFun(newRow);
			});
		}
		
		window.initValue = function(newRow){
			var optTB = document.getElementById("TABLE_DocList");
			var tbInfo = DocList_TableInfo[optTB.id];
			var stage = "阶段"+ tbInfo.lastIndex;
			$(newRow).find("*[widgetid]").each(function(idx,widgetDom){
				var widget = registry.byNode(widgetDom);
				if(idx == 0){
					widget._setValueAttr(stage);
				}else if(idx == 2){
					widget._setValueAttr(startTime);
				}else if(idx == 3){
					widget._setValueAttr(finishTime);
				}else if(idx == 6){
					if(fdSysUnitEnable == "true"){
						if(fdOtherUnitIds&&fdOtherUnitNames){
							widget._setCurIdsAttr(fdOtherUnitIds);
							widget._setCurNamesAttr(fdOtherUnitNames);
						}
					}else{
						if(fdOUnitIds&&fdOUnitNames){
							widget._setCurIdsAttr(fdOUnitIds);
							widget._setCurNamesAttr(fdOUnitNames);
						}
					}
				}
			});
		}
		
		window.detail_fixNo = function() {
			$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
				$(this).children('span').text("阶段" + (i + 1));
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
			domNode.dojoClick = true;
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
		
		window.stageChange = function(domNode){
			var val = domNode.value;
			var url = "${LUI_ContextPath}/km/supervise/km_supervise_task/kmSuperviseTask.do?method=autoAddTask&fdStartTime="+startTime+"&fdFinishTime="+finishTime+"&fdStageType="+val;
			var delDialog = new Dialog.claz({
				'element' : '<br/><br/><div>是否自动生成阶段？<br/>更换自动生成阶段的方式后，已填写的所有信息会被清空且不可恢复!!!</div><br/><br/>',
				'destroyAfterClose':true,
				'closeOnClickDomNode':false,
				'scrollable' : false,
				'parseable': true,
				'position':'center',
				'buttons' : [{
					title : "${lfn:message('km-imeeting:button.cancel')}",
					fn : function(dialog) {
						dialog.hide();
					}
				} ,{
					title : "${lfn:message('km-imeeting:button.submit')}",
					fn : lang.hitch(this,function(dialog) {
						var allTR = document.getElementsByClassName("detail_wrap_td");
						if(allTR.length > 0){
							for(var i = allTR.length - 1 ; i >= 0 ;i--){
								DocList_DeleteRow(allTR[i].parentNode);
							} 
						}
						
						var tableId = "TABLE_DocList";
						var processing = Tip.processing();
						var promise = request.get(url);
						promise.response.then(function(result) {
							dialog.hide();
							processing.hide();
							var results =  eval("(" + result.data + ")");
							if (results.length > 0) {
								for(var j=0;j<results.length;j++){
									var stage ="阶段"+(j+1);
									var startTime =results[j].fdPlanStartTime;
									var endTime =results[j].fdPlanEndTime;
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
										$(newRow).find("*[widgetid]").each(function(idx,widgetDom){
											var widget = registry.byNode(widgetDom);
											if(idx == 0){
												widget._setValueAttr(stage);
											}else if(idx == 2){
												widget._setValueAttr(startTime);
											}else if(idx == 3){
												widget._setValueAttr(endTime);
											}else if(idx == 6){
												if(fdSysUnitEnable == "true"){
													if(fdOtherUnitIds&&fdOtherUnitNames){
														widget._setCurIdsAttr(fdOtherUnitIds);
														widget._setCurNamesAttr(fdOtherUnitNames);
													}
												}else{
													if(fdOUnitIds&&fdOUnitNames){
														widget._setCurIdsAttr(fdOUnitIds);
														widget._setCurNamesAttr(fdOUnitNames);
													}
												}
											}
										});
										topic.publish("/mui/list/resize",newRow);
									});
							   }
							}
						});
					})
				}]
			});
			delDialog.show();
		}
		
		window.submitForm = function(){
			if(!validorObj.validate()){
				return;
			}
			/* var arrayObj = getTABLE_DocList();
			if(!arrayObj){
				Tip.fail({
					text : "${lfn:message('km-supervise:mobile.validation.tip1')}"
				});
				return;
			} */
			if(!isSubmit){
				isSubmit = true;
			}else{
				return ;
			}
			query('[name="docStatus"]').val("20");
			var method = Com_GetUrlParameter(location.href,'method');
			if(method=='add'){
				Com_Submit(document.forms[0],'save');
			}else{
				Com_Submit(document.forms[0],'update');
			}

		};
		
		window.getTABLE_DocList = function(){
			 var checkTime = true;
			 query("#TABLE_DocList tr table").forEach(function(node, index, array){ 
		        
		        var fdPlanStartTime = document.getElementsByName("fdTaskItems["+index+"].fdPlanStartTime")[0].value;
		        var fdPlanEndTime = document.getElementsByName("fdTaskItems["+index+"].fdPlanEndTime")[0].value;
		        
		        if(!checkFinishTime(fdPlanStartTime, fdPlanEndTime)){
		        	checkTime = false;
		        }
		        
			});
			if(checkTime){
				return true;
			}else{
				return false;
			}
		};
		window.checkFinishTime = function(planStartTime, planEndTime){
			var ds = new Date(startTime.replace(/\-/g, '/'))
			var de = new Date(finishTime.replace(/\-/g, '/'));
			var dps = new Date(planStartTime.replace(/\-/g, '/'))
			var dpe = new Date(planEndTime.replace(/\-/g, '/'));
			if(ds <= dps < dpe <= de){
				return true;
			}
			return false;
		};
		
	});
		
</script>