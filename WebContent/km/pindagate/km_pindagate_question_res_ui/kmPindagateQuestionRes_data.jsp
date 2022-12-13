<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.km.pindagate.model.KmPindagateQuestionRes"%>
<%@page import="com.landray.kmss.km.pindagate.service.IKmPindagateQuestionService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmPindagateQuestionRes" list="${queryPage.list}">
		<list:data-column  col="dName" >
			<c:if test="${param.isShow==true }">
				${kmPindagateQuestionRes.fdQuetionairRes.docCreator.fdName}
			</c:if>
			<c:if test="${param.isShow==false }">
				****
			</c:if>
		</list:data-column>
		<list:data-column  col="dept" >
			<c:if test="${param.isShow==true }">
					${kmPindagateQuestionRes.fdQuetionairRes.docCreator.fdParent.fdName}
				</c:if>
				<c:if test="${param.isShow==false }">
					****
				</c:if>
		</list:data-column>
		<list:data-column col="fdCreateTime" >
			<kmss:showDate value="${kmPindagateQuestionRes.fdQuetionairRes.fdCreateTime}" type="datetime" />
		</list:data-column>
		<list:data-column col="dContent" escape="false">
			<%
			if(pageContext.getAttribute("kmPindagateQuestionRes")!=null){
				KmPindagateQuestionRes res = (KmPindagateQuestionRes)pageContext.getAttribute("kmPindagateQuestionRes");
				String questionId = res.getFdQuestionId();
				IKmPindagateQuestionService kmPindagateQuestionService = (IKmPindagateQuestionService) SpringBeanUtil.getBean("kmPindagateQuestionService");
				String tableValue = kmPindagateQuestionService.createTableValue(questionId,res);
				String reason = "",answer = "", other = "";
				if(StringUtil.isNotNull(res.getFdSelectReason())){
					reason = "\n" + res.getFdSelectReason();
					reason = reason.replaceAll(" ( +?)", " &nbsp;").replaceAll("\r\n",
							"<br>").replaceAll("\n", "<br>");
				}
				if(StringUtil.isNotNull(res.getFdAnswer())){
					answer = "\n" + res.getFdAnswer();
					answer = answer.replaceAll(" ( +?)", " &nbsp;").replaceAll("\r\n",
							"<br>").replaceAll("\n", "<br>");
				}
				if(StringUtil.isNotNull(res.getFdOther())){
					other = "\n" + res.getFdOther();
					other = other.replaceAll(" ( +?)", " &nbsp;").replaceAll("\r\n",
							"<br>").replaceAll("\n", "<br>");
				}
				request.setAttribute("reason",reason);
				request.setAttribute("answer",answer);
				request.setAttribute("other",other);
				request.setAttribute("tableValue",tableValue);
			}
			%>
			<script>
			
			</script>
			<%--选择原因--%>
			<c:if test="${param.type == 'selectReason'}">
				${reason} 
			</c:if>
			<c:if test="${param.fdType == 'formfilled'||param.fdType == 'matrixfilled'}">
				${tableValue}
			</c:if>
			<c:if test="${param.type == 'other' or empty param.type }">
			<c:choose>
				<%--简答题答案--%>
				<c:when test="${param.fdType == 'essayquestion'||param.fdType == 'fillquestions'}">
					${answer}
				</c:when>
				<%--其他答案--%>
				<c:otherwise>
					${other}
				</c:otherwise>
			</c:choose>
			</c:if>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>
