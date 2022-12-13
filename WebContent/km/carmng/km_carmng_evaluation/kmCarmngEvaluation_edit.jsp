<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple" sidebar="no">
	<template:replace name="body">
	<script>
	seajs.use(['theme!form']);
	seajs.use(['${KMSS_Parameter_ContextPath}sys/evaluation/import/resource/eval.css']);
	</script>
	<%--满意度评价表单--%>
		<html:form action="/km/carmng/km_carmng_evaluation/kmCarmngEvaluation.do" >
			<div style="margin-top:15px;margin-bottom: 15px">
				<p class="txttitle"><bean:message  bundle="km-carmng" key="table.kmCarmngEvaluation"/></p>
			</div>
			<center>
				<div class="eval_EditMain" id="eval_EditMain">
					<table class="tb_simple" width=95%>
					<html:hidden property="fdId"/>
					<html:hidden property="fdApplicationId"/>
					<html:hidden property="fdEvaluatorId"/>
					<html:hidden property="fdEvaluatorName"/>
					<html:hidden property="fdEvaluationTime"/>
					<tr>
						<%--满意度--%>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore"/>
						</td>
						<td width=85% colspan="3">
							<div >
								<ul class="eval_star">
									<li id="eval_star_1" star="1"></li>
									<li id="eval_star_2" star="2"></li>
									<li id="eval_star_3" star="3"></li>
									<li id="eval_star_4" star="4"></li>
									<li id="eval_star_5" star="5"></li>
								</ul>
								<span id="eval_level" class="eval_level"></span>
							</div>
						 <sunbor:enums property="fdEvaluationScore" enumsType="kmCarmngEvaluation_score" elementType="select" elementClass="eval_hidden" value="1"/>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width=15%>
							<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent"/>
						</td>
						<td width=85% colspan=3>
							<xform:textarea property="fdEvaluationContent" style="width:95%;height:120px"></xform:textarea>		
						</td>
					</tr>
					
					</table>
				</div>
				<div style="padding-top:17px">
					   <ui:button text="${lfn:message('button.update')}"  onclick="submitForm();">
					   </ui:button>
				 </div>
			</center>
		</html:form>
		
		<script type="text/javascript">
			Com_IncludeFile("jquery.js|validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js|xform.js");
		</script>
		<script type="text/javascript">
			$KMSSValidation(document.forms['kmCarmngEvaluationForm']);//加载校验框架
			
			function eval_starChange(val, confirm){
				for(var i=0; i<5; i++){
					var className = 'lui_icon_s_starbad';
					if(i < val ){
						className = 'lui_icon_s_stargood';
					}else{
						className = 'lui_icon_s_starbad';
					}
					$("#eval_EditMain  #eval_star_"+(i+1)).attr('class',className);
				}
				
				if(confirm){
					$('select[name="fdEvaluationScore"]').val(val);
				}
				var level = $('#eval_level');
				level.removeClass("lui_icon_s_recommend");
				level.removeClass("lui_icon_s_poor");
				if(val < 3){
					level.addClass("lui_icon_s_poor");
				}else{
					level.addClass("lui_icon_s_recommend");
				}
				level.html($('select[name="fdEvaluationScore"] option:nth-child('+(val+1)+')').text());
			}
			
			seajs.use(['lui/dialog'],function(dialog){
				//提交评价
				window.submitForm = function(){
					Com_Submit(document.kmCarmngEvaluationForm, 'save');
				};
			});
			
			$(function () {
				var liArr = $('#eval_EditMain').find('.eval_star li'); 
				liArr.click(function(){
					var liObj = $(this);
					var val = liObj.attr("star");
					eval_starChange(parseInt(val, 10),true);
				});
				
				liArr.mouseover(function(){
					var liObj = $(this);
					var val = liObj.attr("star");
					eval_starChange(parseInt(val, 10),false);
				});
		
				liArr.mouseout(function(){
					var val = $('select[name="fdEvaluationScore"]').val();
					eval_starChange(parseInt(val, 10),false);
				});
				
				eval_starChange(4,true);
			});
			
		</script>
	</template:replace>
</template:include>