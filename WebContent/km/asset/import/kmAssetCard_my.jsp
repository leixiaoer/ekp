<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include  ref="default.simple">
	<template:replace name="body">
		<div style="width:100%;">
			<ui:iframe src="${LUI_ContextPath }/km/asset/km_asset_card_ui/kmAssetApplyCard_base.jsp?mode=myCard&fdResponsiblePerson=${param.fdResponsiblePerson }"></ui:iframe>
		</div> 
	</template:replace>
</template:include>