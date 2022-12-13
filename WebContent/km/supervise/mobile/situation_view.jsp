<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="com.landray.kmss.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
		<mui:min-file name="mui-supervise.js"/>
		<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/allSupervision.css?s_cache=${MUI_Cache}">
  	   	<link rel="stylesheet" href="${LUI_ContextPath}/km/supervise/mobile/resource/css/index.css?s_cache=${MUI_Cache}">
	</template:replace>
	<template:replace name="title">
		<bean:message key="mobile.backSituationView" bundle="km-supervise"/>
	</template:replace>
	<template:replace name="content">
		<div data-dojo-type="dojox/mobile/View">
			<div class="lui_db_flag_header">
		        <div class="lui_db_flag_header_wrap">
		          	<ul>
		            	<li class="lui_db_flag_header_item">
		              		<div>
		                		<p class="blue"><i></i><span><bean:message key="task.status.normal" bundle="km-supervise"/></span></p>
		                		<p class="purple"><i></i><span><bean:message key="task.status.soon.delay" bundle="km-supervise"/></span></p>
		                		<p class="red"><i></i><span><bean:message key="task.status.delay" bundle="km-supervise"/></span></p>
		              		</div>
		            	</li>
		            	<li class="lui_db_flag_header_item">
		              		<div>
		                		<p class="orange"><i></i><span><bean:message key="task.status.not.back" bundle="km-supervise"/></span></p>
		              		</div>
		           		</li>
		          	</ul>
		        </div>
		    </div>
		    <div class="lui_db_flag_content">
			    <ul data-dojo-type="mui/list/JsonStoreList" 
			    	data-dojo-mixins="km/supervise/mobile/resource/js/list/BackSituationItemListMixin"
			    	data-dojo-props="url:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getAllBackSituations&fdMainId=${param.fdMainId}',lazy:false">
				</ul>
			</div>
		</div>
	</template:replace>
</template:include>