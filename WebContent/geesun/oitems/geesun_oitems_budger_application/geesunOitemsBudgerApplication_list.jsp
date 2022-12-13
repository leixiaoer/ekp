<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
	<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
</c:import>
<html:form action="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do">
	<div id="optBarDiv">
		
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=add&type=${param.type}" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" />?method=add&type=${JsParam.type}');">
		</kmss:auth>
		<c:if test="${param.docStatus == 'draft' }">
		<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsBudgerApplicationForm, 'draftDelete');">
		</c:if>
		<c:if test="${param.docStatus != 'draft' }">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.geesunOitemsBudgerApplicationForm, 'deleteall');">
		</kmss:auth>
		</c:if>
		<input  type="button" value="<bean:message key="button.search"/>" onclick="Search_Show();">
	</div>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
				<td width="10pt"><input type="checkbox" name="List_Tongle"></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<sunbor:column property="geesunOitemsBudgerApplication.docSubject">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsBudgerApplication.fdTemplate.fdName">
					<bean:message  bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
				</sunbor:column>
				
				<sunbor:column property="geesunOitemsBudgerApplication.fdApplyor.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
				</sunbor:column>
				<!-- 申请者部门 -->
				<sunbor:column property="geesunOitemsBudgerApplication.docDept.fdName">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsBudgerApplication.docCreateTime">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicants.time"/>
				</sunbor:column>
				<sunbor:column property="geesunOitemsBudgerApplication.docStatus">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsGetApplication.docStatus"/>
				</sunbor:column>
				<!--<c:if test="${isReceive == '1' }">
				<sunbor:column property="geesunOitemsBudgerApplication.fdOutStatus">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdOutStatus"/>
				</sunbor:column>
				</c:if>-->
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsBudgerApplication" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do" />?method=view&fdId=${geesunOitemsBudgerApplication.fdId}&type=${HtmlParam.type}">
				<td>
					<input type="checkbox" name="List_Selected" value="${geesunOitemsBudgerApplication.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20">
					<c:out value="${geesunOitemsBudgerApplication.docSubject}" />
				</td>
				<td>
					<c:out value="${geesunOitemsBudgerApplication.fdTemplate.fdName}" />
				</td>
				
				<td>
					<c:out value="${geesunOitemsBudgerApplication.fdApplyor.fdName}" />
				</td>
				<!-- 申请者部门 -->
				<td>
					<c:out value="${geesunOitemsBudgerApplication.docDept.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${geesunOitemsBudgerApplication.docCreateTime}"
					type="datetime" />
				</td>
				<td>
				<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='list'}">
				<c:if test="${geesunOitemsBudgerApplication.docStatus!='30'}">
					<sunbor:enumsShow value="${geesunOitemsBudgerApplication.docStatus}" enumsType="common_status"/>
				</c:if>
				</c:if>
				<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='list'}">
				<c:if test="${geesunOitemsBudgerApplication.docStatus=='30'}">
					<sunbor:enumsShow value="${geesunOitemsBudgerApplication.fdOutStatus}" enumsType="geesunOitems_fdOutStatus"/>
				</c:if>
				</c:if>
				<c:if test="${geesunOitemsBudgerApplicationForm.method_GET=='listForReceive'}">
					<sunbor:enumsShow value="${geesunOitemsBudgerApplication.fdOutStatus}" enumsType="geesunOitems_fdOutStatus"/>
				</c:if>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>
