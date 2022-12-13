<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
	}
	function confirmReceive(msg){
		var rec = confirm('<bean:message key="kmOitems.receive.message" bundle="km-oitems"/>');
		var list = document.getElementsByName("count");
		for(var i = 0;i < list.length; i++){
			//alert(list[i].value);
			if("true" == list[i].value){
				alert('<bean:message key="kmOitemsShoppingTrolley.fdApplicationNumberRunout" bundle="km-oitems"/>');
				rec = false;
				return rec;
			}
		}
		return rec;
	}
	function Receive(){
    	dialog.confirm("${lfn:message('km-oitems:kmOitems.receive.message')}",function(flag){
	    	if(flag==true){
	    		  var url="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=checkListing"; 
	    			 $.ajax({     
	    	    	     type:"post",     
	    	    	     url:url,    
	    	    	     data:{fdId:"${JsParam.fdId}"},  
	    	    	     async:false,    //用同步方式 
	    	    	     success:function(data){
	    	    	 	    var results =  eval("("+data+")");
	    	    		    if(results['isMore'] == 'false'){
	    	    		    	dialog.alert("${lfn:message('km-oitems:kmOitemsShoppingTrolley.fdApplicationNumberRunout')}");
	    	    		    	return false;
	    	    			}else{
	    	    				Com_OpenWindow('kmOitemsBudgerApplication.do?method=receive&fdId=${JsParam.fdId}','_self');
		    	    		}
	    	    		}    
	    	        });
	    	}else{
	    		return false;
		    }
	    },"warn");
}
</script>
<div id="optBarDiv">
		<c:if test="${kmOitemsBudgerApplicationForm.fdOutStatus =='0' && kmOitemsBudgerApplicationForm.docStatus == '30'}">
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=receive&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">		
		<input type="button"
				value="<bean:message bundle="km-oitems" key="kmOitems.button.receive"/>"
				onclick="Receive();">
		</kmss:auth>
		</c:if>
		<c:if test="${kmOitemsBudgerApplicationForm.docStatus != '00' && kmOitemsBudgerApplicationForm.fdOutStatus !='1'}">
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=edit&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('kmOitemsBudgerApplication.do?method=edit&fdId=${JsParam.fdId}&type=${JsParam.type}','_self');">
		</kmss:auth>
		</c:if>
		<kmss:auth requestURL="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsBudgerApplication.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.dept.application"/>
</c:if>
<c:if test="${kmOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="km-oitems" key="kmOitems.tree.person.application"/>
</c:if>
</p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden name="kmOitemsBudgerApplicationForm" property="fdId"/>
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.base.massage" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
					</td><td>
						<c:out value="${kmOitemsBudgerApplicationForm.docSubject}" />
					</td>
					<c:if test="${kmOitemsTempletForm.fdTempletType!='1'}">
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.creator.dept"/>
					</td><td>
						<c:out value="${kmOitemsBudgerApplicationForm.docDeptName}" />
					</td>
					</c:if>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="table.kmOitemsTemplet"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.fdTemplateName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.fdApplicantsId"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.fdApplicantsName}" />
					</td>
					
				</tr>
				<tr>
					<td colspan="4"><bean:message  bundle="km-oitems" key="kmOitems.list"/><br>
						<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title"><bean:message key="page.serial"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.number"/></td>
				</tr>
				<c:forEach items="${kmOitemsBudgerApplicationForm.kmOitemsShoppingTrolleyFormList}"
					var="kmOitemsShoppingTrolleyForm" varStatus="vstatus">
					<tr>
						<td>${vstatus.index+1 }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdNo }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdName }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdCategoryName }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdSpecification }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdBrand }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdUnit }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdReferencePrice }</td>
						<td>${kmOitemsShoppingTrolleyForm.fdAmount}</td>
						<input type="hidden" name="count" value="${kmOitemsShoppingTrolleyForm.fdAmount - kmOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
						<td>
							<c:if test="${kmOitemsShoppingTrolleyForm.fdAmount - kmOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
							<font color="red">${kmOitemsShoppingTrolleyForm.fdApplicationNumber}</font>
							</c:if>
							<c:if test="${kmOitemsShoppingTrolleyForm.fdAmount - kmOitemsShoppingTrolleyForm.fdApplicationNumber >= 0}">
							${kmOitemsShoppingTrolleyForm.fdApplicationNumber}
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
					</td>
					
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdReason"/>
					</td><td colspan="3">
					<kmss:showText value="${kmOitemsBudgerApplicationForm.fdReason}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.fdDesc"/>
					</td><td colspan="3">
					<kmss:showText value="${kmOitemsBudgerApplicationForm.fdDesc}" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%>文档附件</td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="formBeanName" value="kmOitemsBudgerApplicationForm" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.km.oitems.model.KmOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${kmOitemsBudgerApplicationForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="kmOitemsBudgerApplicationForm" />
			<c:param name="fdKey" value="kmOitemsTemplet" />
	</c:import>
	<!-- 权限 -->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
			<tr>
				<td width="14%" class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitems.authReaders"/></td>
				<td width="86%" colspan="3"><c:out
					value="${kmOitemsBudgerApplicationForm.authReaderNames}" />
				</td>
			</tr>
		</table>
			</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>