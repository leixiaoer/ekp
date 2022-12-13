<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
Com_IncludeFile("docutil.js");
Com_IncludeFile("dialog.js|treeview.js");	
function confirmDelete(msg){
	var del = confirm("<bean:message key="kmCarmngApplication.delete.confirm" bundle="km-carmng" />");
	return del;
}

</script>
<html:form action="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do" target="_self">
	<div id="optBarDiv"><%--当流程状态等于已经发布，没调度过，才显示调度按钮 --%> 
		<c:if test="${kmCarmngApplicationForm.docStatus == '30' &&  kmCarmngApplicationForm.fdIsDispatcher==1}">
		<kmss:auth
			requestURL="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=add&fdId=${param.fdId}"
			requestMethod="GET">
			<input type="button"
				value="<bean:message  bundle="km-carmng" key="kmCarmng.button8"/>"
				onclick="Com_SubmitNoEnabled(document.kmCarmngDispatchersInfoForm, 'add');">
		</kmss:auth>
		<input type="hidden" name="method_GET" value="add" />
		<input type="hidden" name="List_Selected"
			value="${kmCarmngApplicationForm.fdId}" />
		</c:if>
		<c:if test="${kmCarmngApplicationForm.docStatus != '00' }">
		<kmss:auth
			requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=edit&fdId=${param.fdId}"
			requestMethod="GET">
			<input type="button" value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmCarmngApplication.do?method=edit&fdId=${param.fdId}','_self');">
		</kmss:auth>
		</c:if>
		<!-- 打印 --> 
		<kmss:auth requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=print&fdId=${param.fdId}" requestMethod="GET">
			<input type=button value="<bean:message bundle="km-carmng" key="button.print" />" onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do"/>?method=print&fdId=${param.fdId}');"/>
		</kmss:auth> 
		<kmss:auth
			requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=delete&fdId=${param.fdId}"
			requestMethod="GET">
			<input type="button" value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngApplication.do?method=delete&fdId=${param.fdId}','_self');">
		</kmss:auth>
		<input type="button" value="<bean:message key="button.close"/>"
			onclick="Com_CloseWindow();">
	</div>
	<p class="txttitle"><bean:message bundle="km-carmng"
		key="table.kmCarmngApplication" /></p>
	<center>
	<table id="Label_Tabel" width=95%>
		<html:hidden name="kmCarmngApplicationForm" property="fdId" />
		<tr
			LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.tree.application" />">
			<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.docSubject" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.docSubject}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdMotorcadeId" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdMotorcadeName}" />
						<input type="button" title="<bean:message  bundle="km-carmng" key="kmCarmng.tree.base.intro"/>" style= "background:url(userinfo_icon.gif);width: 20px" onclick="Com_OpenWindow('<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do" />?method=view&fdId=${kmCarmngApplicationForm.fdMotorcadeId}');"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
					</td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdApplicationPersonName}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng"
						key="kmCarmngApplication.fdApplicationPersonPhone" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdApplicationPersonPhone}" /></td>
				</tr>

				<tr>
                    <td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationDept" />
					</td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdApplicationDeptName}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdDestination" /></td>
					<td width=35% colspan="3"><c:out
						value="${kmCarmngApplicationForm.fdDestination}" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath" />
					</td>
					<td width=35% colspan="3"><c:out
						value="${kmCarmngApplicationForm.fdApplicationPath}" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdStartTime" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdStartTime}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdEndTime" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.fdEndTime}" /></td>
				</tr>


				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" /></td>
					<td width=35% colspan="3"><c:out
						value="${kmCarmngApplicationForm.fdUserPersonNames}" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdUserNumber" /></td>
					<td width=35% colspan="3"><c:out
						value="${kmCarmngApplicationForm.fdUserNumber}" /></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.fdApplicationReason" />
					</td>
					<td width=35% colspan="3"><kmss:showText
						value="${kmCarmngApplicationForm.fdApplicationReason}" /></td>
				</tr>

				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.docCreatorId" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.docCreatorName}" /></td>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-carmng" key="kmCarmngApplication.docCreateTime" /></td>
					<td width=35%><c:out
						value="${kmCarmngApplicationForm.docCreateTime}" /></td>
				</tr>
			</table>
			</td>
		</tr>
		<c:if
			test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm != null }">
			<tr
				LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngDispatchersInfo" />">
				<td>
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdCarInfoId" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdCarInfoNo}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngInsuranceInfo.fdVehicles.fdName" />
						</td>
						<td><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdCarInfoName}" />
						</td>

					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng"
							key="kmCarmngInsuranceInfo.fdVehicles.fdCategoryName" /></td>
						<td><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdCarInfoCategoryName}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngInfomation.fdSeatNumber" /></td>
						<td><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdCarInfoSeatNumber}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdApplicationIds" />
						</td>
						<td width=35% colspan="3"><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdApplicationNames}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngApplication.fdUserPersons" /></td>
						<td width=35% colspan="3"><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdUserName}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdStartTime" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdStartTime}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdEndTime" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdEndTime}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDriversName" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDriverName}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdDestination" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdDestination}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdTravelPath" />
						</td>
						<td width=35% colspan="3"><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdTravelPath}" />
						</td>
					</tr>

					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRelationPhone" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRelationPhone}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.fdRegisterId" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.fdRegisterName}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreator" /></td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreatorName}" />
						</td>
						<td class="td_normal_title" width=15%><bean:message
							bundle="km-carmng" key="kmCarmngDispatchersInfo.docCreateTime" />
						</td>
						<td width=35%><c:out
							value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.docCreateTime}" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<c:if
				test="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm != null && kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm !=null }">
				<tr
					LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngRegisterInfo" />">
					<td>
					<table class="tb_normal" width=95%>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdStartTime" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdStartTime}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdEndTime" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdEndTime}" />
							</td>
						</tr>
						<tr>
							<!--<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng"
								key="kmCarmngRegisterInfo.fdMileageBeforeNumber" /></td>
							<td width=35%><kmss:showNumber
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdMileageBeforeNumber}"
								pattern="#.##" /></td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng"
								key="kmCarmngRegisterInfo.fdMileageAfterNumber" /></td>
							<td width=35%><kmss:showNumber
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdMileageAfterNumber}"
								pattern="#.##" /></td>-->
							<td class="td_normal_title" width=15%>
			                <bean:message  bundle="km-carmng" key="kmCarmngUserFeeInfo.fdMileageNumber"/>
		                    </td><td width=35% colspan="3" >
		                    <c:out value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdMileageNumber}" />
		                    </td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdRealPath" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdRealPath}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdStopFee" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdStopFee}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdTurnpikeFee" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdTurnpikeFee}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdFuelFee" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdFuelFee}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdOtherFee" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdOtherFee}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdCarwashFee" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdCarwashFee}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdTotalFee" /></td>
							<td width=35% colspan="3"><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdTotalFee}" />
							</td>
						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdRemark" /></td>
							<td width=35% colspan="3"><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdRemark}" />
							</td>

						</tr>
						<tr>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterId" /></td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdRegisterName}" />
							</td>
							<td class="td_normal_title" width=15%><bean:message
								bundle="km-carmng" key="kmCarmngRegisterInfo.fdRegisterTime" />
							</td>
							<td width=35%><c:out
								value="${kmCarmngApplicationForm.kmCarmngDispatchersInfoForm.kmCarmngRegisterInfoForm.fdRegisterTime}" />
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</c:if>
		</c:if>
		<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmCarmngApplicationForm" />
			<c:param name="fdKey" value="kmCarmngMotorcadeSet" />
		</c:import>
		<!--<tr
			LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmCarmngApplicationForm" />
					<c:param name="moduleModelName"
						value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
				</c:import>
			</table>
			</td>
		</tr>-->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
		<table class="tb_normal" width=100%>
			<tr>
				<td width="14%" class="td_normal_title"><bean:message  bundle="km-carmng" key="kmCarmngApplication.authReaderId"/></td>
				<td width="86%" colspan="3"><c:out
					value="${kmCarmngApplicationForm.authReaderNames}" />
				</td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
	</center>
    </html:form>
<%@ include file="/resource/jsp/view_down.jsp"%>