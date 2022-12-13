<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/person/person.tld" prefix="person"%>
<%@page import="com.landray.kmss.km.pindagate.model.KmPindagateQuestionRes"%>
<%@page import="com.landray.kmss.km.pindagate.service.IKmPindagateQuestionService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateQuestionRes" list="${queryPage.list}">
		<list:data-column  col="fdName" >
			<c:if test="${isShow==true }">
				${kmPindagateQuestionRes.fdQuetionairRes.docCreator.fdName}
			</c:if>
			<c:if test="${isShow==false }">
				****
			</c:if>
		</list:data-column>
		<list:data-column  col="dept" >
			<c:if test="${isShow==true }">
				${kmPindagateQuestionRes.fdQuetionairRes.docCreator.fdParent.fdName}
			</c:if>
			<c:if test="${isShow==false }">
				****
			</c:if>
		</list:data-column>
		<list:data-column col="fdCreateTime" >
			<kmss:showDate value="${kmPindagateQuestionRes.fdQuetionairRes.fdCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column col="fdAnswer" >
			<%--选择原因--%>
			<c:if test="${type == 'selectReason'}">
				<c:out value="${kmPindagateQuestionRes.fdSelectReason}"></c:out>
			</c:if>
			<c:choose>
				<%--简答题答案--%>
				<c:when test="${fdType == 'essayquestion'}">
					<c:out value="${kmPindagateQuestionRes.fdAnswer}"></c:out>
				</c:when>
				<c:when test="${fdType == 'fillquestions'}">
					<c:out value="${kmPindagateQuestionRes.fdAnswerTxt}"></c:out>
				</c:when>
				<%--填空题--%>
				<c:when test="${fdType == 'formfilled'||fdType == 'matrixfilled'}">
					<%
						if(pageContext.getAttribute("kmPindagateQuestionRes")!=null){
							KmPindagateQuestionRes res = (KmPindagateQuestionRes)pageContext.getAttribute("kmPindagateQuestionRes");
							String questionId = res.getFdQuestionId();
							IKmPindagateQuestionService kmPindagateQuestionService = (IKmPindagateQuestionService) SpringBeanUtil.getBean("kmPindagateQuestionService");
							String tableValue = kmPindagateQuestionService.createTableValue(questionId,res);
							request.setAttribute("tableValue",tableValue);
						}
					%>
					${tableValue}
				</c:when>
				<%--其他答案--%>
				<c:otherwise>
					<c:out value="${kmPindagateQuestionRes.fdOther}"></c:out>
				</c:otherwise>
			</c:choose>
		</list:data-column>
		<%-- 头像 --%>
		<list:data-column col="header" escape="false" >
			<c:if test="${isShow==true }">
				<person:headimageUrl personId="${kmPindagateQuestionRes.fdQuetionairRes.docCreator.fdId}" size="m" />
			</c:if>
			<c:if test="${isShow==false }">
				<person:headimageUrl personId="" size="m" />
			</c:if>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>