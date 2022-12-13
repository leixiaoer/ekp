<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
<list:data-columns var="sysTaskCategory" list="${queryPage.list}">
		<list:data-column property="fdId"/>
		<list:data-column property="fdName" title="${ lfn:message('sys-task:sysTaskCategory.fdName') }">
		</list:data-column>
		<list:data-column headerClass="width30" property="fdOrder" title="${ lfn:message('sys-task:sysTaskCategory.fdOrder') }">
		</list:data-column>	
		<list:data-column headerClass="width140" col="fdIsAvailable" title="${ lfn:message('sys-task:sysTaskCategory.fdIsAvailable') }">
		    <c:if test="${sysTaskCategory.fdIsAvailable=='true' }">
				<bean:message key="message.yes"/>
			</c:if>
			<c:if test="${sysTaskCategory.fdIsAvailable=='false' }">
				<bean:message key="message.no"/>
			</c:if>
		</list:data-column>
		<list:data-column headerClass="width180" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!-- 操作列 -->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/sys/task/sys_task_category/sysTaskCategory.do?method=edit&fdId=${sysTaskCategory.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${sysTaskCategory.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<kmss:auth requestURL="/sys/task/sys_task_category/sysTaskCategory.do?method=delete&fdId=${sysTaskCategory.fdId}" requestMethod="POST">
						<!-- 删除 -->
						<a class="btn_txt" href="javascript:deleteAll('${sysTaskCategory.fdId}')">
							<bean:message key="button.delete"/>
						</a>
					</kmss:auth>
						<!-- 禁用-->
					<c:if test="${sysTaskCategory.fdIsAvailable==false}">
						<a class="btn_txt" href="javascript:enable('${sysTaskCategory.fdId}')">
							<bean:message bundle="sys-task" key="sysTaskMain.btn.open"/>
						</a>
					</c:if>
					<c:if test="${sysTaskCategory.fdIsAvailable==true}">
						<a class="btn_txt" href="javascript:disable('${sysTaskCategory.fdId}')">
							<bean:message bundle="sys-task" key="sysTaskMain.btn.close"/>
						</a>
					</c:if>		
						</div>
					</div>	
			<!--操作按钮 结束-->
		</list:data-column>			
	</list:data-columns>	
	
	<list:data-paging page="${ queryPage }"></list:data-paging>
</list:data>