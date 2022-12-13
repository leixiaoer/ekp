<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog" >
	<%--选择列表--%>
	<template:replace name="content"> 
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" >
			<kmss:auth requestURL="/km/pindagate/km_pindagate_main_temp/kmPindagateMainTemp.do?method=add">
				<ui:button text="${lfn:message('button.ok')}"  onclick="select();" ></ui:button>
			</kmss:auth>
		</ui:toolbar>
		<table width=100% cellspacing=0 border=0 cellpadding=0>
			<% if(request.getParameter("s_path")!=null){ %>
			<tr>
				<td><span class=txtlistpath><bean:message key="page.curPath"/><%= request.getParameter("s_path") %></span></td>
			</tr>
			<% } %>
			<tr>
				<td>
					<table id="List_ViewTable" class="tb_normal" width="100%">
						<tr>
							<td width="10pt" class="td_normal_title">
								<input type="checkbox" name="List_Tongle" id="List_Tongle">
							</td>
							<td width="40pt"  align="center" class="td_normal_title">
								<bean:message key="page.serial"/>
							</td>
							<td align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.question"/></td>
							<td width="20%" align="center" class="td_normal_title"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.fdType"/></td>
						</tr>
						<c:forEach items="${kmPindagateMainTempForm.fdItems}" var="kmPindagateTitleForm" varStatus="vstatus">
							<c:choose>
							<c:when test="${kmPindagateTitleForm.fdSplit}">
								<tr>
									<td>
										<input type="checkbox" name="List_Selected" value="${kmPindagateTitleForm.fdId}">
									</td>
									<td align="center" >${vstatus.index+1}</td>
									<td align="center" title="${kmPindagateTitleForm.fdName}">
										<c:choose>
											<c:when test="${fn:length(kmPindagateTitleForm.fdName)>23}">${fn:substring(kmPindagateTitleForm.fdName,0,22)}..</c:when>
											<c:otherwise><c:out value="${kmPindagateTitleForm.fdName}" /></c:otherwise>
										</c:choose>
									</td>
									<td align="center" >
										<c:if test="${kmPindagateTitleForm.fdType=='singleselect'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.singleselect"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='multiselect'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.multiselect"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='singlematrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.singlematrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='multimatrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.multimatrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='score'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.score"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='essayquestion'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.essayquestion"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='scorematrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scorematrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='formfilled'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.formfilled"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='matrixfilled'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.matrixfilled"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='fillquestions'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.fillquestions"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType==''}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>
										</c:if>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>
										<input type="checkbox" name="List_Selected" value="${kmPindagateTitleForm.fdId}">
									</td>
									<td align="center">${vstatus.index+1}</td>
									<td align="center"  title="${kmPindagateTitleForm.fdName}">
										<c:choose>
											<c:when test="${fn:length(kmPindagateTitleForm.fdName)>23}">${fn:substring(kmPindagateTitleForm.fdName,0,22)}..</c:when>
											<c:otherwise><c:out value="${kmPindagateTitleForm.fdName}" /></c:otherwise>
										</c:choose>
									</td>
									<td align="center">
										<c:if test="${kmPindagateTitleForm.fdType=='singleselect'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.singleselect"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='multiselect'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.multiselect"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='singlematrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.singlematrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='multimatrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.multimatrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='score'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.score"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='essayquestion'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.essayquestion"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='scorematrix'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scorematrix"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='formfilled'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.formfilled"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='matrixfilled'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.matrixfilled"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType=='fillquestions'}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.fillquestions"/>
										</c:if>
										<c:if test="${kmPindagateTitleForm.fdType==''}">
											<bean:message bundle="km-pindagate" key="kmPindagateQuestion.button.insertPageBreak"/>
										</c:if>
									</td>
								</tr>
							</c:otherwise>
							</c:choose>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
	</template:replace>
</template:include>
<script language="JavaScript">
	seajs.use(['lui/jquery', 'lui/dialog'], function($, dialog) {
		$("#List_Tongle").click(function(){
			if($("#List_Tongle").prop('checked')==true){
				$(":input[name='List_Selected']").each(function(){
				    $(this).prop("checked",true);
				});
			}else{
				$(":input[name='List_Selected']").each(function(){
				    $(this).prop("checked",false);
				});
			}
		});
		//选择
		window.select=function(){
			var values ="";
			$("input[name='List_Selected']:checked").each(function(){
				values+=$(this).val()+";";
			});
			if(values.length==0){
				dialog.alert('<bean:message key="page.noSelect"/>');
				return;
			}else{
				if(window.$dialog){
					window.$dialog.hide(values);
				}else{//兼容旧UED
					window.returnValue=values;
					window.close();
				}
			}
		};
	});
</script>