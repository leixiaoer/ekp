<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<list:data>
	<list:data-columns var="node" list="${queryPage.list}" varIndex="index">
		<list:data-column property="fdId" />
		<list:data-column col="index">
		     ${index + 1}
		</list:data-column>
		<!-- 模板名称 -->
		<list:data-column headerClass="width200" col="subject" title="${lfn:message('sys-organization:sysOrgMatrix.relation.subject')}">
			${subjectMap[node.fdId]}
		</list:data-column>
		<!-- 节点名称 -->
		<list:data-column headerClass="width200" col="factName" title="${lfn:message('sys-organization:sysOrgMatrix.relation.factName')}">
			${node.fdFactName}
		</list:data-column>
		<!-- 修改人 -->
		<list:data-column headerClass="width200" col="alterorName" title="${lfn:message('sys-organization:sysOrgMatrix.relation.alterorName')}">
			${alterorNameMap[node.fdId]}
		</list:data-column>
		<!-- 修改时间 -->
		<list:data-column headerClass="width200" col="alterTime" title="${lfn:message('sys-organization:sysOrgMatrix.relation.alterTime')}">
			${alterTimeMap[node.fdId]}
		</list:data-column>
		<!-- 引用矩阵版本 -->
		<list:data-column headerClass="width200" col="version" title="${lfn:message('sys-organization:sysOrgMatrix.relation.version')}">
			${versionMap[node.fdId]}
		</list:data-column>
		
		<!-- 其它操作 -->
		<list:data-column headerClass="width120" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<!-- 同步 -->
					<a class="btn_txt" href="javascript:sync('${node.fdId}', '${versionMap[node.fdId]}')">${lfn:message('sys-organization:sysOrgMatrix.relation.sync')}</a>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>