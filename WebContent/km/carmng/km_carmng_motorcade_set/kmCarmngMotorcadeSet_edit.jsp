<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<c:choose>
	<c:when test="${kmCarmngMotorcadeSetForm.method_GET=='add' }">
	    <kmss:windowTitle 
  				subject="${ lfn:message('km-carmng:kmCarmngMotorcadeSet.create.title') } - ${lfn:message('km-carmng:module.km.carmng')}" />
	</c:when>
	<c:otherwise>
	    <kmss:windowTitle 
  				subject="${kmCarmngMotorcadeSetForm.fdName}- ${ lfn:message('km-carmng:module.km.carmng') } " />
	</c:otherwise>
</c:choose>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|calendar.js");
</script>
<script>
function commitMethod(method){
  Com_Submit(document.kmCarmngMotorcadeSetForm, method);
}
</script>

	<div id="optBarDiv">
		    <c:if test="${kmCarmngMotorcadeSetForm.method_GET=='edit'}">
		       <input type=button value="${lfn:message('button.update') }" onclick="commitMethod('update');" />
			</c:if>
			<c:if test="${kmCarmngMotorcadeSetForm.method_GET=='add'}">
			   <input type=button value="${lfn:message('button.save') }"  onclick="commitMethod('save');" />
			   <input type=button value="${lfn:message('button.saveadd') }"  onclick="commitMethod('saveadd');" />
			</c:if>
			<input type=button value="${lfn:message('button.close') }" order="5" onclick="Com_CloseWindow();" />
	</div>

<p class="txttitle"><bean:message bundle="km-carmng" key="table.kmCarmngMotorcadeSet"/></p>

<html:form action="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do"> 

<center>
<table id="Label_Tabel" width="95%">
	<tr LKS_LabelName="<bean:message bundle="km-carmng" key="kmCarmng.base.info" />">
		<td>
			<table class="tb_normal" width="100%">
				<html:hidden property="fdId"/>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.fdName"/>
					</td><td width=35%>
						<xform:text property="fdName" validators="required" style="width:95%" showStatus="edit" required="true"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.fdOrder"/>
					</td><td width=35%>
						<xform:text property="fdOrder" validators="digits"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.fdDispatchersId"/>
					</td><td width=35%>
						<xform:address propertyId="fdDispatchersId" propertyName="fdDispatchersName" subject="${lfn:message('km-carmng:kmCarmngMotorcadeSet.fdDispatchersId')}" orgType="ORG_TYPE_POSTORPERSON" style="width:95%" required="true" ></xform:address>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.fdRegisterId"/>
					</td><td width=35%>
						<xform:address propertyId="fdRegisterId" propertyName="fdRegisterName" subject="${lfn:message('km-carmng:kmCarmngMotorcadeSet.fdRegisterId')}" orgType="ORG_TYPE_POSTORPERSON" style="width:95%" required="true" ></xform:address>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-carmng" key="kmCarmngMotorcadeSet.isEffective"/>
					</td><td colspan="3">
						<xform:radio property="isEffective" required="true">
							<xform:enumsDataSource enumsType="common_yesno" />
						</xform:radio>
					</td>
				</tr>
				<!-- 车队描述 -->
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.fdRemark"/>
					</td><td width=35% colspan="3">
						<xform:textarea style="width:95%" htmlElementProperties="data-actor-expand='true'" property="fdRemark"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message key="model.tempEditorName"/>
					</td>
					<td colspan="3">
						<xform:address propertyId="authEditorIds" propertyName="authEditorNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
						<div class="description_txt">
							<bean:message	bundle="km-carmng" key="kmCarmngMotorcadeSet.authEditor.tip" />
						</div>
					</td>
				</tr>
				<tr>
					<!-- 可使用者 -->
					<td class="td_normal_title" width=15%>
						<bean:message key="model.tempReaderName"/>
					</td>
					<td width="35%" colspan="3">
						<xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
						<div class="description_txt">
							<bean:message	bundle="km-carmng" key="kmCarmngMotorcadeSet.authReader.tip" />
						</div>
					</td>
				</tr>
				
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.docCreatorId"/>
					</td><td width=35%>
						<html:hidden property="docCreatorId"/>
						<html:text readonly="true" property="docCreatorName"/>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-carmng" key="kmCarmngMotorcadeSet.docCreateTime"/>
					</td><td width=35%>
						<html:text readonly="true" property="docCreateTime"/>
					</td>	
				</tr>
			</table>
		</td>
	</tr>
	<!-- 编号机制 -->
	<c:import url="/sys/workflow/include/sysWfTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmCarmngMotorcadeSetForm" />
		<c:param name="fdKey" value="kmCarmngMotorcadeSet" />
		<c:param name="messageKey" value="km-carmng:kmCarmng.tree.application.sys.workflow"/>
	</c:import>
	<c:import url="/sys/number/include/sysNumberMappTemplate_edit.jsp" charEncoding="UTF-8">
		<c:param name="formName" value="kmCarmngMotorcadeSetForm" />
		<c:param name="modelName" value="com.landray.kmss.km.carmng.model.KmCarmngApplication"/>
	</c:import>
</table>
</center>
<html:hidden property="method_GET"/>
<html:hidden property="docStatus" value="30"/>
 <script language="JavaScript">
	$KMSSValidation(document.forms['kmCarmngMotorcadeSetForm']);
 </script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>