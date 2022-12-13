<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<c:choose>
	<c:when test="${param.contentType eq 'xform'}">
		<ui:content title="任务指派" expand="true">
			<div class="lui_supervise_plan_wrap">
				<div class="lui_supervise_plan_title">
			        <div class="lui_supervise_plan_right">
			            <!-- 按钮组 -->
				        <div class="lui_supervise_plan_btnGroup">
				        	<span>
					            <bean:message bundle="km-supervise" key="py.An" />
								<xform:select property="fdStageType" showPleaseSelect="false" showStatus="edit" onValueChange="stageChange" style="width:15%!important">
									<xform:enumsDataSource enumsType="km_supervise_task_stage"></xform:enumsDataSource>
								</xform:select>
								<bean:message bundle="km-supervise" key="py.ZiDongShengChengJieDuan"/>
				        	</span>
				            <span class="lui_supervise_link lui_text_primary" onclick="addRow()"><i
				                    class="lui_icon_s icon_add"></i><span><bean:message bundle="km-supervise" key="py.TianJiaJieDuan" /></span></span>
				            <span class="lui_supervise_link lui_text_primary" onclick="importExcel()"><i
				                    class="lui_icon_s icon_import"></i><span><bean:message bundle="km-supervise" key="py.PiLiangDaoRu" /></span></span>
				            <span class="lui_supervise_link lui_text_primary" onclick="downloadTemlate()"><i
				                    class="lui_icon_s icon_download"></i><span><bean:message bundle="km-supervise" key="py.MoBanXiaZai" /></span></span>
				        </div>
			    	</div>
				</div>
			    <div class="lui_supervise_plan_table">
			    	<p class="txttitle">
						<bean:write name="kmSuperviseMainPlanForm" property="docSubject" />
					</p>
			    	<table class="tb_normal" width=100% id="TABLE_DocList" tbdraggable="true">
			    		<tr>
			    			<td class="td_normal_title" style="width: 10%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 18%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 15%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 13%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 10%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 13%">
			    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
			    			</td>
			    			<td class="td_normal_title" style="width: 6%">
			    				<bean:message key="list.operation"/>
			    			</td>
			            </tr>
			                    <!-- 基准行 -->
						<tr KMSS_IsReferRow="1" style="display: none" class="task_add_class">
							<td >
								<html:hidden property="fdTaskItems[!{index}].fdId" value=""/>
								<html:hidden property="fdTaskItems[!{index}].fdOrder" value="!{index}"/>
								<xform:text property="fdTaskItems[!{index}].docSubject" style="width:80%" required="true"/>
							</td>
							<td>
								<xform:textarea property="fdTaskItems[!{index}].docContent" style="width:85%" htmlElementProperties="data-actor-expand='true'" required="true"/>
							</td>
							<td>
								<xform:datetime property="fdTaskItems[!{index}].fdPlanStartTime" style="width:93%;" dateTimeType="datetime" required="true" validators="validateTime"/>
							</td>
							<td>
								<xform:datetime property="fdTaskItems[!{index}].fdPlanEndTime"  style="width:93%;" dateTimeType="datetime" required="true" validators="validateTime"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
										<xform:dialog propertyId="fdTaskItems[!{index}].fdSysUnitId"
								              propertyName="fdTaskItems[!{index}].fdSysUnitName"
									          style="width:95%;" 
									          className="inputsgl"
									          useNewStyle="true"
									          required="true">
										      Dialog_UnitTreeList(false, 'fdTaskItems[!{index}].fdSysUnitId', 'fdTaskItems[!{index}].fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
										      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />','kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
										</xform:dialog>
									</c:when>
									<c:otherwise>
										<xform:address propertyId="fdTaskItems[!{index}].fdUnitId" propertyName="fdTaskItems[!{index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" required="true"/>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<xform:address propertyId="fdTaskItems[!{index}].fdSponsorId" propertyName="fdTaskItems[!{index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" required="true"/>
							</td>
							<td>
								<c:choose>
									<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
										<xform:dialog propertyId="fdTaskItems[!{index}].fdOtherUnitIds"
								              propertyName="fdTaskItems[!{index}].fdOtherUnitNames"
									          style="width:95%;" 
									          className="inputsgl"
									          useNewStyle="true">
										      Dialog_UnitTreeList(true, 'fdTaskItems[!{index}].fdOtherUnitIds', 'fdTaskItems[!{index}].fdOtherUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
										      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
										</xform:dialog>
									</c:when>
									<c:otherwise>
										<xform:address propertyId="fdTaskItems[!{index}].fdOUnitIds" propertyName="fdTaskItems[!{index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mulSelect="true"/>
									</c:otherwise>
								</c:choose>
							</td>
							<!-- 删除、上移、下移按钮 -->
							<td align="center">
								<a href="#" onclick="DocList_DeleteRow();"><img
									src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
							</td>
						</tr>
						<c:forEach items="${kmSuperviseMainPlanForm.fdTaskItems}"  var="fdItem" varStatus="vstatus">
							<tr KMSS_IsContentRow="1" class="task_add_class">
								<td >
									<html:hidden property="fdTaskItems[${vstatus.index}].fdId" value=""/>
									<html:hidden property="fdTaskItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
									<xform:text property="fdTaskItems[${vstatus.index}].docSubject" style="width:95%"/>
								</td>
								<td>
									<xform:textarea property="fdTaskItems[${vstatus.index}].docContent" style="width:90%" htmlElementProperties="data-actor-expand='true'" required="true"/>
								</td>
								<td>
									<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanStartTime" style="width:93%;" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" dateTimeType="datetime"  required="true" validators="validateTime"/>
								</td>
								<td>
									<xform:datetime property="fdTaskItems[${vstatus.index}].fdPlanEndTime"  style="width:93%;" subject="${ lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" dateTimeType="datetime" required="true" validators="validateTime"/>
								</td>
								<td>
									<c:choose>
										<c:when test="${kmSuperviseMainPlanForm.fdSysUnitEnable eq 'true' }">
											<xform:dialog propertyId="fdTaskItems[${vstatus.index}].fdSysUnitId"
									              propertyName="fdTaskItems[${vstatus.index}].fdSysUnitName"
										          style="width:95%;" 
										          className="inputsgl"
										          mulSelect="false"
										          useNewStyle="true">
											      Dialog_UnitTreeList(false, 'fdTaskItems[${vstatus.index}].fdSysUnitId', 'fdTaskItems[${vstatus.index}].fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
											      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
											</xform:dialog>
											<script>
												initNewDialog("fdTaskItems[${vstatus.index}].fdSysUnitId","fdTaskItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"","",null);
												resetNewDialog("fdTaskItems[${vstatus.index}].fdSysUnitId","fdTaskItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"${fdItem.fdSysUnitId}","${fdItem.fdSysUnitName}",null);
											</script>
										</c:when>
										<c:otherwise>
											<xform:address propertyId="fdTaskItems[${vstatus.index}].fdUnitId" propertyName="fdTaskItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<xform:address propertyId="fdTaskItems[${vstatus.index}].fdSponsorId" propertyName="fdTaskItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:95%;"/>
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
											<script>
												initNewDialog("fdTaskItems[${vstatus.index}].fdOtherUnitIds","fdTaskItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",null);
												resetNewDialog("fdTaskItems[${vstatus.index}].fdOtherUnitIds","fdTaskItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"${fdItem.fdOtherUnitIds}","${fdItem.fdOtherUnitNames}",null);
											</script>
										</c:when>
										<c:otherwise>
											<xform:address propertyId="fdTaskItems[${vstatus.index}].fdOUnitIds" propertyName="fdTaskItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mulSelect="true"/>
										</c:otherwise>
									</c:choose>
								</td>
								<!-- 删除、上移、下移按钮 -->
								<td align="center">
									<a href="#" onclick="DocList_DeleteRow();"><img
										src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			    <div class="lui_supervise_plan_other">
					<table class="tb_simple">
			    		<tr>
					    	<td class="td1">
					      		<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>：
					      	</td>
				          	<td class="td2">
				          		<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" style="width:10%">
									<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
								</xform:select>
								<span class="lui_supervise_right lui_text_primary" onclick="previewBackDay()">反馈日预览<i class="lui_arrow arrow_right"></i></span>
				          	</td>
						</tr>
						<tr>
							<td class="td1"><bean:message bundle="km-supervise" key="kmSuperviseMain.attSupervise"/>：</td>
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
