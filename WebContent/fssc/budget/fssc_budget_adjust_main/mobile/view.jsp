<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person" %>
<%@page import="com.landray.kmss.fssc.budget.util.FsscBudgetUtil" %>
<template:include ref="mobile.view" compatibleMode="true">
		<template:replace name="loading">
				<c:import url="/fssc/budget/fssc_budget_adjust_main/mobile/view_banner.jsp"
					charEncoding="UTF-8">
					<c:param name="formBeanName" value="fsscBudgetAdjustMainForm"></c:param>
					<c:param name="loading" value="true"></c:param>
				</c:import>
		</template:replace>
        <template:replace name="title">
            <c:out value="${fsscBudgetAdjustMainForm.docSubject} - " />
            <c:out value="${lfn:message('fssc-budget:table.fsscBudgetAdjustMain') }" />
        </template:replace>
        <template:replace name="head">
            <style>
                .detailTips{
                				color: red;
                	    		font-weight: lighter;
                	    		display: inline-block;
                	    		font-size: 1rem;
                			}
                			.muiFormNoContent{
                				padding-left:1rem;
                				border-top:1px solid #ddd;
                				border-bottom: 1px solid #ddd;
                			}
                			.muiDocFrameExt{
                				margin-left: 0rem;
                			}
                			.muiDocFrameExt .muiDocInfo{
                				border: none;
                			}
            </style>
            <script type="text/javascript">
	            require(["dojo/store/Memory","dojo/topic", "dojo/ready"],function(Memory, topic,ready){
	    	   		window._narStore = new Memory({data:[{'text':'${lfn:message("sys-mobile:mui.mobile.info")}',
	    	   			'moveTo':'_contentView','selected':true},{'text':'${lfn:message("sys-mobile:mui.mobile.review.record")}',
	    	   			'moveTo':'_noteView'}]});
	    	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	    	   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
	    	   		});
	    	   		ready(function() {
						var dimensions="${dimensions}";
						var adjustType="${adjustType}";
						if(dimensions){
							var dimension=dimensions.split(";");
							for(var i=0;i<dimension.length;i++){
								if(adjustType=='1'){//调整
									$(".borrowclass"+dimension[i]).attr("style","");
									$(".lendclass"+dimension[i]).attr("style","");
								}else{//追加
									$(".borrowclass"+dimension[i]).attr("style","");
								}
							}
						}
					});
	    	   	});
                var formInitData = {
                		
                };
                var lang = {
                    "the": "${lfn:message('page.the')}",
                    "row": "${lfn:message('page.row')}"
                };
                var messageInfo = {

                    'fdDetailList': '${lfn:escapeJs(lfn:message("fssc-budget:table.fsscBudgetAdjustDetail"))}'
                };
                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
                Com_IncludeFile("mobile_edit.js", "${LUI_ContextPath}/fssc/budget/resource/js/", 'js', true);
                Com_IncludeFile("form_option.js", "${LUI_ContextPath}/fssc/budget/fssc_budget_adjust_main/", 'js', true);
            </script>
        </template:replace>
        <template:replace name="content">
            <html:form action="/fssc/budget/fssc_budget_adjust_main/fsscBudgetAdjustMain.do">
                <div id="scrollView" data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin">
                <c:import url="/fssc/budget/fssc_budget_adjust_main/mobile/view_banner.jsp" charEncoding="UTF-8">
					<c:param name="formBeanName" value="fsscBudgetAdjustMainForm"></c:param>
				</c:import>
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore"
							data-dojo-props="store:_narStore"></div>
					</div>
				</div>
                <div data-dojo-type="dojox/mobile/View" id="_contentView">
                    <div data-dojo-type="mui/panel/AccordionPanel">
                        <div data-dojo-type="mui/panel/Content" data-dojo-props="title:'${lfn:message('fssc-budget:py.JiBenXinXi') }',icon:'mui-ul'">
                                <table class="muiSimple" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.docSubject')}
                                        </td>
                                        <td>
                                            <div id="_xform_docSubject" _xform_type="text">
                                                <xform:text property="docSubject" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.docNumber')}
                                        </td>
                                        <td>
                                            <c:out value="${fsscBudgetAdjustMainForm.docNumber}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.docTemplate')}
                                        </td>
                                        <td>
                                            <div id="_xform_docTemplateId" _xform_type="dialog">
                                                <c:out value="${fsscBudgetAdjustMainForm.docTemplateName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.fdBudgetScheme')}
                                        </td>
                                        <td>
                                            <c:out value="${fsscBudgetAdjustMainForm.fdBudgetSchemeName}"></c:out>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.fdCompany')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCompanyId" _xform_type="dialog">
                                                <c:out value="${fsscBudgetAdjustMainForm.fdCompanyName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.attBudget')}
                                        </td>
                                        <td>
                                            <c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
                                                <c:param name="formName" value="fsscBudgetAdjustMainForm" />
                                                <c:param name="fdKey" value="attBudget" />
                                            </c:import>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.fdDesc')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdDesc" _xform_type="textarea">
                                                <xform:textarea property="fdDesc" showStatus="view" mobile="true" style="width:95%;" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.fdCurrency')}
                                        </td>
                                        <td>
                                            <div id="_xform_fdCurrencyId" _xform_type="dialog">
                                                <c:out value="${fsscBudgetAdjustMainForm.fdCurrencyName}" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <%--预算调整明细 --%>
                                            ${lfn:message('fssc-budget:table.fsscBudgetAdjustDetail')}<br />
											<div data-dojo-type="mui/table/ScrollableHContainer">
												<%@include file="/fssc/budget/fssc_budget_adjust_main/mobile/detail.jsp"%>
											</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.docCreator')}
                                        </td>
                                        <td>
                                            <ui:person personId="${fsscBudgetAdjustMainForm.docCreatorId}" personName="${fsscBudgetAdjustMainForm.docCreatorName}" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="muiTitle">
                                            ${lfn:message('fssc-budget:fsscBudgetAdjustMain.docCreateTime')}
                                        </td>
                                        <td>
                                            <c:out value="${fsscBudgetAdjustMainForm.docCreateTime}"></c:out>
                                        </td>
                                    </tr>
                                </table>
                        </div>
                    </div>
                    </div>
                    <%--流程记录 --%>
					<div data-dojo-type="dojox/mobile/View" id="_noteView">
							<div class="muiFormContent muiFlowInfoW">
								<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
	                                <c:param name="fdModelId" value="${fsscBudgetAdjustMainForm.fdId}" />
	                                <c:param name="fdModelName" value="com.landray.kmss.fssc.budget.model.FsscBudgetAdjustMain" />
	                                <c:param name="formBeanName" value="fsscBudgetAdjustMainForm" />
	                            </c:import>
							</div>
					</div>
                    <template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp"  docStatus="${fsscBudgetAdjustMainForm.docStatus}"  editUrl="javascript:window.building();" formName="fsscBudgetAdjustMainForm" viewName="lbpmView" allowReview="true">
                        <template:replace name="flowArea">
                        </template:replace>
                    </template:include>
                </div>


                <c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="fsscBudgetAdjustMainForm" />
                    <c:param name="fdKey" value="fsscBudgetAdjustMain" />
                    <c:param name="backTo" value="scrollView" />
                    <c:param name="onClickSubmitButton" value="Com_Submit(document.fsscBudgetAdjustMainForm, 'update');" />
                </c:import>
                <script type="text/javascript">
                    require(["mui/form/ajax-form!fsscBudgetAdjustMainForm"]);
                </script>
            </html:form>
        </template:replace>
    </template:include>