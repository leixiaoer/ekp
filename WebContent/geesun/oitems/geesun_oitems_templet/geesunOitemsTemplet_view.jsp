<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${fdsize!=0}">
<%@ include file="/resource/jsp/view_top.jsp"%>
<div id="optBarDiv"> 
  <kmss:auth requestURL="/geesun/oitems/geesun_oitems_templet/geesunOitemsTemplet.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
	<input type="button" value="<bean:message key="button.edit"/>" onclick="Com_OpenWindow('geesunOitemsTemplet.do?method=edit&fdId=${JsParam.fdId}','_self');">
  </kmss:auth>	
  <input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>
<c:if test="${geesunOitemsTempletForm.fdTempletType eq '2' }">
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdTempletType.person"/></p>
</c:if>
<c:if test="${geesunOitemsTempletForm.fdTempletType eq '1' }">
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdTempletType.dept"/></p>
</c:if>
<center>
<table id="Label_Tabel" width=95%>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="table.geesunOitemsInfomation" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.fdName"/>
					<td colspan="3">
					    <c:out value="${geesunOitemsTempletForm.fdName}"></c:out>
					</td>
				</tr>
				<tr>
						<td class="td_normal_title" width="15%">
						   <bean:message key="model.tempReaderName" />
						</td>
						<td width="85%" colspan='3'>
						 <c:choose> 
							 <c:when test="${geesunOitemsTempletForm.authNotReaderFlag eq 'true'}">
							   <bean:message bundle="sys-simplecategory" key="description.main.tempReader.notUse" />
							 </c:when>
							 <c:otherwise>
							   ${geesunOitemsTempletForm.authReaderNames}
							 </c:otherwise>
						 </c:choose>
						 
						</td>
				</tr>
				<tr>
						<td class="td_normal_title" width="15%">
						   <bean:message key="model.tempEditorName" />
						</td>
						<td width="85%" colspan='3'>
						   ${geesunOitemsTempletForm.authEditorNames}
						</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.docCreatorId"/>
					<td>
                        <c:out value="${geesunOitemsTempletForm.docCreatorName}"></c:out>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsTemplet.docCreateTime"/>
					<td>
					    <c:out value="${geesunOitemsTempletForm.docCreateTime}"></c:out>
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_view.jsp"
		charEncoding="UTF-8">
		<c:param name="formName" value="geesunOitemsTempletForm" />
		<c:param name="fdKey" value="geesunOitemsTemplet" />
	</c:import>
	<!-- 编号规则 -->
	<c:import url="/sys/number/include/sysNumberMappTemplate_view.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="geesunOitemsTempletForm" />
		<c:param name="modelName" value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication"/>
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
			onclick="Com_OpenWindow('<c:url value="/geesun/oitems/geesun_oitems_templet/geesunOitemsTemplet.do" />?method=edit&fdModelName=com.landray.kmss.geesun.oitems.model.GeesunOitemsTemplet&fdKey=geesunOitemsTemplet&type=${fdType}');">
	</div>
<%@ include file="/resource/jsp/list_down.jsp"%>
</c:if>
