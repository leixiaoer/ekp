<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%--主文档--%>
	<template:replace name="content"> 
	<style>
		.pindagate_slideDown {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowd_blue.png) no-repeat 0 3px;cursor: pointer;}
		.pindagate_slideUp {margin-left: 12px;padding-left: 15px;font-size: 12px;text-decoration: underline;background: url(../images/icon_arrowU_blue.png) no-repeat 0 3px;cursor: pointer;}
		.com_approval_bar2{z-index:9!important;}
	</style>
	<script type="text/javascript">
		var _dialog;
		seajs.use(['lui/dialog'], function(dialog) {
			_dialog=dialog;
		});
	</script>
	<script type="text/javascript">
		// 修改可调查人员
		var url = 'kmPindagateMain.do?method=updatePindagater&fdId=${JsParam.fdId}';
		seajs.use(["lui/dialog"],function(dialog){
			window.editQuestioner=function(){
			var onOk = function(value,obj){
				obj.content.frame.find("iframe")[0].contentWindow.submitBtn();
				
			}
			var onCancel = function(value,obj){
				obj.hide();
			}
				dialog.iframe(url,"修改参与人员",null,{
					width:700,
					height:400,
					buttons:[{name:"确定",value:1,fn:onOk},{name:"取消",value:0,fn:onCancel}]
				});
			}
		});
	
	
	
		//开始调查
		function startIndagate(){
			_dialog.confirm('<bean:message bundle="km-pindagate" key="view.comfirmStartIndagate"/>',function(value){
				if(value==true){
					Com_OpenWindow('kmPindagateMain.do?method=startIndagate&fdId=${JsParam.fdId}','_self');
				}
			});
		}
		//结束调查
		function stopIndagate(){
			_dialog.confirm('<bean:message bundle="km-pindagate" key="view.comfirmStopIndagate"/>',function(value){
				if(value==true){
					Com_OpenWindow('kmPindagateMain.do?method=stopIndagate&fdId=${JsParam.fdId}','_self');
				}
			});
		}
		//催办未调查者
		function pressAbsent(){
			window._load = _dialog.loading();
			LUI.$.post('<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=pressAbsent&fdId=${JsParam.fdId}"/>',
				function(data){
					if(window._load!=null)
						window._load.hide();
					if(data!=null && data.status==true){
						_dialog.success('<bean:message key="button.pressAbsent.message" bundle="km-pindagate"/>');
					}else{
						_dialog.failure('<bean:message key="return.optFailure" />');
					}
				},'json');
		}
		/**
		 * 打开编辑模态窗口,修改调查结束时间
		 */
		function updateEndTime(){
			var docFinishedTime = "${kmPindagateMainForm.docFinishedTime}";
			var url = '/km/pindagate/km_pindagate_ui/kmPindagateMain_updateEndTime.jsp?docFinishedTime='+docFinishedTime;
			_dialog.iframe(url," ",function(value){
				if(value!=null){
					Com_OpenWindow('${LUI_ContextPath}/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=updateIndagateEndTime&fdId=${JsParam.fdId}&endtime='+value,'_self');
				}
			},{"width":580,"height":480});
		}
		//删除问卷
		function deleteDoc(delUrl){
			_dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
				if(isOk){
					Com_OpenWindow(delUrl,'_self');
				}	
			});
			return;
		}
		/**
		 * 生成题目模板
		 */
		function copyTemplates(){
			Dialog_Tree(false,null,null,';',
					'sysCategoryTreeService&categoryId=!{value}&authType=02&modelName=com.landray.kmss.km.pindagate.model.KmPindagateMainTemp',
					'<bean:message bundle="km-pindagate" key="kmPindagateMain.category" />',
					false,copyAsTemplates,null,false,true,'<bean:message bundle="km-pindagate" key="kmPindagateMain.category" />');
		}
		/**
		 * 生成题目模板回调函数
		 */
		function copyAsTemplates(rtnVal) {
	    	if(rtnVal == null) {
	    		return;
	    	}
	    	var info = rtnVal.GetHashMapArray()[0];
	    	if(info===undefined){
	    		return;
		    }
	    	var docCategoryId=info.id;
	    	var url='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=copyAsTemplate&fdId=${JsParam.fdId}&fdCategoryId='+docCategoryId;
	    	setTimeout("location='"+url+"';", 100);
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
	</script>
		<ui:tabpage expand="false" collapsed="true" var-navwidth="85%">
			<ui:event event="layoutDone">
					this.element.find(".lui_tabpage_float_collapse").hide();
					this.element.find(".lui_tabpage_float_navs_mark").hide();
			</ui:event>
			<%--基本信息--%>
			<ui:content title="" toggle="false">
				<table class="tb_normal" width="100%" id="mainTable">
					<tr>
						<%--问卷主题(模板名称)--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject"/>
						</td>
						<td width="35%">
							<xform:text property="docSubject" style="width:50%;"/>
							<xform:text property="docSubject"  showStatus="noShow"/>
						</td>
						
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.fdPindagateType" />
						</td>
						<td>
						<xform:radio property="fdPindagateType">
							<xform:enumsDataSource enumsType="kmPindagateMain_type" />
						</xform:radio>
						</td>
					</tr>
					
					<tr>
						<%--调查时间--%>
						<td class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.docTime"/>
						</td>
						<td width="35%">
							<c:if test="${kmPindagateMainForm.docStartTime==null }">
								<bean:message key="kmPindagateMain.null.start.time" bundle="km-pindagate" />
							</c:if>
							<c:out value="${kmPindagateMainForm.docStartTime }"></c:out>—
							<c:if test="${kmPindagateMainForm.docFinishedTime==null }">
								<bean:message key="kmPindagateMain.null.not.limit.time" bundle="km-pindagate" />
							</c:if>
							<c:out value="${kmPindagateMainForm.docFinishedTime }"></c:out>
						</td>
						<%-- 参与调查人员--%>
					<c:if test="${kmPindagateMainForm.fdPindagateType ne  'code' }">
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.partic.people"/>
						</td>
						<td width="35%">
							<xform:address propertyId="indagateParticipantIds" propertyName="indagateParticipantNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
						</td>
					</c:if>
					<c:if test="${kmPindagateMainForm.fdPindagateType eq  'code' }">
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.dataLimit"/>
						</td>
						<td width="35%">
							<c:out value="${kmPindagateMainForm.fdParticipantNum}"></c:out>
						</td>
					</c:if>
					</tr>
					<%-- 所属场所 --%>
					<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
		                <c:param name="id" value="${kmPindagateMainForm.authAreaId}"/>
		            </c:import>  
    				<tr>
    					<%-- 调查结果可阅读者--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.result.reader" />
						</td>
						<td width="35%">
							<xform:address propertyId="indagateResultReaderIds" propertyName="indagateResultReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
						</td>
						<%--调查结束通知人员--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.over.notify.person" />
						</td>
						<td width="35%">
							<xform:address propertyId="indagateResultNotifierIds" propertyName="indagateResultNotifierNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:95%"/>
						</td>
					</tr>	
					<tr>
						<%--问卷说明--%>
						<td width="15%" class="td_normal_title">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.fdQuestionExplain" />
						</td>
						<td colspan="3">
							<c:if test="${kmPindagateMainForm.fdQuestionExplain!=null}">
								<xform:rtf property="fdQuestionExplain" height="220" width="80%" toolbarSet="Default"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<%--更多设置--%>
      					<td colspan="4" class="td_normal_title"  style="text-align: center;">
      						<a href="javascript:void(0);" onclick="showMoreSet();" id="showMoreSet" class="pindagate_slideUp">
							<bean:message bundle="km-pindagate" key="kmPindagateMain.more.set.slideUp" /></a>
      					</td>
  					</tr>
  					<tr id="moreSetting"><td width="100%" colspan=4 style="padding: 0px;">
	  				<table class="tb_normal" width="100%">
						<c:if test="${kmPindagateMainForm.fdPindagateType ne  'code' }">
						<tr>
							<%--调查通知方式--%>
							<td class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.notify.type" />
							</td>
		  					<td>
		  						<kmss:showNotifyType value="${kmPindagateMainForm.fdNotifyType}"/>
		  					</td>
		  					<%--调查结束前提醒设置--%>
		  					<td class="td_normal_title">
		  						<bean:message bundle="km-pindagate" key="kmPindagateMain.before.notify.set" />
		  					</td>
		  					<td>
		  						<c:if test="${not empty kmPindagateMainForm.fdBeginNotifyPre }">
		  							<bean:message bundle="km-pindagate" key="kmPindagateMain.before.time" />
			  						<strong><xform:text property="fdBeginNotifyPre" style="" /></strong>
			  						<strong>
				  						<A name="_RefreshKW_F_RemindType"></A>
				  						<xform:select property="fdNotifyTimeUnit" ><xform:enumsDataSource enumsType="kmPindagateMain_config_unit" /></xform:select>
		        					</strong>
		        					<bean:message bundle="km-pindagate" key="kmPindagateMain.start.remind" /><br/>
		        					<bean:message bundle="km-pindagate" key="kmPindagateMain.after.each" />
		        					<strong>
		        						<c:if test="${not empty kmPindagateMainForm.fdNotifyInterval }">
		        							<xform:text property="fdNotifyInterval"/>
		        						</c:if>
		        						<c:if test="${empty kmPindagateMainForm.fdNotifyInterval }">
		        							60
		        						</c:if>
		        					</strong>
		        					<strong><bean:message bundle="km-pindagate" key="kmPindagateMain.config.min" /></strong>
		        					<bean:message bundle="km-pindagate" key="kmPindagateMain.starting.remind" />
		        					<bean:message bundle="km-pindagate" key="kmPindagateMain.remind" />
		        					<strong>
		        						<c:if test="${not empty kmPindagateMainForm.fdNotifyFrequency }">
		        							<xform:text property="fdNotifyFrequency"/>
		        						</c:if>
		        						<c:if test="${empty kmPindagateMainForm.fdNotifyFrequency }">
		        							1
		        						</c:if>
		        					</strong>
		        					<bean:message bundle="km-pindagate" key="kmPindagateMain.times.over" />
		  						</c:if>
		  						<c:if test="${empty kmPindagateMainForm.fdBeginNotifyPre }">
		  							<bean:message bundle="km-pindagate" key="kmPindagateMain.notify.notNotify"/>
		  						</c:if>
	        				</td>
						</tr>
						</c:if>
						<tr>
							<%--允许同一用户进行多次调查 --%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.permission.multi.indagate" /> 
							</td>
							<td width="35%">
								<xform:radio property="fdPersonMulti"><xform:enumsDataSource enumsType="common_yesno" /></xform:radio>
							</td>	
							<%--是否记录参与调查人名单 --%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.is.record.attend.name" />
							</td>
							<td width="35%">
								<xform:radio property="fdRecordPartic"><xform:enumsDataSource enumsType="common_yesno" /></xform:radio>
							</td>
						</tr>
						<tr>
							<%--允许拒绝问卷调查 --%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.fdRejectPinda" />
							</td>
							<td width="35%">
								<xform:radio property="fdRejectPinda"><xform:enumsDataSource enumsType="common_yesno" /></xform:radio>
							</td>
							<%--录入者 --%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.docCreatorName" />
							</td>
							<td width="35%">
								<c:out value="${kmPindagateMainForm.docCreatorName }"></c:out>
								<c:out value="${kmPindagateMainForm.docCreateTime }"></c:out>
							</td>
							<%--录入时间--%>
							<%-- <td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.docCreateTime" />
							</td>
							<td width="35%">
								<c:out value="${kmPindagateMainForm.docCreateTime }"></c:out>
							</td> --%>
						</tr>
						
						<tr>
							<%--附件--%>
							<td width="15%" class="td_normal_title" valign="top">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.attachment" />
							</td>
							<td colspan="3">
	                    		<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
									<c:param name="formBeanName" value="kmPindagateMainForm" />
									<c:param name="fdKey" value="attachment" />
								</c:import>
							</td>
						</tr>
						<tr>
							<%--标题图片--%>
							<td width="15%" class="td_normal_title">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.fdMainPicture"/>
							</td>
							<td colspan="3">
								 <c:if test="${hasImage eq true}">  
									 <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="pic" />
										<c:param name="fdMulti" value="false" />
										<c:param name="fdAttType" value="pic" />
										<c:param name="fdModelId" value="${kmPindagateMainForm.fdId }" />
										<c:param name="fdModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
										<%-- 图片设定大小 --%>
										<c:param name="picWidth" value="258" />
										<c:param name="picHeight" value="192" />
										<c:param name="proportion" value="false" />
										<c:param name="fdLayoutType" value="pic"/>
										<c:param name="fdPicContentWidth" value="258"/>
										<c:param name="fdPicContentHeight" value="192"/>
										<c:param name="fdViewType" value="pic_single"/>
										<c:param name="fdShowMsg">false</c:param>
									</c:import>
								</c:if>
							</td>
						</tr>
						<%-- 参与人员答卷分析结果附件--%>
						<tr>
							<td width="15%" class="td_normal_title" valign="top">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.analysisResponses.attachment" />
							</td>
							<td colspan="3">
								<kmss:auth requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=resultsView&fdId=${kmPindagateMainForm.fdId}">
					               <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
										<c:param name="fdKey" value="resultsDetail"/>
										<c:param name="formBeanName" value="kmPindagateMainForm" />
									</c:import>
				                </kmss:auth> 
							</td>
						</tr>
					</table>	
					</td></tr>
				</table>
				
			</ui:content>
			<%--问卷--%>
			<ui:content title="${lfn:message('km-pindagate:table.kmPindagateQuestion')}" toggle="false">
				<%@include file="/km/pindagate/km_pindagate_question_ui/kmPindagateQuestion_view.jsp"%>
			</ui:content>
			</ui:tabpage>
			
		
		
		<c:choose>
			<c:when test="${param.approveModel eq 'right'}">
				<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-expand="true"  var-count="5" var-average='false' var-useMaxWidth='true'>
					
					<%--查看调查人员--%>
					 <c:if test="${kmPindagateMainForm.fdRecordPartic=='true'&&(kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32')}">
					 <ui:content cfg-order="1" title="${lfn:message('km-pindagate:kmPindagate.indagator.show')}">
					 	<ui:event event="show"> 
					 		var fdMainId = "${kmPindagateMainForm.fdId}";
					 		var url='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=viewIndagatePersonInfo&fdId='+fdMainId;
					 		document.getElementById("participateIframe").src=url+'&flag=already';
					 		document.getElementById("notInvolvedIframe").src=url+'&flag=absent';
					 		document.getElementById("rejectIframe").src=url+'&flag=reject';
						</ui:event>
						<table class="tb_normal"  width="100%"  >	
							<tr>  
								<%--已调查人员--%>
								<td width="15%" class="td_normal_title">
									<bean:message bundle="km-pindagate" key="kmPindagate.indagated.persons" />
								</td>
								<td  width="85%" >
									<iframe id="participateIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
								</td>
							</tr>
							<tr>
								<%--未调查人员--%>
								<td width="15%" class="td_normal_title">
									<bean:message bundle="km-pindagate" key="kmPindagate.indagating.persons" />
								</td>
								<td  width="85%" >
									<iframe id="notInvolvedIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
								</td>
							</tr>
							<tr>
								<%--不参加调查人员--%>
								<td width="15%" class="td_normal_title">
									<bean:message bundle="km-pindagate" key="kmPindagate.reject.persons" />
								</td>
								<td  width="85%" >
									<iframe id="rejectIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
								</td>
							</tr>
						</table>
					 </ui:content>
					 </c:if>
					<%--传阅/阅读--%>
					<c:if test="${kmPindagateMainForm.docStatus=='30'||kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32'}">
						<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="order" value="2" />
						</c:import>
						<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="order" value="3" />
						</c:import>
					</c:if>
					
					<c:choose>
						<c:when test="${kmPindagateMainForm.docStatus>='30' || kmPindagateMainForm.docStatus=='00'}">
							<!-- 流程 -->
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmPindagateMainForm" />
								<c:param name="fdKey" value="pindagateMain" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right"></c:param>
								<c:param name="needInitLbpm" value="true" />
							</c:import>
						</c:when>
						<c:otherwise>
							<%--流程机制 --%>
							<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmPindagateMainForm" />
								<c:param name="fdKey" value="pindagateMain" />
								<c:param name="showHistoryOpers" value="true" />
								<c:param name="isExpand" value="true" />
								<c:param name="approveType" value="right"></c:param>
							</c:import>
						</c:otherwise>
					</c:choose>
					<%--权限机制 --%>
					<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmPindagateMainForm" />
						<c:param name="moduleModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
					</c:import>
					
				</ui:tabpanel>
			</c:when>
				<c:otherwise>
				<ui:tabpage expand="false" var-navwidth="90%">
						
						<%--查看调查人员--%>
						 <c:if test="${kmPindagateMainForm.fdRecordPartic=='true'&&(kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32')}">
						 <ui:content cfg-order="1" title="${lfn:message('km-pindagate:kmPindagate.indagator.show')}">
						 	<ui:event event="show"> 
						 		var fdMainId = "${kmPindagateMainForm.fdId}";
						 		var url='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do"/>?method=viewIndagatePersonInfo&fdId='+fdMainId;
						 		document.getElementById("participateIframe").src=url+'&flag=already';
						 		document.getElementById("notInvolvedIframe").src=url+'&flag=absent';
						 		document.getElementById("rejectIframe").src=url+'&flag=reject';
							</ui:event>
							<table class="tb_normal"  width="100%"  >	
								<tr>  
									<%--已调查人员--%>
									<td width="15%" class="td_normal_title">
										<bean:message bundle="km-pindagate" key="kmPindagate.indagated.persons" />
									</td>
									<td  width="85%" >
										<iframe id="participateIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
									</td>
								</tr>
								<tr>
									<%--未调查人员--%>
									<td width="15%" class="td_normal_title">
										<bean:message bundle="km-pindagate" key="kmPindagate.indagating.persons" />
									</td>
									<td  width="85%" >
										<iframe id="notInvolvedIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
									</td>
								</tr>
								<tr>
									<%--不参加调查人员--%>
									<td width="15%" class="td_normal_title">
										<bean:message bundle="km-pindagate" key="kmPindagate.reject.persons" />
									</td>
									<td  width="85%" >
										<iframe id="rejectIframe" allowTransparency="true" width="100%"  marginheight="0" marginwidth="0" scrolling=no frameborder=0 src=''></iframe>
									</td>
								</tr>
							</table>
						 </ui:content>
						 </c:if>
						<%--传阅/阅读--%>
						<c:if test="${kmPindagateMainForm.docStatus=='30'||kmPindagateMainForm.docStatus=='31'||kmPindagateMainForm.docStatus=='32'}">
							<c:import url="/sys/circulation/import/sysCirculationMain_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmPindagateMainForm" />
								<c:param name="order" value="2" />
							</c:import>
							<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
								<c:param name="formName" value="kmPindagateMainForm" />
								<c:param name="order" value="3" />
							</c:import>
						</c:if>
						<%--流程机制 --%>
						<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="fdKey" value="pindagateMain" />
						</c:import>
						<%--权限机制 --%>
						<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
							<c:param name="formName" value="kmPindagateMainForm" />
							<c:param name="moduleModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
						</c:import>
					</ui:tabpage>
				</c:otherwise>
			</c:choose>
		
		
	</template:replace>
	<c:choose>
		<c:when test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
		<c:choose>
				<c:when test="${kmPindagateMainForm.docStatus>='30' || kmPindagateMainForm.docStatus=='00'}">
					<ui:accordionpanel>
						<!-- 基本信息-->
						<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
						</c:import>
					</ui:accordionpanel>
				</c:when>
				<c:otherwise>
					<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel" >
					<%-- 流程 --%>
					<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmPindagateMainForm" />
						<c:param name="fdKey" value="pindagateMain" />
						<c:param name="showHistoryOpers" value="true" />
						<c:param name="isExpand" value="true" />
						<c:param name="approveType" value="right" />
						<c:param name="approvePosition" value="right" />
					</c:import>
					<!-- 审批记录 -->
					<c:import url="/sys/lbpmservice/support/lbpm_audit_note/lbpmAuditNote_list_content.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmPindagateMainForm" />
						<c:param name="fdModelId" value="${kmPindagateMainForm.fdId}" />
						<c:param name="fdModelName" value="com.landray.kmss.km.pindagate.model.KmPindagateMain" />
					</c:import>
					<!-- 基本信息-->
					<c:import url="/km/pindagate/km_pindagate_ui/kmPindagateMain_viewBaseInfoContent.jsp" charEncoding="UTF-8">
					</c:import>
				</ui:tabpanel>
				</c:otherwise>
		</c:choose>
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