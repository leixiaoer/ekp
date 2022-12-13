<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
function confirm_invalidated(){
	var msg = confirm("<bean:message bundle="sys-organization" key="organization.invalidated.comfirm"/>");
	return msg;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/sys/organization/sys_org_org/sysOrgOrg.do?method=edit&fdId=${sysOrgOrgForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>" onClick="Com_OpenWindow('sysOrgOrg.do?method=edit&fdId=<bean:write name="sysOrgOrgForm" property="fdId" />','_self');">
	</kmss:auth>
	<c:if test="${sysOrgOrgForm.fdIsAvailable}">
	<kmss:auth requestURL="/sys/organization/sys_org_org/sysOrgOrg.do?method=invalidated&fdId=${sysOrgOrgForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="sys-organization" key="organization.invalidated" />" onClick="if(!confirm_invalidated())return;Com_OpenWindow('sysOrgOrg.do?method=invalidated&fdId=<bean:write name="sysOrgOrgForm" property="fdId" />','_self');">
	</kmss:auth>
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onClick="Com_CloseWindow();">
</div>
<div class="txttitle"><bean:message bundle="sys-organization" key="sysOrgElement.org"/></div>
<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.baseInfo"/>">
		<td>
			<table class="tb_normal" width=95%>
				<tr>
				    <!-- 机构名称  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdName"/></td>
					<td width=35% colspan="3"><pre><bean:write name="sysOrgOrgForm" property="fdName"/></pre></td>
				</tr>
				<tr>
				    <!-- 上级机构  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdParent"/></td>
					<td width=35%>
						<pre><%=com.landray.kmss.sys.organization.util.SysOrgUtil.getFdParentsNameByForm((com.landray.kmss.sys.organization.forms.SysOrgOrgForm)request.getAttribute("sysOrgOrgForm"))%></pre>
					</td>
					<!-- 编号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdNo"/></td>
					<td width=35%><bean:write name="sysOrgOrgForm" property="fdNo"/></td>
				</tr>
				<tr>
				    <!-- 机构领导  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdThisLeader"/></td>
					<td width=35%><pre><bean:write name="sysOrgOrgForm" property="fdThisLeaderName"/></pre></td>
					<!-- 上级领导  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdSuperLeader"/></td>
					<td width=35%><pre><bean:write name="sysOrgOrgForm" property="fdSuperLeaderName"/></pre></td>
				</tr>
				<tr>
				    <!-- 关键字  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdKeyword"/></td>
					<td width=35%><pre><bean:write name="sysOrgOrgForm" property="fdKeyword"/></pre></td>
					<!-- 排序号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdOrder"/></td>
					<td width=35%><bean:write name="sysOrgOrgForm" property="fdOrder"/></td>
				</tr>
				<tr>
				    <!-- 邮件地址  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgElement.fdOrgEmail"/></td>
					<td width=35% colspan="3"><pre><bean:write name="sysOrgOrgForm" property="fdOrgEmail"/></pre></td>
				</tr>
				<tr>
				    <!-- 是否业务相关  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdIsBusiness"/></td>
					<td width=35%><sunbor:enumsShow value="${sysOrgOrgForm.fdIsBusiness}" enumsType="common_yesno" /></td>
					<!-- 是否有效  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdIsAvailable"/></td>
					<td width=35%><sunbor:enumsShow value="${sysOrgOrgForm.fdIsAvailable}" enumsType="sys_org_available_result" /></td>
				</tr>
				<tr>
				    <!-- 管理员  -->
					<td class="td_normal_title" width=15%><bean:message bundle="sys-organization" key="sysOrgElement.authElementAdmins"/></td>
					<td width="85%" colspan="3">
						<pre><xform:address propertyId="authElementAdminIds" propertyName="authElementAdminNames" mulSelect="true" orgType="ORG_TYPE_POSTORPERSON" style="width:85%" /></pre>
					</td>
				</tr>		
				<tr>
				    <!-- 备注  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgOrg.fdMemo"/></td>
					<td colspan="3"><pre><kmss:showText value="${sysOrgOrgForm.fdMemo}"/></pre></td>
				</tr>
				<%-- 引入动态属性 --%>
				<c:import url="/sys/property/custom_field/custom_fieldView.jsp" charEncoding="UTF-8" />					
			</table>
		</td>
	</tr>
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.logInfo"/>">
		<td>
			<iframe name="IFRAME" src='<c:url value="/sys/organization/sys_log_organization/index.jsp?fdId=${sysOrgOrgForm.fdId}" />' frameBorder=0 width="100%"> </iframe>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>