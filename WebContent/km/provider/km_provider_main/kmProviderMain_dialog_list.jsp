<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
</script>

<script type="text/javascript">
	//查看细节
	function showProviderDetail(id)
	{
		var path=location.href;
		path=Com_SetUrlParameter(Com_Parameter.ContextPath+'resource/jsp/frame.jsp','url',Com_Parameter.ContextPath+'km/provider/km_provider_main/kmProviderMain.do?method=view&fdId='+id);
		window.open(path);
	}

	//重写刷新方法
	function pageNavJsFunction(href){
		parent.document.kmProviderMainForm.submit();
	}
	
</script>
<% request.setAttribute("pageNavJsFunction","pageNavJsFunction"); %>
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table class="tb_normal" width=100% align="center">
		<tr>
			<td width="10pt"></td>
			<td width="30pt">
				<bean:message key="page.serial" />
			</td>
			<td width="150pt">
				<bean:message key="kmProviderMain.fdName" bundle="km-provider" />
			</td>
			<td width="150pt">
				<bean:message key="kmProviderMain.docCategory" bundle="km-provider" />
			</td>
			<td width="100pt">
				<bean:message key="kmProviderMain.fdBiao"	bundle="km-provider" />
			</td>
			<td width="40pt">
				<bean:message key="kmProviderMain.title.detail" bundle="km-provider" />
			</td>
		</tr>
		<c:forEach items="${queryPage.list}" var="kmProviderMain" varStatus="vstatus">
			<tr>
				<input type="hidden" name="selectProviderName" value="${kmProviderMain.fdName }" />
				<td width="10pt">
					<c:if test="${param.multi==true}">
						<input type="checkbox" name="selectProviderId" value="${kmProviderMain.fdId }" />
					</c:if>
					<c:if test="${param.multi!=true }">
						<input type="radio" name="selectProviderId" value="${kmProviderMain.fdId }" />
					</c:if>
				</td>
				<td width="30pt" align="center">${vstatus.index+1}</td>
				<td width="150pt"><c:out value="${kmProviderMain.fdName}" /></td>
				<td width="150pt"><c:out value="${kmProviderMain.docCategory.fdName}" /></td>
				<td width="100pt"><c:out value="${kmProviderMain.fdBiao}" /></td>
				<td width="40pt"><a href="javascipt:void(0)"
					onclick="showProviderDetail('${kmProviderMain.fdId}')"> <bean:message
					key="kmProviderMain.link.view" bundle="km-provider" /> </a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
<%@ include file="/resource/jsp/list_down.jsp"%>