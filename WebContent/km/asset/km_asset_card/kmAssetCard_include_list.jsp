<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>  
<style type="text/css">

		.list,.list td
		{
			text-align:center;
			border: 0px #C0C0C0 solid;
			background:#FFFFFF;
			font-size:12px; font-family:Microsoft YaHei,Lucida Sans Unicode, Arial, Verdana，SansSerif,"宋体"; color:#3a3a3a;
			line-height:25px;
			word-break:break-all;
			word-wrap:break-word;
			overflow: auto;
		}
		.list th
		{
			background:#daecfe;
		}

</style>
<c:if test="${fn:length(kmAssetCardForm.fdItems)== 0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${fn:length(kmAssetCardForm.fdItems)>0}">
	<table width="100%" style="table-layout:fixed;border: 0px #C0C0C0 solid;min-height:130px" bgcolor="#c9c9c9" align=left  cellspacing=1 cellpadding=0>
		<tr class="list"  height="30px">
				<th width="3%">
					<bean:message key="page.serial"/>
				</th>
				<th width="10%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
				</th>
				<th width="10%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
				</th>
				<th width="35%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
				</th>
				<th width="8%">
					<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
				</th>
				<th width="10%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
				</th>
				<th width="10%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
				</th>
				<th width="8%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
				</th>
				<th width="9%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
				</th>
		</tr>
		<c:forEach items="${kmAssetCardForm.fdItems}" var="kmAssetCardForm" varStatus="vstatus">
			<tr class="list">
				<td width="3%">
					${vstatus.index+1}
				</td>
				<td>
					<a data-href="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=view&fdId=${kmAssetCardForm.fdId}" target="_blank" onclick="Com_OpenNewWindow(this)">
					<c:out value="${kmAssetCardForm.fdCode}" />
					</a>
				</td>
				<td>
				   <a data-href="<c:url value="/km/asset/km_asset_card/kmAssetCard.do" />?method=view&fdId=${kmAssetCardForm.fdId}" target="_blank" onclick="Com_OpenNewWindow(this)">
					 <c:out value="${kmAssetCardForm.fdName}" />
				   </a>
				</td>
				<td>
					<c:out value="${kmAssetCardForm.fdStandard}" />
				</td>
				<td>
					<c:out value="${kmAssetCardForm.docDeptName}" />
				</td>
				<td>
					<c:out value="${kmAssetCardForm.fdResponsiblePersonName}" />
				</td>
				<td>
					<c:out value="${kmAssetCardForm.fdAssetAddressName}" />
				</td>
				<td>
					<c:out value="${kmAssetCardForm.fdAssetCategoryName}" />
				</td>
				<td>
					<xform:select property="fdAssetStatus" value="${kmAssetCardForm.fdAssetStatus}" showStatus="view">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
					</xform:select>
				</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
