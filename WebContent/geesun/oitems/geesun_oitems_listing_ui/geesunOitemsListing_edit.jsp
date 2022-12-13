<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no" showQrcode="false">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ geesunOitemsListingForm.method_GET == 'add' }">
				<c:out value="${lfn:message('geesun-oitems:geesunOitemsListing.opt.create') } - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${geesunOitemsListingForm.fdName} - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
		<c:if test="${geesunOitemsListingForm.method_GET=='edit'}">
			 <ui:button text="${lfn:message('button.update') }" order="2" onclick="Com_Submit0(document.geesunOitemsListingForm, 'update');">
			 </ui:button>
	    </c:if> 
	    <c:if test="${geesunOitemsListingForm.method_GET=='add'}">
	         <ui:button text="${lfn:message('button.save') }" order="2" onclick="Com_Submit0(document.geesunOitemsListingForm, 'save');">
			 </ui:button>
			 <ui:button text="${lfn:message('button.saveadd') }" order="2" onclick="Com_Submit0(document.geesunOitemsListingForm, 'saveadd');">
			 </ui:button>
	    </c:if> 
		<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
		</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('geesun-oitems:geesunOitems.msg.listing') }">
				</ui:menu-item>
				<ui:menu-source autoFetch="false">
					<ui:source type="AjaxJson">
						{"url":"/sys/simplecategory/criteria/sysSimpleCategoryCriteria.do?method=path&modelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsManage&categoryId=${geesunOitemsListingForm.fdCategoryId}"} 
					</ui:source>
				</ui:menu-source>
		</ui:menu>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.simplecategory">
			<ui:varParams moduleTitle="${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }" 
			    modulePath="/geesun/oitems/geesun_oitems_listing_ui/index.jsp" 
				modelName="com.landray.kmss.geesun.oitems.model.GeesunOitemsManage" 
				autoFetch="false"
				href="/geesun/oitems/geesun_oitems_listing_ui/index.jsp" 
				categoryId="${geesunOitemsListingForm.fdCategoryId}" />
		</ui:combin>
	</template:replace>
<template:replace name="content"> 
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
	Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js", null, "js");
</script>
<script language="javascript">
seajs.use(['sys/ui/js/dialog'], function(dialog) {
	window.dialog = dialog;
});
	function checkUnique(){ 
		var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=checkUnique"; 
		var  fdNo = document.getElementsByName("fdNo")[0];
		var fdListingId = document.getElementsByName('fdId')[0]
		var flag = true;
		 $.ajax({     
   	     type:"post",   
   	     url:url,     
   	     data:{fdNo:fdNo.value,fdListingId:fdListingId.value},    
   	     async:false,    //用同步方式 
   	     success:function(data){
   	 	    var results =  eval("("+data+")");
   	 	    if(results['repeat']=="true"){
   	 	       flag=false;
   	   	 	}
   		 }    
	  });
	   return flag;
	}

	function checkAmount(){ 
		var fdAmount = document.getElementsByName("fdAmount")[0].value;
		if(fdAmount<0){
			return false;
		}
		return true;
	}
	function check(obj){
		var eventObj = Com_GetEventObject();
		if(eventObj.keyCode == 13)
			return true;
		if(eventObj.keyCode < 48 || eventObj.keyCode >57){
			alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice.type"/>');
			return false;
		}else return true;
	}
	function Com_Submit0(form,operation){
		Com_Submit(form,operation);
	}
	function changeCate(){
		dialog.simpleCategory('com.landray.kmss.geesun.oitems.model.GeesunOitemsManage','fdCategoryId','fdCategoryName',false,null);
	}
	
</script>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
	<div class="lui_form_content_frame" style="padding-top:20px">
       <table class="tb_normal" width=100% id="Table_Main"> 
		<html:hidden property="fdId" />
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdName" /></td>
			<td colspan="3">
				<xform:text style="width:97%" property="fdName" validators="maxLength(200)"/>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdNo" />
			</td>
			<td width=35%>
				<xform:text property="fdNo" style="width:95%"  validators="fdNoUnique"/>
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId" />
			</td>
			<td width=35%>
			    <html:hidden property="fdCategoryId" />
			    <html:text property="fdCategoryName" readonly="true" style="width:50%;border:none" />
					&nbsp;&nbsp;
					<a href="javascript:changeCate()" class="com_btn_link">
						<bean:message key="geesunOitemsListing.changeCate" bundle="geesun-oitems" /> 
					</a>
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification" /></td>
			<td width=35%>
				<xform:text property="fdSpecification" style="width:95%" />
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdBrand" />
			</td>
			<td width=35%>
				<xform:text property="fdBrand" style="width:95%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice" />
			</td>
			<td width=35%>
			    <c:if test="${geesunOitemsListingForm.method_GET=='add'}">
				<input type="text" name="fdReferencePrice" style="width:95%" validate="currency-dollar min(0) required" maxlength="100" class="inputsgl" subject='<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>'>
				<span class="txtstrong">*</span>
				</c:if>
				 <c:if test="${geesunOitemsListingForm.method_GET=='edit'}">
				 <input type="text" name="fdReferencePrice" value="<kmss:showNumber value="${geesunOitemsListingForm.fdReferencePrice}" pattern="0.00#"/>" readonly="readonly" style="border: none">
				 </c:if>
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdUnit" />
			</td>
			<td width=35%>
				<xform:text property="fdUnit" style="width:95%" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdAmount" /></td>
			<td><c:if
				test="${geesunOitemsListingForm.method_GET=='edit'}">
				<html:text style="width:80%" property="fdAmount" readonly="true" />
			</c:if> 
			<c:if test="${geesunOitemsListingForm.method_GET=='add'}">
				<xform:text style="width:70%" property="fdAmount"  validators="fdAmounPositive"/>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.atuoCount" />
			</c:if></td>
			<td width=15% class="td_normal_title">
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.fdIsAbandon"/>
			</td><td>
				<sunbor:enums property="fdIsAbandon" enumsType="common_yesno" elementType="radio" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.picture" /></td>
			<td colspan="3"><c:import
				url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
				charEncoding="UTF-8">
				<c:param name="fdKey" value="geesunOitemsListing" />
				<c:param name="fdAttType" value="pic" />
				<c:param name="fdMulti" value="false" />
				<c:param name="fdShowMsg" value="true" />
				<c:param name="fdImgHtmlProperty" value="width=100 height=100" />
			</c:import></td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%><bean:message
				bundle="geesun-oitems" key="geesunOitemsListing.fdRemark" /></td>
			<td width="85%" colspan="3">
				<xform:textarea style="width:97%" property="fdRemark" />
			</td>
		</tr>
		<tr>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.docCreatorId" />
			</td>
			<td width=35%>
				<html:hidden property="docCreatorId" /> 
				<html:text property="docCreatorName" readonly="true"/>
			</td>
			<td class="td_normal_title" width=15%>
				<bean:message bundle="geesun-oitems" key="geesunOitemsListing.docCreateTime" />
			</td>
			<td width=35%>
				<html:text property="docCreateTime" readonly="true"/>
			</td>
		</tr>
	</table>
	</div>
	<html:hidden property="method_GET" />
	<ui:tabpage expand="false">
	<%--权限机制 --%>
	<c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="geesunOitemsListingForm" />
		<c:param name="moduleModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing" />
	</c:import>
	</ui:tabpage>
</html:form>
<script language="JavaScript">
	var _validation = $KMSSValidation(document.forms['geesunOitemsListingForm']);
	_validation.addValidator("fdNoUnique","${lfn:message('geesun-oitems:GeesunOitemsListing.fdNo.isExists')}",function(v, e, o) {
		return checkUnique();
	});
	_validation.addValidator("fdAmounPositive","${lfn:message('geesun-oitems:GeesunOitemsListing.fdAmount.positive')}",function(v, e, o) {
		return checkAmount();
	});

</script>
</template:replace>
</template:include>
