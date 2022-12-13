<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${ geesunOitemsListingForm.fdName } - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
	  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
	    <kmss:auth requestURL="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=add&fdOitemsId=${param.fdId}" requestMethod="GET">		
			<ui:button order="2" text="${ lfn:message('geesun-oitems:geesunOitems.button1') }" 
						onclick="Com_OpenWindow('${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=add&fdOitemsId=${JsParam.fdId}','_blank');">
			</ui:button>
	    </kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			<ui:button order="2" text="${ lfn:message('button.edit') }" 
								onclick="Com_OpenWindow('geesunOitemsListing.do?method=edit&fdId=${JsParam.fdId}','_self');">
			</ui:button>
		</kmss:auth>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
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
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }" href="/geesun/oitems/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.msg.listing') }" href="/geesun/oitems/geesun_oitems_listing_ui/index.jsp" target="_self">
				</ui:menu-item>
				<ui:menu-source autoFetch="false" 
						target="_self" 
						href="/geesun/oitems/geesun_oitems_listing_ui/index.jsp?categoryId=${geesunOitemsListingForm.fdCategoryId}">
					<ui:source type="AjaxJson">
						{"url":"/sys/simplecategory/criteria/sysSimpleCategoryCriteria.do?method=path&modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsManage&categoryId=${geesunOitemsListingForm.fdCategoryId}"} 
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
    		Com_OpenWindow('geesunOitemsListing.do?method=delete&fdId=${JsParam.fdId}','_self');
    	}else{
    		return false;
	    }
    },"warn");
}
</script>
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsListing"/></p>
<div class="lui_form_content_frame" style="padding-top:5px">
		<table class="tb_normal" width=100%>
		<html:hidden name="geesunOitemsListingForm" property="fdId"/>
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
						<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.inprice.last"/>
					</td><td width=35%>
						<kmss:showNumber value="${geesunOitemsListingForm.fdReferencePrice}" pattern="#,##0.00#"></kmss:showNumber>
						&nbsp;&nbsp;
						<font color="red">
							<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.inprice.last.desc"/>
						</font>
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
					</td><td width=35% >
						<c:out value="${geesunOitemsListingForm.fdAmount}"/>
					</td>
					<td width=15% class="td_normal_title">
			     	<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdIsAbandon"/>
	                 </td>
		             <td width=35%>
					   <sunbor:enumsShow value="${geesunOitemsListingForm.fdIsAbandon}" enumsType="common_yesno" />
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
   </div>
   <ui:tabpage expand="false">
	   <ui:content title="${lfn:message('geesun-oitems:table.geesunOitemsWarehousingRecord')}">
		<ui:event event="show">
			document.getElementById('expenseMain').src = '<c:url value="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=list&fdListingId="/>${JsParam.fdId}';
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
	   <ui:content title="${lfn:message('geesun-oitems:geesunOitemsListing.num.price')}">
		<ui:event event="show">
			document.getElementById('joinMain').src = '<c:url value="/geesun/oitems/geesun_oitems_warehousing_record_joinlist/geesunOitemsWarehousingRecordJoinList.do?method=list&fdListingId="/>${JsParam.fdId}';
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
			<c:param name="formName" value="geesunOitemsListingForm" />
			<c:param name="moduleModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing" />
		</c:import>
   </ui:tabpage>


</template:replace>
</template:include>
