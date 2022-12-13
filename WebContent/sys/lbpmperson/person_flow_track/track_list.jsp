<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="lbpmProcess" list="${queryPage.list }" varIndex="status">
	    <list:data-column property="fdId">
		</list:data-column >
		<list:data-column col="url" escape="false">
		    <c:if test="${not empty urltMap[lbpmProcess.fdId]}">
	             ${urltMap[lbpmProcess.fdId]}
	        </c:if>
		</list:data-column >
		<list:data-column col="index">
		     ${status+1}
		</list:data-column >
	    <!--标题-->
	    <list:data-column col="subject" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.docSubject') }" escape="false" style="text-align:left">
		     <c:if test="${not empty subjectMap[lbpmProcess.fdId]}">
		          <span class="com_subject">${subjectMap[lbpmProcess.fdId]}</span>
	        </c:if>
		</list:data-column>
		<!--所属模块-->
		<c:if test="${showModule==true}">
		    <list:data-column headerStyle="width:10%" col="subject" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.module') }" escape="false">
		         ${moduleMap[lbpmProcess.fdModelName]}
			</list:data-column>
		</c:if>
		<!--申请单编号-->
		<list:data-column headerStyle="width:100px" col="fdNumber" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.fdNumber') }" escape="false" >
			<c:if test="${not empty numberMap[lbpmProcess.fdId]}">
				${numberMap[lbpmProcess.fdId]}
			</c:if>
		</list:data-column>
	    <!--创建人-->
	    <list:data-column headerStyle="width:8%" property="fdCreator.fdName" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.creator') }"> 
		</list:data-column>
		<!--创建时间-->
		<list:data-column col="fdCreateTime" headerClass="width100" styleClass="width100" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.creatorTime') }">
				<kmss:showDate value="${lbpmProcess.fdCreateTime}" type="date"/>
		</list:data-column>
		<!--状态-->
		<list:data-column headerStyle="width:6%" col="fdStatus" title="${ lfn:message('sys-lbpmperson:lbpmperson.flow.docStatus') }" escape="false">
					<c:if test="${docStatusMap[lbpmProcess.fdId]=='00'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.discard') }
					</c:if>
					<c:if test="${docStatusMap[lbpmProcess.fdId]=='10'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.draft') }
					</c:if>
					 <c:if test="${docStatusMap[lbpmProcess.fdId]=='11'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.refuse') }
					</c:if>
					<c:if test="${docStatusMap[lbpmProcess.fdId]=='20'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.append') }
					</c:if>
				 
					<c:if test="${docStatusMap[lbpmProcess.fdId]=='30'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.publish') }
					</c:if>
					<c:if test="${docStatusMap[lbpmProcess.fdId]=='40'}">
						${ lfn:message('sys-lbpmperson:lbpmperson.status.expire') }
					</c:if>
		</list:data-column>
		<!--当前处理（节点）-->
		<list:data-column headerStyle="width:8%" col="nodeName" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.nodeName') }" escape="false">
			<kmss:showWfPropertyValues idValue="${lbpmProcess.fdId}" propertyName="nodeName" />
		</list:data-column>
		<!--当前处理人-->
		<list:data-column headerStyle="width:10%" col="handlerName" title="${ lfn:message('sys-lbpmperson:lbpmperson.person.handlerName') }" escape="false">
		    <kmss:showWfPropertyValues idValue="${lbpmProcess.fdId}" propertyName="handlerName" />
		</list:data-column>
		<list:data-column col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<a class="btn_txt" href="javascript:cancelFollowFun('${lbpmProcess.fdId}')">${lfn:message('sys-lbpmservice-support:lbpmFollow.button.cancelFollow')}</a>
				</div>
			</div>
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>