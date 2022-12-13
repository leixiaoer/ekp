<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils"%>

<div style="display: none;" id="eval_formData">
	<input type="hidden" name="fdId" /> 
	<input type="hidden" name="fdApplicationId" value="${param.fdApplicationId}"/>
	<input type="hidden" name="fdEvaluatorName" value="${KMSS_Parameter_CurrentUserName}" />
	<input type="hidden" name="fdEvaluationTime" /> 
	<input type="hidden" name="fdEvaluationScore" value="1" />
</div>
<li class="muiBtnSubmit" data-dojo-type="${LUI_ContextPath}/km/carmng/mobile/evaluation/Eval.js" data-dojo-props='colSize:2,transition:"slide"' onclick="doEvaluate()">
 评价
</li>