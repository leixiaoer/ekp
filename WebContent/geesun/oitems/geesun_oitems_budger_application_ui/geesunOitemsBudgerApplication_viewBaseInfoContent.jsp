<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('geesun-oitems:geesunOitemsBudgerApplication.baseInfo') }" titleicon="lui-fm-icon-2">
	<!-- 草稿状态的文档默认选中基本信息页签 -->
	<c:if test="${geesunOitemsBudgerApplicationForm.docStatus=='10'}">
		<script>
			LUI.ready(function(){
				setTimeout(function(){
					$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
				},200);
			});
		</script>
	</c:if>
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.fdApplicantsName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.docDeptName}" />
			</td>
		</tr>
		
		</c:if>
		
		<c:if test="${geesunOitemsTempletForm.fdTempletType=='1'}">
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicants.deptId"/>
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.fdApplicantsName}" />
			</td>
		</tr>
		</c:if>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docNumber" />
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.docNumber}" />
			</td>
		</tr>
		
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreatorId" />
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.docCreatorName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreateTime" />
			</td>
			<td>
				<c:out value="${geesunOitemsBudgerApplicationForm.docCreateTime}" />
			</td>
		</tr>
		
	</table>
</ui:content>
