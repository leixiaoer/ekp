<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

    <% pageContext.setAttribute("currentUser", UserUtil.getKMSSUser()); %>
    
<template:include ref="default.edit">
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
            		
        </style>
        <script type="text/javascript">
            var formInitData = {

            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_main/", 'js', true);
            
            function selectDept(){
	        	var url = "${KMSS_Parameter_ContextPath}km/supervise/km_supervise_main/kmSuperviseMain.do?method=getApplicantDept";
	        	var fdSponsorId = document.getElementsByName("fdSponsorId")[0];
	        	 $.ajax({     
	           	     type:"post",   
	           	     url:url,     
	           	     data:{fdSponsorId:fdSponsorId.value},    
	           	     async:false,    //用同步方式 
	           	     success:function(data){
	           	 	    var results =  eval("("+data+")");
	           	 	    if(results['deptId']!=""&&results['deptName']!=""){
	           	 	    	var kmssData = new KMSSData();
	      	          		kmssData.AddHashMap({deptId:results['deptId'],deptName:results['deptName']});
	      	          		kmssData.PutToField("deptId:deptName", "fdUnitId:fdUnitName", "", false);
	           	   	 	}else{
	           	   	 		//emptyNewAddress('fdUnitName',null,0);
		           	   	 	var address = Address_GetAddressObj("fdUnitName");
		    				address.emptyAddress(true);
	           	   	 	}
	           		 }    
	             });
	        }
        </script>
    </template:replace>
    <c:if test="${kmSuperviseMainForm.method_GET == 'edit' || (param['i.docTemplate']!=null && param['i.docTemplate']!='')}">
        <template:replace name="title">
            <c:choose>
                <c:when test="${kmSuperviseMainForm.method_GET == 'add' }">
                    <c:out value="${ lfn:message('operation.create') } - ${ lfn:message('km-supervise:module.km.supervise') }" />
                </c:when>
                <c:otherwise>
                    <c:out value="${kmSuperviseMainForm.docSubject} - " />
                    <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
                </c:otherwise>
            </c:choose>
        </template:replace>
        <template:replace name="toolbar">
        <c:if test="${kmSuperviseMainForm.docDeleteFlag ==1}">
			<ui:toolbar id="toolbar" style="display:none;"></ui:toolbar>
		</c:if>
		<c:if test="${kmSuperviseMainForm.docDeleteFlag !=1}">
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
                <c:choose>
                    <c:when test="${ kmSuperviseMainForm.method_GET == 'edit' }">
                        <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' }">
                            <ui:button text="${ lfn:message('button.savedraft') }" onclick="submit('${kmSuperviseMainForm.docStatus}','update',true);" />
                        </c:if>
                        <c:if test="${ kmSuperviseMainForm.docStatus=='10' || kmSuperviseMainForm.docStatus=='11' || kmSuperviseMainForm.docStatus=='20' }">
                            <ui:button text="${ lfn:message('button.submit') }" onclick="submit('20','update');" />
                        </c:if>
                    </c:when>
                    <c:when test="${ kmSuperviseMainForm.method_GET == 'add' }">
                        <ui:button text="${ lfn:message('button.savedraft') }" order="2" onclick="_saveDraft();" />
                        <ui:button text="${ lfn:message('button.submit') }" order="2" onclick="submit('20','save');" />
                    </c:when>
                </c:choose>

                <ui:button text="${ lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
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
						categoryId="${kmSuperviseMainForm.docTemplateId}" />
			</ui:combin>
	    </template:replace>
        <template:replace name="content">
		<%-- 软删除 --%>
	    <c:import url="/sys/recycle/import/redirect.jsp">
			<c:param name="formBeanName" value="kmSuperviseMainForm"></c:param>
		</c:import>        
            <html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">

                <ui:tabpage expand="false" var-navwidth="90%">
                    <ui:content title="${ lfn:message('km-supervise:py.JiBenXinXi') }" expand="true">
                    	<div id="kmSuperviseDiv">
                        <table class="tb_normal" width="100%" >
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.docSubject')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <div id="_xform_docSubject" _xform_type="text">
                                        <xform:text property="docSubject" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdLead')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdLeadId" _xform_type="address">
                                        <xform:address propertyId="fdLeadId" propertyName="fdLeadName" orgType="ORG_TYPE_PERSON" showStatus="edit" required="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdLead')}" style="width:95%;" />
                                    </div>
                                </td>
                            	<td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.docNumber')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_docNumber" _xform_type="text">
                                        <c:choose>
											<c:when test='${kmSuperviseMainForm.docNumber!=null}'>
											    <xform:text property="docNumber" showStatus="view" style="width:95%;" />
											</c:when>
											<c:otherwise>
												<bean:message bundle="km-supervise" key="kmSuperviseMain.auto.number" />
											</c:otherwise>
										</c:choose>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdSponsor')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdSponsorId" _xform_type="address">
                                        <xform:address propertyId="fdSponsorId" propertyName="fdSponsorName" orgType="ORG_TYPE_PERSON" showStatus="edit" required="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor')}" style="width:95%;" onValueChange="selectDept"/>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdUnitId" _xform_type="address">
                                        <xform:address propertyId="fdUnitId" propertyName="fdUnitName" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" showStatus="edit" required="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdUnit')}" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdResponsible')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdResponsibleId" _xform_type="address">
                                        <xform:address propertyId="fdResponsibleId" propertyName="fdResponsibleName" orgType="ORG_TYPE_PERSON" showStatus="edit" required="true" subject="${lfn:message('km-supervise:kmSuperviseMain.fdResponsible')}" style="width:95%;" />
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdRecipients')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdRecipientIds" _xform_type="address">
                                        <xform:address propertyId="fdRecipientIds" propertyName="fdRecipientNames" mulSelect="true" orgType="ORG_TYPE_ALL" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdLevel')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdLevelId" _xform_type="select">
                                        <xform:select property="fdLevelId" showStatus="edit">
                                            <xform:beanDataSource serviceBean="kmSuperviseLevelService" selectBlock="fdId,fdName" whereBlock="fdIsAvailable=true" orderBy="fdOrder" />
                                        </xform:select>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdUrgency')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdUrgencyId" _xform_type="select">
                                        <xform:select property="fdUrgencyId" showStatus="edit">
                                            <xform:beanDataSource serviceBean="kmSuperviseUrgencyService" selectBlock="fdId,fdName" whereBlock="fdIsAvailable=true" orderBy="fdOrder" />
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
                                        <xform:datetime property="fdApprovalTime" showStatus="edit" dateTimeType="datetime" style="width:95%;" required="true"/>
                                    </div>
                                </td>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}
                                </td>
                                <td width="35%">
                                    <div id="_xform_fdFinishTime" _xform_type="datetime">
                                        <xform:datetime property="fdFinishTime" showStatus="edit" dateTimeType="datetime" style="width:95%;" validators="finishTimeValidator _finishTimeValidator" required="true" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.fdContent')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <div id="_xform_fdContent" _xform_type="textarea">
                                        <xform:textarea property="fdContent" showStatus="edit" style="width:95%;" />
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_normal_title" width="15%">
                                    ${lfn:message('km-supervise:kmSuperviseMain.attSupervise')}
                                </td>
                                <td colspan="3" width="85.0%">
                                    <c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
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
	                                	<html:hidden property="fdModelId" />
		  								  <html:hidden property="fdModelName" />
	                                      <a href="<c:url value="${kmSuperviseMainForm.fdSourceUrl}"/>" target="_blank">${kmSuperviseMainForm.fdSourceSubject}</a>
	                                </td>
	                            </tr>
                            </c:if>
                        </table>
                        </div>
                    </ui:content>
                    <ui:content title="${lfn:message('km-supervise:kmSuperviseMain.fdContent')}" expand="true">
                        <c:if test="${kmSuperviseMainForm.docUseXform == 'false'}">
                            <table class="tb_normal" width=100%>
                                <tr>
                                    <td colspan="2">
                                        <kmss:editor property="docXform" width="95%" />
                                    </td>
                                </tr>
                            </table>
                        </c:if>
                        <c:if test="${kmSuperviseMainForm.docUseXform == 'true' || empty kmSuperviseMainForm.docUseXform}">
                            <c:import url="/sys/xform/include/sysForm_edit.jsp" charEncoding="UTF-8">
                                <c:param name="formName" value="kmSuperviseMainForm" />
                                <c:param name="fdKey" value="kmSuperviseMain" />
                                <c:param name="useTab" value="false" />
                            </c:import>
                        </c:if>
                    </ui:content>
                    <c:import url="/sys/lbpmservice/import/sysLbpmProcess_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmSuperviseMainForm" />
                        <c:param name="fdKey" value="kmSuperviseMain" />
                        <c:param name="isExpand" value="true" />
                    </c:import>

                    <c:import url="/sys/right/import/right_edit.jsp" charEncoding="UTF-8">
                        <c:param name="formName" value="kmSuperviseMainForm" />
                        <c:param name="moduleModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseMain" />
                    </c:import>

                </ui:tabpage>
                <html:hidden property="fdId" />
                <html:hidden property="docStatus" />
                <html:hidden property="method_GET" />
            </html:form>
        </template:replace>
		<template:replace name="nav">
			<%--关联机制(与原有机制有差异)--%>
			<c:import url="/sys/relation/import/sysRelationMain_edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainForm" />
			</c:import>
		</template:replace>
    </c:if>
</template:include>
<script type="text/javascript">
	function _saveDraft(){
		var _validation = $KMSSValidation(document.forms['kmSuperviseMainForm']);
		_validation.removeElements($('#kmSuperviseDiv')[0],'required');
		Com_Submit(document.kmSuperviseMainForm, 'save');
	}
	
	seajs.use(['lui/jquery','lui/dialog'],function($,dialog){
		
		window.submit = function(status, method, isDraft){
			var _validation = $KMSSValidation(document.forms['kmSuperviseMainForm']);
			//完成时限在立项时间和当前时间之后
		    _validation.addValidator('finishTimeValidator','完成时限在立项时间和当前时间之后',function(v,e,o){
		    	var input = Com_GetDate(v);
				var fdApprovalTime = $('input[name="fdApprovalTime"]').val();
				if(fdApprovalTime){
					var approval = Com_GetDate(fdApprovalTime);
					if(approval.getTime()>=input.getTime()){
						return false;
					}
					var now = new Date();
					if(now.getTime()>=input.getTime()){
						return false;
					}
				}
		    	return true;
		    });
		    _validation.addValidator('_finishTimeValidator','请先输入立项时间',function(v,e,o){
				var fdApprovalTime = $('input[name="fdApprovalTime"]').val();
		    	if(!fdApprovalTime){
					$('input[name="fdFinishTime"]').val('');
					return false;
				}
		    	return true;
		    });
		    submitForm(status, method, isDraft);
		}
	});
</script>