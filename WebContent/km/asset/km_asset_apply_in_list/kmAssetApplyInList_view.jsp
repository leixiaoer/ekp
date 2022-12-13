<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<tr>
	<td colspan="4">
		<table class="tb_normal" width=100% id="TABLE_DocList_Stock" align="center">
			<tr>
	 			<%-- 采购明细标题 --%>
				<td colspan="12" class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/>
				</td>
			</tr>

			<tr align="center">
				<%--序号--%> 
				<td class="td_normal_title" width=4%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdOrder"/>
				</td>
				<%--采购单号--%> 
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<%--资产名称--%>
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
				</td>
				<%--规格型号--%>
				<td class="td_normal_title" width=13%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
				</td>
				<%--单位--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
				</td>
				<%--单价--%>
				<td class="td_normal_title" width=8%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
				</td>
				<%--采购数量--%>
				<td class="td_normal_title" width=8%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
				</td>
				<%--已到数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
				</td>
				<%--采购人--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
				</td>
				<%--供应商--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
				</td>
				<%--采购日期--%>
				<td class="td_normal_title" width=8%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
				</td>
			</tr>
			
			<c:forEach items="${stockLists}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1" align="center">
					<td width="4%"><c:out  value="${vstatus.index+1}"></c:out></td>
					<td width=12%><c:out  value="${item.fdAssetApplyStock.fdNo}"></c:out></td>
					<td width=12%><c:out  value="${item.fdName }"></c:out></td>
					<td width=13%><c:out  value="${item.fdStandard}"></c:out></td>
					<td width=7%><c:out  value="${item.fdMeasure}"></c:out></td>
					<td width=8%><kmss:showNumber value="${item.fdPrice}" pattern="###,##0.00"/></td>
					<td width=8%><c:out  value="${item.fdStockAmount}"></c:out></td>
					<td width=7% class="receiveAmount"></td>
					<td width=10%><c:out  value="${item.fdStocker.fdName}"></c:out></td>
					<td width=10%> <c:out  value="${item.fdProvider.fdName}"></c:out></td>
					<td width=8%>
						<kmss:showDate value="${item.fdStockDate}" type="date" />
					</td>
				</tr>
			</c:forEach>
		</table>
	</td>
</tr>

<%-- 分隔符 --%>
<tr><td colspan="4">&nbsp;</td></tr>
				
<tr>
	<td colspan="4">
		<table  class="tb_normal" width=100%  align="center">
			<tr>
 				<%-- 入库明细标题 --%>
				<td class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyInList"/>
				</td>
			</tr>
		</table>
		<table class="tb_normal" width=100% id="TABLE_DocList_In" align="center"  style="table-layout:fixed;">
			<tr align="center">
				<%--序号--%> 
				<td class="td_normal_title" width=4%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdOrder"/>
				</td>
				<%--采购单号--%> 
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<%--资产名称--%>
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
				</td>
				<%--采购数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
				</td>
				<%--已到数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
				</td>
				<%--资产类别--%>
				<td class="td_normal_title" width=14%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetCategory"/>
				</td>
				<%--资产序列号--%>
				<td class="td_normal_title" width=13%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdNo"/>
				</td>
				<%--资产序编码--%>
				<td class="td_normal_title" width=14%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
				</td>
				<%--组织机构代码--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdDeptCode"/>
				</td>
				<%--到货数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdInNum"/>
				</td>
			</tr>
			
			<c:forEach items="${kmAssetApplyInForm.kmAssetApplyInListForms}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1" align="center">
					<script>
						var receiveAmount=$(".receiveAmount");
						receiveAmount.eq("${vstatus.index}").html("${item.fdReceiveAmount }");
					</script>
					<td width="4%"><c:out value="${vstatus.index+1}"></c:out></td>
					<td width=12%><c:out value="${item.fdStockNo}"></c:out></td>
					<td width=12%><c:out value="${item.fdName}"></c:out></td>
					<td width=7%><c:out value="${item.fdStockAmount}"></c:out></td>
					<td width=7%><c:out value="${item.fdReceiveAmount}"></c:out></td>
					<td width="14%"><c:out value="${item.fdAssetCategoryName}"></c:out></td>
					<td width=13%><c:out value="${item.fdNo}"></c:out></td>
					<td width=14% >
						<c:if test="${not empty item.fdCode}">
							<c:out value="${item.fdCode}"></c:out>
						</c:if>
						<c:if test="${codeRule=='2'&&kmAssetApplyInForm.docStatus!='30'}">
							<bean:message bundle="km-asset"  key="kmAssetApplyInList.fdCodeAuto" />
						</c:if>	
					</td>
					<td width=10%><c:out value="${item.fdDeptCode}"></c:out></td>
					<td width=7%><c:out value="${item.fdInNum}"></c:out></td>
				</tr>
			</c:forEach>
			
		</table>
	</td>
</tr>