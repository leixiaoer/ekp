<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=add&fdOitemsId=${param.fdId}" requestMethod="GET">		
		<input type="button"
				value="<bean:message bundle="km-oitems" key="kmOitems.button1"/>"
				onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=add&fdOitemsId="/>${JsParam.fdId}','_blank');">
	</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmOitemsListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsListing.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsListing"/></p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden name="kmOitemsListingForm" property="fdId"/>
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="kmOitemsListing.kmOitemsListing" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
					</td><td colspan="3">
						<c:out value="${kmOitemsListingForm.fdName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.fdNo}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.fdCategoryName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.fdSpecification}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.fdBrand}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
					</td><td width=35%>
						<kmss:showNumber value="${kmOitemsListingForm.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.fdUnit}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
					</td><td width=35% colspan="3">
						<c:out value="${kmOitemsListingForm.fdAmount}"/>
					</td>
					
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.picture"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8"> 
				          <c:param name="fdKey" value="kmOitemsListing"/>
				          <c:param name="fdAttType" value="pic"/>
				          <c:param name="fdMulti" value="false"/>
				          <c:param name="fdShowMsg" value="false"/>
				          <c:param name="formBeanName" value="kmOitemsListingForm" />
				          <c:param name="fdImgHtmlProperty" value="width=100 height=100"/>
				        </c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdRemark"/>
					</td><td colspan="3">
					<kmss:showText value="${kmOitemsListingForm.fdRemark}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="kmOitemsListing.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsListing.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${kmOitemsListingForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="table.kmOitemsWarehousingRecord" />" style="display:none">
	<td id="expenseMain" onresize="Doc_LoadFrame('expenseMain','<c:url value="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=list&fdListingId="/>${JsParam.fdId}');">
			<iframe name="" marginwidth=0 marginheight=0 width=100% height="300" src="" frameborder=0></iframe>
			</td>
	</tr>
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="kmOitemsListing.num.price" />" style="display:none">
	<td id="joinMain" onresize="Doc_LoadFrame('joinMain','<c:url value="/km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=list&fdListingId="/>${JsParam.fdId}');">
			<iframe name="" marginwidth=0 marginheight=0 width=100% height="300" src="" frameborder=0></iframe>
			</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>