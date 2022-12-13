<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-review:kmReviewDocumentLableName.baseInfo') }" titleicon="lui-fm-icon-2">
	<!-- 草稿状态的文档默认选中基本信息页签 -->
	<c:if test="${kmPindagateMainForm.docStatus=='10'}">
		<script>
			LUI.ready(function(){
				setTimeout(function(){
					$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
				},200);
			});
		</script>
	</c:if>
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!--申请人-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.creatorName" />
			</td>
			<td>
				<xform:text property="docCreatorId" showStatus="noShow"/> 
				<c:out value="${ kmPindagateMainForm.docCreatorName}"></c:out>
			</td>
		</tr>
		<!--所属部门-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.dept" />
			</td>
			<td>
				<c:out value="${ kmPindagateMainForm.docDeptName}"></c:out>
			</td>
		</tr>
		<!--申请时间-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.creatorDate" />
			</td>
			<td>
				<c:out value="${ kmPindagateMainForm.docCreateTime}"></c:out>
			</td>
		</tr>
		<!--问卷主题-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.docSubject" />
			</td>
			<td>
				<c:out value="${ kmPindagateMainForm.docSubject}"></c:out>
			</td>
		</tr>
		
		<!-- 调查开始/结束时间 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.docTime" />
			</td>
			<td>
				<c:out value="${ kmPindagateMainForm.docStartTime}"></c:out>-
				<c:out value="${ kmPindagateMainForm.docFinishedTime}"></c:out>
				
			</td>
		</tr>
		<!--调查参与人员-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-pindagate" key="kmPindagateMain.participantNames" />
			</td>
			<td>
				<c:out value="${ kmPindagateMainForm.indagateParticipantNames}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>