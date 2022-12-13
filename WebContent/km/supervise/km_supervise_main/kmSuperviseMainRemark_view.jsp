<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	
	<template:replace name="head">
        <style type="text/css">
            .all>span{font-size:2em;color:#999;}
			.all>.gold{color:gold;}
        </style>
    </template:replace>
    
    <template:replace name="title">
        <c:out value="${kmSuperviseMainForm.docSubject} - " />
        <c:out value="${ lfn:message('km-supervise:module.km.supervise') }" />
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
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
	
	<%--督办评价表单--%>
	<template:replace name="content"> 
		<ui:tabpage expand="true" var-navwidth="90%">
			<p class="txttitle">${ lfn:message('km-supervise:py.DuBanKaoPing') }</p>
			<ui:content title="${ lfn:message('km-supervise:py.DuBanKaoPing') }">
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
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdLead" />
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
							      <c:if test="${kmSuperviseMainForm.fdFinishLevel == '1' }">
							      	<span class="gold">★</span>
							      	<span>★</span>
							      	<span>★</span>
							      	<span>★</span>
							      	<span>★</span>
							      </c:if>
							      <c:if test="${kmSuperviseMainForm.fdFinishLevel == '2' }">
							     	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span>★</span>
							      	<span>★</span>
							      	<span>★</span>
							      </c:if>
							      <c:if test="${kmSuperviseMainForm.fdFinishLevel == '3' }">
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span>★</span>
							      	<span>★</span>
							      </c:if>
							      <c:if test="${kmSuperviseMainForm.fdFinishLevel == '4' }">
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span>★</span>
							      </c:if>
							      <c:if test="${kmSuperviseMainForm.fdFinishLevel == '5' }">
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      	<span class="gold">★</span>
							      </c:if>
							    </p>
							</td>
						</tr>
						<!-- 评价说明 -->
						<tr>
							<td class="td_normal_title">
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdRemark" />
							</td>
							<td colspan="3">
								<xform:textarea property="fdRemark" style="width:98%;"/>
							</td>
						</tr>
		            </table>
		        </div>
			</ui:content>
		</ui:tabpage>
	</template:replace>
</template:include>