<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ui:content title="${ lfn:message('list.search') }"  expand="false">
	<ul class='lui_list_nav_list'>
		<li><a href="javascript:void(0)" onclick="openUrl('create');">${ lfn:message('km-carmng:kmCarmng.tree.my.submit') }</a></li>
		<li><a href="javascript:void(0)" onclick="openUrl('approval');">${ lfn:message('list.approval') }</a></li>
		<li><a href="javascript:void(0)" onclick="openUrl('approved');">${ lfn:message('list.approved') }</a></li>
		<li><a href="javascript:void(0)" onclick="openUrl('all');">${lfn:message('km-carmng:kmCarmng.use.all')}</a></li>
	</ul>
</ui:content>
<kmss:authShow roles="ROLE_KMCARMNG_CARMANAGE">
	<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.car.information') }" expand="${param.key != 'carinfomationArea'?'false':'true' }">
		<ul id="km_carmng_info" class='lui_list_nav_list'>
			<li><a href="javascript:void(0)" onclick="openUrl('infringeInfo');">${ lfn:message('km-carmng:kmCarmng.tree.car.information3') }</a></li>
			<li><a href="javascript:void(0)" onclick="openUrl('insuranceInfo');">${ lfn:message('km-carmng:kmCarmng.tree.car.information4') }</a></li>
			<li><a href="javascript:void(0)" onclick="openUrl('maintenanceInfo');">${ lfn:message('km-carmng:kmCarmng.tree.car.information5') }</a></li>
		</ul>
	</ui:content>
</kmss:authShow>
<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER;ROLE_KMCARMNG_ATTEMPER;ROLE_KMCARMNG_EVALUATION">
	<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.dispatcher') }" expand="${param.key != 'cardispatchArea'?'false':'true' }">
		<ul id="km_carmng_dispatch" class='lui_list_nav_list'>
			<li><a href="${LUI_ContextPath }/km/carmng/km_carmng_calendar/rescalendar.jsp" target="_self">${ lfn:message('km-carmng:kmCarmng.tree.dispatcher4') }</a></li>
			<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER;ROLE_KMCARMNG_ATTEMPER">
				<li><a href="javascript:void(0)" onclick="openUrl('listByDispatchers');">${ lfn:message('km-carmng:kmCarmng.tree.dispatcher1') }</a></li>
				<li><a href="javascript:void(0)" onclick="openUrl('dispatchersInfo');">${ lfn:message('km-carmng:kmCarmng.tree.dispatcher2') }</a></li>
			</kmss:authShow>
			<kmss:authShow roles="ROLE_KMCARMNG_EVALUATION">
				<li><a href="javascript:void(0)" onclick="openUrl('evaluation');">${ lfn:message('km-carmng:table.kmCarmngEvaluation') }</a></li>
			</kmss:authShow>
		</ul>
	</ui:content>
</kmss:authShow>
<kmss:authShow roles="ROLE_KMCARMNG_CHARGESTAT">
	<ui:content title="${ lfn:message('km-carmng:kmCarmng.tree.fee.count') }" expand="${param.key != 'carstatArea'?'false':'true' }">
		<ul class='lui_list_nav_list'>
			<li><a href="javascript:void(0)" onclick="javascript:openPage('${LUI_ContextPath }/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=count');resetMenuNavStyle(this);">${ lfn:message('km-carmng:kmCarmng.tree.fee.count1') }</a></li>
			<li><a href="javascript:void(0)" onclick="javascript:openPage('${LUI_ContextPath }/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=count');resetMenuNavStyle(this);">${ lfn:message('km-carmng:kmCarmng.tree.fee.count2') }</a></li>
			<li><a href="javascript:void(0)" onclick="javascript:openPage('${LUI_ContextPath }/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=count');resetMenuNavStyle(this);">${ lfn:message('km-carmng:kmCarmng.tree.fee.count3') }</a></li>
		</ul>
	</ui:content>
</kmss:authShow>
<kmss:authShow roles="ROLE_KMCARMNG_BACKSTAGE_MANAGER">
<ui:content title="${ lfn:message('list.otherOpt') }">
	<ul class='lui_list_nav_list'>
		<li><a href="${LUI_ContextPath }/sys/profile/index.jsp#app/ekp/km/carmng" target="_blank">${ lfn:message('list.manager') }</a></li>
	</ul>
</ui:content>
</kmss:authShow>
<script>
		seajs.use([
		   	   	'lui/jquery', 
		   	   	'lui/util/str', 
		   	   	'lui/dialog',
		   	   	'lui/topic'
		   	   	], function($, strutil, dialog, topic){
			
	   	   	window.openUrl = function(prefix){
		   	   	var urlPara = prefix;
		   	    var srcUrl = "${LUI_ContextPath}/km/carmng/";
		   	   	if(urlPara == 'create'){
		   	   		srcUrl = "${LUI_ContextPath}/km/carmng/#cri.q=mydoc:create";
		   	   		window.open(srcUrl,"_self");
			   	}
			   	if(urlPara == 'approval'){
			   		srcUrl = "${LUI_ContextPath}/km/carmng/#cri.q=mydoc:approval";
			   		window.open(srcUrl,"_self");
			   	}
			   	if(urlPara == 'approved'){
			   		srcUrl = "${LUI_ContextPath}/km/carmng/#cri.q=mydoc:approved";
			   		window.open(srcUrl,"_self");
		   	   	}
			   	if(urlPara == 'all'){
			   		srcUrl = "${LUI_ContextPath}/km/carmng";
			   		window.open(srcUrl,"_self");
		   	   	}
			   	if(urlPara == 'evaluation' ||urlPara == 'info' || urlPara == 'infringeInfo' || urlPara == 'insuranceInfo' || urlPara == 'maintenanceInfo'|| urlPara == 'listByDispatchers' || urlPara == 'dispatchersInfo'){
					srcUrl = srcUrl + "km_carmng_"+prefix+"_ui"+"/index.jsp";
					window.open(srcUrl,"_self");
			   	}
		   	};
		});
</script>	
