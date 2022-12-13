<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
	<template:replace name="title">
		<c:choose>
			<c:when test="${ kmOitemsBudgerApplicationForm.method_GET == 'add' }">
				<c:out value="${lfn:message('km-oitems:kmOitems.create.title') } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>	
			</c:when>
			<c:otherwise>
				<c:out value="${kmOitemsBudgerApplicationForm.docSubject} - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
			</c:otherwise>
		</c:choose>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
			<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='edit'}">
				<c:if test="${kmOitemsBudgerApplicationForm.docStatus eq '10'}">
				  <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('update','true');">
				  </ui:button>
				</c:if>
				  <ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('update','false');">
				  </ui:button>
			</c:if>
			<c:if test="${kmOitemsBudgerApplicationForm.method_GET=='add'}">
			      <ui:button text="${lfn:message('button.savedraft') }" order="2" onclick="commitMethod('save','true');">
				  </ui:button>
				  <ui:button text="${lfn:message('button.submit') }" order="2" onclick="commitMethod('save','false');">
				  </ui:button>
			</c:if>
			<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
			</ui:button>
		</ui:toolbar>  
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.tree.modelName') }">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.msg.application') }">
				</ui:menu-item>
		</ui:menu>
	</template:replace>	
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
	var formObj = document.kmOitemsBudgerApplicationForm;
	var docStatus = document.getElementsByName("docStatus")[0];
	if(docStatus.value!="30"&&docStatus.value!="31"&&('${kmOitemsBudgerApplicationForm.method_GET}'=='add'||'${kmOitemsBudgerApplicationForm.method_GET}'=='edit')){
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
		  initKmOitemsType("${kmOitemsBudgerApplicationForm.fdType}");
	  });
	  
function afterApplicantSelect(){
	var url = "${KMSS_Parameter_ContextPath}km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=getApplicantDept";
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
<html:form action="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do">
<p class="txttitle">
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.dept.application"/>
</c:if>
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.person.application"/>
</c:if>
</p>
<div class="lui_form_content_frame" style="padding-top:20px">
	<div id="kmOitemsAppForm">
			<table class="tb_normal" width=100% id="Table_Main">
				<html:hidden property="fdId"/>
				<html:hidden property="docStatus"/>
				<html:hidden property="fdType"/>
				<html:hidden property="fdTempletType" value="${kmOitemsBudgerApplicationForm.fdType}"/>
				<tr>
				    <td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
					</td><td width=85% colspan="4">
						 <div style="width:82%;display: inline-block;">
							<c:if test="${kmOitemsBudgerApplicationForm.titleRegulation==null || kmOitemsBudgerApplicationForm.titleRegulation=='' }">
								<xform:text property="docSubject"  style="width:95%;" className="inputsgl"/>
							</c:if>
							<c:if test="${kmOitemsBudgerApplicationForm.titleRegulation!=null && kmOitemsBudgerApplicationForm.titleRegulation!='' }">
								<xform:text property="docSubject" style="width:95%;height:auto;color:#333;" className="inputsgl" showStatus="readOnly" value="${lfn:message('km-review:kmReviewMain.docSubject.info') }" />
							</c:if>
						</div>
					</td>
				</tr>
				<tr>
				<td class="td_normal_title" width=15%>
					<c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicants.deptId"/>
					</c:if>
					<c:if test="${kmOitemsBudgerApplicationForm.fdType =='2'}">
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
					</c:if>
					</td>
					<td width=35%>					
						 <c:if test="${kmOitemsBudgerApplicationForm.fdType =='1'}">
						     <xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicants.deptId')}"></xform:address>
						</c:if>
						<c:if test="${kmOitemsBudgerApplicationForm.fdType =='2'}">
						     <xform:address propertyId="fdApplicantsId" propertyName="fdApplicantsName" orgType="ORG_TYPE_PERSON" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.fdApplicantsId')}" onValueChange="afterApplicantSelect"></xform:address>
						</c:if>						
					</td>
				
					<td class="td_normal_title" width=15%>
					  <c:choose>
					  	<c:when test="${kmOitemsBudgerApplicationForm.fdType!='1'}">
					  		<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
					  	</c:when>
					  	<c:otherwise>
					  		<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docNumber" />
					  	</c:otherwise>
					  </c:choose>
					</td>
					<td>
					   <c:choose>
						 <c:when test="${kmOitemsBudgerApplicationForm.fdType!='1'}">
						   	 <xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:95%" required="true" subject="${ lfn:message('km-oitems:kmOitemsBudgerApplication.creator.dept')}"></xform:address>
						 </c:when>
						 <c:otherwise>
						 	 <c:if test="${kmOitemsBudgerApplicationForm.docStatus==10 || kmOitemsBudgerApplicationForm.docStatus==null || kmOitemsBudgerApplicationForm.docStatus=='' }">
						 	 	<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.no.per" />
						 	 </c:if>
						 	 <xform:text property="docNumber" showStatus="view" style="width:95%;" />
						 </c:otherwise>
					   </c:choose>
					</td>
				</tr>
				<tr>
                    <td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="table.kmOitemsTemplet"/>
					</td>
					<c:choose>
						<c:when test="${kmOitemsBudgerApplicationForm.fdType eq '1'}">
							<td width=85% colspan="4">
								<div id="selectDiv">
								</div>
							</td>
						</c:when>
						<c:otherwise>
							<td>
								<div id="selectDiv">
								</div>
							</td>
							<td class="td_normal_title" width=15%>
								<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docNumber" />
							</td>
							<td>
								<c:if test="${kmOitemsBudgerApplicationForm.docStatus==10 || kmOitemsBudgerApplicationForm.docStatus==null || kmOitemsBudgerApplicationForm.docStatus=='' }">
							 	 	<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.no.per" />
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
									 <c:import url="/km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley_edit.jsp"
										charEncoding="UTF-8">
									</c:import>
									</td>
								</tr>
						</table>
						<div style="float:right;margin-right:20px">
						    <span style="font-weight:bold;">
						     <bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdTotalAmount"/>
						    </span>：
							<span class="total" style="font-size:18px;color:#868686"></span>
							<input type="hidden" name="fdTotalAmount"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdReason"/>
					</td><td width="85%" colspan="3">
						<xform:textarea style="width:97%" property="fdReason" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdDesc"/>
					</td><td width="85%" colspan="3">
						<xform:textarea style="width:97%" property="fdDesc" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%><bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.attachment"/></td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<html:hidden property="docCreatorId"/>
						<html:text property="docCreatorName" readonly="true"/>				
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<html:text property="docCreateTime" readonly="true"/>
					</td>
				</tr>
			</table>
</div>
 <ui:tabpage expand="false">
	<!-- 流程 -->
	<c:import url="/sys/workflow/import/sysWfProcess_edit.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
			<c:param name="fdKey" value="kmOitemsTemplet" />
			<c:param name="isExpand" value="true" />
	</c:import>
	<!-- 权限 -->
	<ui:content title="${lfn:message('sys-right:right.moduleName')}">
			<table class="tb_normal" width=100% id="Table_Main">
				<tr>
					<td width="15%" class="td_normal_title"><bean:message
						bundle="km-oitems" key="kmOitems.authReaders" /></td>
					<td width="85%" colspan="3">
					<xform:address propertyId="authReaderIds" propertyName="authReaderNames" style="width:97%" textarea="true" orgType="ORG_TYPE_ALL" mulSelect="true"></xform:address>
					<br>
					<bean:message key="right.read.authReaders.note1" bundle="sys-right" /></td>
				</tr>
			</table>
		</ui:content>
</ui:tabpage>
</div>
<html:hidden property="method_GET"/>
</html:form> 
    <script language="JavaScript">
		var _validation = $KMSSValidation(document.forms['kmOitemsBudgerApplicationForm']);
		//校验用品不为空
		_validation.addValidator("listingNotNull","${lfn:message('km-oitems:kmOitems.error.message1')}",function(v, e, o) {
			return validateListing();
		});
		
		function changKmOitemsTemplet(fdTempId){
			document.kmOitemsBudgerApplicationForm.action = Com_SetUrlParameter(location.href,"method","change");
			document.kmOitemsBudgerApplicationForm.submit();
		}
		
		function initKmOitemsType(val){
			var url ="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_templet/kmOitemsTemplet.do?method=getTemp";
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
					var selectObj = '<select name="fdTemplateId" onchange="if(!onChangeKmOitemsTemplate(this.value))return;">'
					var optionHtml = '';
					for(var i=0;i<results.length;i++){
						optionHtml +='<option value="'+results[i].fdId+'"';
						if( results[i].fdId =="${kmOitemsBudgerApplicationForm.fdTemplateId}"){
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

		function onChangeKmOitemsTemplate(fdTempId){
			changKmOitemsTemplet(fdTempId);
		}
    </script>
</template:replace>
</template:include>
