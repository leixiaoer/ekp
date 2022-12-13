<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">	
	<script type="text/javascript">	
	</script>
	<table width="100%"> 
		<tr>
			<td colspan="2"> 
				<list:listview id="listview">
	                <ui:source type="AjaxJson">
	                    {url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&isChange=true&showAll=true&fdOriginId=${param.fdOriginId}&q.j_path=/BianGengLiuCheng'}
	                </ui:source>
	                <!-- 列表视图 -->
	                <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" isDefault="true" layout="sys.ui.listview.columntable" rowHref="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=!{fdId}&fdOriginId=!{fdOriginId}" name="columntable">
	                    <list:col-checkbox />
	                    <list:col-serial/>
	                    <list:col-auto/>
	                </list:colTable>
	            </list:listview>
				<list:paging layout="sys.ui.paging.simple"></list:paging>
			</td>
		</tr>
	</table>
	</template:replace> 
</template:include>
