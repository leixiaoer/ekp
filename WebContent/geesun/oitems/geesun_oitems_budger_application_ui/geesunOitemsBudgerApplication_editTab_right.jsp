<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:replace name="content"> 
<%@ page import=" com.landray.kmss.util.KmssMessageWriter, com.landray.kmss.util.KmssReturnPage" %>
<script type="text/javascript">
Com_Parameter.CloseInfo="<bean:message key="message.closeWindow"/>";
Com_IncludeFile("docutil.js|optbar.js|validator.jsp|validation.js|plugin.js|validation.jsp|xform.js", null, "js");
</script>
<br>
<% if(request.getAttribute("KMSS_RETURNPAGE")==null){ %>
<logic:messagesPresent>
	<table align=center><tr><td>
		<font class="txtstrong"><bean:message key="errors.header.vali"/></font>
		<bean:message key="errors.header.correct"/>
		<html:messages id="error">
			<br><img src='${KMSS_Parameter_StylePath}msg/dot.gif'>&nbsp;&nbsp;<bean:write name="error"/>
		</html:messages>
	</td></tr></table>
	<hr />
</logic:messagesPresent>
<% }else{
	KmssMessageWriter msgWriter = new KmssMessageWriter(request, (KmssReturnPage)request.getAttribute("KMSS_RETURNPAGE"));
%>
<script>
Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
function showMoreErrInfo(index, srcImg){
	var obj = document.getElementById("moreErrInfo"+index);
	if(obj!=null){
		if(obj.style.display=="none"){
			obj.style.display="block";
			srcImg.src = Com_Parameter.StylePath + "msg/minus.gif";
		}else{
			obj.style.display="none";
			srcImg.src = Com_Parameter.StylePath + "msg/plus.gif";
		}
	}
}

</script>
<hr/>
<% } %>
<script type="text/javascript">
	Com_IncludeFile("calendar.js|dialog.js|doclist.js"); 
</script>
<script type="text/javascript">
function commitMethod(commitType, saveDraft){
	_validation.validateElement(document.getElementById("listingValidate"));
	var formObj = document.geesunOitemsBudgerApplicationForm;
	var docStatus = document.getElementsByName("docStatus")[0];
	if(docStatus.value!="30"&&docStatus.value!="31"&&('${geesunOitemsBudgerApplicationForm.method_GET}'=='add'||'${geesunOitemsBudgerApplicationForm.method_GET}'=='edit')){
		if(saveDraft=="true"){
			docStatus.value="10";
		}else{
			docStatus.value="20";
		}
	}
	Com_Submit(formObj, commitType);
}

//校验物品列表是否为空
function validateListing(){
	if($("#TABLE_DocList tr:not(:first)").length>0){
         return true;
	}else{
		 return false;
	}
}

	  $(document).ready(function(){
		  initGeesunOitemsType("${geesunOitemsBudgerApplicationForm.fdType}");
	  });
	  
function afterApplicantSelect(){
	var url = "${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=getApplicantDept";
	var fdApplicantsId = document.getElementsByName("fdApplicantsId")[0];
	 $.ajax({     
   	     type:"post",   
   	     url:url,     
   	     data:{fdApplicantsId:fdApplicantsId.value},    
   	     async:false,    //用同步方式 
   	     success:function(data){
   	 	    var results =  eval("("+data+")");
   	 	    if(results['deptId']!=""&&results['deptName']!=""){
   	 	     //document.getElementsByName("docDeptId")[0].value = results['deptId'];
   	 	     //document.getElementsByName("docDeptName")[0].value = results['deptName'];
   	 	      var kmssData = new KMSSData();
	          kmssData.AddHashMap({deptId:results['deptId'],deptName:results['deptName']});
	          kmssData.PutToField("deptId:deptName", "docDeptId:docDeptName", "", false);
   	   	 	}else{
   	   	 	  //document.getElementsByName("docDeptId")[0].value = "";
  	 	      //document.getElementsByName("docDeptName")[0].value = "";
		   	  var address = Address_GetAddressObj("docDeptName");
			  address.emptyAddress(true);
   	   	 	}
   		 }    
     });
}
</script>
<c:if test="${param.approveModel ne 'right'}">
		<form name="geesunOitemsBudgerApplicationForm" method="post" action ="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do">
	</c:if>	
<p class="txttitle">
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.dept.application"/>
</c:if>
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.person.application"/>
</c:if>
</p>
<div class="lui_form_content_frame" style="padding-top:20px">
	<div id="geesunOitemsAppForm">
			<table class="tb_normal" width=100% id="Table_Main">
				<html:hidden property="fdId"/>
				<html:hidden property="docStatus"/>
				<html:hidden property="fdType"/>
				<html:hidden property="fdTempletType" value="${geesunOitemsBudgerApplicationForm.fdType}"/>
				<tr>
				    <td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
					</td><td width=85% colspan="4">
						 <div style="width:82%;display: inline-block;">
							<c:if test="${geesunOitemsBudgerApplicationForm.titleRegulation==null || geesunOitemsBudgerApplicationForm.titleRegulation=='' }">
								<xform:text property="docSubject"  style="width:95%;" className="inputsgl"/>
							</c:if>
							<c:if test="${geesunOitemsBudgerApplicationForm.titleRegulation!=null && geesunOitemsBudgerApplicationForm.titleRegulation!='' }">
								<xform:text property="docSubject" style="width:95%;height:auto;color:#333;" className="inputsgl" showStatus="readOnly" value="${lfn:message('km-review:kmReviewMain.docSubject.info') }" />
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
				<td class="td_normal_title" width=15%>
					<c:if test="${geesunOitemsBudgerApplicationForm.fdType =='1'}">
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicants.deptId"/>
					</c:if>
					<c:if test="${geesunOitemsBudgerApplicationForm.fdType =='2'}">
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
					</c:if>
					</td>
					<td width=35%>					
						 <c:if test="${geesunOitemsBudgerApplicationForm.fdType =='1'}">
						     <xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicants.deptId')}"></xform:address>
						</c:if>
						<c:if test="${geesunOitemsBudgerApplicationForm.fdType =='2'}">
						     <xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_PERSON" style="width:95%" required="true" subject="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.fdApplicantsId')}" onValueChange="afterApplicantSelect"></xform:address>
						</c:if>						
					</td>
				
					<td class="td_normal_title" width=15%>
					  <c:choose>
					  	<c:when test="${geesunOitemsBudgerApplicationForm.fdType!='1'}">
					  		<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
					  	</c:when>
					  	<c:otherwise>
					  		<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docNumber" />
					  	</c:otherwise>
					  </c:choose>
					</td>
					<td>
					   <c:choose>
						 <c:when test="${geesunOitemsBudgerApplicationForm.fdType!='1'}">
						   	 <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('geesun-oitems:geesunOitemsBudgerApplication.creator.dept')}"></xform:address>
						 </c:when>
						 <c:otherwise>
						 	 <c:if test="${geesunOitemsBudgerApplicationForm.docStatus==10 || geesunOitemsBudgerApplicationForm.docStatus==null || geesunOitemsBudgerApplicationForm.docStatus=='' }">
						 	 	<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.no.per" />
						 	 </c:if>
						 	 <xform:text property="docNumber" showStatus="view" style="width:95%;" />
						 </c:otherwise>
					   </c:choose>
					</td>
				</tr>
				<tr>
                    <td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
					</td>
					<c:choose>
						<c:when test="${geesunOitemsBudgerApplicationForm.fdType eq '1'}">
							<td width=85% colspan="4">
								<c:choose>
									<c:when test="${geesunOitemsBudgerApplicationForm.docStatus < '30' || geesunOitemsBudgerApplicationForm.docStatus==null }">
										<div id="selectDiv">
										</div>
									</c:when>
									<c:otherwise>
										<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
									</c:otherwise>
								</c:choose>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<c:choose>
									<c:when test="${geesunOitemsBudgerApplicationForm.docStatus < '30' || geesunOitemsBudgerApplicationForm.docStatus==null }">
										<div id="selectDiv">
										</div>
									</c:when>
									<c:otherwise>
										<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
									</c:otherwise>
								</c:choose>
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docNumber" />
							</td>
							<td>
								<c:if test="${geesunOitemsBudgerApplicationForm.docStatus==10 || geesunOitemsBudgerApplicationForm.docStatus==null || geesunOitemsBudgerApplicationForm.docStatus=='' }">
							 	 	<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.no.per" />
							 	</c:if>
							 	<xform:text property="docNumber" showStatus="view" style="width:95%;" />
							</td>
						</c:otherwise>
					</c:choose>					
				</tr>	
				<tr>		
					<td colspan="4">
						<table class="tb_normal" width=100% style="border:none">
								<tr style="border:none">
									<td style="border:none">
									 <c:import url="/geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley_edit.jsp"
										charEncoding="UTF-8">
									</c:import>
									</td>
								</tr>
						</table>
						<div style="float:right;margin-right:20px">
						    <span style="font-weight:bold;">
						     <bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdTotalAmount"/>
						    </span>：
							<span class="total" style="font-size:18px;color:#868686"></span>
							<input type="hidden" name="fdTotalAmount"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdReason"/>
					</td><td width="85%" colspan="3">
						<xform:textarea style="width:97%" property="fdReason" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdDesc"/>
					</td><td width="85%" colspan="3">
						<xform:textarea style="width:97%" property="fdDesc" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.attachment"/></td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<html:hidden property="docCreatorId"/>
						<html:text property="docCreatorName" readonly="true"/>				
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<html:text property="docCreateTime" readonly="true"/>
					</td>
				</tr>
			</table>
</div>
	<ui:tabpanel suckTop="true" layout="sys.ui.tabpanel.sucktop" var-supportExpand="true" var-extend="true" var-average='false' var-useMaxWidth='true'>
				
			<c:choose>
					<c:when test="${param.approveModel eq 'right'}">
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
					<c:param name="fdKey" value="geesunOitemsTemplet" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
				</c:import>
				</c:when>
				<c:otherwise>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
					<c:param name="fdKey" value="geesunOitemsTemplet" />
					<c:param name="isExpand" value="true" />
				</c:import>
				</c:otherwise>
				</c:choose>
				
				
	<!-- 权限 -->
	<ui:content title="${lfn:message('sys-right:right.moduleName')}">
			<table class="tb_normal" width=100% id="Table_Main">
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="geesun-oitems" key="geesunOitems.authReaders" /></td>
					<td width="85%" colspan="3">
					<xform:address propertyId="authReaderIds" propertyName="authReaderNames" style="width:97%" textarea="true" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
					<br>
					<bean:message key="right.read.authReaders.note1" bundle="sys-right" /></td>
				</tr>
			</table>
		</ui:content>
		</ui:tabpanel>
</div>
<html:hidden property="method_GET"/>

<c:if test="${param.approveModel ne 'right'}">
		</form>
		</c:if>	
		
    <script language="JavaScript">
		var _validation = $KMSSValidation(document.forms['geesunOitemsBudgerApplicationForm']);
		//校验用品不为空
		_validation.addValidator("listingNotNull","${lfn:message('geesun-oitems:geesunOitems.error.message1')}",function(v, e, o) {
			return validateListing();
		});
		
		function changGeesunOitemsTemplet(fdTempId){
			document.geesunOitemsBudgerApplicationForm.action = Com_SetUrlParameter(location.href,"method","change");
			document.geesunOitemsBudgerApplicationForm.submit();
		}
		
		function initGeesunOitemsType(val){
			var url ="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_templet/geesunOitemsTemplet.do?method=getTemp";
			$.post(url,$.param({"fdType":val},true),function(results){
				var DivObj = $('#selectDiv');
				if(results == null || results.length == 0){
					DivObj.hide();
				}
				DivObj.html("");
				//只有一个可用模板时不显示下拉框
				if(results.length ==1){
					DivObj.append('<input type="hidden" name="fdTemplateId" value="'+results[0].fdId+'"/>'+results[0].fdName);
				}else{
					var selectObj = '<select name="fdTemplateId" onchange="if(!onChangeGeesunOitemsTemplate(this.value))return;">'
					if('edit'=='${geesunOitemsBudgerApplicationForm.method_GET}'){
						selectObj = '<select name="fdTemplateId" disabled="true" onchange="if(!onChangeGeesunOitemsTemplate(this.value))return;">'
					}
					var optionHtml = '';
					for(var i=0;i<results.length;i++){
						optionHtml +='<option value="'+results[i].fdId+'"';
						if( results[i].fdId =="${geesunOitemsBudgerApplicationForm.fdTemplateId}"){
							optionHtml += ' selected="selected"';
						}
						optionHtml +='>' +results[i].fdName+'</option>';
					}
					selectObj += optionHtml;
					selectObj += '</select>';
					DivObj.append(selectObj);
				}
			},'json');
		}

		function onChangeGeesunOitemsTemplate(fdTempId){
			changGeesunOitemsTemplet(fdTempId);
		}
    </script>
</template:replace>

<c:if test="${param.approveModel eq 'right'}">
		<template:replace name="barRight">
			<ui:tabpanel layout="sys.ui.tabpanel.vertical.icon" id="barRightPanel">
				<c:if test="${geesunOitemsBudgerApplicationForm.docStatus>='30' || geesunOitemsBudgerApplicationForm.docStatus=='00'}">
					<c:import url="/geesun/oitems/geesun_oitems_budger_application_ui/geesunOitemsBudgerApplication_viewBaseInfoContent.jsp" charEncoding="UTF-8"></c:import>
				</c:if>
				<%--流程--%>
				<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
					<c:param name="fdKey" value="geesunOitemsTemplet" />
					<c:param name="showHistoryOpers" value="true" />
					<c:param name="isExpand" value="true" />
					<c:param name="approveType" value="right" />
					<c:param name="approvePosition" value="right" />
				</c:import>
				
			</ui:tabpanel>
		</template:replace>
	</c:if>












