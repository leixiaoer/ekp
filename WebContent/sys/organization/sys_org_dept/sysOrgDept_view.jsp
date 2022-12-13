<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirm_invalidated(){
	var msg = confirm("<bean:message bundle="sys-organization" key="organization.invalidated.comfirm"/>");
	return msg;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/sys/organization/sys_org_dept/sysOrgDept.do?method=edit&fdId=${sysOrgDeptForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>" onClick="Com_OpenWindow('sysOrgDept.do?method=edit&fdId=<bean:write name="sysOrgDeptForm" property="fdId" />','_self');">
	</kmss:auth>
	<c:if test="${sysOrgDeptForm.fdIsAvailable}">
	<kmss:auth requestURL="/sys/organization/sys_org_dept/sysOrgDept.do?method=invalidated&fdId=${sysOrgDeptForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="sys-organization" key="organization.invalidated" />" onClick="if(!confirm_invalidated())return;Com_OpenWindow('sysOrgDept.do?method=invalidated&fdId=<bean:write name="sysOrgDeptForm" property="fdId" />','_self');">
	</kmss:auth>
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onClick="Com_CloseWindow();">
</div>
<div class="txttitle"><bean:message bundle="sys-organization" key="sysOrgElement.dept"/></div>
<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.baseInfo"/>">
		<td>
			<table class="tb_normal" width=95%>
				<tr>
				    <!-- 部门名称  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdName"/></td>
					<td width=35% colspan="3"><pre><xform:text property="fdName"></xform:text></pre></td>
				</tr>
				<tr>
				    <!-- 上级部门  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdParent"/></td>
					<td width=35%>
						<pre><%=com.landray.kmss.sys.organization.util.SysOrgUtil.getFdParentsNameByForm((com.landray.kmss.sys.organization.forms.SysOrgDeptForm)request.getAttribute("sysOrgDeptForm"))%></pre>
					</td>
					<!-- 编号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdNo"/></td>
					<td width=35%><bean:write name="sysOrgDeptForm" property="fdNo"/></td>
				</tr>
				<tr>
				    <!-- 部门领导  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdThisLeader"/></td>
					<td width=35%><pre><bean:write name="sysOrgDeptForm" property="fdThisLeaderName"/></pre></td>
					<!-- 上级领导  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdSuperLeader"/></td>
					<td width=35%><pre><bean:write name="sysOrgDeptForm" property="fdSuperLeaderName"/></pre></td>
				</tr>
				<tr>
				    <!-- 关键字  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdKeyword"/></td>
					<td width=35%><pre><bean:write name="sysOrgDeptForm" property="fdKeyword"/></pre></td>
					<!-- 排序号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdOrder"/></td>
					<td width=35%><bean:write name="sysOrgDeptForm" property="fdOrder"/></td>
				</tr>
				<tr>
				    <!-- 邮件地址  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgElement.fdOrgEmail"/></td>
					<td width=35% colspan="3"><pre><bean:write name="sysOrgDeptForm" property="fdOrgEmail"/></pre></td>
				</tr>
				<tr>
				    <!-- 是否业务相关  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdIsBusiness"/></td>
					<td width=35%><sunbor:enumsShow value="${sysOrgDeptForm.fdIsBusiness}" enumsType="common_yesno" /></td>
					<!-- 是否有效  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdIsAvailable"/></td>
					<td width=35%><sunbor:enumsShow value="${sysOrgDeptForm.fdIsAvailable}" enumsType="sys_org_available_result" /></td>
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
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgDept.fdMemo"/></td>
					<td colspan="3"><pre><kmss:showText value="${sysOrgDeptForm.fdMemo}"/></pre></td>
				</tr>
				<%-- 引入动态属性 --%>
				<c:import url="/sys/property/custom_field/custom_fieldView.jsp" charEncoding="UTF-8" />	
			</table>
		</td>
	</tr>
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.logInfo"/>">
		<td>
			<iframe name="IFRAME" src='<c:url value="/sys/organization/sys_log_organization/index.jsp?fdId=${sysOrgDeptForm.fdId}" />' frameBorder=0 width="100%"> </iframe>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>