<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="auto">
	<template:replace name="body"> 
		<script language="JavaScript">
			seajs.use(['theme!form']);
		</script>
		<script type="text/javascript">
			function getReturnValue()
			{
				 var checks=document.getElementsByName("List_Selected");
				 var checksValue="";
				 for(var i=0;i<checks.length;i++)
				 {
					 if(checks[i].checked)
					 {
						checksValue+=checks[i].value+";";
					}
				 }
				 if(checksValue==""){
						seajs.use(['lui/dialog'], function(dialog) {
						dialog.alert('<bean:message bundle="km-asset" key="kmAssetApplyStockList.notNull"/>');
						});
						return;
				 }
				 $dialog.hide(checksValue);
			}
			function selectStock(fdId){
				//多选的情况
				if($('[name="List_Selected"][value="'+fdId+'"]').prop('checked') ){
					$('[name="List_Selected"][value="'+fdId+'"]').prop('checked',false);
				}else{
					$('[name="List_Selected"][value="'+fdId+'"]').prop('checked',true);
				}
			};
			window.onload = function(){
				var keywords = Com_GetUrlParameter(location.href,'keywords');
				if(keywords != null &&  keywords != '')
					document.getElementsByName("keywords")[0].value = keywords;
			};
			function dosearch(){
				var keywords = document.getElementsByName("keywords")[0].value;
				//去除首尾空格
				keywords = keywords.replace(/(^\s*)|(\s*$)/g,"");
				keywords = encodeURI(keywords); //中文两次转码
				window.location.href ="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=list&isDialog=0&keywords="+keywords;
			}
		</script>
		<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/></p>
		<div class="input_search" style="border:0">
		 <input type="text"  name="keywords"  size="20" style="width: 200px;" placeholder="<bean:message bundle='km-asset' key='kmAssetApplyStockList.dosearch.placeholder' />" />
		   <input type="button" class="btnopt" value="<bean:message key="button.search"/>" onclick="dosearch();">
		</div>
		<html:form action="/km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do">
		<c:if test="${queryPage.totalrows==0}">
			<%@ include file="/resource/jsp/list_norecord.jsp"%>
		</c:if>
		<c:if test="${queryPage.totalrows>0}">
			<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
			<table id="List_ViewTable">
				<tr>
					<sunbor:columnHead htmlTag="td">
						<td width="10pt">
							<input type="checkbox" name="List_Tongle">
						</td>
						<td width="40pt">
							<bean:message key="page.serial"/>
						</td>
						<sunbor:column property="kmAssetApplyStockList.fdAssetApplyStock.fdNo">
							<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdName">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdStandard">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdStockAmount">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdReceiveAmount">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdPrice">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
						</sunbor:column>
						<sunbor:column property="kmAssetApplyStockList.fdStockDate">
							<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
						</sunbor:column>
					</sunbor:columnHead>
				</tr>
				<c:forEach items="${queryPage.list}" var="kmAssetApplyStockList" varStatus="vstatus">
					<tr style="cursor:pointer"  onclick="selectStock('${kmAssetApplyStockList.fdId}')">
						<td>
							<input type="checkbox" name="List_Selected" value="${kmAssetApplyStockList.fdId}">
						</td>
						<td>
							${vstatus.index+1}
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdAssetApplyStock.fdNo}" />
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdName}" />
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdStandard}" />
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdStockAmount}" />
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdReceiveAmount}" />
						</td>
						<td>
							<c:out value="${kmAssetApplyStockList.fdPrice}" />
						</td>
						<td>
							<kmss:showDate value="${kmAssetApplyStockList.fdStockDate}" type="date"/>
						</td>
					</tr>
				</c:forEach>
			</table>
			<center>
			   <div style="padding-top:15px">
				<input name="btnOk" id="btnOk"  type="button" class="lui_form_button" style="width:50px"
				value="<bean:message key="button.ok"/>" onclick="getReturnValue();">&nbsp;
				<input name="btnCancel" id="btnCancel" type="button"  class="lui_form_button" style="width:50px"
				value="<bean:message key="button.cancel"/>" onclick="$dialog.hide();">
			    </div>
			</center>
			<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
		</c:if>
		</html:form>
		<%@ include file="/resource/jsp/list_down.jsp"%>
	</template:replace> 
</template:include>