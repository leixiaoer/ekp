<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<ul>
	<li>
		<textarea name="fdRemark" placeholder="<bean:message bundle="sys-evaluation" key="mui.sysEvaluation.mobile.reply"/>" class="muiEvalMaskText"></textarea>
	</li>
	<li class="muiEvalGradeBar" >
		<div class="muiEvalGradeLeft" data-mark="muiEvalGrade" style="display:!{startShow}">
			<span><bean:message bundle="sys-evaluation" key="mui.sysEvaluation.mobile.eval.score"/>:</span>
			<span id="eval_star_opt" 
				data-dojo-type="!{starklass}" 
				data-dojo-props="value:4,editable:true">
			</span>
			<span id="contentLength" style="color: red;"></span>
		</div>
		<div class="muiEvalGradeLeft" data-mark="muiEvalAdd" style="display:!{additionTxtShow}">
			${lfn:message('sys-evaluation:sysEvaluationMain.addition') }
		</div>
		
		<div class="muiEvalGradeRight" >
			<div class="muiEvalSubmit"><bean:message bundle="sys-evaluation" key="mui.sysEvaluation.mobile.eval.submit"/></div>
		</div>
	</li>
	<li class="muiEvalHideMask"><div class="mui-down-n mui"></div></li>
</ul>