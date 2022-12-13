<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/review/resource/style/doc/banner.css"/>
<c:set var="__kmReviewMainForm" value="${requestScope[param.formName]}" />
<!-- #130192-流程状态图标在没有展现的查看页面也显示了属性，应该去除-开始 -->
<c:if test="${__kmReviewMainForm.docStatus eq '30' || __kmReviewMainForm.docStatus eq '00'}">
<!-- #130192-流程状态图标在没有展现的查看页面也显示了属性，应该去除-结束 -->
	<div class="lbpm_flowInfoW">
		<c:if test="${__kmReviewMainForm.docStatus eq '30'}">
	   		<div class="lbpmProcessStatus">
	   			<div class="lbpmProcessText"><bean:message bundle="km-review" key="kmReviewMain.processStatus.end" /></div>
	      	</div>
	    </c:if>
	   	<c:if test="${__kmReviewMainForm.docStatus eq '00'}">
	    	<div class="lbpmProcessStatus lbpmDiscardStatus">
	      		<div class="lbpmProcessText"><bean:message bundle="km-review" key="kmReviewMain.processStatus.discard" /></div>
	      	</div>
	   	</c:if>
	</div>
	<c:if test="${param.approveType eq 'right'}">
	 	<script>
	 		$(function(){
	 			$(".lbpm_flowInfoW").css("top","2px")
	 		});
	 	</script>
	</c:if>
<!-- #130192-流程状态图标在没有展现的查看页面也显示了属性，应该去除-开始 -->
</c:if>
<!-- #130192-流程状态图标在没有展现的查看页面也显示了属性，应该去除-结束 -->