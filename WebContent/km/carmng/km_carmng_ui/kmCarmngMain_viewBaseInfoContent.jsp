<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${lfn:message('km-review:kmReviewDocumentLableName.baseInfo') }" titleicon="lui-fm-icon-2">
	<!-- 草稿状态的文档默认选中基本信息页签 -->
	<c:if test="${kmCarmngApplicationForm.docStatus=='10'}">
		<script>
			LUI.ready(function(){
				setTimeout(function(){
					$("i.lui-fm-icon-2").closest(".lui_tabpanel_vertical_icon_navs_item_l").click();
				},200);
			});
		</script>
	</c:if>
	<table class="tb_normal lui-fm-noneBorderTable" width=100%>
		<!--联系人-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson" />
			</td>
			<td>
				<c:out value="${ kmCarmngApplicationForm.fdApplicationPersonName}"></c:out>
			</td>
		</tr>
		<!--用车部门-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngUserFeeInfo.fdDeptIds" />
			</td>
			<td>
				<c:out value="${ kmCarmngApplicationForm.fdApplicationDeptName}"></c:out>
			</td>
		</tr>
		<!--申请编号-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngApplication.fdNo" />
			</td>
			<td>
				<c:out value="${ kmCarmngApplicationForm.fdNo}"></c:out>
			</td>
		</tr>
		<!--用车状态-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngApplication.docStatus" />
			</td>
			<td>
				<c:if test="${kmCarmngApplicationForm.docStatus < 30 }">	
					<sunbor:enumsShow value="${kmCarmngApplicationForm.docStatus}" enumsType="common_status"/>
				</c:if>	
				<%--通过--%>
				<c:if test="${kmCarmngApplicationForm.docStatus == 30 && kmCarmngApplicationForm.fdIsDispatcher != 2  && kmCarmngApplicationForm.fdIsDispatcher != 3}">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish"/>
				</c:if>
				<%--发车--%>
				<c:if test="${kmCarmngApplicationForm.fdIsDispatcher == 2 }">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish2"/>
				</c:if>
				<%--完成--%>
				<c:if test="${kmCarmngApplicationForm.fdIsDispatcher == 3 }">	
				<bean:message bundle="km-carmng" key="kmCarmng.tree.publish3"/>
				</c:if>			
			</td>
		</tr>
		<!-- 创建者 -->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngApplication.docCreatorId" />
			</td>
			<td>
				<c:out value="${ kmCarmngApplicationForm.docCreatorName}"></c:out>
			</td>
		</tr>
		<!--创建时间-->
		<tr>
			<td class="tr_normal_title" width=30%>
				<bean:message bundle="km-carmng" key="kmCarmngApplication.docCreateTime" />
			</td>
			<td>
				<c:out value="${ kmCarmngApplicationForm.docCreateTime}"></c:out>
			</td>
		</tr>
	</table>
</ui:content>