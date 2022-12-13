<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
<%@page import="com.landray.kmss.km.supervise.model.KmSuperviseMain"%>
<%@page import="com.landray.kmss.km.supervise.service.IKmSuperviseMainService"%>
<%@page import="com.landray.kmss.util.SpringBeanUtil"%>
<list:data>
    <list:data-columns var="kmSuperviseMain" list="${queryPage.list}" varIndex="status">
        <list:data-column property="fdId" />
        <list:data-column col="index" title="${ lfn:message('page.serial') }">
            ${status+1}
        </list:data-column>
		<%-- 督办事项 --%>
        <list:data-column col="docSubject" title="${lfn:message('km-supervise:kmSupervise.items')}" escape="false">
        	<c:out value="${kmSuperviseMain.docSubject}" />
        </list:data-column>
         <%-- 督办领导id --%>
        <list:data-column col="fdLead.id" escape="false">
            <c:out value="${kmSuperviseMain.fdLead.fdId}" />
        </list:data-column>
      	<%-- 主办单位负责人 --%>
        <list:data-column col="fdSponsor" title="${lfn:message('km-supervise:kmSuperviseMain.fdSponsor') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdSponsor.fdName }" />
        </list:data-column>
      		 <%-- 督办领导name --%>
        <list:data-column col="fdLeadName" title="${lfn:message('km-supervise:kmSuperviseMain.fdLead')}" escape="false">
            <c:out value="${kmSuperviseMain.fdLead.fdName}" />
        </list:data-column>
       	<%-- 开始时间 --%>
        <list:data-column col="fdStartTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdStartTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdStartTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 完成时限 --%>
        <list:data-column col="fdFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 立项时间 --%>
        <list:data-column col="fdApprovalTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdApprovalTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdApprovalTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 实际完成时间 --%>
        <list:data-column col="fdRealFinishTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRealFinishTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRealFinishTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 撤销时间 --%>
        <list:data-column col="fdRepealTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRepealTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRepealTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 督办状态 --%>
        <list:data-column col="fdStatus" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}">
         	<c:out value="${kmSuperviseMain.docStatus}" />
        </list:data-column>
        <list:data-column col="fdStatusText" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}">
        	<c:choose>
        		<c:when test="${kmSuperviseMain.docStatus=='30' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.30" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.docStatus=='40' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.40" />
        		</c:when>
        		<c:when test="${kmSuperviseMain.docStatus=='50' }">
        			<kmss:message bundle="km-supervise" key="enums.doc_status.50" />
        		</c:when>
        		<c:otherwise>
        			<kmss:message bundle="km-supervise" key="enums.doc_status.20" />
        		</c:otherwise>
        	</c:choose>
        </list:data-column>
        <%-- 督办进度 --%>
        <list:data-column col="fdSuperviseProgress" title="${lfn:message('km-supervise:kmSuperviseMain.fdSuperviseProgress')}" escape="false" style="width: 113px;height: 7px;">
			 <c:out value="${kmSuperviseMain.fdSuperviseProgress}" />
        </list:data-column>
        <%-- 创建时间 --%>
        <list:data-column col="docCreateTime" title="${lfn:message('km-supervise:kmSuperviseMain.docCreateTime')}">
            <kmss:showDate value="${kmSuperviseMain.docCreateTime}" type="datetime"></kmss:showDate>
        </list:data-column>
        <%-- 主办单位 --%>
        <list:data-column col="fdUnit" title="${lfn:message('km-supervise:kmSuperviseMain.fdUnit') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdUnit.fdName }" />
        </list:data-column>
        <%-- 经办人 --%>
        <list:data-column col="fdResponsible" title="${lfn:message('km-supervise:kmSuperviseMain.fdResponsible') }" escape="false">
        	<c:out value="${kmSuperviseMain.fdResponsible.fdName }" />
        </list:data-column>
        <%-- 考评状态 --%>
        <list:data-column col="remarkStatus" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemarkStatus') }" escape="false">
        	<c:if test="${kmSuperviseMain.fdRemarkStatus == '0' }">
        		<kmss:message bundle="km-supervise" key="enums.remark_status.0" />
        	</c:if>
        	<c:if test="${kmSuperviseMain.fdRemarkStatus == '1' }">
        		<kmss:message bundle="km-supervise" key="enums.remark_status.1" />
        	</c:if>
        </list:data-column>
        <%-- 考评状态值 --%>
        <list:data-column property="fdRemarkStatus" />
        <%-- 评价说明 --%>
        <list:data-column property="fdRemark" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemark') }" />
        <%-- 创建人name --%>
        <list:data-column col="docCreatorName" title="${lfn:message('km-supervise:kmSuperviseMain.initiator') }">
        	<c:out value="${kmSuperviseMain.docCreator.fdName }" />
        </list:data-column>
        <%-- 创建人id --%>
        <list:data-column col="docCreator.id">
        	<c:out value="${kmSuperviseMain.docCreator.fdId }" />
        </list:data-column>
        <%-- 文档状态 --%>
        <list:data-column col="docStatus" title="${lfn:message('km-supervise:kmSuperviseMain.docStatus')}">
			<c:choose>
				<c:when test="${kmSuperviseMain.docStatus=='10' }">
					<bean:message key="status.draft"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='20' }">
					<bean:message key="status.examine"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='11' }">
					<bean:message key="status.refuse"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">
					<bean:message key="status.publish"></bean:message>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='00' }">
					<bean:message key="status.discard"></bean:message>
				</c:when>
			</c:choose>
		</list:data-column>
        <list:data-column col="docStatusNew" title="${lfn:message('km-supervise:kmSuperviseMain.docStatus')}">
        	<c:out value="${kmSuperviseMain.docStatus }" />
        </list:data-column>
        <%-- 当前环节 --%>
        <list:data-column headerClass="width100" col="nodeName" title="${ lfn:message('km-supervise:sysWfNode.processingNode.currentProcess') }" escape="false">
			<kmss:showWfPropertyValues  var="nodevalue" idValue="${kmSuperviseMain.fdId}" propertyName="nodeName" />
			    <div class="textEllipsis width100" title="${nodevalue}">
			        <c:out value="${nodevalue}"></c:out>
			    </div>
		</list:data-column>
        <%-- 当前处理人 --%>
        <list:data-column headerClass="width80" col="handlerName" title="${ lfn:message('km-supervise:sysWfNode.processingNode.currentProcessor') }" escape="false">
		   <kmss:showWfPropertyValues  var="handlerValue" idValue="${kmSuperviseMain.fdId}" propertyName="handlerName" />
			    <div class="textEllipsis width80" style="font-weight:bold;" title="${handlerValue}">
			        <c:out value="${handlerValue}"></c:out>
			    </div>
		</list:data-column>
		<list:data-column col="href" escape="false">
			/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseMain.fdId}
		</list:data-column>
		<%-- 督办状态 --%>
        <list:data-column col="fdStatusNew" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}">
         	<c:out value="${kmSuperviseMain.fdStatus}" />
        </list:data-column>
		<list:data-column col="fdStatusNewText" title="${lfn:message('km-supervise:kmSuperviseMain.fdStatus')}" escape="false">
        	<c:if test="${kmSuperviseMain.docStatus == '30' || kmSuperviseMain.docStatus == '40' || kmSuperviseMain.docStatus == '50'|| kmSuperviseMain.docStatus == '60'}">
	        	<c:choose>
	        		<c:when test="${kmSuperviseMain.fdStatus=='10' }">
	        			<%
	        				if(pageContext.getAttribute("kmSuperviseMain")!=null){
	        					KmSuperviseMain kmSuperviseMain = (KmSuperviseMain)pageContext.getAttribute("kmSuperviseMain");
	    						if(KmSuperviseUtil.isSoonStart(kmSuperviseMain)){
	    				%>
	        						<kmss:message bundle="km-supervise" key="enums.status.soon.start" />
	        			<% 
	        					}else{
	        			%>
	        						<kmss:message bundle="km-supervise" key="enums.status.normal" />
	        			<%		
	        					}
	        				}
	        			%>
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='20' }">
	        			<kmss:message bundle="km-supervise" key="enums.status.soon.delay" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='30' }">
	        			<kmss:message bundle="km-supervise" key="enums.status.delay" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='40' }">
	        			<kmss:message bundle="km-supervise" key="enums.status.finish" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='50' }">
	        			<kmss:message bundle="km-supervise" key="enums.status.stop" />
	        		</c:when>
	        		<c:when test="${kmSuperviseMain.fdStatus=='60' }">
	        			<kmss:message bundle="km-supervise" key="enums.status.change" />
	        		</c:when>
	        	</c:choose>
        	</c:if>
        </list:data-column>
        <%-- 督办类型 --%>
		<list:data-column col="templateName" title="${lfn:message('km-supervise:kmSuperviseMain.type')}" escape="false">
            <c:out value="${kmSuperviseMain.docTemplate.fdName}" />
        </list:data-column>
        <%-- 主办部门 --%>
		<list:data-column col="fdSysUnitName" title="${lfn:message('km-supervise:kmSuperviseMain.fdSysUnit')}" escape="false">
            <c:choose>
            	<c:when test="${kmSuperviseMain.fdSysUnitEnable == true }">
            		<c:out value="${kmSuperviseMain.fdSysUnit.fdName}" />
            	</c:when>
            	<c:otherwise>
            		<c:out value="${kmSuperviseMain.fdUnit.fdName }" />
            	</c:otherwise>
            </c:choose>
        </list:data-column>
        
        <%
			if(pageContext.getAttribute("kmSuperviseMain")!=null){
				KmSuperviseMain kmSuperviseMain = (KmSuperviseMain)pageContext.getAttribute("kmSuperviseMain");
				IKmSuperviseMainService kmSuperviseMainService = (IKmSuperviseMainService)SpringBeanUtil.getBean("kmSuperviseMainService");
				String leaderConcernNames = kmSuperviseMainService.getLeadConcernNames(kmSuperviseMain);
				request.setAttribute("leaderConcernNames",leaderConcernNames);
			}
		%>
        <list:data-column col="leaderConcernNames" title="关注领导" escape="false">
            <c:out value="${leaderConcernNames}" />
        </list:data-column>
        
        <%-- 变更时间 --%>
		<list:data-column col="fdChangeTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangeTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdChangeTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 变更人 --%>
        <list:data-column col="fdChangePersonName" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangePerson')}">
            <c:out value="${kmSuperviseMain.fdChangePerson.fdName}" />
        </list:data-column>
        <%-- 变更原因 --%>
		<list:data-column col="fdChangeDesc" title="${lfn:message('km-supervise:kmSuperviseMain.fdChangeDesc')}">
            <c:out value="${kmSuperviseMain.fdChangeDesc}" />
        </list:data-column>
        <%-- 考评星级 --%>
        <list:data-column col="fdFinishLevel" title="${lfn:message('km-supervise:kmSuperviseMain.fdFinishLevel') }" escape="false">
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '1' }">
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '2' }">
		     	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '3' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '4' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span>☆</span>
		      </c:if>
		      <c:if test="${kmSuperviseMain.fdFinishLevel == '5' }">
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      	<span class="gold">★</span>
		      </c:if>
        </list:data-column>
        <%-- 评价说明 --%>
        <list:data-column col="fdRemark" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemark') }" >
        	<c:out value="${kmSuperviseMain.fdRemark}" />
        </list:data-column>
        <%-- 考评时间 --%>
		<list:data-column col="fdRemarkTime" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemarkTime')}">
            <kmss:showDate value="${kmSuperviseMain.fdRemarkTime}" type="date"></kmss:showDate>
        </list:data-column>
        <%-- 考评人 --%>
        <list:data-column col="fdRemarkerName" title="${lfn:message('km-supervise:kmSuperviseMain.fdRemarker')}">
            <c:out value="${kmSuperviseMain.fdRemarker.fdName}" />
        </list:data-column>
		
		<list:data-column col="remarkHref" escape="false">
			/km/supervise/km_supervise_main/kmSuperviseMain.do?method=view&fdId=${kmSuperviseMain.fdId}&remark=1
		</list:data-column>
		
		<list:data-column col="status" title="${lfn:message('km-supervise:kmSuperviseMain.docStatus')}" escape="false">
			<c:choose>
				<c:when test="${kmSuperviseMain.docStatus=='10' }">
					<span class="muiProcessStatusBorder muiProcessDraft"><bean:message key="status.draft"></bean:message></span>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='20' }">
					<span class="muiProcessStatusBorder muiProcessExamine"><bean:message key="status.examine"></bean:message></span>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='11' }">
					<span class="muiProcessStatusBorder muiProcessRefuse"><bean:message key="status.refuse"></bean:message></span>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='30' || kmSuperviseMain.docStatus=='40' }">
					<span class="muiProcessStatusBorder muiProcessPublish"><bean:message key="status.publish"></bean:message></span>
				</c:when>
				<c:when test="${kmSuperviseMain.docStatus=='00' }">
					<span class="muiProcessStatusBorder muiProcessDiscard"><bean:message key="status.discard"></bean:message></span>
				</c:when>
			</c:choose>
		</list:data-column>
    </list:data-columns>
    <%-- 分页信息生成 --%>
        <list:data-paging page="${queryPage}" />
</list:data>
