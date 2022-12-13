<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<script type="text/javascript">
	Response_IncludeJsFile(Com_Parameter.ContextPath+"km/pindagate/question_type_ui/fillquestions/fillquestion_response_script.js");
	Response_IncludeJsFile(Com_Parameter.ContextPath+"resource/js/calendar.js");
	
</script>
<script>Com_IncludeFile('calendar.js');</script>
<!-- <script id="calendar_js" src="/ekp/resource/js/calendar.js"></script> -->
<div id="${HtmlParam.divId}" class="pi_question" style="margin-top: -15px">
	<input type="hidden" name="fdItems[${HtmlParam.index}].fdAnswer" value="">
	<input type="hidden" name="fdItems[${HtmlParam.index}].fdAnswerTxt" value="">
	<input type="hidden" name="fdItems[${HtmlParam.index}].fdRelationHide" value="">
</div>