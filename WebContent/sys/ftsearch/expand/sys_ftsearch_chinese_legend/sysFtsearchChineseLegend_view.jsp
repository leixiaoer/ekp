<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/sys/ftsearch/expand/sys_ftsearch_chinese_legend/sysFtsearchChineseLegend.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('sysFtsearchChineseLegend.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/sys/ftsearch/expand/sys_ftsearch_chinese_legend/sysFtsearchChineseLegend.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('sysFtsearchChineseLegend.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="sys-ftsearch-expand" key="table.sysFtsearchChineseLegend"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-ftsearch-expand" key="sysFtsearchChineseLegend.fdUserName"/>
		</td><td width="35%">
			<xform:text property="fdUserName" style="width:85%" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-ftsearch-expand" key="sysFtsearchChineseLegend.fdSearchTime"/>
		</td><td width="35%">
			<xform:text property="fdSearchTime" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-ftsearch-expand" key="sysFtsearchChineseLegend.fdSearchWord"/>
		</td><td width="35%">
			<xform:text property="fdSearchWord" style="width:85%"  />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-ftsearch-expand" key="sysFtsearchChineseLegend.fdSearchFrequency"/>
		</td><td width="35%">
			<xform:text property="fdSearchFrequency" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="sys-ftsearch-expand" key="sysFtsearchChineseLegend.fdShieldFlag"/>
		</td>
		<td width="35%">
		<sunbor:enumsShow value="${sysFtsearchChineseLegendForm.fdShieldFlag}" enumsType="common_yesno" />
		</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>