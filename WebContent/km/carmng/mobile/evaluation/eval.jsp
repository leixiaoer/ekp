<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div class="muiDialogElementContainer muiCarDialog" style="transform: translateX(-50%) translateY(-50%);position: absolute;left: 50%;top: 50%">
	<span class="muiCarDialogCloseBtn">
		<i class="mui mui-addIco mui-rotate-45"></i>
	</span>
	<div class="muiCarDialogHeader">
	</div>
	<div class="muiCarDialogContent">
		<!-- 点评 -->
		<div id="eval_star_opt" class="muiRating" style="position: relative;"
			data-dojo-type="!{starklass}" 
			data-dojo-props="value:4,editable:true">
		</div>
		<!-- 点评 -->
		<div class="muiEvalLevel">————<span class="muiEvalLevelText">满意</span>————</div>
		<div class="muiEvalContent">
			<textarea name="fdEvaluationContent" placeholder="说点什么吧... " class="muiEvalMaskText"></textarea>
		</div>
	</div>
	<div class="muiCarDialogFooter">
		<span class="muiEvalSubmit muiCarDialogBtn">提交</span>
	</div>
</div>
