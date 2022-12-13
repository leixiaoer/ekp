<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/km/carmng/km_carmng_motorcade_set/kmCarmng_view_top.jsp"%>
<kmss:windowTitle 
   subject="${kmCarmngMotorcadeSetForm.fdName}-${ lfn:message('km-carmng:module.km.carmng') } " /> 
<script>
	function confirmDelete(msg){
		var del = confirm('<bean:message key="page.comfirmDelete"/>');
		return del;
	}
</script>
	<div id="optBarDiv">
			<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			   <input type="button" value="${lfn:message('button.edit') }"  onclick="Com_OpenWindow('kmCarmngMotorcadeSet.do?method=edit&fdId=${param.fdId}','_self');" />
			</kmss:auth>
			<kmss:auth requestURL="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				 <input type="button" value="${lfn:message('button.delete') }" onclick="if(!confirmDelete())return;Com_OpenWindow('kmCarmngMotorcadeSet.do?method=delete&fdId=${param.fdId}','_self');" />
			</kmss:auth>
			<input type="button" value="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
	</div>

<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngMotorcadeSet"/></p>

<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.base.info" />">
		<td>
		<table class="tb_normal" width="100%">
			<html:hidden name="kmCarmngMotorcadeSetForm" property="fdId"/>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.fdName"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.fdName}" />
				</td>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.fdOrder"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.fdOrder}" />
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.fdDispatchersId"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.fdDispatchersName}" />
				</td>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.fdRegisterId"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.fdRegisterName}" />
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.isEffective"/>
				</td><td colspan="3">
					<xform:radio property="isEffective">
						<xform:enumsDataSource enumsType="common_yesno" />
					</xform:radio>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.fdRemark"/>
				</td><td width=35% colspan="3">
					<kmss:showText value="${kmCarmngMotorcadeSetForm.fdRemark}" />
				</td>
			</tr>
				<%-- 可维护者 --%>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message key="model.tempEditorName" />
				</td>
				<td width=35% colspan="3">
					<c:out value="${kmCarmngMotorcadeSetForm.authEditorNames}" />
				</td>
			</tr>
				
			<tr>
				<!-- 可使用者 -->
				<td class="td_normal_title" width=15%>
					<bean:message key="model.tempReaderName"/>
				</td>
				<td width="85%" colspan="3">
					<c:out value="${kmCarmngMotorcadeSetForm.authReaderNames}" />
				</td>
			</tr>
				
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.docCreatorId"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.docCreatorName}" />
				</td>
				<td class="td_normal_title" width=15%>
					<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.docCreateTime"/>
				</td><td width=35%>
					<c:out value="${kmCarmngMotorcadeSetForm.docCreateTime}" />
				</td>
			</tr>
		</table>
	</td>
</tr>
<%--流程机制 --%>
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmCarmngMotorcadeSetForm" />
		<c:param name="fdKey" value="kmCarmngMotorcadeSet" />
		<c:param name="messageKey" value="km-carmng:kmCarmng.tree.application.sys.workflow"/>
	</c:import>
	<%--编号机制 --%>
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmCarmngMotorcadeSetForm" />
		<c:param name="modelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication"/>
	</c:import>
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.tree.base.set2" />">
		<td>
			<table class="tb_normal" width=100%>
				<iframe frameborder="0" style="width:100%;height:900px" src="<c:url value="/km/carmng/km_carmng_drivers_info/index2.jsp?motorcadeId=${kmCarmngMotorcadeSetForm.fdId}"/>"></iframe>
			</table>
		</td>
	</tr>
	<tr  LKS_LabelName="<bean:message bundle="km-carmng" key="table.kmCarmngInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
				<iframe frameborder="0" style="width:100%;height:900px" src="<c:url value="/km/carmng/km_carmng_info_ui/index2.jsp?motorcadeId=${kmCarmngMotorcadeSetForm.fdId}"/>"></iframe>
			</table>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>