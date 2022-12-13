<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<link type="text/css" rel="stylesheet" href="${KMSS_Parameter_ContextPath}km/meeting/resource/css/jquery.qtip.css" />
<script language="JavaScript">
		Com_IncludeFile("jquery.js");
		Com_IncludeFile("optbar.js|list.js");
		Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
		//重写刷新方法
		function pageNavJsFunction(href){
			parent.document.kmAssetAddressForm.submit();
		}
</script>
<% request.setAttribute("pageNavJsFunction","pageNavJsFunction"); %>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
<table class="tb_normal" style="width: 100%">
	<tr align="center">
	  <sunbor:columnHead htmlTag="td">
	     <td>
		 </td>
		 <td>
		     <bean:message bundle="km-asset" key="kmAssetAddress.selectOrder" />
		</td>
		<sunbor:column property="kmAssetAddress.fdAddress">
		     <bean:message bundle="km-asset" key="kmAssetAddress.fdAddress"/>
		</sunbor:column>
		<sunbor:column property="kmAssetAddress.fdAssetAddressCate.fdName">
			<bean:message bundle="km-asset" key="kmAssetAddress.fdAssetAddressCate"/>
		</sunbor:column>
	</sunbor:columnHead>
	</tr>
	<c:forEach items="${queryPage.list}" var="kmAssetAddress" varStatus="vstatus">
		<tr align="center" style="cursor:pointer" onclick="selectResouce('${kmAssetAddress.fdId}')">
			<input type="hidden" name="fdAddressName" value="${kmAssetAddress.fdAddress }" />
			<td width="10%">
				<c:choose>
					 <c:when test="${isMul eq 'true' }">
					 	 <input type="checkbox" name="fdAddressId"  value="${kmAssetAddress.fdId }" onclick="selectResouce('${kmAssetAddress.fdId}')"/>
					 </c:when>
					 <c:otherwise>
					  	<input type="radio" name="fdAddressId"  value="${kmAssetAddress.fdId }" />
					 </c:otherwise>
				</c:choose>
			     <input type="hidden"  name="selResource"  value="${kmAssetAddress.fdId }" />
			</td>	
			  <td  width="10%">
            	${vstatus.index+1}
            </td>	
			<td width="50%" align="center">
			     <c:out value="${kmAssetAddress.fdAddress}" />
			</td>
			<td width="30%" align="center">
			     <c:out value="${kmAssetAddress.fdAssetAddressCate.fdName}" />
			</td>
		</tr>
	</c:forEach>
</table>
<script language="JavaScript">
function selectResouce(resId){
	//radio置为选中
	if("${isMul}" == 'true'){
		if($('[name="fdAddressId"][value="'+resId+'"]').prop("checked")){
			$('[name="fdAddressId"][value="'+resId+'"]').prop('checked',false);
		}else{
			$('[name="fdAddressId"][value="'+resId+'"]').prop('checked',true);
		}
	}else{
		$('[name="fdAddressId"][value="'+resId+'"]').prop('checked',true);
	}
};
</script>
<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>

<%@ include file="/resource/jsp/list_down.jsp"%>
