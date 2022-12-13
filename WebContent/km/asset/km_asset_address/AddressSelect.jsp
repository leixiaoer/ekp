<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath
		+ "km/asset/resource/", "js", true);
</script>
<html:form action="/km/asset/km_asset_address/kmAssetAddress.do">

<center>
<table class="tb_normal" width=95%>
	<tr>
	<!-- 地址名-->
	<html:hidden property="fdId" />
	<td class="td_normal_title" width=15%>
			<bean:message bundle="km-asset" key="kmAssetAddress.fdAddress"/>
		</td><td colspan="3">
                    <html:text property="fdAddress" style="width:80%" 
					    readonly="true"
						styleClass="inputsgl" />
						<a href="#" onClick="selectResource();">
						<bean:message bundle="km-asset" key="kmAssetAddress.select" /></a>     
		</td>
	</tr>
	
	
	
	</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>