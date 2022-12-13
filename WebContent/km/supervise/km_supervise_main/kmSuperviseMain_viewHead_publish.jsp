<%@page import="com.landray.kmss.sys.lbpmservice.support.model.LbpmSetting"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
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
            seajs.use(['sys/ui/js/dialog','lui/topic'], function(dialog,topic) {
            	//催办
                window.urgeSupervise = function(){
                	dialog.iframe('/km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=showUrgeSupervise&fdMainIds=${param.fdId}',
                			'新建催办',null,{width:800,height:360});
              	}
            	//反馈情况一览表
                window.backSituationView = function(){
                	dialog.iframe("/km/supervise/km_supervise_main/import/back_situation_view_iframe.jsp?fdMainId=${param.fdId}",
                   			'反馈情况一览表',null,{width:800,height:560});
                }
                
            });
          	
            //督办办结
            function finishSupervise(){
            	if(repeat("com.landray.kmss.km.supervise.model.KmSuperviseMainFinish","kmSuperviseMainFinish","0")){
            		if(repeat("com.landray.kmss.km.supervise.model.KmSuperviseMainStop","kmSuperviseMainStop","1")){
		            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do" />?method=add&fdMainId=${param.fdId}','_self');
            		}
            	}
            }
            //督办终止
            function stopSupervise(){
            	if(repeat("com.landray.kmss.km.supervise.model.KmSuperviseMainStop","kmSuperviseMainStop","0")){
            		if(repeat("com.landray.kmss.km.supervise.model.KmSuperviseMainFinish","kmSuperviseMainFinish","1")){
		            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do" />?method=add&fdMainId=${param.fdId}','_self');
            		}
            	}
            }
          	//督办考评
            function remarkSupervise(){
            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_main_remark/kmSuperviseMainRemark.do" />?method=add&fdMainId=${param.fdId}','_self');
            }
            //督办变更
            function changeSupervise(){
            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do" />?method=changeSupervise&fdOriginId=${param.fdId}&fdMainId=${param.fdId}','_self');
            }

            //0:任务反馈;1:阶段反馈
            function updateAddFeedback(fdType){
            	Com_OpenWindow('<c:url value="/km/supervise/km_supervise_back/kmSuperviseBack.do" />?method=add&fdType='+fdType+'&fdMainId=${param.fdId}&fdIsNew=true');
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
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
        </script>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;"></ui:toolbar>
		</c:if>
        <c:if test="${kmSuperviseMainForm.docDeleteFlag !=1}">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="6" var-navwidth="90%" style="display:none;">
            <!--关注-->
            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddConcern&fdId=${param.fdId}">
            	<c:if test="${kmSuperviseMainForm.isConcern == 'false' && kmSuperviseMainForm.docStatus!='10' }">
                	<ui:button text="${lfn:message('km-supervise:py.GuanZhu')}" onclick="updateConcern('addConcern');" order="2" id="attention"/>
                </c:if>
                <c:if test="${kmSuperviseMainForm.isConcern == 'true' }">
                	<ui:button text="${lfn:message('km-supervise:py.cancelGuanZhu')}" onclick="updateConcern('deleteConcern');" order="2" id="disAttention"/>
                </c:if>
            </kmss:auth>
            <c:if test="${kmSuperviseMainForm.docStatus=='30' && kmSuperviseMainForm.docStatus!='40' && kmSuperviseMainForm.docStatus!='50'}">
	            <!--催办-->
	            <kmss:auth
					requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=urgeSupervise&fdId=${param.fdId}" requestMethod="GET">
					<ui:button order="2" text="${ lfn:message('km-supervise:py.CuiBan') }" onclick="urgeSupervise()">
					</ui:button>
				</kmss:auth>
	            <!--督办办结-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddFinish&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanBanJie')}" onclick="finishSupervise();" order="2" />
	            </kmss:auth>
	            <!--督办变更-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=changeSupervise&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanBianGeng')}" onclick="changeSupervise();" order="2" />
	            </kmss:auth>
	            <!--督办终止-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddStop&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanZhongZhi')}" onclick="stopSupervise();" order="2" />
	            </kmss:auth>
            </c:if>
            <c:if test="${kmSuperviseMainForm.docStatus=='40' && kmSuperviseMainForm.fdRemarkStatus!='1' }">
            	<!--督办考评-->
	            <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRemark&fdId=${param.fdId}">
	                <ui:button text="${lfn:message('km-supervise:py.DuBanKaoPing')}" onclick="remarkSupervise();" order="2" />
	            </kmss:auth>
            </c:if>
            <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
                <!--edit-->
                <kmss:auth requestURL="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('kmSuperviseMain.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
            </c:if>
            <c:if test="${kmSuperviseMainForm.docStatus!='60'}">
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