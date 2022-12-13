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
	<kmss:auth requestURL="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=add&fdOitemsId=${param.fdId}" requestMethod="GET">		
		<input type="button"
				value="<bean:message bundle="geesun-oitems" key="geesunOitems.button1"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=add&fdOitemsId="/>${JsParam.fdId}','_blank');">
	</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('geesunOitemsListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsListing.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsListing"/></p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden name="geesunOitemsListingForm" property="fdId"/>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="geesunOitemsListing.geesunOitemsListing" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
					</td><td colspan="3">
						<c:out value="${geesunOitemsListingForm.fdName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.fdNo}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.fdCategoryName}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.fdSpecification}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.fdBrand}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
					</td><td width=35%>
						<kmss:showNumber value="${geesunOitemsListingForm.fdReferencePrice}" pattern="#.##"></kmss:showNumber>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.fdUnit}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
					</td><td width=35% colspan="3">
						<c:out value="${geesunOitemsListingForm.fdAmount}"/>
					</td>
					
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.picture"/>
					</td><td colspan="3">
						<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8"> 
				          <c:param name="fdKey" value="geesunOitemsListing"/>
				          <c:param name="fdAttType" value="pic"/>
				          <c:param name="fdMulti" value="false"/>
				          <c:param name="fdShowMsg" value="false"/>
				          <c:param name="formBeanName" value="geesunOitemsListingForm" />
				          <c:param name="fdImgHtmlProperty" value="width=100 height=100"/>
				        </c:import>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdRemark"/>
					</td><td colspan="3">
					<kmss:showText value="${geesunOitemsListingForm.fdRemark}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="geesunOitemsListing.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsListingForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="table.geesunOitemsWarehousingRecord" />" style="display:none">
	<td id="expenseMain" onresize="Doc_LoadFrame('expenseMain','<c:url value="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=list&fdListingId="/>${JsParam.fdId}');">
			<iframe name="" marginwidth=0 marginheight=0 width=100% height="300" src="" frameborder=0></iframe>
			</td>
	</tr>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="geesunOitemsListing.num.price" />" style="display:none">
	<td id="joinMain" onresize="Doc_LoadFrame('joinMain','<c:url value="/geesun/oitems/geesun_oitems_warehousing_record_joinlist/geesunOitemsWarehousingRecordJoinList.do?method=list&fdListingId="/>${JsParam.fdId}');">
			<iframe name="" marginwidth=0 marginheight=0 width=100% height="300" src="" frameborder=0></iframe>
			</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
