<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
	<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
</c:import>
<html:form action="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do">
	<div id="optBarDiv">
		
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=add&type=${param.type}" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do" />?method=add&type=${JsParam.type}');">
		</kmss:auth>
		<c:if test="${param.docStatus == 'draft' }">
		<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsBudgerApplicationForm, 'draftDelete');">
		</c:if>
		<c:if test="${param.docStatus != 'draft' }">
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmOitemsBudgerApplicationForm, 'deleteall');">
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
				<sunbor:column property="kmOitemsBudgerApplication.docSubject">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsBudgerApplication.fdTemplate.fdName">
					<bean:message  bundle="km-oitems" key="table.kmOitemsTemplet"/>
				</sunbor:column>
				
				<sunbor:column property="kmOitemsBudgerApplication.fdApplyor.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
				</sunbor:column>
				<!-- 申请者部门 -->
				<sunbor:column property="kmOitemsBudgerApplication.docDept.fdName">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsBudgerApplication.docCreateTime">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicants.time"/>
				</sunbor:column>
				<sunbor:column property="kmOitemsBudgerApplication.docStatus">
					<bean:message  bundle="km-oitems" key="kmOitemsGetApplication.docStatus"/>
				</sunbor:column>
				<!--<c:if test="${isReceive == '1' }">
				<sunbor:column property="kmOitemsBudgerApplication.fdOutStatus">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdOutStatus"/>
				</sunbor:column>
				</c:if>-->
				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmOitemsBudgerApplication" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do" />?method=view&fdId=${kmOitemsBudgerApplication.fdId}&type=${HtmlParam.type}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmOitemsBudgerApplication.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20">
					<c:out value="${kmOitemsBudgerApplication.docSubject}" />
				</td>
				<td>
					<c:out value="${kmOitemsBudgerApplication.fdTemplate.fdName}" />
				</td>
				
				<td>
					<c:out value="${kmOitemsBudgerApplication.fdApplyor.fdName}" />
				</td>
				<!-- 申请者部门 -->
				<td>
					<c:out value="${kmOitemsBudgerApplication.docDept.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${kmOitemsBudgerApplication.docCreateTime}"
					type="datetime" />
				</td>
				<td>
				<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='list'}">
				<c:if test="${kmOitemsBudgerApplication.docStatus!='30'}">
					<sunbor:enumsShow value="${kmOitemsBudgerApplication.docStatus}" enumsType="common_status"/>
				</c:if>
				</c:if>
				<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='list'}">
				<c:if test="${kmOitemsBudgerApplication.docStatus=='30'}">
					<sunbor:enumsShow value="${kmOitemsBudgerApplication.fdOutStatus}" enumsType="kmOitems_fdOutStatus"/>
				</c:if>
				</c:if>
				<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='listForReceive'}">
					<sunbor:enumsShow value="${kmOitemsBudgerApplication.fdOutStatus}" enumsType="kmOitems_fdOutStatus"/>
				</c:if>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>