<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.util.ResourceUtil"%>

<template:include ref="default.view">
    <template:replace name="head">
        <style type="text/css">
            
            			.lui_paragraph_title{
            				font-size: 15px;
            				color: #15a4fa;
            		    	padding: 15px 0px 5px 0px;
            			}
            			.lui_paragraph_title span{
            				display: inline-block;
            				margin: -2px 5px 0px 0px;
            			}
            			.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;margin-top:3px;float:left;}
						.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
						.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
        </style>
        <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
       <%--  <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/common.css?s_cache=${LUI_Cache}"/> --%>
    </template:replace>
    <template:replace name="title">
        <c:out value="${kmSuperviseMainForm.docSubject} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <template:replace name="toolbar">
        <script>
            function deleteDoc(delUrl) {
                seajs.use(['lui/dialog'], function(dialog) {
                	Com_Delete_Get(delUrl, 'com.landray.kmss.km.supervise.model.KmSuperviseMain');
                });
            }

            function openWindowViaDynamicForm(popurl, params, target) {
                var form = document.createElement('form');
                if(form) {
                    try {
                        target = !target ? '_blank' : target;
                        form.style = "display:none;";
                        form.method = 'post';
                        form.action = popurl;
                        form.target = target;
                        if(params) {
                            for(var key in params) {
                                var
                                v = params[key];
                                var vt = typeof
                                v;
                                var hdn = document.createElement('input');
                                hdn.type = 'hidden';
                                hdn.name = key;
                                if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                                    hdn.value =
                                    v +'';
                                } else {
                                    if($.isArray(
                                        v)) {
                                        hdn.value =
                                        v.join(';');
                                    } else {
                                        hdn.value = toString(
                                            v);
                                    }
                                }
                                form.appendChild(hdn);
                            }
                        }
                        document.body.appendChild(form);
                        form.submit();
                    } finally {
                        document.body.removeChild(form);
                    }
                }
            }

            function doCustomOpt(fdId, optCode) {
                if(!fdId || !optCode) {
                    return;
                }

                if(viewOption.customOpts && viewOption.customOpts[optCode]) {
                    var param = {
                        "List_Selected_Count": 1
                    };
                    var argsObject = viewOption.customOpts[optCode];
                    if(argsObject.popup == 'true') {
                        var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                        for(var arg in argsObject) {
                            param[arg] = argsObject[arg];
                        }
                        openWindowViaDynamicForm(popurl, param, '_self');
                        return;
                    }
                    var optAction = viewOption.basePath + '?method=' + optCode;
                    if(optCode == 'updateAddFeedback')
                    	optAction += '&fdMainId=' + fdId;
                    else
                    	optAction += '&fdId=' + fdId;
                    //Com_OpenWindow(optAction, '_self');
                    seajs.use(['lui/dialog'],function(dialog){
                    	dialog.iframe(optAction,viewOption.customOpts[optCode].title,function(value){
                    		if(((optCode == 'updateAddFinish' || optCode == 'updateAddRepeal' || optCode == 'updateAddRestart') && typeof(value) == "undefined") || value == 'success'){
                    			setTimeout(function (){
           						 location.reload();
           						}, 1000);
                    		}
                    	},{
        					"width" : 1010,
        					"height" : 600
        				});
                    });
                }
            }
            window.doCustomOpt = doCustomOpt;
            var viewOption = {
                contextPath: '${LUI_ContextPath}',
                basePath: '/km/supervise/km_supervise_main/kmSuperviseMain.do',
                customOpts: {
                    updateAddConcern: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.GuanZhu')}"
                    },
                    updateAddTask: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.RenWuZhiPai')}"
                    },
                    updateUpdateTask: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.RenWuBianGeng')}"
                    },
                    updateUpdateDuty: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.ZeRenRenBianGeng')}"
                    },
                    updateAddFeedback: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.DuBanFanKui')}"
                    },
                    updateAddFinish: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.DuBanBanJie')}"
                    },
                    updateAddRepeal: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.DuBanCheXiao')}"
                    },
                    updateAddRemark: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.DuBanKaoPing')}"
                    },
                    updateAddRestart: {
                        popup: 'false',
                        title: "${lfn:message('km-supervise:py.DuBanChongQi')}"
                    },
                    ____fork__: 0
                }
            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
        </script>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;"></ui:toolbar>
		</c:if>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag !=1}">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6" var-navwidth="90%" style="display:none;">
			<!-- 督办重启 -->
			<c:if test="${kmSuperviseMainForm.docStatus=='50'}">
				<kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRestart&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanChongQi')}" onclick="doCustomOpt('${param.fdId}','updateAddRestart');" order="1" />
	            </kmss:auth>
			</c:if>
            <!--关注-->
            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${param.fdId}">
            	<c:if test="${kmSuperviseMainForm.isConcern == 'false' && kmSuperviseMainForm.docStatus!='10' }">
                	<ui:button text="${lfn:message('km-supervise:py.GuanZhu')}" onclick="updateConcern('addConcern');" order="1" id="attention"/>
                </c:if>
                <c:if test="${kmSuperviseMainForm.isConcern == 'true' }">
                	<ui:button text="${lfn:message('km-supervise:py.cancelGuanZhu')}" onclick="updateConcern('deleteConcern');" order="1" id="disAttention"/>
                </c:if>
            </kmss:auth>
            <c:if test="${kmSuperviseMainForm.docStatus=='30'}">
	            <!--任务指派-->
	            <kmss:authShow roles="ROLE_SYSTASK_DEFAULT">
		            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
		                <ui:button text="${lfn:message('km-supervise:py.RenWuZhiPai')}" onclick="addTask('${param.fdId}','addTaskPage');" order="2" />
		            </kmss:auth>
		            <!--任务变更-->
		            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateTask&fdId=${param.fdId}">
		                <ui:button text="${lfn:message('km-supervise:py.RenWuBianGeng')}" onclick="updateTask('${param.fdId}','updateTaskPage');" order="2" />
		            </kmss:auth>
	            </kmss:authShow>
	            <!--责任人变更-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateDuty&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.ZeRenRenBianGeng')}" onclick="updatePerform('${param.fdId}','updatePerformPage');" order="2" />
	            </kmss:auth>
	            <!--督办反馈-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFeedback&fdMainId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanFanKui')}" onclick="doCustomOpt('${param.fdId}','updateAddFeedback');" order="2" />
	            </kmss:auth>
            </c:if>
            <c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
	            <!--督办办结-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFinish&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanBanJie')}" onclick="doCustomOpt('${param.fdId}','updateAddFinish');" order="2" />
	            </kmss:auth>
	            <!--督办撤销-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRepeal&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanCheXiao')}" onclick="doCustomOpt('${param.fdId}','updateAddRepeal');" order="2" />
	            </kmss:auth>
            </c:if>
            <c:if test="${kmSuperviseMainForm.docStatus=='40' && kmSuperviseMainForm.fdRemarkStatus!='1' }">
            	<!--督办考评-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRemark&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanKaoPing')}" onclick="doCustomOpt('${param.fdId}','updateAddRemark');" order="2" />
	            </kmss:auth>
            </c:if>
            <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
                <!--edit-->
                <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
            </c:if>
            <!--delete-->
            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=delete&fdId=${param.fdId}">
                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('kmSuperviseMain.do?method=delete&fdId=${param.fdId}');" order="5" />
            </kmss:auth>
            <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />
        </ui:toolbar>
   	</c:if>
    </template:replace>
    <template:replace name="path">
        <ui:combin ref="menu.path.category">
				<ui:varParams 
					moduleTitle="${ lfn:message('km-supervise:module.km.supervise') }" 
					modulePath="/km/supervise/" 
					modelName="com.landray.kmss.km.supervise.model.KmSuperviseTemplet" 
					autoFetch="false"
					href="/km/supervise/" 
					categoryId="${kmSuperviseMainForm.docTemplateId}" />
		</ui:combin>
    </template:replace>
    <template:replace name="content">
    	<%-- 软删除 --%>
		<c:import url="/sys/recycle/import/redirect.jsp">
			<c:param name="formBeanName" value="kmSuperviseMainForm"></c:param>
		</c:import>

        <c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
			<form name="kmSuperviseMainForm" method="post" action="<c:url value='/km/supervise/km_supervise_main/kmSuperviseMain.do'/>">
		</c:if>

            <ui:tabpage expand="false" var-navwidth="90%">
            	<p class="txttitle">
					<bean:write name="kmSuperviseMainForm" property="docSubject" />
				</p>
                <ui:content title="${ lfn:message('km-supervise:py.JiBenXinXi') }" expand="true">
                    <table class="tb_normal" width="100%">
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdLead')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdLeadId" _xform_type="address">
                                    <xform:address propertyId="fdLeadId" propertyName="fdLeadName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.docNumber')}
                            </td>
                            <td width="35%">
                                <div id="_xform_docNumber" _xform_type="text">
                                    <xform:text property="docNumber" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdUnitId" _xform_type="address">
                                    <xform:address propertyId="fdUnitId" propertyName="fdUnitName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdSponsor')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdSponsorId" _xform_type="address">
                                    <xform:address propertyId="fdSponsorId" propertyName="fdSponsorName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdResponsible')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdResponsibleId" _xform_type="address">
                                    <xform:address propertyId="fdResponsibleId" propertyName="fdResponsibleName" orgType="ORG_TYPE_ALL" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdRecipients')}
                            </td>
                            <td width="35%">
                                <c:out value="${kmSuperviseMainForm.fdRecipientNames }" />
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}
                            </td>
                            <td width="35%">
								<c:choose>
                                	<c:when test="${kmSuperviseMainForm.docStatus eq '30' }">
                                		<kmss:showTaskStatus taskStatus="2" showText= "true" />
                                	</c:when>
                                	<c:when test="${kmSuperviseMainForm.docStatus eq '40' }">
                                		<kmss:showTaskStatus taskStatus="3" showText= "true" />
                                	</c:when>
                                	<c:when test="${kmSuperviseMainForm.docStatus eq '50' }">
                                		<kmss:message bundle="km-supervise" key="enums.doc_status.50" />
                                	</c:when>
                                	<c:otherwise>
                                		<kmss:showTaskStatus taskStatus="1" showText= "true" />
                                	</c:otherwise>
                                </c:choose>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdSuperviseProgress')}
                            </td>
                            <td width="35%">
                            	<div id="_xform_fdStatus" _xform_type="text" style="float:left;">
	                                <c:out value="${kmSuperviseMainForm.fdSuperviseProgress}" />%
								</div>
								<div class='pro_barline'>
									<c:if test="${kmSuperviseMainForm.fdSuperviseProgress=='100' }">
										<div class='complete' style="width:${kmSuperviseMainForm.fdSuperviseProgress}%"></div>
									</c:if>
									<c:if test="${empty kmSuperviseMainForm.fdSuperviseProgress }">
										<div class='uncomplete' style="width:0%"></div>
									</c:if>
									<c:if test="${not empty kmSuperviseMainForm.fdSuperviseProgress && kmSuperviseMainForm.fdSuperviseProgress!='100' }">
										<div class='uncomplete' style="width:${kmSuperviseMainForm.fdSuperviseProgress}%"></div>
									</c:if>
								</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdLevelId" _xform_type="select">
                                    <xform:select property="fdLevelId" showStatus="view">
                                        <xform:beanDataSource serviceBean="kmSuperviseLevelService" selectBlock="fdId,fdName" />
                                    </xform:select>
                                </div>
                            </td>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdUrgency')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdUrgencyId" _xform_type="select">
                                    <xform:select property="fdUrgencyId" showStatus="view">
                                        <xform:beanDataSource serviceBean="kmSuperviseUrgencyService" selectBlock="fdId,fdName" />
                                    </xform:select>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdApprovalTime" _xform_type="datetime">
                                    <xform:datetime property="fdApprovalTime" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        	<td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}
                            </td>
                            <td width="35%">
                                <div id="_xform_fdFinishTime" _xform_type="datetime">
                                    <xform:datetime property="fdFinishTime" showStatus="view" style="width:95%;" dateTimeType="datetime" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.fdContent')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <div id="_xform_fdContent" _xform_type="textarea">
                                    <xform:textarea property="fdContent" showStatus="view" style="width:95%;" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_normal_title" width="15%">
                                ${lfn:message('km-supervise:kmSuperviseMain.attSupervise')}
                            </td>
                            <td colspan="3" width="85.0%">
                                <c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
                                    <c:param name="fdKey" value="attSupervise" />
                                    <c:param name="formBeanName" value="kmSuperviseMainForm" />
                                    <c:param name="fdMulti" value="true" />
                                </c:import>
                            </td>
                        </tr>
                        <!-- 督办来源 -->
                        <c:if test="${not empty kmSuperviseMainForm.fdModelId}">
	                       	<tr>
	                          <td class="td_normal_title" width="15%">
	                              ${lfn:message('km-supervise:kmSuperviseMain.source')}
	                          </td>
	                          <td colspan="3" width="85.0%">
	                                <a href="<c:url value="${kmSuperviseMainForm.fdSourceUrl}"/>" target="_blank">${kmSuperviseMainForm.fdSourceSubject}</a>
	                          </td>
	                      	</tr>
                      	</c:if>
                    </table>
                </ui:content>
                
                <!-- 判断底部菜单显示 -->
                <c:choose>
					<c:when test="${kmSuperviseMainForm.docStatus >= '30'}">
					    <c:set var="taskExpand" value="true"></c:set>
					    <c:set var="lbpmExpand" value="false"></c:set>
					</c:when>
					<c:otherwise>
					  	<c:set var="taskExpand" value="false"></c:set>
					    <c:set var="lbpmExpand" value="true"></c:set>
					</c:otherwise>
				</c:choose>
                
                <!-- 督办计划 -->
                <kmss:ifModuleExist  path = "/sys/task/">
                	<ui:content title="${ lfn:message('km-supervise:kmSuperviseMain.task.title') }" expand="${taskExpand }">
		               <ui:dataview>
							<ui:source type="AjaxJson">
								{url:'/sys/task/sys_task_main/sysTaskMain.do?method=findByModelId&fdModelId=${kmSuperviseMainForm.fdId }&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain'}
							</ui:source>
							<ui:render type="Template">
								<c:import url="/km/supervise/km_supervise_task/task_history.jsp" charEncoding="UTF-8"></c:import>
							</ui:render>
						</ui:dataview>
		            </ui:content>
				</kmss:ifModuleExist>

                <ui:content title="${lfn:message('km-supervise:kmSuperviseMain.fdContent')}" expand="true">
                    <c:if test="${kmSuperviseMainForm.docUseXform == 'false'}">
                        <table class="tb_normal" width=100%>
                            <tr>
                                <td colspan="4">
                                	<xform:rtf property="docXform" />
                                </td>
                            </tr>
                        </table>
                    </c:if>
                    <c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
                        <c:import url="/sys/xform/include/sysForm_view.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmSuperviseMainForm" />
                            <c:param name="fdKey" value="kmSuperviseMain" />
                            <c:param name="useTab" value="false" />
                        </c:import>
                    </c:if>
                </ui:content>
                <%-- 流程处理 --%>
				<c:choose>
                    <c:when test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
                        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmSuperviseMainForm" />
                            <c:param name="fdKey" value="kmSuperviseMain" />
                            <c:param name="isExpand" value="${lbpmExpand }" />
                            <c:param name="onClickSubmitButton" value="Com_Submit(document.kmSuperviseMainForm, 'publishSupervise');" />
                        </c:import>
                    </c:when>
                    <c:otherwise>
                        <c:import url="/sys/lbpmservice/import/sysLbpmProcess_view.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmSuperviseMainForm" />
                            <c:param name="fdKey" value="kmSuperviseMain" />
                            <c:param name="isExpand" value="${lbpmExpand }" />
                        </c:import>
                    </c:otherwise>
                </c:choose>
                

                <ui:content title="${ lfn:message('km-supervise:py.DuBanDongTai') }">
                	<ui:event event="show">
                		setTimeout(function() {
                			var div1 = $("#div1");
							var div2 = $("#div2");
							var div3 = $("#div3");
							var attFinish = $("#attFinish");
							var attRepeal = $("#attRepeal");
							var attRestart = $("#attRestart");
							div1.replaceWith(attFinish);
							div2.replaceWith(attRepeal);
							div3.replaceWith(attRestart);
                		},200);
                	</ui:event>
                	<div id="attFinish">
                    	<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
	                        <c:param name="fdKey" value="attFinish" />
	                        <c:param name="formBeanName" value="kmSuperviseMainForm" />
	                        <c:param name="fdMulti" value="true" />
	                    </c:import>
                    </div>
                    <div id="attRepeal">
                    	<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
	                        <c:param name="fdKey" value="attRepeal" />
	                        <c:param name="formBeanName" value="kmSuperviseMainForm" />
	                        <c:param name="fdMulti" value="true" />
	                    </c:import>
                    </div>
                    <div id="attRestart">
                    	<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
	                        <c:param name="fdKey" value="attRestart" />
	                        <c:param name="formBeanName" value="kmSuperviseMainForm" />
	                        <c:param name="fdMulti" value="true" />
	                    </c:import>
                    </div>
                    <ui:dataview>
						<ui:source type="AjaxJson">
							{url:'/km/supervise/km_supervise_dynamic/kmSuperviseDynamic.do?method=getDynamicBySupervise&superviseId=${JsParam.fdId }'}
						</ui:source>
						<ui:render type="Template">
							<c:import url="/km/supervise/resource/tmpl/dynamic.jsp" charEncoding="UTF-8"></c:import>
						</ui:render>
					</ui:dataview>
                </ui:content>
                <ui:content title="${ lfn:message('km-supervise:py.DuBanFanKui') }">
                    <ui:event event="show">
                    	document.getElementById("feedbackList").src = '<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain_inner_feedback.jsp" />?fdSuperviseId=${JsParam.fdId }';
                    </ui:event>
                    <iframe id="feedbackList" width=100% height=100% frameborder=0 scrolling=no></iframe>
                </ui:content>
                <%-- 督办考评 --%>
                <c:if test="${not empty kmSuperviseMainForm.fdRemarkStatus and kmSuperviseMainForm.fdRemarkStatus eq '1' }">
                	<ui:content title="${ lfn:message('km-supervise:py.DuBanKaoPing') }">
                		<c:import url="/km/supervise/km_supervise_main/kmSuperviseMain_inner_remark.jsp" charEncoding="UTF-8">
                            <c:param name="formName" value="kmSuperviseMainForm" />
                        </c:import>
                	</ui:content>
                </c:if>
                	<%-- 督办沟通 --%>
				<c:if test="${kmSuperviseMainForm.docStatus!='10'}">
					<kmss:ifModuleExist path = "/km/collaborate/">
						<%request.setAttribute("communicateTitle",ResourceUtil.getString("kmSuperviseMain.communicateTitle","km-supervise"));%>
							<c:import url="/km/collaborate/import/kmCollaborateMain_view.jsp" charEncoding="UTF-8">
								<c:param name="commuTitle" value="${communicateTitle}" />
								<c:param name="formName" value="kmSuperviseMainForm" />
								<c:param name="docSubject" value="${kmSuperviseMainForm.docSubject}" />
							</c:import>
					</kmss:ifModuleExist>
			    </c:if>
			    <%-- 权限 --%>
			    <c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
                    <c:param name="formName" value="kmSuperviseMainForm" />
                    <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
                </c:import>
            </ui:tabpage>
       <c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
			</form>
	   </c:if>	
    </template:replace>
	<template:replace name="nav">
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmSuperviseMainForm" />
		</c:import>
	</template:replace>
</template:include>
<script type="text/javascript">
seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/toolbar'], function($, dialog, topic, toolbar){

	//关注or取消关注
	window.updateConcern = function(method){
		 var del_load = dialog.loading();
		 var msg = '';
	     $.ajax({
	        	url:viewOption.contextPath + viewOption.basePath+'?method='+method,
	        	data:{"fdId":'${param.fdId}'},
	        	dataType:'json',
	        	type:'POST',
	        	success:function(data){
	            	del_load.hide();
	        		if(method == 'addConcern'){
	        			msg = '<bean:message bundle="km-supervise" key="kmSuperviseMain.concern.sucess"/>';
	        		}else{
	        			msg = '<bean:message bundle="km-supervise" key="kmSuperviseMain.source.failure"/>';
	        		}
	        		dialog.success(msg);
	        		if(method == 'addConcern'){
	        			LUI('toolbar').removeButton(LUI('attention'));
						LUI('toolbar').addButtons([toolbar.buildButton({text:'${lfn:message("km-supervise:py.cancelGuanZhu")}',id:'disAttention',click:'updateConcern("deleteConcern");',order:'1'})]);
	        		}else{
	        			LUI('toolbar').removeButton(LUI('disAttention'));
						LUI('toolbar').addButtons([toolbar.buildButton({text:'${lfn:message("km-supervise:py.GuanZhu")}',id:'attention',click:'updateConcern("addConcern");',order:'1'})]);
	        		}
	        		 
				/* 	setTimeout(function (){
						 location.reload();
					}, 1000); */
	        	},
	        	error:function(req){
	        		del_load.hide();
	        		if(req.responseJSON){
	        			var data = req.responseJSON;
	        			dialog.failure(data.title);
	        		}else{
	        			dialog.failure('操作失败');
	        		}
	        	}
	
	      });
	};
	
	//任务指派
	function addTask(fdId, method){
		var optAction = viewOption.basePath + '?method=' + method + '&fdId=' + fdId; 
		dialog.iframe(optAction,"${lfn:message('km-supervise:py.RenWuZhiPai')}",null,{
			width : 1010,
			height : 650
		});
	}
	window.addTask = addTask;
	
	//任务变更
	function updateTask(fdId, method){
		var optAction = viewOption.basePath + '?method=' + method + '&fdId=' + fdId; 
		dialog.iframe(optAction,"${lfn:message('km-supervise:py.RenWuBianGeng')}",null,{
			width : 1010,
			height : 650
		});
	}
	window.updateTask = updateTask;
	
	//责任人变更
	function updatePerform(fdId, method){
		var optAction = viewOption.basePath + '?method=' + method + '&fdId=' + fdId; 
		dialog.iframe(optAction,"${lfn:message('km-supervise:py.ZeRenRenBianGeng')}",null,{
			width : 1010,
			height : 650
		});
	}
	window.updatePerform = updatePerform;

});
	
</script>