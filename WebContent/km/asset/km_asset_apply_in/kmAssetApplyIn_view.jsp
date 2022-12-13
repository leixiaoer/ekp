<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	Com_IncludeFile("jquery.js");
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<c:if test="${kmAssetApplyInForm.docStatus=='10' || kmAssetApplyInForm.docStatus=='11'|| kmAssetApplyInForm.docStatus=='20'}">
	<kmss:auth requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmAssetApplyIn.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	</c:if>
	<kmss:auth requestURL="/km/asset/km_asset_apply_in/kmAssetApplyIn.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmAssetApplyIn.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${txttitle}</p>

<center>
<table id="Label_Tabel"  width=95%>
	<%-- 入库信息 --%>
	<tr LKS_LabelName="<bean:message bundle="km-asset" key="kmAssetApplyStock.page.tab1" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<%-- 标题 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td colspan="3">
						<xform:text property="docSubject" style="width:85%" />
					</td>
				</tr>
				
				<tr>
					<%--类别--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdApplyTemplateName}" />
					</td>
					<%--入库单编号--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td width=35%>
						<c:out value="${kmAssetApplyInForm.fdNo}" />
					</td>
				</tr>
							
				<tr>
					<%--拟单人--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td width="35%">
						<c:out value="${kmAssetApplyInForm.fdCreatorName}" />
					</td>
					<%--拟单时间--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td width="35%">
						<xform:datetime property="fdCreateDate"/>
					</td>
				</tr>
				
				<%-- 入库明细--%>	
				<%@include file="/km/asset/km_asset_apply_in_list/kmAssetApplyInList_view.jsp"%>
				
				<%-- 分隔符 --%>
				<tr><td colspan="4">&nbsp;</td></tr>		
				
				<tr>
					<%-- 附件 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyStock.attachment"/>
					</td>
					<td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
							<c:param name="fdKey" value="kmAssetApplyIn"/>
							<c:param name="formBeanName" value="kmAssetApplyInForm"/>
						</c:import>
					</td>
				</tr>
				
				<tr>
					<%--说明 --%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyBase.fdExplain"/>
					</td>
					<td colspan="3">
					    <kmss:showText value="${kmAssetApplyInForm.fdExplain}"></kmss:showText> 
					</td>
				</tr>		
				
						
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsCreateCard"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsCreateCard">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_create_card"/>
						</xform:radio>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyIn.fdIsUnpickByNums"/>
					</td>
					<td colspan="3">
						<xform:radio property="fdIsUnpickByNums">
							<xform:enumsDataSource enumsType="km_asset_apply_in_fd_is_unpick_by_nums"/>
						</xform:radio>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	
	
	<%--流程--%>
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyInForm" />
		<c:param name="fdKey" value="KmAssetApplyInDoc" />
		<c:param name="showHistoryOpers" value="true" />
	</c:import>
	
	<%-- 权限 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
		<td>
			<table class="tb_normal" width=100%>
				<c:import url="/sys/right/right_view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmAssetApplyInForm" />
					<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" />
				</c:import>
			</table>
		</td>
	</tr>
	
	<%--关联机制--%>
	<tr	LKS_LabelName="<bean:message bundle="sys-relation" key="sysRelationMain.tab.label" />">
		<c:set var="mainModelForm" value="${kmAssetApplyInForm}" scope="request"/>
		<c:set var="currModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyIn" scope="request"/>
		<td>
			<%@ include	file="/sys/relation/include/sysRelationMain_view.jsp"%>
		</td>
	</tr>
	
	<%--阅读机制--%>
	<c:import url="/sys/readlog/include/sysReadLog_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetApplyInForm" />
	</c:import>
	
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>