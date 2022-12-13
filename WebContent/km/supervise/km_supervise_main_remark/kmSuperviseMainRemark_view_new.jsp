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
		            			<xform:text property="docSubject" showStatus="view"/>
		            		</td>
		            	</tr>
		                <tr>
							<!-- 分管领导 -->
							<td class="td_normal_title" width="15%">
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdLeads" />
							</td>
							<td width="35%">
								<xform:address propertyName="fdLeadNames" propertyId="fdLeadIds" showStatus="view" />
							</td>
							<!-- 主办单位 -->
							<td class="td_normal_title" width="15%">
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />
							</td>
							<td width="35%">
								<c:choose>
									<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true'}">
										<xform:address propertyName="fdSysUnitName" propertyId="fdSysUnitId" showStatus="view"/>
									</c:when>
									<c:otherwise>
										<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="view"/>
									</c:otherwise>
								</c:choose>
							</td>	
						</tr>
						<tr>
							<!-- 主办单位责任人 -->
							<td class="td_normal_title" width="15%">
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSponsor" />
							</td>
							<td width="35%">
								<xform:address propertyName="fdSponsorName" propertyId="fdSponsorId" showStatus="view" />
							</td>
							<!-- 协办单位 -->
							<td class="td_normal_title" width="15%">
								<bean:message bundle="km-supervise" key="kmSuperviseMain.fdOtherUnits" />
							</td>
							<td width="35%">
								<c:choose>
									<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true'}">
										<xform:address propertyName="fdOtherUnitNames" propertyId="fdOtherUnitIds" showStatus="view" />
									</c:when>
									<c:otherwise>
										<xform:address propertyName="fdOUnitNames" propertyId="fdOUnitIds" showStatus="view"/>
									</c:otherwise>
								</c:choose>
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
								<xform:textarea property="fdRemark" style="width:98%;" showStatus="view"/>
							</td>
						</tr>
		            </table>
		        </div>
			</ui:content>
		</ui:tabpage>
	</template:replace>
</template:include>