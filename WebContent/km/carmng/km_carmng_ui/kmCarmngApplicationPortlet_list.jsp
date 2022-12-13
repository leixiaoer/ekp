<%@ page language="java" contentType="text/json; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmCarmngApplication" list="${queryPage.list}">	
		<list:data-column property="fdId">
		</list:data-column>
		<list:data-column  headerClass="width60" col="docSubject" title="${ lfn:message('km-carmng:kmCarmngApplication.docSubject') }" escape="false" style="text-align:center;min-width:180px">
			<a class="com_subject textEllipsis" title="${kmCarmngApplication.docSubject}" data-href="${LUI_ContextPath}/km/carmng/km_carmng_application/kmCarmngApplication.do?method=view&fdId=${kmCarmngApplication.fdId}" target="_blank" onclick="Com_OpenNewWindow(this)">
				<c:out value="${kmCarmngApplication.docSubject}"/>
			</a> 
		</list:data-column>
		<list:data-column headerClass="width80" col="fdApplicationPath" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPath')}" style="text-align:center;" escape="false">
			<c:if test="${not empty kmCarmngApplication.fdDeparture}">
				<c:out value="${kmCarmngApplication.fdDeparture}"/>-
			</c:if>
			<c:if test="${not empty kmCarmngApplication.fdDestination}">
				<c:out value="${kmCarmngApplication.fdDestination}"/>
			</c:if>
			<c:if test="${not empty kmCarmngApplication.fdApplicationPath}">
				-
				<c:out value="${kmCarmngApplication.fdApplicationPath}"/>
			</c:if>
		</list:data-column>		
		<list:data-column headerClass="width60" col="docCreateTime" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationTime')}" escape="false">
			<kmss:showDate value="${kmCarmngApplication.docCreateTime}"></kmss:showDate>
		</list:data-column>
		<c:if test="${param.myFlow!='unExecuted' }">
			<list:data-column  headerStyle="text-align:center;" col="docStatus" headerClass="width40" styleClass="width40" title="${ lfn:message('km-carmng:kmCarmngApplication.docStatus') }">
				<c:if test="${kmCarmngApplication.docStatus < 30 }">	
					<sunbor:enumsShow value="${kmCarmngApplication.docStatus}" enumsType="common_status"/>
				</c:if>	
				<%--通过--%>
				<c:if test="${kmCarmngApplication.docStatus == 30 && kmCarmngApplication.fdIsDispatcher != 2  && kmCarmngApplication.fdIsDispatcher != 3}">	
					<bean:message bundle="km-carmng" key="kmCarmng.tree.publish"/>
				</c:if>
				<%--发车--%>
				<c:if test="${kmCarmngApplication.fdIsDispatcher == 2 }">	
					<bean:message bundle="km-carmng" key="kmCarmng.tree.publish2"/>
				</c:if>
				<%--完成--%>
				<c:if test="${kmCarmngApplication.fdIsDispatcher == 3 }">	
					<bean:message bundle="km-carmng" key="kmCarmng.tree.publish3"/>
				</c:if>
			</list:data-column>
		</c:if>
		<c:if test="${flag != 'owner' }">
			<list:data-column headerStyle="text-align:center;" col="docCreator.fdName" headerClass="width60" styleClass="width40" title="${ lfn:message('km-carmng:kmCarmngApplication.fdApplicationPerson') }" escape="false">
			  <ui:person personId="${kmCarmngApplication.docCreator.fdId}" personName="${kmCarmngApplication.docCreator.fdName}"></ui:person>
			</list:data-column>
		</c:if>		
		<list:data-column headerStyle="text-align:center;" style="text-align:center;" headerClass="width60" styleClass="width40" col="handlerName" title="${ lfn:message('km-carmng:sysWfNode.processingNode.currentProcessor') }" escape="false">
		    <kmss:showWfPropertyValues  var="handlerName" idValue="${kmCarmngApplication.fdId}" propertyName="handlerName" />
			    <div style="font-weight: bold;" title="${handlerName}">
			        <c:out value="${handlerName}"></c:out>
			    </div>
		</list:data-column>
	</list:data-columns>
</list:data>
