<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfoIndex.do?method=list'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<list:col-html   title="${ lfn:message('km-carmng:kmCarmngMaintenanceInfo.fdVehiclesInfoId') }" style="text-align:center;width:20%">
				{$ <span class="com_subject">{%row['fdVehiclesInfo.fdNo']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdMaintenanceTime;docCreateTime;fdMaintenanceFee;fdPersonName;fdRepairFee;docCreator.fdName;docCreateTime"></list:col-auto>
			</list:colTable>
		</list:listview> 
		
<list:paging></list:paging>	