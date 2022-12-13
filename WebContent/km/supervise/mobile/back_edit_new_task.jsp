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
							<!-- 反馈单位 -->
			            	<tr>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
											<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
										    	 data-dojo-props='"idField":"fdSysUnitId","nameField":"fdSysUnitName","curIds":"${kmSuperviseBackForm.fdSysUnitId}","curNames":"${kmSuperviseBackForm.fdSysUnitName}","subject":"反馈单位","title":"反馈单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
										   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
										    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
										    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
											   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
											</div>
										</c:when>
										<c:otherwise>
											<xform:address propertyName="fdUnitName" propertyId="fdUnitId" orgType="ORG_TYPE_DEPT" subject="反馈单位" required="true" mobile="true"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- 反馈人 -->
							<tr>
								<td>
									<xform:address propertyName="fdPersonName" propertyId="fdPersonId" orgType="ORG_TYPE_PERSON" subject="${lfn:message('km-supervise:kmSuperviseBack.fdPerson') }" required="true" mobile="true" />
								</td>
							</tr>
							<!-- 反馈时间 -->
							<tr>
								<td>
									<xform:datetime property="fdFeedbackTime" required="true" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdFeedbackTime') }"/>
								</td>
							</tr>
							<!-- 反馈阶段 -->
							<tr>
								<td>
									<c:choose>
										<c:when test="${empty kmSuperviseBackForm.fdTaskId  }">
											<xform:select property="fdTaskId" showStatus="edit" style="width:45%" onValueChange="getBackPeriod(this);" subject="${lfn:message('km-supervise:kmSuperviseBack.fdTask') }" required="true" mobile="true">
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
							<!-- 反馈周期 -->
							<tr>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseBackForm.fdBackType != '0'}">
											<xform:select property="fdBackPeriod" htmlElementProperties="id='_fdBackPeriod'" subject="${lfn:message('km-supervise:kmSuperviseBack.fdBackPeriod') }" showStatus="edit"  required="true" mobile="true"></xform:select>
										</c:when>
										<c:otherwise>
											<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
												<bean:message bundle="km-supervise" key="kmSuperviseBack.fdBackPeriod" />
											</span>
											<html:hidden property="fdBackPeriod" />
											<div><bean:message bundle="km-supervise" key="enums.task.back.default" /></div>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- 阶段目标 -->
							<tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStageTarget" />
									</span>
									<html:hidden property="fdStageTarget" />
									<div id="fdStageTargetSpan"><c:out value="${kmSuperviseBackForm.fdStageTarget}"/></div>
								</td>
							</tr>
							
							<!-- 任务进度 -->
			                <tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
									</span>
									<c:choose>
										<c:when test="${kmSuperviseBackForm.isUndertake eq 'true'}">
											<div class="muiProgressBox">
												<input data-dojo-type="dojox/mobile/Slider" 
													data-dojo-mixins="km/supervise/mobile/resource/js/_ProgressSliderMixin"
													data-dojo-props="valueText:0" value="${kmSuperviseBackForm.fdProgress }"
													id="fdProgress" name="fdProgress" class="progress"/>
											</div>
										</c:when>
										<c:otherwise>
		    								<html:hidden property="fdProgress" />
		    								<span id="lui_supervise_rate">${kmSuperviseBackForm.fdProgress}%</span>
		    								<c:choose>
					    						<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
					    							<span style="color:#666666;font-size:12px">仅承办单位需要反馈进度</span>
					    						</c:when>
					    						<c:otherwise>
					    							<span style="color:#666666;font-size:12px">仅承办人需要反馈进度</span>
					    						</c:otherwise>
				    						</c:choose>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<!-- 督办状态 -->
							<tr>
								<td>
									<xform:radio property="fdStatus" value="${kmSuperviseBackForm.fdStatus}" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseBack.fdStatus') }" htmlElementProperties="onclick=changeStatus()">
										<xform:enumsDataSource enumsType="km_supervise_back_status" />
									</xform:radio>
								</td>
							</tr>
							
							<!-- 进展情况 -->
							<tr>
								<td>
									<xform:textarea property="docProgress" placeholder="请输入当前进展情况" subject="${lfn:message('km-supervise:kmSuperviseBack.docProgress') }" required="true" mobile="true"/>
								</td>
							</tr>
							<!-- 存在困难及下一步措施 -->
							<tr>
								<td>
									<xform:textarea property="docDifficulty" placeholder="请输入当前阶段遇到的困难及你的解决措施" subject="${lfn:message('km-supervise:kmSuperviseBack.docDifficulty') }" mobile="true"/>
								</td>
							</tr>
							<!-- 相关附件 -->
							<tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
									</span>
									<c:import
										url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
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
					<c:param name="fdKey" value="kmSuperviseFeedback" />
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
								var fdTaskId = '${kmSuperviseBackForm.fdTaskId}';
								if(fdTaskId != ''){
									//getPeriod(fdTaskId);
								}
							}
							
							window.getPeriod = function(taskId){
								var isUndertake = '${kmSuperviseBackForm.isUndertake}';
								var backType = '${kmSuperviseBackForm.fdBackType}';
								var data = new KMSSData();
								if(backType != '0'){
									var fdPerson = document.getElementsByName('fdPersonId')[0];
						        	var fdPersonId = fdPerson.value;
						        	data.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&fdTaskId="+taskId+"&type=1&fdPersonId="+fdPersonId);
						        	var hashArr = data.GetHashMapArray();
						        	var values = [];
						        	for(var i = 0;i<hashArr.length;i++){
						        		var value = {"value":hashArr[i].id,"text":hashArr[i].name};
						        		values.push(value);
						        	}
						        	var _fdBackPeriod = registry.byId('_fdBackPeriod');
						        	_fdBackPeriod.set("values",values);
								}else{
									data.AddBeanData("kmSuperviseBackTaskService&fdMainId=${kmSuperviseBackForm.fdSuperviseId}&fdTaskId="+taskId+"&type=3");
					            	data.PutToField("fdBackPeriod","fdBackPeriod","",false);
								}
					        	
					        	data = new KMSSData();
					        	data.AddBeanData("kmSuperviseBackTaskService&fdTaskId="+taskId+"&type=2");
						    	data.PutToField("fdStageTarget:fdProgress","fdStageTarget:fdProgress","",false);
						    	if(isUndertake == 'true'){
						    		setProgress();
						    	}else{
						    		var progress = document.getElementsByName("fdProgress")[0].value;
							    	document.getElementById("lui_supervise_rate").innerHTML=progress+"%";
						    	}
						    	document.getElementById("fdStageTargetSpan").innerHTML=document.getElementsByName("fdStageTarget")[0].value;
							}
							
							
							window.getBackPeriod = function(node){
								var val = node.value;
								getPeriod(val);
					        }
							 
							 window.setProgress=function(){
					         	var value = document.getElementsByName('fdProgress')[0].value;
					         	console.log(value);
					            var type= /^[0-9]*[1-9]*[0-9]*$/;
					           	if(!type.test(value)){
					            	alert("<bean:message bundle='km-supervise' key='kmSuperviseMain.fdSuperviseProgress.alert' />");
					                document.getElementsByName('fdProgress')[0].value = "0";
					            }
					           	var fdProgress = registry.byId('fdProgress');
					           	fdProgress.set("value",value);
					         }
							 //改变督办状态
								window.changeStatus = function(){
									var fdStatus = document.getElementsByName('fdStatus')[0].value;
									 var fdProgress = registry.byId('fdProgress');
									 if(fdStatus=="2"){
								           	fdProgress.set("value","100");
									 }else{
										 var fdTaskId = document.getElementsByName('fdTaskId')[0].value;
										 	console.log(fdTaskId);
											if(fdTaskId != ''){
												getPeriod(fdTaskId);
											}else{
												fdProgress.set("value","0");
											}
									 }
								}
					});
				</script>
			</div>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>