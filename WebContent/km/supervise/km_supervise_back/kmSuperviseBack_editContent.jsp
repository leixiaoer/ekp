<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script>
    Com_IncludeFile("dialog.js|jquery.js");
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
    Com_IncludeFile('jquery.ui.widget.js|jquery.marcopolo.js|jquery.manifest.js','js/jquery-plugin/manifest/');
</script>
<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
		<ui:content title="${lfn:message('km-supervise:py.fanKuiXinXi') }" expand="true">
			<p class="txttitle">
				<bean:write name="kmSuperviseBackForm" property="docSubject" />
			</p>
			<div class="lui_form_content_frame" >
	            <table class="tb_normal" width="95%">
	            	<!-- 反馈单位 -->
	            	<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />
						</td>
						<td colspan="3">
							<c:choose>
								<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
									<xform:dialog propertyId="fdSysUnitId"
								              propertyName="fdSysUnitName"
									          style="width:35%;" 
									          className="inputsgl"
									          useNewStyle="true"
									          required="true"
									          subject="${ lfn:message('km-supervise:kmSuperviseMain.fdSysUnit') }">  
										      Dialog_UnitTreeList(false, 'fdSysUnitId', 'fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
										      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
									</xform:dialog>
									<script>
										initNewDialog("fdSysUnitId","fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"${kmSuperviseBackForm.fdSysUnitId}","${kmSuperviseBackForm.fdSysUnitName}",null);
									</script>
								</c:when>
								<c:otherwise>
									<xform:address propertyName="fdUnitName" propertyId="fdUnitId" orgType="ORG_TYPE_DEPT" required="true" style="width:35%;"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<!-- 反馈人 -->
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdPerson" />
						</td>
						<td colspan="3">
							<xform:address propertyName="fdPersonName" propertyId="fdPersonId" orgType="ORG_TYPE_PERSON" required="true" style="width:35%;" onValueChange="changePerson()"/>
						</td>
					</tr>
					<!-- 反馈时间 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdFeedbackTime" />
						</td>
						<td>
							<xform:datetime property="fdFeedbackTime" required="true" style="width:35%;"/>
						</td>
					</tr>
					<!-- 反馈阶段 -->
					
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdTask" />
						</td>
						<td colspan="3">
							<c:choose>
								<c:when test="${empty kmSuperviseBackForm.fdTaskId  }">
									<xform:select property="fdTaskId" showStatus="edit" style="width:45%" onValueChange="getBackPeriod(value);" subject="${lfn:message('km-supervise:kmSuperviseBack.fdTask') }" required="true">
									</xform:select>
								</c:when>
								<c:otherwise>
									<html:hidden property="fdTaskId" />
									<c:out value="${kmSuperviseBackForm.fdTaskSubject}"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<!-- 反馈周期 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdBackPeriod" />
						</td>
						<td colspan="3">
							<c:choose>
								<c:when test="${kmSuperviseBackForm.fdBackType != '0'}">
									<c:choose>
										<c:when test="${empty kmSuperviseBackForm.fdBackPeriod }">
											<xform:select property="fdBackPeriod" showStatus="edit"  style="width:45%" required="true">
											</xform:select>
										</c:when>
										<c:otherwise>
											<html:hidden property="fdBackPeriod" />
											<c:out value="${kmSuperviseBackForm.fdBackDay}"/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<html:hidden property="fdBackPeriod" />
									<span><bean:message bundle="km-supervise" key="enums.task.back.default" /></span>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<!-- 阶段目标 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStageTarget" />
						</td>
						<td colspan="3">
							<html:hidden property="fdStageTarget" />
							<span id="fdStageTargetSpan"> <c:out value="${kmSuperviseBackForm.fdStageTarget}"/></span>
						</td>
					</tr>
					
					<!-- 任务进度 -->
	                <tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
						</td>
						<td width="35%">
							<c:choose>
								<c:when test="${kmSuperviseBackForm.isUndertake eq 'true' || kmSuperviseBackForm.method_GET == 'edit'}">
									<span id="fdProgreeAuto_id">
										<div id="sliderProcess" style="height:15px;margin:5px 0px 5px 0px"></div>
									</span>
									<span>
										<html:text style="width:25px" property="fdProgress" onchange="setProgress();"/>%
									</span>
								</c:when>
								<c:otherwise>
									<html:hidden property="fdProgress" />
									<span class="lui_supervise_progress">
						        		<span class="lui_supervise_bar">
						            		<div id="lui_supervise_inner_bar" class="lui_supervise_inner_bar com_bgcolor_d" style="width:${kmSuperviseBackForm.fdProgress}%"></div>
						        		</span>
       							 		<span id="lui_supervise_rate" class="lui_supervise_rate"><c:out value="${kmSuperviseBackForm.fdProgress}"/>%</span>
    								</span>
    								<c:choose>
			    						<c:when test="${kmSuperviseBackForm.fdSysUnitEnable eq 'true'}">
			    							<span style="margin-left:40px;color:#666666;font-size:12px">仅承办单位需要反馈进度</span>
			    						</c:when>
			    						<c:otherwise>
			    							<span style="margin-left:40px;color:#666666;font-size:12px">仅承办人需要反馈进度</span>
			    						</c:otherwise>
		    						</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<!-- 督办状态 -->
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.fdStatus" />
						</td>
						<td colspan="3">
							<xform:radio property="fdStatus" value="${kmSuperviseBackForm.fdStatus}" htmlElementProperties="onchange=setfdStatus()" >
								<xform:enumsDataSource enumsType="km_supervise_back_status" />
							</xform:radio>
						</td>
					</tr>
					
					<!-- 进展情况 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.docProgress" />
						</td>
						<td colspan="3">
							<xform:textarea property="docProgress" style="width:95%;" placeholder="请输入当前进展情况" required="true"/>
						</td>
					</tr>
					<!-- 存在困难及下一步措施 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.docDifficulty"/>
						</td>
						<td colspan="3">
							<xform:textarea property="docDifficulty" style="width:95%;" placeholder="请输入当前阶段遇到的困难及你的解决措施"/>
						</td>
					</tr>
					<!-- 相关附件 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseBack.attBack"/>
						</td>
						<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="attBack"/>
								<c:param name="formBeanName" value="kmSuperviseBackForm" />
				                <c:param name="fdMulti" value="true" />
							</c:import>	
						</td>
					</tr>
	            </table>
	        </div>
		</ui:content>
		
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
	        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_edit.jsp" charEncoding="UTF-8">
	            <c:param name="formName" value="kmSuperviseBackForm" />
	            <c:param name="fdKey" value="kmSuperviseFeedback" />
	            <c:param name="showHistoryOpers" value="true" />
	            <c:param name="isExpand" value="true" />
        	</c:import>
		</c:if>
	</c:when>
</c:choose>