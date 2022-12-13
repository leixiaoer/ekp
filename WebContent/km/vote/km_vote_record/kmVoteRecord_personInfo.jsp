<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view"  sidebar="no" showQrcode="false">	
	<%-- 标签页标题--%>
	<template:replace name="title">
		<c:out value="${lfn:message('km-vote:kmVoteRecord.viewPersonDetail')}"></c:out>
	</template:replace>
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="5">
		<%--关闭--%>
		<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
		<br/>
		<p class="txttitle"><bean:message bundle="km-vote" key="kmVoteRecord.viewPersonDetail"/></p>
		<table class="tb_normal"  width="95%"  >
			<tr>
				<%--已调查人员--%>
				<td width="15%" class="td_normal_title">
					<bean:message bundle="km-vote" key="kmVoteRecord.already" />(${alreadyNum}/${allNum}):
				</td>
				<td width="85%" >
					<div id="personInfo" style="margin-top: 0px;word-break: break-all;">
						${already}
					</div>
				</td>
			</tr>	
			<tr>
				<%--未调查人员--%>
				<td width="15%" class="td_normal_title">
					<bean:message bundle="km-vote" key="kmVoteRecord.absent" />(${absentNum}/${allNum}):
				</td>
				<td width="85%" >
					<div id="personInfo" style="margin-top: 0px;word-break: break-all;">
						${absent}
					</div>
				</td>
			</tr>
		</table>
		<br/><br/>
	</template:replace>
	
</template:include>