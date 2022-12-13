<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<%
		String fdCarNo = request.getParameter("fdCarNo");
		pageContext.setAttribute("reqFdCarNo", fdCarNo);
	%>

	<template:replace name="body">
		<script type="text/javascript">
			function exportDetailExcel(){
			    var fdCarInfoId = '${JsParam.carId}';
				var timeType = '${JsParam.timeType}';
				var fdStartDate = '${JsParam.fdStartDate}';
				var fdEndDate = '${JsParam.fdEndDate}';
			    if(fdStartDate && fdEndDate){
			    	Com_OpenWindow('${KMSS_Parameter_ContextPath}km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=exportCarUseDetailExcel&carId='+fdCarInfoId+'&timeType='+timeType +'&fdStartDate='+fdStartDate+"&fdEndDate="+fdEndDate,'_blank');
			    }
			}
		</script>
		<center style="font-size: 30px;font-weight: bold;margin-bottom: 20px;margin-top: 20px;">${reqFdCarNo}-明细</center>
		<div style="text-align: center;margin-top: 10px;margin-bottom:10px">
			 <ui:button text="${lfn:message('km-carmng:kmCarmng.button1') }" onclick="exportDetailExcel();">
			 </ui:button>
		</div>
		<list:listview id="listview" >
		    <ui:source type="AjaxJson">
		        {url:'/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=carUseDetail&carId=${JsParam.carId }&timeType=${JsParam.timeType }&fdStartDate=${JsParam.fdStartDate }&fdEndDate=${JsParam.fdEndDate }'}
		    </ui:source>
		    <!-- 列表视图 -->
		    <list:colTable 
		    	isDefault="true" 
		    	layout="sys.ui.listview.columntable" 
		    	rowHref="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=view&fdId=!{fdId}" 
		    	name="columntable">
		        <list:col-serial/>
		        <list:col-auto/>
		    </list:colTable>
		    <ui:event topic="list.loaded">  
			   seajs.use(['lui/jquery'], function($) {
					if(window.frameElement != null && window.frameElement.tagName=="IFRAME") {
						window.frameElement.style.height = ($(document.body).height() + 10) + "px";
					}
				});
			</ui:event>
		</list:listview>
		<!-- 翻页 -->
		<list:paging />
	</template:replace>
</template:include>
