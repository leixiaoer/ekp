<%@page import="com.landray.kmss.sys.news.model.SysNewsConfig"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
   	 SysNewsConfig sysNewsConfig = new SysNewsConfig();
     pageContext.setAttribute("ImageW",sysNewsConfig.getfdImageW());
     pageContext.setAttribute("ImageH",sysNewsConfig.getfdImageH());
%>
<%--表单--%>
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
					document.getElementById("QS").style.display="";
					document.getElementById("showQSLink").style.display="none";
				}
				var pindagateType=$("input[name='fdPindagateType']:checked").val();
				if (pindagateType!="code") {
					$("[name='fdParticipantNum']").val("");
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
						 document.getElementById("place_content").style.display="none";
					}else{	
						LUI.$("[name='fdParticipantNum']").removeAttr("required",true); 
						 LUI.$("[name='fdParticipantNum']").removeAttr("validate","required digits min(0)"); 
		                 LUI.$("[name='indagateParticipantNames']").attr("validate","required"); 
						 LUI.$("[xform-name='mf_indagateParticipantNames']").attr("validate","required"); 
						 document.getElementById("place_title").innerText="<bean:message bundle='km-pindagate' key='kmPindagateMain.partic.people' />";
						 document.getElementById("particPeople").style.display="";
						 document.getElementById("participantNum").style.display="none";
						 document.getElementById("place_content").style.display="";
					}
				}
				 window.pindagateType_change=function(val){
					 pindagateType_change(val);
				 }
			});
			//提交
			function commitMethod(method, status){
				//判断是否有关联逻辑被清除校验
				tbInfo = DocList_TableInfo['TABLE_DocList'];
				count=0;
				content="";
				for(var i = 2; i<tbInfo.lastIndex; i++){
					var fields = $(tbInfo.DOMElement.rows[i]).find(".fdRelationDef");
					realtionDef={};
					for(var j=0; j<fields.length; j++){
						if (fields[j].value) {
							var relationDefVal=fields[j].value;
							relationDefVal=JSON.parse(relationDefVal);
							for ( var k in relationDefVal) {
								if (relationDefVal[k].sign=="false") {
									var count=parseInt(relationDefVal[k].currentTopic)+1;
									content+=count+" ";
								}
							}
						}
			 		}
				}
				if (content) {
					seajs.use([ 'lui/dialog' ], function(dialog) {
						dialog.confirm("关联逻辑必须设置为依赖于本题之前的题目,第"+content+"题关联逻辑以被清除!", function(value){
							if(value ===null||value==false){
								return;
							}
							var pindagateType=$("input[name='fdPindagateType']:checked").val();
							if (pindagateType=="code") {
								$("input[name='indagateParticipantIds']").val("");
							}
							//去掉多余的分页符
							SplitValidate();
							LUI.$("input[name='docStatus']").val(status);
							Com_Submit(document.kmPindagateMainForm, method);
						});
					});
				}else{
					var pindagateType=$("input[name='fdPindagateType']:checked").val();
					if (pindagateType=="code") {
						$("input[name='indagateParticipantIds']").val("");
					}
					//去掉多余的分页符
					SplitValidate();
					LUI.$("input[name='docStatus']").val(status);
					Com_Submit(document.kmPindagateMainForm, method);
				}
				
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
				 var docStartTime=document.getElementsByName('docStartTime')[0].value;
				 var docFinishedTime=document.getElementsByName('docFinishedTime')[0].value;
				  if(docFinishedTime!=null&&docFinishedTime!=""&&docStartTime!=null&&docStartTime!=""){
					 if(Date.parse(Com_GetDate(docFinishedTime))<=Date.parse(Com_GetDate(docStartTime))){
				    	return false;
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
				document.getElementById("QS").style.display="";
				_this.style.display="none";
			}
		</script>
		<c:if test="${param.approveModel ne 'right'}">
			<form name="kmPindagateMainForm" method="post" action ="${KMSS_Parameter_ContextPath}km/pindagate/km_pindagate_main/kmPindagateMain.do">
		</c:if>
		<html:hidden property="docStatus" value="20" />
		<html:hidden property="fdId" />
		<html:hidden property="method_GET" />
		<html:hidden property="fdTemplateId" /> 
		<ui:tabpage expand="false" collapsed="true">
			<ui:event event="layoutDone">
					this.element.find(".lui_tabpage_float_collapse").hide();
					this.element.find(".lui_tabpage_float_navs_mark").hide();
			</ui:event>
			<ui:content title="" toggle="false">
				<table class="tb_normal" width=100%>	
					<tr>
						<%--问卷主题(模板名称)--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject" />
						</td>
						<td width="35%">
							<xform:text property="docSubject" style="width:97%;" />
						</td>
						<%--调查类型--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.fdPindagateType" />
						</td>
						<td>
						<xform:radio property="fdPindagateType"  onValueChange="pindagateType_change(value);">
							<xform:enumsDataSource enumsType="kmPindagateMain_type" />
						</xform:radio>
						<span class="com_help">
								（<bean:message bundle="km-pindagate" key="kmPindagateMain.code.help" />）
						</span>
						</td>
					</tr>
					<tr>
						<%--调查时间--%>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docTime" />
						</td>
						<td width="35%">
							<xform:datetime property="docStartTime" dateTimeType="datetime"  style="width:45%;"  validators="after indagateCompareTime"  />
							<span style="position: relative;top:-5px;">—</span>
							<xform:datetime property="docFinishedTime" dateTimeType="datetime" style="width:45%;" validators="after indagateCompareTime" />
							<br/>
							<span class="com_help">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.tip.null.start.indagate" />;<br/>
								<bean:message bundle="km-pindagate" key="kmPindagateMain.tip.null.not.limit.time" />
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
							  <xform:address subject="${lfn:message('km-pindagate:kmPindagateMain.partic.people')}" propertyId="indagateParticipantIds"  propertyName="indagateParticipantNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%" required="true" />  
							</div>
						</td>
							<td width="35%"  id="participantNum">
							  <xform:text property="fdParticipantNum" subject="${lfn:message('km-pindagate:kmPindagateMain.dataLimit')}" style="width:97%;" required="true"  />
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
							<xform:address propertyId="indagateResultReaderIds" propertyName="indagateResultReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
						</td>
						<%-- 调查结束通知人员--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.over.notify.person" />
						</td>
						<td width="35%">
							<xform:address propertyId="indagateResultNotifierIds"  propertyName="indagateResultNotifierNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%" />
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
					<tr>
						<%--更多设置--%>
						<td colspan="4" class="td_normal_title" style="text-align: center;">
							<a href="javascript:void(0);" onclick="showMoreSet();" id="showMoreSet" class="pindagate_slideDown">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.more.set.slideDown" /></a>
						</td>
					</tr>
					<tr  style="display: none"  id="moreSetting"><td width="100%" colspan=4 style="padding: 0px;">
					<table class="tb_normal" width="100%" >
						<tr  id="place_content">
							<%--调查通知方式--%>
							<td class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.notify.type" />
							</td>
							<td>
								<c:choose>
									<c:when test="${kmPindagateMainForm.method_GET == 'add' }">
										<kmss:editNotifyType property="fdNotifyType" />
									</c:when>
									<c:otherwise>
									<script type="text/javascript">
									$(document).ready(function(){
										if("${kmPindagateMainForm.fdNotifyType }"==""||"${kmPindagateMainForm.fdNotifyType }"==null){
											$(":checkbox[name^='__notify_type']").prop("checked",false);
											$("input[name='fdNotifyType']").val("");
										}
									});
									</script>
											<kmss:editNotifyType property="fdNotifyType" value="${kmPindagateMainForm.fdNotifyType }"/>
									</c:otherwise>
								</c:choose>
							</td>
							<%--调查结束前提醒设置--%>
							<td class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.before.notify.set" />
							</td>
							<td>
								<bean:message bundle="km-pindagate" key="kmPindagateMain.before.time" />
								<xform:text property="fdBeginNotifyPre" style="width:35px;" />
								<strong>
									<A name="_RefreshKW_F_RemindType"></A>
									<xform:select property="fdNotifyTimeUnit" showPleaseSelect="false">
										<xform:enumsDataSource enumsType="kmPindagateMain_config_unit" />
									</xform:select> 
								</strong>
								<bean:message bundle="km-pindagate" key="kmPindagateMain.start.remind" /><br/>
								<bean:message bundle="km-pindagate" key="kmPindagateMain.after.each" />
								
								<strong> 
									<xform:text property="fdNotifyInterval" style="width:35px;" required="true" validators="min(10)"/>
								</strong>
								<strong>
									<bean:message bundle="km-pindagate" key="kmPindagateMain.config.min" />
								</strong>
								<bean:message bundle="km-pindagate" key="kmPindagateMain.starting.remind" />
								<bean:message bundle="km-pindagate" key="kmPindagateMain.remind" />
								<strong>
									<xform:text property="fdNotifyFrequency" style="width:35px;" required="true" validators="range(1,8)"/> 
								</strong> 
								<bean:message bundle="km-pindagate" key="kmPindagateMain.times.over" />
							</td>
						</tr>
						<tr>
							<%--允许同一用户进行多次调查--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.permission.multi.indagate" />
							</td>
							<td width="35%">
								<xform:radio property="fdPersonMulti">
									<xform:enumsDataSource enumsType="common_yesno" />
								</xform:radio>
							</td>
							<%--是否记录参与调查人名单--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.is.record.attend.name" />
							</td>
							<td width="35%">
								<xform:radio property="fdRecordPartic">
									<xform:enumsDataSource enumsType="common_yesno" />
								</xform:radio>
								<span class="com_help">(<bean:message bundle="km-pindagate" key="kmPindagateMain.tip.control" />)</span>
							</td>
						</tr>
						<tr>
							<!-- 是否允许用户可以拒绝调查 -->
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.fdRejectPinda" />
							</td>
							<td width="35%">
								<xform:radio property="fdRejectPinda" value="false">
									<xform:enumsDataSource enumsType="common_yesno" />
								</xform:radio>
							</td>
							<%--录入者--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.docCreatorName" />
							</td>
							<td width="35%">
								<html:hidden property="docCreatorId" />
								<c:out value="${kmPindagateMainForm.docCreatorName}" />
								<html:hidden property="docCreateTime" />
								<c:out value="${kmPindagateMainForm.docCreateTime}" />
							</td>
							<%--录入时间已被注释--%>
							<%-- <td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.docCreateTime" />
							</td>
							<td width="35%">
								<html:hidden property="docCreateTime" />
								<c:out value="${kmPindagateMainForm.docCreateTime}" />
							</td> --%>
						</tr>
						<tr>
							<%--附件--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.attachment" />
							</td>
							<td colspan="3">
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="attachment" />
									<c:param name="formBeanName" value="kmPindagateMainForm" />
								</c:import>
							</td>
						</tr>
						<tr>
							<%--标题图片--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.fdMainPicture"/>
							</td>
							<td colspan="3">
								<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="pic" />
									<c:param name="fdMulti" value="false" />
									<c:param name="fdAttType" value="pic" />
									<c:param name="fdModelId" value="${param.fdId }" />
									<c:param name="fdModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
									<%-- 图片设定大小 --%>
									<c:param name="picWidth" value="${ImageW}" />
									<c:param name="picHeight" value="${ImageH}" />
									<c:param name="proportion" value="false" />
									<c:param name="fdLayoutType" value="pic"/>
									<c:param name="fdPicContentWidth" value="${ImageW}"/>
									<c:param name="fdPicContentHeight" value="${ImageH}"/>
									<c:param name="fdViewType" value="pic_single"/>
								</c:import>
							</td>
						</tr>
					</table>
					</td></tr>
				</table>
				<br/>
				<%--设置调查题目按钮--%>
				<a style="display:block;cursor: pointer;background-image: url('${LUI_ContextPath}/km/pindagate/images/question_button.png');width:167px;height:57px;" 
					onclick="showQS(this);" id="showQSLink">
					<div style="font-size: 16px;color: white;padding: 18px 15px;">
						<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.setQuestion"/>						
					</div>
				</a>
				<%--问卷--%>
				<div id="QS" style="display: none;">
					<div class="lui_tabpage_float_header_l">
						<div class="lui_tabpage_float_header_text">${lfn:message('km-pindagate:table.kmPindagateQuestion')}</div>
					</div>
					<br/>
					<%@include file="/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_edit.jsp"%>
				</div>
				</ui:content>
		</ui:tabpage>
		<c:choose>
				<c:when test="${param.approveModel eq 'right'}">
					<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-expand="true"   var-count="5" var-average='false' var-useMaxWidth='true'>
						<%--流程机制 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="fdKey" value="pindagateMain" />
							<c:param name="showHistoryOpers" value="true" />
							<c:param name="isExpand" value="true" />
							<c:param name="approveType" value="right" />
						</c:import>
						<%--权限机制 --%>
						<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
						</c:import>
					</ui:tabpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpage expand="false">
						<%--流程机制 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="fdKey" value="pindagateMain" />
						</c:import>
						<%--权限机制 --%>
						<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
						</c:import>
					</ui:tabpage>
				</c:otherwise>
			</c:choose>
		<c:if test="${param.approveModel ne 'right'}">
			</form>
		</c:if>
		
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
			_validation.addValidator("remindTime","提醒次数不要超过8",function(v, e, o) {
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
					<%-- 流程 --%>
					<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmPindagateMainForm" />
						<c:param name="fdKey" value="pindagateMain" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
						<c:param name="approvePosition" value="right" />
					</c:import>
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