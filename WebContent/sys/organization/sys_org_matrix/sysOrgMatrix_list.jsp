<%@ page import="com.landray.kmss.sys.authorization.util.TripartiteAdminUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<!-- 表格数据 -->
	<list:data-columns var="sysOrgMatrix" list="${queryPage.list }">
		<list:data-column property="fdId" />
		<!-- 排序号 -->
		<list:data-column headerClass="width80"  property="fdOrder" title="${ lfn:message('sys-organization:sysOrgMatrix.fdOrder') }">
		</list:data-column>
		<!-- 矩阵类别 -->
		<list:data-column headerClass="width200" col="fdGroupCate" title="${ lfn:message('sys-organization:sysOrgMatrix.fdCategory') }">
			${sysOrgMatrix.fdCategory.fdName}
		</list:data-column>
		<!-- 矩阵名称 -->
		<list:data-column headerClass="width200" property="fdName" title="${ lfn:message('sys-organization:sysOrgMatrix.fdName') }">
		</list:data-column>
		<!-- 是否内置还是人工创建 -->
		<list:data-column col="matrixType">
			<c:if test="${sysOrgMatrix.matrixType=='1'}">
				(${ lfn:message('sys-organization:sysOrgMatrix.matrixType.sysCreate.message') })
			</c:if>
			<c:if test="${sysOrgMatrix.matrixType!='1'}">
				(${ lfn:message('sys-organization:sysOrgMatrix.matrixType.peopleCreate.message') })
			</c:if>
		</list:data-column>
		<!-- 描述 -->
		<list:data-column property="fdDesc">
		</list:data-column>
		<!-- 状态 -->
		<list:data-column headerClass="width100" col="fdIsAvailable" title="${ lfn:message('sys-organization:sysOrgMatrix.fdIsAvailable') }">
			<sunbor:enumsShow value="${sysOrgMatrix.fdIsAvailable}" enumsType="sys_org_available_result" />
		</list:data-column>
		<!-- 原始状态 -->
		<list:data-column col="isAvailable">
			${sysOrgMatrix.fdIsAvailable}
		</list:data-column>
		<!-- 其它操作 -->
		<list:data-column headerClass="width200" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
					<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=edit&fdId=${sysOrgMatrix.fdId}" requestMethod="GET">
						<!-- 编辑 -->
						<a class="btn_txt" href="javascript:edit('${sysOrgMatrix.fdId}')">${lfn:message('button.edit')}</a>
					</kmss:auth>
					<c:if test="${sysOrgMatrix.fdIsAvailable}">
					<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=invalidated&fdId=${sysOrgMatrix.fdId}" requestMethod="GET">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:invalidated('${sysOrgMatrix.fdId}')">${ lfn:message('sys-organization:sys.org.available.false') }</a>
					</kmss:auth>
					</c:if>
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
		<!-- 编辑权限 -->
		<list:data-column col="edit_auth">
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=edit&fdId=${sysOrgMatrix.fdId}" requestMethod="GET">
				true
			</kmss:auth>
		</list:data-column>
		<!-- 分组维护者 -->
		<list:data-column col="data_cate_auth">
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=dataCate&fdId=${sysOrgMatrix.fdId}" requestMethod="GET">
				true
			</kmss:auth>
		</list:data-column>
	</list:data-columns>

	<!-- 分页 -->
	<list:data-paging currentPage="${queryPage.pageno }" pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }" />
</list:data>