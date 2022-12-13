<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
		<ui:content title="${lfn:message('km-supervise:py.RenWuZhiPai')}" expand="true">
			<div class="lui_supervise_plan_wrap">
			    <div class="lui_supervise_plan_table">
				    <p class="txttitle">
						<bean:write name="kmSuperviseMainPlanForm" property="docSubject" />
					</p>
			    	<table id="TABLE_DocList" class="tb_normal" width=100%>
			            <tr>
			    			<td class="td_normal_title" style="width: 10%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 20%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 10%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
			    			</td>
			            </tr>
						<c:forEach items="${kmSuperviseMainPlanForm.fdTaskItems}"  var="fdItem" varStatus="vstatus">
							<tr KMSS_IsContentRow="1" class="task_add_class">
								<td>
									<html:hidden property="fdTaskItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
									<xform:text property="fdTaskItems[${vstatus.index}].docSubject" style="width:95%" showStatus="readOnly" value="${fdItem.docSubject}"/>
								</td>
								<td>
									<xform:textarea property="fdTaskItems[${vstatus.index}].docContent" style="width:90%" showStatus="readOnly" value="${fdItem.docContent}"/>
								</td>
								<td>
									<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanStartTime" style="width:93%;" value="${fdItem.fdPlanStartTime}" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" dateTimeType="datetime"  showStatus="readOnly" />
								</td>
								<td>
									<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanEndTime"  style="width:93%;"  value="${fdItem.fdPlanEndTime}" subject="${ lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" dateTimeType="datetime" showStatus="readOnly" />
								</td>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
											<xform:dialog propertyId="fdTaskItems[${vstatus.index}].fdSysUnitId"
									              propertyName="fdTaskItems[${vstatus.index}].fdSysUnitName"
										          style="width:95%;" 
										          className="inputsgl"
										          mulSelect="false"
										          useNewStyle="true"
										          required="true">
											      Dialog_UnitTreeList(false, 'fdTaskItems[${vstatus.index}].fdSysUnitId', 'fdTaskItems[${vstatus.index}].fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
											      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
											</xform:dialog>
										</c:when>
										<c:otherwise>
											<xform:address propertyId="fdTaskItems[${vstatus.index}].fdUnitId" propertyName="fdTaskItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" required="true"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<xform:address propertyId="fdTaskItems[${vstatus.index}].fdSponsorId" propertyName="fdTaskItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" required="true"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
											<xform:dialog propertyId="fdTaskItems[${vstatus.index}].fdOtherUnitIds"
									              propertyName="fdTaskItems[${vstatus.index}].fdOtherUnitNames"
										          style="width:95%;" 
										          className="inputsgl"
										          mulSelect="true"
										          useNewStyle="true">
											      Dialog_UnitTreeList(true, 'fdTaskItems[${vstatus.index}].fdOtherUnitIds', 'fdTaskItems[${vstatus.index}].fdOtherUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
											      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
											</xform:dialog>
										</c:when>
										<c:otherwise>
											<xform:address propertyId="fdTaskItems[${vstatus.index}].fdOUnitIds" propertyName="fdTaskItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mulSelect="true"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<c:if test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
								<script>
									initNewDialog("fdTaskItems[${vstatus.index}].fdSysUnitId","fdTaskItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"","",null);
									resetNewDialog("fdTaskItems[${vstatus.index}].fdSysUnitId","fdTaskItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"${fdItem.fdSysUnitId}","${fdItem.fdSysUnitName}",null);
									initNewDialog("fdTaskItems[${vstatus.index}].fdOtherUnitIds","fdTaskItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",null);
									resetNewDialog("fdTaskItems[${vstatus.index}].fdOtherUnitIds","fdTaskItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"${fdItem.fdOtherUnitIds}","${fdItem.fdOtherUnitNames}",null);
								</script>
							</c:if>
						</c:forEach>
					</table>
				</div>
			    <div class="lui_supervise_plan_other">
					<table class="tb_simple">
			    		<tr>
					    	<td class="td_normal_title td1">
					      		<bean:message bundle="km-supervise" key="kmSuperviseMain.fdBackType"/>
					      	</td>
				          	<td class="td2">
				          		<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" style="width:10%">
									<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
								</xform:select>
								<span class="lui_supervise_right lui_text_primary" onclick="previewBackDay()"><bean:message bundle="km-supervise" key="py.backDay.preview"/><i class="lui_arrow arrow_right"></i></span>
				          	</td>
						</tr>
						<tr>
							<td class="td_normal_title td1"><bean:message bundle="km-supervise" key="kmSuperviseMain.attSupervise"/></td>
				        	<td class="td2">
				          		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
					            	<c:param name="fdKey" value="attTask" />
					                <c:param name="formBeanName" value="kmSuperviseMainPlanForm" />
					                <c:param name="fdMulti" value="true" />
				            	</c:import>
				            </td>
				        </tr>
				    </table>
				</div>
			</div>
		</ui:content>
	</c:when>
	<c:when test="${param.contentType eq 'other'}">
		<c:if test="${param.approveModel ne 'right'}">
			<%--流程--%>
			<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainPlanForm" />
				<c:param name="fdKey" value="kmSuperviseMakePlan" />
				<c:param name="showHistoryOpers" value="true" />
				<c:param name="isExpand" value="true" />
			</c:import>
		</c:if>
	</c:when>
</c:choose>