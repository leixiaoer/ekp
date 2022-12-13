<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="mobile.view" compatibleMode="true">
	<template:replace name="loading">
		<c:import url="/km/institution/mobile/view_banner.jsp" charEncoding="UTF-8">
			<c:param name="formBeanName" value="kmInstitutionKnowledgeForm"></c:param>
			<c:param name="loading" value="true"></c:param>
		</c:import>
	</template:replace>
	<template:replace name="title">
		<c:out value="${kmInstitutionKnowledgeForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" href="${LUI_ContextPath}/km/institution/mobile/resource/css/institution.css?s_cache=${MUI_Cache}" />
		<script type="text/javascript">
	   	require(["dojo/store/Memory","dojo/topic"],function(Memory, topic){
	   		window._narStore = new Memory({data:[{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.info" />',
	   			'moveTo':'_contentView','selected':true},{'text':'<bean:message bundle="sys-mobile" key="mui.mobile.review.record" />',
	   			'moveTo':'_noteView'}]});
	   		topic.subscribe("/mui/navitem/_selected",function(evtObj){
	   			setTimeout(function(){topic.publish("/mui/list/resize");},150);
	   		});
	   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<div id="scrollView" 
			data-dojo-type="mui/view/DocScrollableView">
			<c:import url="/km/institution/mobile/view_banner.jsp" charEncoding="UTF-8">
				<c:param name="formBeanName" value="kmInstitutionKnowledgeForm"></c:param>
			</c:import>
			<%-- 文档失效 --%>
			<c:if test="${kmInstitutionKnowledgeForm.docStatus == '50' }">
				<div class="status_expire"></div>
			</c:if>	
			<c:if test="${kmInstitutionKnowledgeForm.docStatus < '30' }">
				<div data-dojo-type="mui/fixed/Fixed" id="fixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore"
							data-dojo-props="store:_narStore"></div>
					</div>
				</div>
			</c:if>
			<div data-dojo-type="dojox/mobile/View" id="_contentView">
			<div class="muiDocFrame">
				<c:if test="${kmInstitutionKnowledgeForm.docStatus == '50' }">
					<table class="muiSimple" cellpadding="0" cellspacing="0" style="margin-bottom: 10px">
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-institution" key="kmInstitution.fdAbolishDescription" />
							</td>
							<td>
								<font color="red"><c:out value="${kmInstitutionKnowledgeForm.fdAbolishDescription}" /></font>
							</td>
						</tr>
						<tr>
							<td class="muiTitle">
								<bean:message bundle="km-institution" key="kmInstitution.fdAbolishTime" />
							</td>
							<td>
								<font color="red"><c:out value="${kmInstitutionKnowledgeForm.fdAbolishTime}" /></font>
							</td>
						</tr>
					</table>
				</c:if>	
				<div class="muiDocContent" id="contentDiv" style="z-index: -1;">
					<xform:rtf property="docContent" mobile="true"></xform:rtf>
				</div>
				<c:import url="/sys/attachment/mobile/import/view.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmInstitutionKnowledgeForm"></c:param>
					<c:param name="fdKey" value="attachment"></c:param>
				</c:import> 
			</div>
			</div>
			<c:if test="${kmInstitutionKnowledgeForm.docStatus < '30' }">
			<div data-dojo-type="dojox/mobile/View" id="_noteView">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message bundle="km-institution" key="kmInstitution.processRecords" />',icon:'mui-ul'">
						<c:import url="/sys/lbpmservice/mobile/lbpm_audit_note/import/view.jsp" charEncoding="UTF-8">
							<c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId }"/>
							<c:param name="fdModelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge"/>
							<c:param name="formBeanName" value="kmInstitutionKnowledgeForm"/>
						</c:import>
					</div>
				</div>
				</div>
			</c:if>
			
			<template:include file="/sys/lbpmservice/mobile/import/tarbar.jsp" 
							formName="kmInstitutionKnowledgeForm"
							viewName="lbpmView"
							allowReview="true">
				<template:replace name="flowArea">
					 <%--传阅 --%>
					 <c:import url="/sys/circulation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
					 </c:import>
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					    <c:param name="fdModelName" value="${kmInstitutionKnowledgeForm.modelClass.name}"/>
					    <c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}"/>
					    <c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}"/>
					    <c:param name="showOption" value="label"></c:param>
					</c:import>
					<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
					  	<c:param name="formName" value="kmInstitutionKnowledgeForm"/>
					  	<c:param name="showOption" value="label"></c:param>
					</c:import>
				</template:replace>
				<template:replace name="publishArea">
					<%--传阅 --%>
					<c:import url="/sys/circulation/mobile/import/view.jsp" charEncoding="UTF-8">
						<c:param name="formName" value="kmInstitutionKnowledgeForm"></c:param>
						<c:param name="showOption" value="label"></c:param>
					</c:import>
					<c:import url="/sys/bookmark/mobile/import/view.jsp" charEncoding="UTF-8">
					  <c:param name="fdModelName" value="${kmInstitutionKnowledgeForm.modelClass.name}"/>
					  <c:param name="fdModelId" value="${kmInstitutionKnowledgeForm.fdId}"/>
					  <c:param name="fdSubject" value="${kmInstitutionKnowledgeForm.docSubject}"/>
					  <c:param name="showOption" value="label"></c:param>
					</c:import>
					<c:import url="/sys/relation/mobile/import/view.jsp" charEncoding="UTF-8">
				  		<c:param name="formName" value="kmInstitutionKnowledgeForm"/>
				  		 <c:param name="showOption" value="label"></c:param>
				  	</c:import>
				</template:replace>			
			</template:include>
		</div>
		<!-- 钉钉图标 -->
		<kmss:ifModuleExist path="/third/ding">
			<c:import url="/third/ding/import/ding_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			</c:import>
		</kmss:ifModuleExist>
		<!-- 钉钉图标 end -->
		<c:import url="/sys/lbpmservice/mobile/import/view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmInstitutionKnowledgeForm" />
			<c:param name="fdKey" value="mainDoc" />
			<c:param name="viewName" value="lbpmView" />
			<c:param name="backTo" value="scrollView" />
		</c:import>
	</template:replace>
</template:include>
