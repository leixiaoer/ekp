<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${fdsize!=0}">
<%@ include file="/resource/jsp/view_top.jsp"%>
<div id="optBarDiv"> 
  <kmss:auth requestURL="/km/oitems/km_oitems_templet/kmOitemsTemplet.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
	<input type="button" value="<bean:message key="button.edit"/>" onclick="Com_OpenWindow('kmOitemsTemplet.do?method=edit&fdId=${JsParam.fdId}','_self');">
  </kmss:auth>	
  <input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<c:if test="${kmOitemsTempletForm.fdTempletType eq '2' }">
<p class="txttitle"><bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdTempletType.person"/></p>
</c:if>
<c:if test="${kmOitemsTempletForm.fdTempletType eq '1' }">
<p class="txttitle"><bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdTempletType.dept"/></p>
</c:if>
<center>
<table id="Label_Tabel" width=95%>
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="table.kmOitemsInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.fdName"/>
					<td colspan="3">
					    <c:out value="${kmOitemsTempletForm.fdName}"></c:out>
					</td>
				</tr>
				<tr>
						<td class="td_normal_title" width="15%">
						   <bean:message key="model.tempReaderName" />
						</td>
						<td width="85%" colspan='3'>
						 <c:choose> 
							 <c:when test="${kmOitemsTempletForm.authNotReaderFlag eq 'true'}">
							   <bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
							 </c:when>
							 <c:otherwise>
							   ${kmOitemsTempletForm.authReaderNames}
							 </c:otherwise>
						 </c:choose>
						 
						</td>
				</tr>
				<tr>
						<td class="td_normal_title" width="15%">
						   <bean:message key="model.tempEditorName" />
						</td>
						<td width="85%" colspan='3'>
						   ${kmOitemsTempletForm.authEditorNames}
						</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.docCreatorId"/>
					<td>
                        <c:out value="${kmOitemsTempletForm.docCreatorName}"></c:out>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsTemplet.docCreateTime"/>
					<td>
					    <c:out value="${kmOitemsTempletForm.docCreateTime}"></c:out>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="kmOitemsTempletForm" />
		<c:param name="fdKey" value="kmOitemsTemplet" />
	</c:import>
	<!-- 编号规则 -->
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmOitemsTempletForm" />
		<c:param name="modelName" value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication"/>
	</c:import>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
</c:if>
<c:if test="${fdsize==0}">
<%@ include file="/resource/jsp/list_top.jsp"%>
<%@ include file="/resource/jsp/list_norecord.jsp"%>
	<div id="optBarDiv">
		<input type="button" value="<bean:message key="button.add"/>"
			onclick="Com_OpenWindow('<c:url value="/km/oitems/km_oitems_templet/kmOitemsTemplet.do" />?method=edit&fdModelName=com.landray.kmss.km.oitems.model.KmOitemsTemplet&fdKey=kmOitemsTemplet&type=${fdType}');">
	</div>
<%@ include file="/resource/jsp/list_down.jsp"%>
</c:if>
