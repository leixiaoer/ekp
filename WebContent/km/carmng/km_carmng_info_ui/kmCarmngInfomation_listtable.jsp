<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
		<list:listview id="listview">
			<ui:source type="AjaxJson">
					{url:'/km/carmng/km_carmng_infomation/kmCarmngInfomationIndex.do?method=list&motorcadeId=${param.motorcadeId}'}
			</ui:source>
			  <!-- 列表视图 -->	
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable" 
				rowHref="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=view&fdId=!{fdId}"  name="columntable">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial> 
				<list:col-html   title="${ lfn:message('km-carmng:kmCarmngInfomation.fdNo') }" style="text-align:left">
				{$ <span class="com_subject">{%row['fdNo']%}</span> $}
				</list:col-html>
				<list:col-auto props="docSubject;fdVehichesType.fdName;fdSeatNumber;docCreateTime;fdMotorcade.fdName;fdDriverName;docStatus"></list:col-auto>
			</list:colTable>
		</list:listview> 
		
<list:paging></list:paging>	