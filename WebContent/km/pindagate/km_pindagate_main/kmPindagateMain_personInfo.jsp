<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="no" showQrcode="false">	
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-pindagate:kmPindagateMain.toolControl.participantsInfo') }-${ lfn:message('km-pindagate:module.km.pindagate') }"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
		<c:if test="${kmPindagateMainForm.docStatus=='31'}">
			<kmss:auth
				requestURL="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=pressAbsentAll" requestMethod="GET">	
					<ui:button text="${lfn:message('km-pindagate:button.pressAbsent')}" 
						onclick="Com_OpenWindow('kmPindagateMain.do?method=pressAbsent&fdId=${JsParam.fdId}');" order="2">
					</ui:button>
			</kmss:auth>
		</c:if>
		<%--关闭--%>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
		<br/>
		<p class="txttitle"><bean:message bundle="km-pindagate" key="kmPindagateMain.toolControl.participantsInfo"/></p>
		<table class="tb_normal"  width="95%"  >
			<tr>
				<%--已调查人员--%>
				<td width="15%" class="td_normal_title">
					<bean:message bundle="km-pindagate" key="kmPindagate.indagated.persons" />
				</td>
				<td width="85%" >
					<iframe id="participateIframe" allowTransparency="true" width="100%" height="100%" 
						marginheight="0" marginwidth="0" scrolling=no frameborder=0 
						src='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=viewIndagatePersonInfo&fdId=${kmPindagateMainForm.fdId}&flag=already'></iframe>
				</td>
			</tr>	
			<tr>
				<%--未调查人员--%>
				<td width="15%" class="td_normal_title">
					<bean:message bundle="km-pindagate" key="kmPindagate.indagating.persons" />
				</td>
				<td width="85%" >
					<iframe id="notInvolvedIframe" allowTransparency="true" width="100%" height="100%" 
						marginheight="0" marginwidth="0" scrolling=no frameborder=0 
						src='<c:url value="/km/pindagate/km_pindagate_main/kmPindagateMain.do" />?method=viewIndagatePersonInfo&fdId=${kmPindagateMainForm.fdId}&flag=absent'></iframe>
				</td>
			</tr>
		</table>
		<br/><br/>
	</template:replace>
	
</template:include>