<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<html:form action="/km/vote/km_vote_record/kmVoteRecord.do">
<div id="optBarDiv">
	<c:if test="${kmVoteRecordForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmVoteRecordForm, 'update');">
	</c:if>
	<c:if test="${kmVoteRecordForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmVoteRecordForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmVoteRecordForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-vote" key="table.kmVoteRecord"/></p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.docCreateTime"/>
		</td><td width="35%">
			<xform:datetime property="docCreateTime" showStatus="view" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.fdMainItemIds"/>
		</td><td width="35%">
			<xform:text property="fdMainItemIds" style="width:85%" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.docCreator"/>
		</td><td width="35%">
			<xform:address propertyId="docCreatorId" propertyName="docCreatorName" orgType="ORG_TYPE_PERSON" showStatus="view" />
		</td>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteMain"/>
		</td><td width="35%">
			<xform:select property="kmVoteMainId">
				<xform:beanDataSource serviceBean="xxMainService" selectBlock="fdId,docSubject" orderBy="" />
			</xform:select>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-vote" key="kmVoteRecord.kmVoteComment"/>
		</td><td width="35%">
			<xform:select property="kmVoteCommentId">
				<xform:beanDataSource serviceBean="kmVoteCommentService" selectBlock="fdId,fdId" orderBy="" />
			</xform:select>
		</td>
		<td class="td_normal_title" width=15%>&nbsp;</td><td width=35%>&nbsp;</td>
	</tr>
</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="method_GET" />
<script>
	$KMSSValidation();
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>