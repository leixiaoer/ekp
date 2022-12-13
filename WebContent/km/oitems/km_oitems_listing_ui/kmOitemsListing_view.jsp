<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${ kmOitemsListingForm.fdName } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
	  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
	    <kmss:auth requestURL="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=add&fdOitemsId=${param.fdId}" requestMethod="GET">		
			<ui:button order="2" text="${ lfn:message('km-oitems:kmOitems.button1') }" 
						onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=add&fdOitemsId=${JsParam.fdId}','_blank');">
			</ui:button>
	    </kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<ui:button order="2" text="${ lfn:message('button.edit') }" 
								onclick="Com_OpenWindow('kmOitemsListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
			</ui:button>
		</kmss:auth>
		<kmss:auth requestURL="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<ui:button order="2" text="${ lfn:message('button.delete') }" 
								onclick="Delete();">
			</ui:button>
		</kmss:auth>
	    <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();">
		</ui:button>
	  </ui:toolbar>
	</template:replace>
<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.tree.modelName') }" href="/km/oitems/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.msg.listing') }" href="/km/oitems/km_oitems_listing_ui/index.jsp" target="_self">
				</ui:menu-item>
				<ui:menu-source autoFetch="false" 
						target="_self" 
						href="/km/oitems/km_oitems_listing_ui/index.jsp?categoryId=${kmOitemsListingForm.fdCategoryId}">
					<ui:source type="AjaxJson">
						{"url":"/sys/simplecategory/criteria/sysSimpleCategoryCriteria.do?method=path&modelName=com.landray.kmss.km.oitems.model.KmOitemsManage&categoryId=${kmOitemsListingForm.fdCategoryId}"} 
					</ui:source>
				</ui:menu-source>
			</ui:menu>
</template:replace>	
<template:replace name="content">
<script>
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog=dialog;
});
function Delete(){
	dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
    	if(flag==true){
    		Com_OpenWindow('kmOitemsListing.do?method=delete&fdId=${JsParam.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn");
}
</script>
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsListing"/></p>
<div class="lui_form_content_frame" style="padding-top:5px">
		<table class="tb_normal" width=100%>
		<html:hidden name="kmOitemsListingForm" property="fdId"/>
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
						<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.inprice.last"/>
					</td><td width=35%>
						<kmss:showNumber value="${kmOitemsListingForm.fdReferencePrice}" pattern="#,##0.00#"></kmss:showNumber>
						&nbsp;&nbsp;
						<font color="red">
							<bean:message bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.inprice.last.desc"/>
						</font>
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
					</td><td width=35% >
						<c:out value="${kmOitemsListingForm.fdAmount}"/>
					</td>
					<td width=15% class="td_normal_title">
			     	<bean:message bundle="km-oitems" key="kmOitemsListing.fdIsAbandon"/>
	                 </td>
		             <td width=35%>
					   <sunbor:enumsShow value="${kmOitemsListingForm.fdIsAbandon}" enumsType="common_yesno" />
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
   </div>
   <ui:tabpage expand="false">
	   <ui:content title="${lfn:message('km-oitems:table.kmOitemsWarehousingRecord')}">
		<ui:event event="show">
			document.getElementById('expenseMain').src = '<c:url value="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=list&fdListingId="/>${JsParam.fdId}';
		</ui:event>
		<table width="100%">
			<tr>
				<td>
					<iframe src="" width=100% height=100% frameborder=0 scrolling="no" id="expenseMain">
					</iframe>
				</td>
			</tr>
		</table>
	  </ui:content>
	   <ui:content title="${lfn:message('km-oitems:kmOitemsListing.num.price')}">
		<ui:event event="show">
			document.getElementById('joinMain').src = '<c:url value="/km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=list&fdListingId="/>${JsParam.fdId}';
		</ui:event>
		<table width="100%">
			<tr>
				<td>
					<iframe src="" width=100% height=100% frameborder=0 scrolling="no" id="joinMain">
					</iframe>
				</td>
			</tr>
		</table>
	  </ui:content>
	  <%--权限机制 --%>
		<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmOitemsListingForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.km.oitems.model.KmOitemsListing" />
		</c:import>
   </ui:tabpage>


</template:replace>
</template:include>
