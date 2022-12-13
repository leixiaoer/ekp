<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="auto">
	<template:replace name="title">
		<c:out value="${ kmCarmngEvaluationForm.fdApplicationName } - ${ lfn:message('km-carmng:module.km.carmng') }"></c:out>
	</template:replace>
	<template:replace name="head">
		<script>
			seajs.use(['${KMSS_Parameter_ContextPath}sys/evaluation/import/resource/eval.css']);
		</script>
		<style>
		#eval_area .eval_star li{cursor: text}
		</style>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
		<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngEvaluation"/></p>
		
		<div style="background:#fff; padding:16px;">
			<html:form action="/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do">
				<html:hidden name="kmCarmngEvaluationForm" property="fdId"/>
				<div class="eval_EditMain" id="eval_EditMain">
				<table class="tb_normal" width=100%>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdAppNames"/>
						</td>
						<td width=85% colspan="3">
							<c:out value="${ kmCarmngEvaluationForm.fdApplicationName}" />
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore" />
						</td>
						<td width=85% colspan="3">
							<div id="eval_area">
								<sunbor:enumsShow value="${ kmCarmngEvaluationForm.fdEvaluationScore}" bundle="km-carmng" enumsType="kmCarmngEvaluation_score" />
								<ul class="eval_star">
									<li id="eval_star_1" star="1"></li>
									<li id="eval_star_2" star="2"></li>
									<li id="eval_star_3" star="3"></li>
									<li id="eval_star_4" star="4"></li>
									<li id="eval_star_5" star="5"></li>
								</ul>
							</div>
						</td>
					</tr>			
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent" />
						</td>
						<td width=85% colspan="3">
							<c:out value="${ kmCarmngEvaluationForm.fdEvaluationContent}" />
						</td>
					</tr>			
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluator"/>
						</td>
						<td width=35%>
							<c:out value="${ kmCarmngEvaluationForm.fdEvaluatorName}" />
						</td>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationTime"/>
						</td>
						<td width=35%>
							<c:out value="${ kmCarmngEvaluationForm.fdEvaluationTime}" />
						</td>
					</tr>
				</table>
				</div>
			</html:form>
			<script type="text/javascript">
				Com_IncludeFile("jquery.js");
			</script>
			<script type="text/javascript">
			window.onload = function(){
				setStart("${kmCarmngEvaluationForm.fdEvaluationScore}");
			}
			function setStart(val){
				for(var i=0; i<5; i++){
					var className = 'lui_icon_s_starbad';
					if(i < val ){
						className = 'lui_icon_s_stargood';
					}else{
						className = 'lui_icon_s_starbad';
					}
					$("#eval_EditMain  #eval_star_"+(i+1)).attr('class',className);
				}
			}
			</script>
		</div>
	</template:replace>
</template:include>

