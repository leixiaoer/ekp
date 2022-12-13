<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|dialog.js|treeview.js");
</script>
<script type="text/javascript">
	function showTemplateDialog(){
		Dialog_Tree(false,null,null,null,'kmCarmngMotorcadeSetTreeService&categoryId=!{value}',
			'<bean:message key="kmCarmngMotorcadeSet.tree.title" bundle="km-carmng"/>',null,afterSelectTemplate,null,null,true);
	}
	function afterSelectTemplate(rtnVal){	
		var fdTempletId;
		var fdTempletName;		
		if(rtnVal == null)
			return;
		var data = rtnVal.GetHashMapArray();
		if(data.length > 0 ){
			fdTempletName = data[0]["name"];
			fdTempletId = data[0]["id"];
		}
		else{
			return;
		}		
		Com_OpenWindow('<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do" />?method=add&fdTempletId='+fdTempletId);
	}
	function List_ConfirmDel(checkName){
		return List_CheckSelect(checkName) && confirm('<bean:message key="kmCarmngApplication.delete.confirm" bundle="km-carmng"/>');
	}
</script>
<html:form action="/km/carmng/km_carmng_application/kmCarmngApplication.do" >
<c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
	<c:param name="fdModelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication" />
    </c:import>
	<div id="optBarDiv">
		<kmss:auth requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add" requestMethod="GET">
			<input type="button" value="<bean:message key="button.add"/>"
				onclick="showTemplateDialog();">
		</kmss:auth>
		<c:if test="${param.docStatus == '10' }">
		<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngApplicationForm, 'deleteDraft');">
		</c:if>
		<c:if test="${param.docStatus != '10' }">
		<kmss:auth requestURL="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=deleteall" requestMethod="GET">
			<input type="button" value="<bean:message key="button.deleteall"/>"
				onclick="if(!List_ConfirmDel())return;Com_Submit(document.kmCarmngApplicationForm, 'deleteall');">
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
				<sunbor:column property="kmCarmngApplication.docSubject">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.docSubject"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.fdDestination">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdDestination"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.fdApplicationPath">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdApplicationPath"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.fdStartTime">
					<bean:message  bundle="km-carmng" key="kmCarmng.fdUseTime"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.fdUserNumber">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdUserNumber"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.fdApplicationPerson.fdName">				
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdApplicationPerson"/>
				</sunbor:column>
				<sunbor:column property="kmCarmngApplication.docCreateTime">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.fdApplicationTime"/>
				</sunbor:column>	
									
				<sunbor:column property="kmCarmngApplication.docStatus">
					<bean:message  bundle="km-carmng" key="kmCarmngApplication.docStatus"/>
				</sunbor:column>
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmCarmngApplication" varStatus="vstatus">
			<tr
				kmss_href="<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do" />?method=view&fdId=${kmCarmngApplication.fdId}">
				<td>
					<input type="checkbox" name="List_Selected" value="${kmCarmngApplication.fdId}">
				</td>
				<td>${vstatus.index+1}</td>
				<td kmss_wordlength="20">
					<c:out value="${kmCarmngApplication.docSubject}" />
				</td>
				<td kmss_wordlength="20">
					<c:out value="${kmCarmngApplication.fdDestination}" />
				</td>
				<td kmss_wordlength="30">
					<c:out value="${kmCarmngApplication.fdApplicationPath}" />
				</td>
				<td kmss_wordlength="40">
					<kmss:showDate value="${kmCarmngApplication.fdStartTime}" ></kmss:showDate>
				<bean:message bundle="km-carmng" key="kmCarmng.message.title0"/>
					<kmss:showDate value="${kmCarmngApplication.fdEndTime}" ></kmss:showDate>
				</td>
				<td>
					<c:out value="${kmCarmngApplication.fdUserNumber}" />
				</td>
				<td>
					<c:out value="${kmCarmngApplication.fdApplicationPerson.fdName}" />
				</td>
				<td>
					<kmss:showDate value="${kmCarmngApplication.docCreateTime}" />
				</td>	
				
				<td>
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
				</td>	
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
<%@ include file="/resource/jsp/list_down.jsp"%>