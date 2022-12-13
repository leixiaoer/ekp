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
						<html:hidden property="fdId" />
						<html:hidden property="docStatus"/>
						<html:hidden property="fdMainId"/>
						<html:hidden property="docSubject"/>
						<html:hidden property="method_GET" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
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
														</td>
													</tr>
													<tr data-celltr="true">
														<td class="muiTitle">
															<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
														</td>
														<td>
															<xform:config  orient="none">
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
																<xform:datetime property="fdTaskItems[!{index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="edit" required="true" mobile="true"/>	
															</xform:config>
														</td>
													</tr>
													<tr data-celltr="true"> 
														<td class="muiTitle">
															${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
														</td>
														<td>
															<xform:config  orient="none">
																<xform:datetime property="fdTaskItems[!{index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="edit" required="true" mobile="true"/>	
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
																		<xform:address propertyId="fdTaskItems[!{index}].fdUnitId" propertyName="fdTaskItems[!{index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
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
										
										<c:forEach items="${kmSuperviseMainPlanForm.fdTaskItems}" var="fdItem" varStatus="vstatus">
											<tr KMSS_IsContentRow="1">
												<td class="detail_wrap_td">
													<table class="muiSimple">
														<tr celltr-title="true">
															<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
																<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
																<span onclick="expandRow(this);">
																	${fdItem.docSubject}
																</span>
															</td>
														</tr>
														<tr data-celltr="true">
															<td class="muiTitle">
																<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
															</td>
															<td>
																<xform:config  orient="none">
																	<html:hidden property="fdTaskItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
																	<xform:text property="fdTaskItems[${vstatus.index}].docSubject" value="${fdItem.docSubject}" showStatus="readOnly" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" mobile="true"></xform:text>
																</xform:config>
															</td>
														</tr>
														<tr data-celltr="true">
															<td class="muiTitle">
																<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
															</td>
															<td>
																<xform:config orient="none">
																	<xform:textarea property="fdTaskItems[${vstatus.index}].docContent" value="${fdItem.docContent}" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}" showStatus="readOnly"/>
																</xform:config>
															</td>
														</tr>
														<tr data-celltr="true">
															<td class="muiTitle">
																${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
															</td>
															<td>
																<xform:config  orient="none">
																	<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanStartTime" value="${fdItem.fdPlanStartTime}" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="readOnly" required="true" mobile="true"/>	
																</xform:config>
															</td>
														</tr>
														<tr data-celltr="true"> 
															<td class="muiTitle">
																${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
															</td>
															<td>
																<xform:config  orient="none">
																	<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanEndTime" dateTimeType="datetime" value="${fdItem.fdPlanEndTime}" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="readOnly" required="true" mobile="true"/>	
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
																			<html:hidden property="fdItems[${vstatus.index}].fdUnitId" value="${fdItem.fdUnitId}"/>
																			<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
																		    	 data-dojo-props='"idField":"fdTaskItems[${vstatus.index}].fdSysUnitId","nameField":"fdTaskItems[${vstatus.index}].fdSysUnitName","curIds":"${fdItem.fdUnitId}","curNames":"${fdItem.fdUnitName}","subject":"承办单位","title":"承办单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
																		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
																		    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
																		    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
																			   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<xform:address propertyId="fdTaskItems[${vstatus.index}].fdUnitId" required="true" propertyName="fdTaskItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
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
																	<xform:address propertyId="fdTaskItems[${vstatus.index}].fdSponsorId" propertyName="fdTaskItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" required="true" showStatus="edit"/>
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
																		    	 data-dojo-props='"idField":"fdTaskItems[${vstatus.index}].fdOtherUnitIds","nameField":"fdTaskItems[${vstatus.index}].fdOtherUnitNames","curIds":"${fdItem.fdOtherUnitIds}","curNames":"${fdItem.fdOtherUnitNames}","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
																		   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
																		    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
																		    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
																			   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<xform:address propertyId="fdTaskItems[${vstatus.index}].fdOUnitIds" propertyName="fdTaskItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}"/>
																		</c:otherwise>
																	</c:choose>
																</xform:config>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</c:forEach>
									</table>
								</td>
							</tr>
							<!-- 阶段反馈周期 -->
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
								</td>
								<td>
									<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" mobile="true" value="0">
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
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading"], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading){
		
		//校验对象
		var validorObj = null;
		
		//防止重复提交
		var isSubmit = false;
		
		ready(function(){
			validorObj = registry.byId('scrollView');
		});
		
		window.detail_fixNo = function() {
			$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
				$(this).children('span').text("阶段" + (i + 1));
			});
		}
		
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
		
		window.submitForm = function(){
			if(!validorObj.validate()){
				return;
			}
			query('[name="docStatus"]').val("20");
			var method = Com_GetUrlParameter(location.href,'method');
			if(method=='add'){
				Com_Submit(document.forms[0],'save');
			}else{
				Com_Submit(document.forms[0],'update');
			}
		};
		
		
	});
		
</script>