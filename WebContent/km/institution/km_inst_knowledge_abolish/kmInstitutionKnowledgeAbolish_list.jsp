<%@ page language="java" contentType="text/json; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<list:data>
	<list:data-columns var="kmInstitutionKnowledgeAbolish" list="${queryPage.list }" varIndex="status">
		<%--ID--%>
		<list:data-column property="fdId"></list:data-column>
		<%--序号--%>
		<list:data-column col="index">${status+1 }</list:data-column>
		<%--主题--%>
		<list:data-column property="docSubject" title="${ lfn:message('km-institution:kmInstitution.docSubject') }" style="text-align:left">
		</list:data-column>
		<%--文档状态--%>
		<list:data-column col="docStatus" headerStyle="width:80px;"  title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus') }">
			<sunbor:enumsShow value="${kmInstitutionKnowledgeAbolish.docStatus}" enumsType="kmInstitutionKnowledge_docStaus" />
		</list:data-column>
		<%--录入人--%>
		<list:data-column headerStyle="width:120px;"  col="docCreator.fdName" title="${ lfn:message('sys-doc:sysDocBaseInfo.docCreator') }" escape="false">
			<ui:person personId="${kmInstitutionKnowledgeAbolish.docCreator.fdId}" personName="${kmInstitutionKnowledgeAbolish.docCreator.fdName}"></ui:person>
		</list:data-column>
		<%--录入时间--%>
		<list:data-column headerStyle="width:120px;"  col="docCreateTime" title="${ lfn:message('sys-doc:sysDocBaseInfo.docCreateTime') }" escape="false">
			<kmss:showDate value="${kmInstitutionKnowledgeAbolish.docCreateTime}" type="date" />
		</list:data-column>
		<list:data-column headerClass="width80" col="operations" title="${ lfn:message('list.operation') }" escape="false">
			<!--操作按钮 开始-->
			<div class="conf_show_more_w">
				<div class="conf_btn_edit">
				<%-- <c:if test="${kmInstitutionKnowledgeAbolish.docStatus == '30' || kmInstitutionKnowledgeAbolish.docStatus == '10' }"> --%>
					<kmss:auth 	requestURL="/km/institution/km_inst_knowledge_abolish/kmInstitutionKnowledgeAbolish.do?method=delete&fdId=${kmInstitutionKnowledgeAbolish.fdId}" requestMethod="GET">
						<!-- 禁用 -->
						<a class="btn_txt" href="javascript:deleteAll('${kmInstitutionKnowledgeAbolish.fdId}')">${lfn:message('button.delete')}</a>
					</kmss:auth>
				<%-- </c:if> --%>
				
				</div>
			</div>
			<!--操作按钮 结束-->
		</list:data-column>
	</list:data-columns>

	<list:data-paging currentPage="${queryPage.pageno }"
		pageSize="${queryPage.rowsize }" totalSize="${queryPage.totalrows }">
	</list:data-paging>
</list:data>