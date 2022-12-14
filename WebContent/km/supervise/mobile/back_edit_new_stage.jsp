<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:py.DuBanFanKui') }
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
		<html:form action="/km/supervise/km_supervise_back/kmSuperviseBack.do">
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
						<html:hidden property="docSubject" />
					   	<html:hidden property="docStatus" />
					   	<html:hidden property="method_GET" />
					   	<html:hidden property="fdSuperviseId" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<!-- ???????????? -->
			            	<tr>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
											<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
										    	 data-dojo-props='"idField":"fdSysUnitId","nameField":"fdSysUnitName","curIds":"${kmSuperviseBackForm.fdSysUnitId}","curNames":"${kmSuperviseBackForm.fdSysUnitName}","subject":"????????????","title":"????????????","showStatus":"edit","isMul":false,"validate":"required","required":true,
										   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
										    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
										    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
											   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
											</div>
										</c:when>
										<c:otherwise>
											<xform:address propertyName="fdUnitName" propertyId="fdUnitId" orgType="ORG_TYPE_DEPT" subject="????????????" required="true" mobile="true"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- ????????? -->
							<tr>
								<td>
									<xform:address propertyName="fdPersonName" propertyId="fdPersonId" orgType="ORG_TYPE_PERSON" subject="${lfn:message('km-supervise:kmSuperviseBack.fdPerson') }"  required="true" mobile="true" />
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<td>
									<xform:datetime property="fdFeedbackTime" required="true" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime') }"/>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<td>
									<c:choose>
										<c:when test="${empty kmSuperviseBackForm.fdTaskId}">
											<xform:select property="fdTaskId" showStatus="edit" style="width:45%" onValueChange="getBackPeriod(this);" subject="${lfn:message('km-supervise:kmSuperviseBack.fdTask') }"  required="true" mobile="true">
												<xform:customizeDataSource className="com.landray.kmss.km.supervise.service.spring.KmSuperviseStageDataSource"></xform:customizeDataSource>
											</xform:select>
										</c:when>
										<c:otherwise>
											<html:hidden property="fdTaskId" />
											<xform:text property="fdTaskSubject" showStatus="view" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdTask') }"></xform:text>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStageTarget" />
									</span>
									<html:hidden property="fdStageTarget" />
									<div id="fdStageTargetSpan"><c:out value="${kmSuperviseBackForm.fdStageTarget}"/></div>
								</td>
							</tr>
							
							<!-- ???????????? -->
			                <tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
									</span>
									<html:hidden property="fdProgress" />
		    						<span id="lui_supervise_rate">${kmSuperviseBackForm.fdProgress}%</span>
		    						<c:choose>
			    						<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
			    							<span style="color:#666666;font-size:12px">?????????????????????????????????</span>
			    						</c:when>
			    						<c:otherwise>
			    							<span style="color:#666666;font-size:12px">??????????????????????????????</span>
			    						</c:otherwise>
		    						</c:choose>
								</td>
							</tr>
							
							
							<!-- ???????????? -->
							<tr>
								<td>
									<xform:radio property="fdStatus" value="${kmSuperviseBackForm.fdStatus}" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdStatus') }">
										<xform:enumsDataSource enumsType="km_supervise_back_status" />
									</xform:radio>
								</td>
							</tr>
							
							<!-- ???????????? -->
							<tr>
								<td>
									<xform:textarea property="docProgress" placeholder="???????????????????????????" subject="${lfn:message('km-supervise:kmSuperviseBack.docProgress') }" required="true" mobile="true"/>
								</td>
							</tr>
							<!-- ?????????????????????????????? -->
							<tr>
								<td>
									<xform:textarea property="docDifficulty" placeholder="?????????????????????????????????????????????????????????" subject="${lfn:message('km-supervise:kmSuperviseBack.docDifficulty') }" mobile="true"/>
								</td>
							</tr>
							<!-- ???????????? -->
							<tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
									</span>
									<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseBackForm"></c:param>
										<c:param name="fdKey" value="attBack" />
										<c:param name="fdMulti" value="true" />
									</c:import>
								</td>
							</tr>
						</table>
						
					</div>
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseBackForm" />
					<c:param name="fdKey" value="kmSuperviseStage" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="back_submit();" />
				</c:import>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmSuperviseBackForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
				         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
							window.back_submit = function(){
								var validorObj = registry.byId('scrollView');
								if(!validorObj.validate()){
									return;
								}
								var status = document.getElementsByName("docStatus")[0];
								var method = Com_GetUrlParameter(location.href,'method');
								query('[name="docStatus"]').val('20');
								if(method=='add'){
									Com_Submit(document.forms[0],'save');
								}else{
									Com_Submit(document.forms[0],'update');
								}
							};
							
							window.onload = function(){
								/* var fdTaskId = '${kmSuperviseBackForm.fdTaskId}';
								if(fdTaskId != ''){
									var data = new KMSSData();
						        	data.AddBeanData("kmSuperviseBackTaskService&fdTaskId="+fdTaskId+"&type=2");
							    	data.PutToField("fdStageTarget:fdProgress","fdStageTarget:fdProgress","",false);
							    	document.getElementById("fdStageTargetSpan").innerHTML=document.getElementsByName("fdStageTarget")[0].value;
							    	var progress = document.getElementsByName("fdProgress")[0].value;
							    	document.getElementById("lui_supervise_rate").innerHTML=progress+"%";
								} */
							}
							
							window.getBackPeriod = function(node){
								var val = node.value;
					        	var data = new KMSSData();
					        	data.AddBeanData("kmSuperviseBackTaskService&fdTaskId="+val+"&type=2");
						    	data.PutToField("fdStageTarget:fdProgress","fdStageTarget:fdProgress","",false);
						    	document.getElementById("fdStageTargetSpan").innerHTML=document.getElementsByName("fdStageTarget")[0].value;
						    	var progress = document.getElementsByName("fdProgress")[0].value;
						    	document.getElementById("lui_supervise_rate").innerHTML=progress+"%";
					        }
					});
				</script>
			</div>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>