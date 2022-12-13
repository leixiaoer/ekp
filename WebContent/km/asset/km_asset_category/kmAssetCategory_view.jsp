<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<div id="optBarDiv">
	<c:import url="/sys/simplecategory/sys_simple_category/sysCategoryMain_edit_button.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetCategoryForm" />
	</c:import>
</div>

<p class="txttitle"><bean:message bundle="km-asset" key="table.kmAssetCategory"/></p>

<center>
<table id="Label_Tabel"
		width=95%>
	<c:import url="/sys/simplecategory/include/sysCategoryMain_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetCategoryForm" />
			<c:param name="requestURL" value="/km/asset/km_asset_category/kmAssetCategory.do?method=add" />
			<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetCategory" />
			<c:param name="fdKey" value="fdAssetCategory" />
	</c:import>
	
	<!-- 表单 -->
	<tr LKS_LabelName="<kmss:message bundle="km-asset" key="kmAssetCategory.extend" />" style="display:none">
	<td>
	  <c:import url="/sys/xform/include/sysFormTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmAssetCategoryForm" />
		<c:param name="fdKey" value="assetMainDoc" />
		<c:param name="fdMainModelName"
				value="com.landray.kmss.km.asset.model.KmAssetCard"/>
	    <c:param name="useLabel" value="false" />
	  </c:import>
	  <table id="rtfView" class="tb_normal" width=100% style="border-top:0;">
			<tr>
				<td colspan="4" style="border-top:0;">
					<html:hidden property="fdUseForm" />
					<xform:rtf property="docContent" toolbarSet="Default" height="500"></xform:rtf>
				</td>
			</tr>
			</table>
	</td>
	</tr>
	
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
	   <c:param name="formName" value="kmAssetCategoryForm" />
	   <c:param name="modelName" value="com.landray.kmss.km.asset.model.KmAssetCard"/>
    </c:import>
	<%-- 以下代码为嵌入默认权限模板标签的代码 --%>
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />"><td>
		<table class="tb_normal" width=100%>
			<c:import url="/sys/right/tmp_right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetCategoryForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetCard" />
			</c:import>
		</table>
	</td></tr>
	<%-- 以上代码为嵌入默认权限模板标签的代码 --%>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<%@ include file="/resource/jsp/view_down.jsp"%>