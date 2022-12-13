<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable" style="width:4500px;border:1px;bolder-collapse:collapse;" cellspacing="0" cellpadding="0">
		<tr style="border:1px solid black;">
			<sunbor:columnHead htmlTag="td">
				<td width="15px;" style="border:1px solid black;">
					<bean:message key="page.serial"/>
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					申请日期
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					申请单编号
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					申请人工号
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					申请人
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					岗位
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					收款单位/实际报销人
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					明细金额
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					预算中心
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					报销部门
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					使用部门
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					产品线
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					科目名称
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					三级科目
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					项目号
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					付款原因
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					请示报告
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					报销说明
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					文档状态
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					现金流项目
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					付款日期
				</td>
				<!-- <td align="center" style="min-width:80px;border:1px solid black;">
					付款说明
				</td> -->
				<td align="center" style="min-width:80px;border:1px solid black;">
					行号
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					开户行
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					账号
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					开始日期
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					结束日期
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					出差天数
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					出发地
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					目的地
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					车船费
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					机票费
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					市内交通费
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					住宿费
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					租房费用
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					出差补贴
				</td>
				<td align="center" style="min-width:80px;border:1px solid black;">
					其他
				</td>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="model" varStatus="vstatus">
			<tr style="border:1px solid black;" kmss_href="<c:url value="/km/review/km_review_main/kmReviewMain.do" />?method=view&fdId=${model.fdApplyId}">
				<td style="border:1px solid black;">
					${vstatus.index+1}
				</td>
				<td style="border:1px solid black;">
					<kmss:showDate value="${model.fdApplyDate}" type="date"/>
				</td> 
				<td style="border:1px solid black;">
					<c:out value="${model.fdApplyNumber}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdApplyNo}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdApplyerName}" />
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdApplyerGw}" />
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdReceiverName}" />
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdTotalMoney}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdCenterName}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdApplyerDeptName}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdUserDeptName}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdProduct}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdItemName}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdThreeItemName}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdProjectNo}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdPayReason}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdQsbg}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdExpenseDescription}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdStatus}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdXjlXm}"/>
				</td>
				<td style="border:1px solid black;">
					<kmss:showDate value="${model.fdPayDate}" type="date"/>
				</td>
				<%-- <td style="border:1px solid black;">
					<c:out value="${model.fdPayDescription}"/>
				</td> --%>
				<td style="border:1px solid black;">
					<c:out value="${model.fdHh}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdKhh}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdAccount}"/>
				</td>
				<td style="border:1px solid black;">
					<kmss:showDate value="${model.fdBeginDate}" type="date"/>
				</td>
				<td style="border:1px solid black;">
					<kmss:showDate value="${model.fdEndDate}" type="date"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdTravelDays}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdStartPlace}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdEndPlace}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdCcf}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdJpf}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdSnjtf}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdZsf}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdZffy}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdCcbt}"/>
				</td>
				<td style="border:1px solid black;">
					<c:out value="${model.fdOther}"/>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
<%@ include file="/resource/jsp/list_down.jsp"%>