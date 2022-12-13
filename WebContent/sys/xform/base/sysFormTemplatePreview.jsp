<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.edit" sidebar="auto">
	<template:replace name="title">
		<c:out value=""></c:out>
	</template:replace>
	<template:replace name="content">
		<script>
			Com_IncludeFile("data.js");
		</script>
		<html:form action="${_url}">
			<div id="sysDefineXform">
				<c:import url="/sys/xform/include/sysForm_edit.jsp"
					charEncoding="UTF-8">
					<c:param name="formName" value="${__formName}" />
					<c:param name="fdKey" value="${_fdKey}" />
					<c:param name="messageKey" value="" />
					<c:param name="useTab" value="false" />
				</c:import>
			</div>
		</html:form>
	</template:replace>
</template:include>