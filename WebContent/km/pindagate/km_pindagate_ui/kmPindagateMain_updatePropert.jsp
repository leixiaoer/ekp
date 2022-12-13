<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmPindagateMainForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-pindagate:kmPindagateMain.opt.create')} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmPindagateMainForm.docSubject} - ${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
		<%--路径导航--%>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="categoryId"> 
			<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:module.km.pindagate') }">
			</ui:menu-item>
			<ui:menu-item text="${ lfn:message('km-pindagate:kmPindagate.tree.set') }">
			</ui:menu-item>
			<ui:menu-source autoFetch="false" >
				<ui:source type="AjaxJson">
					{"url":"/sys/category/criteria/sysCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.pindagate.model.KmPindagateTemplate&categoryId=${kmPindagateMainForm.fdTemplateId}&currId=!{value}&nodeType=!{nodeType}"} 
				</ui:source>
			</ui:menu-source>
		</ui:menu>
	</template:replace>	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" var-navwidth="85%" layout="sys.ui.toolbar.float" count="3">
		
				<ui:button text="${lfn:message('km-pindagate:kmPindagateQuestion.button.resubmit')}" order="1" onclick="updateDoc();"></ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace> 
	<template:replace name="content">
	<style>
			.pindagate_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
			.pindagate_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
		</style>
		<script type="text/javascript">
		Com_IncludeFile("form.js");
		    //快捷新建模板弹出框
		  <c:if test="${kmPindagateMainForm.method_GET=='add'}">
			window.changeDocTemp = function(modelName,url,canClose){
				if(modelName==null || modelName=='' || url==null || url=='')
					return;
		 		seajs.use(['sys/ui/js/dialog'],function(dialog) {
				 	dialog.categoryForNewFile(modelName,url,false,null,function(rtn) {
						// 无分类状态下（一般于门户快捷操作）创建文档，取消操作同时关闭当前窗口
						if (!rtn)
							window.close();
					},'${JsParam.categoryId}','_self',canClose);
			 	});
		 	};
		 	
			if('${JsParam.fdTemplateId}'==''){
				window.changeDocTemp('com.landray.kmss.km.pindagate.model.KmPindagateTemplate','/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=add&fdTemplateId=!{id}',true);
			}
			
		  </c:if>
			var _dialog,_toolbar;
			seajs.use(['lui/dialog','lui/toolbar'], function(dialog,toolbar) {
				_dialog=dialog;
				_toolbar=toolbar;
			});
			//复制问卷、编辑页面不默认隐藏问题
			LUI.ready(function(){
				pindagateType_change('${kmPindagateMainForm.fdPindagateType}');
				if("${kmPindagateMainForm.method_GET}"=='edit'||"${JsParam.copyPindagate}"=='true'){
					//document.getElementById("QS").style.display="";
					//document.getElementById("showQSLink").style.display="none";
				}
		    
				function pindagateType_change(val){
					if(val=="code"){						
						 LUI.$("[name='fdParticipantNum']").attr("validate","required digits min(0)"); 
						 LUI.$("[name='indagateParticipantNames']").removeAttr("required",true); 
						 LUI.$("[xform-name='mf_indagateParticipantNames']").removeAttr("required",true);
						 LUI.$("[name='indagateParticipantNames']").removeAttr("validate","required"); 
						 LUI.$("[xform-name='mf_indagateParticipantNames']").removeAttr("validate","required");
						
						 document.getElementById("place_title").innerText="<bean:message bundle='km-pindagate' key='kmPindagateMain.dataLimit' />";
						 document.getElementById("particPeople").style.display="none";
						 document.getElementById("participantNum").style.display="";
						 //document.getElementById("place_content").style.display="none";
					}else{	
						LUI.$("[name='fdParticipantNum']").removeAttr("required",true); 
						 LUI.$("[name='fdParticipantNum']").removeAttr("validate","required digits min(0)"); 
		                 LUI.$("[name='indagateParticipantNames']").attr("validate","required"); 
						 LUI.$("[xform-name='mf_indagateParticipantNames']").attr("validate","required"); 
						 document.getElementById("place_title").innerText="<bean:message bundle='km-pindagate' key='kmPindagateMain.partic.people' />";
						 document.getElementById("particPeople").style.display="";
						 document.getElementById("participantNum").style.display="none";
						//document.getElementById("place_content").style.display="";
					}
					$("#fdPindagateTypeValue").val(val);
				}
				 window.pindagateType_change=function(val){
					 pindagateType_change(val);
				 }
			});
			//提交
			function commitMethod(method, status){
				LUI.$("input[name='docStatus']").val(status);
				Com_Submit(document.kmPindagateMainForm, method);
			}
			//提示次数不能超过8次
			function validateRemindTime(){
			   var fdNotifyFrequency = document.getElementsByName("fdNotifyFrequency")[0].value;
			   if(fdNotifyFrequency > 8){
				   return false;
			   }
			    return true;	
			}
			//校验题目是否为空
			function validateQuetion(index){
				if($('input[name="fdItems['+index+'].fdSplit"]').val() == 'true'){
					index++;
					return validateQuetion(index);
				}else if(!$("input[name='fdItems["+index+"].fdQuestionDef']").val() || $("input[name='fdItems["+index+"].fdQuestionDef']").val() == ""){
					return false;
				}else{
					return true;
				}
			}
			
			//校验调查结束时间不能早于开始调查时间
			function validateIndagateCompareTime(){
				var docStartTime=document.getElementsByName('docStartTime');
				 var docFinishedTime=document.getElementsByName('docFinishedTime');
				 if(docStartTime.length > 0 && docFinishedTime.length > 0) {
					 var _docStartTime = docStartTime[0].value;
					 var _docFinishedTime = docFinishedTime[0].value;
					 if(_docFinishedTime!=null&&_docFinishedTime!=""&&_docStartTime!=null&&_docStartTime!=""){
						 if(Date.parse(Com_GetDate(_docFinishedTime))<=Date.parse(Com_GetDate(_docStartTime))){
					    	return false;
						}
					} 
				 }
				return true;
			}
			//更多设置
			function showMoreSet(){
				if(document.getElementById("moreSetting").style.display==""){
					document.getElementById("showMoreSet").className ="pindagate_slideDown";
					document.getElementById("showMoreSet").innerHTML="<bean:message bundle='km-pindagate' key='kmPindagateMain.more.set.slideDown' />";
					document.getElementById("moreSetting").style.display="none";
				}else{
					document.getElementById("showMoreSet").className ="pindagate_slideUp";
					document.getElementById("showMoreSet").innerHTML="<bean:message bundle='km-pindagate' key='kmPindagateMain.more.set.slideUp' />";
					document.getElementById("moreSetting").style.display="";
				}
			}
			
			//显示题目
			function showQS(_this){
				//document.getElementById("QS").style.display="";
				_this.style.display="none";
			}
		</script>
		<html:form action="km/pindagate/km_pindagate_main/kmPindagateMain.do">
		<html:hidden property="fdId" />
		<html:hidden property="fdPindagateType" />
		<html:hidden property="docStatus" />
		<html:hidden property="method_GET" />
		<ui:tabpage expand="false" collapsed="true">
			<ui:event event="layoutDone">
					this.element.find(".lui_tabpage_float_collapse").hide();
					this.element.find(".lui_tabpage_float_navs_mark").hide();
			</ui:event>
             	<table class="tb_normal" width=100%>
             		<!-- 标题 -->
					<tr>
						<%--问卷主题(模板名称)--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject" />
						</td>
						<td width="35%">
							<xform:text showStatus="view" property="docSubject" style="width:97%;" />
						</td>
						<%--调查类型--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.fdPindagateType" />
						</td>
						<td>
						<xform:radio showStatus="view" property="fdPindagateType"  onValueChange="pindagateType_change(value);">
							<xform:enumsDataSource  enumsType="kmPindagateMain_type" />
						</xform:radio>
						<span class="com_help">
								（<bean:message bundle="km-pindagate" key="kmPindagateMain.code.help" />）
						</span>
						<input type="hidden" id="fdPindagateTypeValue">
						</td>
					</tr>
					<tr>
						<%--调查时间--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docTime" />
						</td>
						<td width="35%">
							<xform:datetime showStatus="view" property="docStartTime" dateTimeType="datetime"  style="width:45%;"  validators="after indagateCompareTime"  />
							<span style="position: relative;top:-5px;">—</span>
							<xform:datetime property="docFinishedTime" showStatus="edit" dateTimeType="datetime" style="width:45%;" validators="after indagateCompareTime" />
							<br/>
							<span class="com_help">
							<bean:message bundle="km-pindagate" key="kmPindagateQuestion.topic.1" />
							</span>
						</td>
						<%-- 调查参与人员 --%>
						<td width="15%" class="td_normal_title"  id="place_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.partic.people" />
						</td>
						<td width="35%"  id="particPeople">
						
						       <div style="color:#00b3ee;cursor:pointer;" onclick="importAddress();"><bean:message bundle="km-pindagate" key="kmPindagateMain.import" />
								</div>
						       <div id="particPeopleAddress" _xform_type="address" >
							  <xform:address  showStatus="edit" subject="${lfn:message('km-pindagate:kmPindagateMain.partic.people')}" propertyId="indagateParticipantIds"  propertyName="indagateParticipantNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%" required="true" />  
							</div>
						</td>
							<td width="35%"  id="participantNum">
							  <xform:text property="fdParticipantNum" showStatus="edit"  subject="${lfn:message('km-pindagate:kmPindagateMain.dataLimit')}" style="width:97%;" required="true"  />
						<span class="com_help">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.dataLimit.explain" />
						</span>
						</td>
					</tr>
					<%-- 所属场所 --%>
					<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
		            	<c:param name="id" value="${kmPindagateMainForm.authAreaId}"/>
		            </c:import>  
					<tr>
						<%-- 调查结果可阅读者 --%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.result.reader" />
						</td>
						<td width="35%">
							<xform:address   showStatus="edit" propertyId="indagateResultReaderIds" propertyName="indagateResultReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
						</td>
						<%-- 调查结束通知人员--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.over.notify.person" />
						</td>
						<td width="35%">
							<xform:address showStatus="edit" propertyId="indagateResultNotifierIds"  propertyName="indagateResultNotifierNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%" />
						</td>
					</tr>
					<tr>
						<%-- 问卷说明--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.fdQuestionExplain" />
						</td>
						<td colspan="3">
							<kmss:editor property="fdQuestionExplain" toolbarSet="Default"  height="140" width="98%"/>
						</td>
					</tr>
				</table>
				
			</ui:tabpage> 
		</html:form>
		<script type="text/javascript">
			seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
				window.updateDoc = function() {
					var fdLastStatNum = ${fdLastStatNum };
					var pindateType=  $("[id='fdPindagateTypeValue']").val();
					if (pindateType=="code") {
						var fdParticipantNum=  $("[name='fdParticipantNum']").val();
						if (fdParticipantNum<fdLastStatNum) {
							dialog.confirm("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.topic.2' />", function(value){});
							
						}else if(fdParticipantNum==fdLastStatNum){
							dialog.confirm("<bean:message bundle='km-pindagate' key='kmPindagateQuestion.topic.3' />", function(value){
								if(value){
									commitMethod('updateProValue', '20');
								}
							}); 
						}else{
							commitMethod('updateProValue', '20');
						}
					}else{
						commitMethod('updateProValue', '20');
					}		
				}
			});
		</script>
		<script>
			$KMSSValidation(document.forms['kmPindagateMainForm']);
		</script>
		<script>
			var _validation = $KMSSValidation();
			//校验调查题目不为空
			_validation.addValidator("questionNotNull","${lfn:message('km-pindagate:kmPindagateMain.fdQuestionDef.not.null')}",function(v, e, o) {
				return validateQuetion(0);
			});
			//校验调查结束时间不能早于开始时间
			_validation.addValidator("indagateCompareTime","${lfn:message('km-pindagate:kmPindagateMain.endDate.not.lt.startDate')}",function(v, e, o) {
				 var docStartTime=document.getElementsByName('docStartTime')[0];
				 var docFinishedTime=document.getElementsByName('docFinishedTime')[0];
				 var result= validateIndagateCompareTime();
				 if(result==false){
					KMSSValidation_HideWarnHint(docStartTime);
					KMSSValidation_HideWarnHint(docFinishedTime);
				}
				return result;
			});
			//校验提醒次数不能超过8次
			_validation.addValidator("remindTime","<bean:message bundle='km-pindagate' key='kmPindagateQuestion.topic.4' />",function(v, e, o) {
				if(LUI.$("input[name='docStatus']").val()=="20"){
			       return validateRemindTime();
			     }else{
					return true;
				}
			});
			
			
			function importAddress() {
				seajs.use([ 'lui/dialog' ], function(dialog) {
					dialog.iframe("/km/pindagate/km_pindagate_ui/kmPindagateMain_upload.jsp",
							"${lfn:message('km-pindagate:kmPindagateMain.import.list')}", function(
									value) {
							}, {
								"width" : 1010,
								"height" : 600
							});
				});
			}
			function AddAddress(values) {
				//newAddressAdd(document.getElementsByName("indagateParticipantNames")[0],values);
				var idArray = $form("indagateParticipantIds").val().split(';');
				var nameArray = $form("indagateParticipantNames").val().split(';');
				var ids = [];
				var names = [];
				for (var i = 0; i < idArray.length; i++) {
					if (idArray[i] != "") {
						ids.push(idArray[i]);
						names.push(nameArray[i]);
					}
				}
				for (var i = 0; i < values.length; i++) {
					if (idArray.indexOf(values[i].id) == -1) {
						ids.push(values[i].id);
						names.push(values[i].name);
					}
				}
				$form("indagateParticipantNames").val("");
				$form("indagateParticipantIds").val(ids.join(';'));
				$form("indagateParticipantNames").val(names.join(';'));
			}
		</script>
	</template:replace>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
			<template:replace name="barRight">
				<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
					<!-- 关联机制(与原有机制有差异) -->
					<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmPindagateMainForm" />
					<c:param name="approveType" value="right" />
					<c:param name="needTitle" value="true" />
				</c:import>
				</ui:tabpanel>
			</template:replace>
		</c:when>
		<c:otherwise>
			<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmPindagateMainForm" />
			</c:import>
		</template:replace>
	</c:otherwise>
	</c:choose>
	</template:include>