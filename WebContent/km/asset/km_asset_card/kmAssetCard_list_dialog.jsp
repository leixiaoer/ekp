<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<html:form action="/km/asset/km_asset_card/kmAssetCard.do">
<c:if test="${queryPage.totalrows==0}">
    <%@include file="kmAssetForSearch_condition.jsp" %>
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<%@include file="kmAssetForSearch_condition.jsp" %>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt">
				 <c:if test="${empty isParentCard}">
					<input type="checkbox" name="List_Tongle">
				 </c:if>
				</td>
				<td width="40pt">
					<bean:message key="page.serial"/>
				</td>
				<sunbor:column property="kmAssetCard.fdCode">
					<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCard.fdName">
					<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCard.fdStandard">
					<bean:message bundle="km-asset" key="kmAssetCard.fdStandard"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCard.fdAssetCategory.fdName">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
				</sunbor:column>
				<sunbor:column property="kmAssetCard.fdAssetStatus">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmAssetCard" varStatus="vstatus">
			<tr style="cursor:pointer"  onclick="selectCard('${kmAssetCard.fdId}')">
				<td>
					<c:choose>
						 <c:when test="${not empty isParentCard}">
						   <input type="radio" name="List_Selected" value="${kmAssetCard.fdId}">
						 </c:when>
						<c:otherwise>
						  <input type="checkbox" name="List_Selected" value="${kmAssetCard.fdId}">
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					${vstatus.index+1}
				</td>
				<td>
					<c:out value="${kmAssetCard.fdCode}" />
				</td>
				<td>
					<c:out value="${kmAssetCard.fdName}" />
				</td>
				<td>
					<c:out value="${kmAssetCard.fdStandard}" />
				</td>
				<td>
					<c:out value="${kmAssetCard.fdAssetCategory.fdName}" />
				</td>
				<td>
					<xform:select property="fdAssetStatus" value="${kmAssetCard.fdAssetStatus}" showStatus="view">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
					</xform:select>
				</td>
				
			</tr>
		</c:forEach>
	</table>
<script language="JavaScript">
function selectCard(cardId){
	if("${isParentCard}" != ""){
		//单选的情况
		$('[name="List_Selected"][value="'+cardId+'"]').prop('checked',true);
	}else{
		//多选的情况
		if($('[name="List_Selected"][value="'+cardId+'"]').prop('checked') ){
			$('[name="List_Selected"][value="'+cardId+'"]').prop('checked',false);
		}else{
			$('[name="List_Selected"][value="'+cardId+'"]').prop('checked',true);
		}
	}
};
</script>
	
	
	
	
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>