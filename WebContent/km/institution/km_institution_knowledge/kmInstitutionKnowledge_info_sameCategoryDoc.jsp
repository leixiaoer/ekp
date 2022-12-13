<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<link href="<c:url value="/km/institution"/>/resource/style/sidebar/sideBox.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="contentDiv">
	<c:if test="${queryPage.totalrows<=0}">
		<bean:message bundle="km-institution" key="km.institution.result.notData"/>
	</c:if>
	<c:if test="${queryPage.totalrows>0}">
		<ul class="docList">
			<c:forEach items="${queryPage.list}" var="kmInstitutionKnowledge" varStatus="vstatus">
				<li>
					<a onclick="Com_OpenNewWindow(this)" data-href="<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=${kmInstitutionKnowledge.fdId}" />" target="_blank">
						<c:out value="${kmInstitutionKnowledge.docSubject}" />
						<span class="colorGray">
							${kmInstitutionKnowledge.docCreator.fdName}
							<kmss:showDate value="${kmInstitutionKnowledge.docCreateTime}" type="date" />
						</span>
					</a>
				</li>
			</c:forEach>
		</ul>
	</c:if>
</div>
</body>
</html>
<script>
function dyniFrameSize() {
	try {
		// 调整高度
		var arguObj = document.getElementById('contentDiv');
		if(arguObj!=null && window.frameElement!=null && window.frameElement.tagName=="IFRAME"){
			window.frameElement.style.height = (arguObj.offsetHeight + 20) + "px";
		}
	} catch(e) {
	}
}
dyniFrameSize();
</script>