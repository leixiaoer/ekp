<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<c:set var="kmInstitutionKnowledgeForm" value="${requestScope[param.formBeanName]}" />
			<div class="muiViewBanner muiSummaryInfoBanner">
					<div class="leftInfo">
						<span class="figure"><i class="mui mui-bookLogo"></i></span>
					</div>
					<div class="rightInfo">
						<span class="title">
							<xform:text property="docSubject"></xform:text>
						</span>
						<ul>
							<c:if test="${kmInstitutionKnowledgeForm.docStatus >= '30' }">
								<li>
									${lfn:message('km-institution:kmInstitution.docPublishTime') }：<c:out value="${kmInstitutionKnowledgeForm.docPublishTime}" />
								</li>
							</c:if>
							<li>
								${lfn:message('km-institution:kmInstitution.fdNumber') }：<c:out value="${ kmInstitutionKnowledgeForm.fdNumber }"/>		
							</li>
						</ul>
					</div>
				</div>
<c:if test="${not empty param.loading and param.loading == 'true' }">
	<div style="height: 100%;padding-top: 10rem;">
		<%@ include file="/sys/mobile/extend/combin/loading.jsp"%>
	</div>
</c:if>