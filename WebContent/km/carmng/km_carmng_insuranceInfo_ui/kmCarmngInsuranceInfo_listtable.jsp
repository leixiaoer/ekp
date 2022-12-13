<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfoIndex.do?method=list'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<list:col-html   title="${ lfn:message('km-carmng:kmCarmngInsuranceInfo.fdVehiclesInfoId') }" style="text-align:center">
				{$ <span class="com_subject">{%row['fdVehiclesInfo.fdNo']%}</span> $}
				</list:col-html>
				<list:col-auto props="fdProductBrand;fdRegisterTime;fdInsuranceStartTime;fdInsuranceEndTime;docCreateTime;fdInsurancePrice;fdInsuranceFee;fdInsuranceNo"></list:col-auto>
			</list:colTable>
		</list:listview> 
		
<list:paging></list:paging>	