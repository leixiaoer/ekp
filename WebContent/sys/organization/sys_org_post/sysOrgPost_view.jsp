<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
function confirm_invalidated(){
	var msg = confirm("<bean:message bundle="sys-organization" key="organization.invalidated.comfirm"/>");
	return msg;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/sys/organization/sys_org_post/sysOrgPost.do?method=edit&fdId=${sysOrgPostForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message key="button.edit"/>" onClick="Com_OpenWindow('sysOrgPost.do?method=edit&fdId=${sysOrgPostForm.fdId}','_self');">
	</kmss:auth>
	<c:if test="${sysOrgPostForm.fdIsAvailable}">
	<kmss:auth requestURL="/sys/organization/sys_org_post/sysOrgPost.do?method=invalidated&fdId=${sysOrgPostForm.fdId}" requestMethod="GET">
		<input type="button" value="<bean:message bundle="sys-organization" key="organization.invalidated" />" onClick="if(!confirm_invalidated())return;Com_OpenWindow('sysOrgPost.do?method=invalidated&fdId=${sysOrgPostForm.fdId}','_self');">
	</kmss:auth>
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onClick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message bundle="sys-organization" key="sysOrgElement.post"/></p>
<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.baseInfo"/>">
		<td>
			<table class="tb_normal" width=95%>
				<tr>
				    <!-- 岗位名称  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdName"/></td>
					<td width=35%><pre><bean:write name="sysOrgPostForm" property="fdName"/></pre></td>
					<!-- 编号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdNo"/></td>
					<td width=35%><bean:write name="sysOrgPostForm" property="fdNo"/></td>
				</tr>
				<tr>
				    <!-- 所在部门  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdParent"/></td>
					<td width=35%>
						<pre><%=com.landray.kmss.sys.organization.util.SysOrgUtil.getFdParentsNameByForm((com.landray.kmss.sys.organization.forms.SysOrgPostForm)request.getAttribute("sysOrgPostForm"))%></pre>
					</td>
					<!-- 岗位领导  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdThisLeader"/></td>
					<td width=35%><pre><bean:write name="sysOrgPostForm" property="fdThisLeaderName"/></pre></td>
				</tr>
				<tr>
				    <!-- 关键字  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdKeyword"/></td>
					<td width=35%><pre><bean:write name="sysOrgPostForm" property="fdKeyword"/></pre></td>
					<!-- 排序号  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdOrder"/></td>
					<td width=35%><bean:write name="sysOrgPostForm" property="fdOrder"/></td>
				</tr>
				<tr>
				    <!-- 是否业务相关  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdIsBusiness"/></td>
					<td><sunbor:enumsShow value="${sysOrgPostForm.fdIsBusiness}" enumsType="common_yesno" /></td>
					<!-- 是否有效  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdIsAvailable"/></td>
					<td><sunbor:enumsShow value="${sysOrgPostForm.fdIsAvailable}" enumsType="sys_org_available_result" /></td>
				</tr>
				<tr>
				    <!-- 人员列表  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdPersons"/></td>
					<td colspan=3><pre><bean:write name="sysOrgPostForm" property="fdPersonNames"/></pre></td>
				</tr>
				<tr>
				    <!-- 备注  -->
					<td width=15% class="td_normal_title"><bean:message bundle="sys-organization" key="sysOrgPost.fdMemo"/></td>
					<td colspan="3"><pre><kmss:showText value="${sysOrgPostForm.fdMemo}"/></pre></td>
				</tr>
				<%-- 引入动态属性 --%>
				<c:import url="/sys/property/custom_field/custom_fieldView.jsp" charEncoding="UTF-8" />	
			</table>
		</td>
	</tr>
	<tr LKS_LabelName="<bean:message bundle="sys-organization" key="sysOrgElement.logInfo"/>">
		<td>
			<iframe name="IFRAME" src='<c:url value="/sys/organization/sys_log_organization/index.jsp?fdId=${sysOrgPostForm.fdId}" />' frameBorder=0 width="100%"></iframe>
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>