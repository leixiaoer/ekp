<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<c:set var="tiny" value="true" scope="request" />
<template:include ref="mobile.list" file="/sys/mportal/module/mobile/jsp/module.jsp" canHash="true">
	<template:replace name="head">
		<script type="text/javascript">
			window.isLeader = false;
			<kmss:authShow roles="ROLE_KMSUPERVISE_LEADER">
				window.isLeader = true
			</kmss:authShow>
			window.canCreate = false;
			<kmss:authShow roles="ROLE_KMSUPERVISE_CREATE">
				window.canCreate = true;
			</kmss:authShow>
			console.log(window.isLeader,window.canCreate);
		</script>
		<mui:cache-file name="mui-supervise-list.js" cacheType="md5" />
		<mui:cache-file name="mui-supervise-index.css" cacheType="md5"/>
		<mui:cache-file name="mui-supervise-allSupervision.css" cacheType="md5"/>
		<mui:cache-file name="mui-supervise-list.css" cacheType="md5"/>
		<mui:cache-file name="mui-list.js" cacheType="md5" />
	</template:replace>
	<template:replace name="title">
		<bean:message bundle="km-supervise" key="module.km.supervise"/>
	</template:replace>
	<template:replace name="content">
		<div data-dojo-type="sys/mportal/module/mobile/Module"
			data-dojo-mixins="km/supervise/mobile/module/js/ModuleMixin"></div>
	</template:replace>
</template:include>