<%@ page
	language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script src="./resource/weui_switch.js"></script>
<script language="JavaScript">
	Com_IncludeFile("dialog.js");
</script>

<html:form action="/km/pindagate/km_pindagate_template/kmPindagateTemplate.do"
	onsubmit="return validateKmPindagateTemplateForm(this);">
	<div id="optBarDiv">
	<c:if
		test="${kmPindagateTemplateForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmPindagateTemplateForm, 'update');">
	</c:if> 
	<c:if test="${kmPindagateTemplateForm.method_GET=='add' || kmPindagateTemplateForm.method_GET=='clone'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmPindagateTemplateForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmPindagateTemplateForm, 'saveadd');">
	</c:if> <input type="button" value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();"></div>

	<p class="txttitle"><bean:message bundle="km-pindagate"
		key="table.kmPindagateTemplate" /></p>

	<center>
	<table id="Label_Tabel" width=95%>
		<tr
			LKS_LabelName="<bean:message bundle='km-pindagate' key='kmPindagateTemplateLableName.templateInfo'/>">
			<td>
			<table class="tb_normal" width=100%>
				<html:hidden property="fdId" />
				<!-- 模板名称 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.fdName" /></td>
					<td width=85% colspan="3">
					<%-- 
					<html:text property="fdName" style="width:80%;" />
					<span class="txtstrong">*</span></td>
					--%>
					<xform:text property="fdName" style="width:80%;" required="true"></xform:text>
				</tr>
				<!-- 适用类别 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.fdCatoryName" /></td>
					<td width=85% colspan="3"><html:hidden property="fdCategoryId" /> <html:text
						property="fdCategoryName" readonly="true" styleClass="inputsgl"
						style="width:80%;" /> <span class="txtstrong">*</span>&nbsp;&nbsp;&nbsp;<a
						href="#"
						onclick="Dialog_Category('com.landray.kmss.km.pindagate.model.KmPindagateTemplate','fdCategoryId','fdCategoryName');"><bean:message
						key="dialog.selectOther" /></a>
						<c:if test="${not empty noAccessCategory}">
							<script language="JavaScript">
								function closeWindows(rtnVal){
									if(rtnVal==null){
										window.close();
									}
								}
								if(!confirm("<bean:message arg0="${noAccessCategory}" key="error.noAccessCreateTemplate.alert" />")){
									window.close();
								}else{
									Dialog_Category('com.landray.kmss.km.pindagate.model.KmPindagateTemplate','fdCategoryId','fdCategoryName',null,null,null,null,closeWindows, true);
								}
							</script>
						</c:if>						
					</td>
				</tr>
				
				<%---辅类别modify by zhouchao--%>
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="table.sysCategoryProperty" /></td>
					<td width=85% colspan="3"><html:hidden property="docPropertyIds" /> 						
						  <html:text
							property="docPropertyNames"
							readonly="true"
							styleClass="inputsgl"
							style="width:70%" /> <a
							href="#"
							onclick="Dialog_property(true, 'docPropertyIds','docPropertyNames', ';',ORG_TYPE_PERSON);"> 
							<bean:message key="dialog.selectOther" /> </a></td> 
				</tr>
				<!-- 排序号 -->				
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.fdOrder" /></td>
					<td width=35% ><html:text property="fdOrder" style="width:80%;" /></td>
					<td class="td_normal_title" width=15%>
							<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable" />
						</td>
					<td width=35%>
						<html:hidden property="fdIsAvailable" /> 
						<label class="weui_switch">
							<span class="weui_switch_bd">
								<input type="checkbox" ${'true' eq kmPindagateTemplateForm.fdIsAvailable ? 'checked' : '' } />
								<span></span>
								<small></small>
							</span>
							<span id="fdIsAvailableText"></span>
						</label>
						<script type="text/javascript">
							function setText(status) {
								if(status) {
									$("#fdIsAvailableText").text('<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.true" />');
								} else {
									$("#fdIsAvailableText").text('<bean:message bundle="km-pindagate" key="kmPindagateTemplate.fdIsAvailable.false" />');
								}
							}
							$(".weui_switch :checkbox").on("click", function() {
								var status = $(this).is(':checked');
								$("input[name=fdIsAvailable]").val(status);
								setText(status);
							});
							setText(${kmPindagateTemplateForm.fdIsAvailable});
						</script>
					</td>
				</tr>
				<%-- 所属场所 --%>
				<c:import url="/sys/authorization/sys_auth_area/sysAuthArea_field.jsp" charEncoding="UTF-8">
                     <c:param name="id" value="${kmPindagateTemplateForm.authAreaId}"/>
                </c:import> 
				<!-- 可使用者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="table.kmPindagateTemplateUser" /></td>
					<td  width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authReaderIds" propertyName="authReaderNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmPindagateTemplate.tepmlateUser" bundle="km-pindagate"/>
				   </td>
				</tr>
				<!-- 可维护者 -->
				<tr>
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="table.kmPindagateTemplateEditor" /></td>
					<td width=85% colspan="3">
						<xform:address textarea="true" mulSelect="true" propertyId="authEditorIds" propertyName="authEditorNames" orgType="ORG_TYPE_ALL" style="width:80%" ></xform:address><br>
						<bean:message key="kmPindagateTemplate.tepmlateManager" bundle="km-pindagate"/>
					</td>
				</tr>
				<%---新建时，不显示 创建人，创建时间 modify by zhouchao---%>
               <c:if
		         test="${kmReviewTemplateForm.method_GET=='edit'}">
				<tr>
					<!-- 创建人员 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.docCreatorId" /></td>
					
					<td width=35%><html:text property="docCreatorName"
						readonly="true" style="width:50%;" /></td>
					<!-- 创建时间 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-pindagate" key="kmPindagateTemplate.docCreateTime" /></td>
					<td width=35%><html:text property="docCreateTime"
						readonly="true" style="width:50%;" /></td>
				</tr>
				
				</c:if>
			</table>
			</td>
		</tr>
		
		<!-- 流程 -->
		<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmPindagateTemplateForm" />
			<c:param name="fdKey" value="pindagateMain" />
		</c:import>

		<!-- 文档关联 -->
		<tr
			LKS_LabelName="<bean:message bundle='km-pindagate' key='kmPindagateTemplateLableName.relationInfo'/>">
			<c:set var="mainModelForm" value="${kmPindagateTemplateForm}"
				scope="request" />
			<c:set
				var="currModelName"
				value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate"
				scope="request" />
			<td><%@ include
				file="/sys/relation/include/sysRelationMain_edit.jsp"%></td>
		</tr>
		<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
					<c:import url="/sys/right/tmp_right_edit.jsp" charEncoding="UTF-8">
						<c:param
							name="formName"
							value="kmPindagateTemplateForm" />
						<c:param
							name="moduleModelName"
							value="com.landray.kmss.km.pindagate.model.KmPindagateTemplate" />
					</c:import>
				</table>
			</td>
		</tr>
	</table>
	</center>
	<html:hidden property="method_GET" />
</html:form>
<script language="JavaScript">Com_IncludeFile("calendar.js");</script>
<html:javascript formName="kmPindagateTemplateForm" cdata="false"
	dynamicJavascript="true" staticJavascript="false" />
<%@ include file="/resource/jsp/edit_down.jsp"%>

