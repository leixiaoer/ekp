<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
	<template:replace name="head">
	    <link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
	</template:replace>
    <template:replace name="title">
        <c:out value="${kmSuperviseMainForm.docSubject} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
    <template:replace name="toolbar">
        <script>
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            
            function deleteDoc(delUrl) {
                seajs.use(['lui/dialog'], function(dialog) {
                	Com_Delete_Get(delUrl, 'com.landray.kmss.km.supervise.model.KmSuperviseMain');
                });
            }
            
            //任务指派
            function addTask(isAdd){
            	if(repeat("com.landray.kmss.km.supervise.model.KmSuperviseMainPlan","kmSuperviseMainPlan","0")){
	            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do" />?method=add&fdMainId=${param.fdId}&isAdd='+isAdd);
            	}
            }
            //查询是否存在未终止流程
            function repeat(fdModelName,modelName,type){
                var flag = false;
                $.ajax({
                    url: "${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getLbpmRepeat",
                    dataType : 'json',
                    type : 'post',
                    data:{ "fdMainId":"${param.fdId}","fdModelName":fdModelName,"modelName":modelName,"type":type },
                    async : false,
                    success : function(rtn){
                        if(!rtn.status){
                            seajs.use(['lui/dialog'], function(dialog) {
                              dialog.alert(rtn.error);
                            });
                        }
                        falg = rtn.status;
                    }
                });
                return falg;
            }
        </script>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;"></ui:toolbar>
		</c:if>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag !=1}">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6" var-navwidth="90%" style="display:none;">
            <c:if test="${kmSuperviseMainForm.docStatus=='30'}">
	            <c:if test="${kmSuperviseMainForm.fdIsPlan eq false}">
	            	<c:choose>
	            		<c:when test="${ empty kmSuperviseMainForm.fdItems}">
		            		<!--任务指派-->
				            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
				                <ui:button text="${lfn:message('km-supervise:py.RenWuZhiPai')}" onclick="addTask('true');" order="5" />
				            </kmss:auth>
	            		</c:when>
	            		<c:otherwise>
	            			<!--任务指派-->
				            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addTask&fdId=${param.fdId}">
				                <ui:button text="${lfn:message('km-supervise:py.RenWuZhiPai')}" onclick="addTask('false');" order="5" />
				            </kmss:auth>
	            		</c:otherwise>
	            	</c:choose>
	            </c:if>
            </c:if>
            <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
                <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
            </c:if>
            <c:if test="${ kmSuperviseMainForm.docStatus=='10'}">
	            <!--delete-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=delete&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('kmSuperviseMain.do?method=delete&fdId=${param.fdId}');" order="5" />
	            </kmss:auth>
            </c:if>
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