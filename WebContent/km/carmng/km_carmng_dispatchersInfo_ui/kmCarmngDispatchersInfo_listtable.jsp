<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfoIndex.do?method=list'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto props="fdApplicationNames;fdCarInfoNames;fdStartTime;fdEndTime;fdFlag;"></list:col-auto>
			</list:colTable> 
		</list:listview>
		
<list:paging></list:paging>	