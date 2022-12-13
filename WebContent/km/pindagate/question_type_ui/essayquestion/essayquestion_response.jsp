<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script>
	Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type_ui/essayquestion/essayquestion_response_script.js");
</script>
<div id="${HtmlParam.divId}" class="pi_question">
	<input type="hidden" name="fdItems[${HtmlParam.index}].fdAnswerTxt" value="">
	<input type="hidden" name="fdItems[${HtmlParam.index}].fdRelationHide" value="">
</div>
