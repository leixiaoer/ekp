<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-carmng:module.km.carmng') }"/>
	</template:replace>
	 <template:replace name="head">
		<link rel="stylesheet" type="text/css" href="${ LUI_ContextPath}/km/carmng/mobile/css/view.css?s_cache=${MUI_Cache}" />
		<link rel="stylesheet" href="${LUI_ContextPath}/km/carmng/mobile/css/carlist.css?s_cache=${MUI_Cache}" />
	</template:replace>
	<template:replace name="content">
		<div id="scrollView"  data-dojo-type="mui/view/DocScrollableView">
			<div data-dojo-type="mui/panel/AccordionPanel">
				<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${ lfn:message('km-carmng:table.kmCarmngEvaluation') }',icon:'mui-ul'">
					<div class="muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdAppNames"/>
								</td><td>
									<c:out value="${kmCarmngEvaluationForm.fdApplicationName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationScore" />
								</td><td>
									<div class="muiFieldItem edit">
										<div class="muiFieldValue">
											<!-- 满意度 -->
											<div class="muiCarRateInfo">
												<em class="muiCarRateTitle">
													<sunbor:enumsShow value="${kmCarmngEvaluationForm.fdEvaluationScore}" bundle="km-carmng" enumsType="kmCarmngEvaluation_score" />	
												</em>
												<div class="muiRating" style="position: relative;">
													<div class="muiRatingArea">
														<i class="mui mui-star-off mui-2 muiRatingOff" score="1"></i>
														<i class="mui mui-star-off mui-2 muiRatingOff" score="2"></i>
														<i class="mui mui-star-off mui-2 muiRatingOff" score="3"></i>
														<i class="mui mui-star-off mui-2 muiRatingOff" score="4"></i>
														<i class="mui mui-star-off mui-2 muiRatingOff" score="5"></i>
													</div>
													<div class="muiRatingValue" style="width: ${(kmCarmngEvaluationForm.fdEvaluationScore)*2}0%;">
														<i class="mui mui-star-on mui-2 muiRatingOn" score="1"></i>
														<i class="mui mui-star-on mui-2 muiRatingOn" score="2"></i>
														<i class="mui mui-star-on mui-2 muiRatingOn" score="3"></i>
														<i class="mui mui-star-on mui-2 muiRatingOn" score="4"></i>
														<i class="mui mui-star-on mui-2 muiRatingOn" score="5"></i>
													</div>
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>			
							<tr>
								<td class="muiTitle">
									<bean:message bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationContent" />
								</td><td>
									<c:out value="${kmCarmngEvaluationForm.fdEvaluationContent}" />
								</td>
							</tr>			
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluator"/>
								</td><td>
									<c:out value="${kmCarmngEvaluationForm.fdEvaluatorName}" />
								</td>
							</tr>
							<tr>
								<td class="muiTitle">
									<bean:message  bundle="km-carmng" key="kmCarmngEvaluation.fdEvaluationTime"/>
								</td><td>
									<c:out value="${kmCarmngEvaluationForm.fdEvaluationTime}" />
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
		</div>
	</template:replace>
</template:include>
