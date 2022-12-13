<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-oitems:kmOitemsBudgerApplication.baseInfo') }" titleicon="lui-fm-icon-2">
	<!-- 草稿状态的文档默认选中基本信息页签 -->
	<c:if test="${kmOitemsBudgerApplicationForm.docStatus=='10'}">
		<script>
			LUI.ready(function(){
				setTimeout(function(){
					$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
				},200);
			});
		</script>
	</c:if>
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<c:if test="${kmOitemsTempletForm.fdTempletType!='1'}">
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.fdApplicantsName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.docDeptName}" />
			</td>
		</tr>
		
		</c:if>
		
		<c:if test="${kmOitemsTempletForm.fdTempletType=='1'}">
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicants.deptId"/>
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.fdApplicantsName}" />
			</td>
		</tr>
		</c:if>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-oitems" key="table.kmOitemsTemplet"/>
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.fdTemplateName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docNumber" />
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.docNumber}" />
			</td>
		</tr>
		
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docCreatorId" />
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.docCreatorName}" />
			</td>
		</tr>
		
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docCreateTime" />
			</td>
			<td>
				<c:out value="${kmOitemsBudgerApplicationForm.docCreateTime}" />
			</td>
		</tr>
		
	</table>
</ui:content>