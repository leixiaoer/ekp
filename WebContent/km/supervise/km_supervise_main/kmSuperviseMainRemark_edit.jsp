<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	
	<template:replace name="head">
        <style type="text/css">
            .lui_form_body{background:white;}
          	.all>input{opacity:0;position:absolute;width:2em;height:2em;margin:0;cursor:pointer;top:auto;}
		    .all>input:nth-of-type(1),
		    .all>span:nth-of-type(1){display:none;}
		    .all>span{font-size:2em;color:gold;
		      -webkit-transition:color .8s;
		      transition:color .8s;
		    }
		    .all>input:checked~span{color:#666;}
		    .all>input:checked+span{color:gold;}
        </style>
        <script type="text/javascript">
            var formInitData = {

            };
            Com_IncludeFile("security.js");
            Com_IncludeFile("domain.js");
            Com_IncludeFile("form.js");
            Com_IncludeFile("main_edit.js", "${LUI_ContextPath}/km/supervise/resource/js/", 'js', true);
            Com_IncludeFile("form_option.js", "${LUI_ContextPath}/km/supervise/km_supervise_main/", 'js', true);
        </script>
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--add页面的按钮--%>
			<ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('remark');">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	
	<%--督办评价表单--%>
	<template:replace name="content"> 
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
		    <p class="lui_form_subject">${ lfn:message('km-supervise:py.DuBanKaoPing') }</p>
	        <div class="lui_form_content_frame" >
	            <table class="tb_normal" width="95%">
	            	<tr>
	            		<td class="td_normal_title">
	            			<bean:message bundle="km-supervise" key="kmSupervise.items" />
	            		</td>
	            		<td colspan="3">
	            			<xform:text property="docSubject"/>
	            		</td>
	            	</tr>
	                <tr>
						<!-- 督办领导 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="enums.warn.10" />
						</td>
						<td>
							<xform:address propertyName="fdLeadName" propertyId="fdLeadId" showStatus="view" />
						</td>
						<!-- 主办单位 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdUnit" />
						</td>
						<td>
							<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="view" />
						</td>	
					</tr>
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSponsor" />
						</td>
						<td>
							<xform:address propertyName="fdSponsorName" propertyId="fdSponsorId" showStatus="view" />
						</td>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdResponsible" />
						</td>
						<td>
							<xform:address propertyName="fdResponsibleName" propertyId="fdResponsibleId" showStatus="view" />
						</td>
					</tr>
					<tr>
					<!-- 任务进度 -->
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSuperviseProgress" />
						</td>
						<td colspan="3">
							<style>
								.pro_barline{width: 113px;height: 7px;background: #e5e4e1;border: 1px solid #d2d1cc;text-align: left;border-radius: 4px;}
								.pro_barline .complete{height: 7px;background: #00a001;border-radius: 3px;}
								.pro_barline .uncomplete{height: 7px;background: #ff8b00;border-radius: 3px;}
							</style>
							<c:choose>
								<c:when test="${not empty kmSuperviseMainForm.fdSuperviseProgress }">
									<c:if test="${kmSuperviseMainForm.fdSuperviseProgress=='100' }">
										<c:out value="${lfn:message('km-supervise:kmSupervise.task.docStatus.3')}" />
									</c:if>
									<c:if test="${kmSuperviseMainForm.fdSuperviseProgress!='100' }">
										<c:out value="${lfn:message('km-supervise:kmSupervise.task.docStatus.2')}" />
									</c:if>
									&nbsp;&nbsp;<c:out value="${kmSuperviseMainForm.fdSuperviseProgress }" />%
								</c:when>
								<c:otherwise>
									<c:out value="${lfn:message('km-supervise:kmSupervise.task.docStatus.2')}" />&nbsp;&nbsp;0%
								</c:otherwise>
							</c:choose>
							<div class='pro_barline'>
								<c:choose>
									<c:when test="${not empty kmSuperviseMainForm.fdSuperviseProgress }">
										<c:if test="${kmSuperviseMainForm.fdSuperviseProgress=='100' }">
											<div class='complete' style="width:${kmSuperviseMainForm.fdSuperviseProgress}%"></div>
										</c:if>
										<c:if test="${kmSuperviseMainForm.fdSuperviseProgress!='100' }">
											<div class='uncomplete' style="width:${kmSuperviseMainForm.fdSuperviseProgress}%"></div>
										</c:if>
									</c:when>
									<c:otherwise>
										<div class='uncomplete' style="width:0%"></div>
									</c:otherwise>
								</c:choose>
							</div>	
						</td>
					</tr>
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishLevel" />
						</td>
						<td colspan="3">
							<p class="all">
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="1" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="2" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="3" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="4" checked="checked" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="5" />
						      <span>★</span>
						    </p>
						</td>
					</tr>
					<!-- 评价说明 -->
					<tr>
						<td class="td_normal_title">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdRemark" />
						</td>
						<td colspan="3">
							<html:textarea property="fdRemark" style="width:98%;"/>
						</td>
					</tr>
	            </table>
	        </div>
		    <html:hidden property="fdId" />
		    <html:hidden property="method_GET" />
		    <script>
		        $KMSSValidation();
		        window.commitMethod = function(method){
		        	Com_SubmitForm(document.kmSuperviseMainForm,method);
	        		window.$dialog.hide("success");
		        };
		    </script>
		</html:form>
	</template:replace>
	
</template:include>