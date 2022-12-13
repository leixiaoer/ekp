<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
	}
	function confirmReceive(msg){
		var rec = confirm('<bean:message key="geesunOitems.receive.message" bundle="geesun-oitems"/>');
		var list = document.getElementsByName("count");
		for(var i = 0;i < list.length; i++){
			//alert(list[i].value);
			if("true" == list[i].value){
				alert('<bean:message key="geesunOitemsShoppingTrolley.fdApplicationNumberRunout" bundle="geesun-oitems"/>');
				rec = false;
				return rec;
			}
		}
		return rec;
	}
	function Receive(){
    	dialog.confirm("${lfn:message('geesun-oitems:geesunOitems.receive.message')}",function(flag){
	    	if(flag==true){
	    		  var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=checkListing"; 
	    			 $.ajax({     
	    	    	     type:"post",     
	    	    	     url:url,    
	    	    	     data:{fdId:"${JsParam.fdId}"},  
	    	    	     async:false,    //用同步方式 
	    	    	     success:function(data){
	    	    	 	    var results =  eval("("+data+")");
	    	    		    if(results['isMore'] == 'false'){
	    	    		    	dialog.alert("${lfn:message('geesun-oitems:geesunOitemsShoppingTrolley.fdApplicationNumberRunout')}");
	    	    		    	return false;
	    	    			}else{
	    	    				Com_OpenWindow('geesunOitemsBudgerApplication.do?method=receive&fdId=${JsParam.fdId}','_self');
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
		<c:if test="${geesunOitemsBudgerApplicationForm.fdOutStatus =='0' && geesunOitemsBudgerApplicationForm.docStatus == '30'}">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=receive&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">		
		<input type="button"
				value="<bean:message bundle="geesun-oitems" key="geesunOitems.button.receive"/>"
				onclick="Receive();">
		</kmss:auth>
		</c:if>
		<c:if test="${geesunOitemsBudgerApplicationForm.docStatus != '00' && geesunOitemsBudgerApplicationForm.fdOutStatus !='1'}">
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=edit&fdId=${param.fdId}&type=${param.type}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.edit"/>"
				onclick="Com_OpenWindow('geesunOitemsBudgerApplication.do?method=edit&fdId=${JsParam.fdId}&type=${JsParam.type}','_self');">
		</kmss:auth>
		</c:if>
		<kmss:auth requestURL="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			<input type="button"
				value="<bean:message key="button.delete"/>"
				onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsBudgerApplication.do?method=delete&fdId=${JsParam.fdId}','_self');">
		</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle">
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '1' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.dept.application"/>
</c:if>
<c:if test="${geesunOitemsBudgerApplicationForm.fdType == '2' }">
<bean:message  bundle="geesun-oitems" key="geesunOitems.tree.person.application"/>
</c:if>
</p>
<center>
<table id="Label_Tabel" width=95%>
		<html:hidden name="geesunOitemsBudgerApplicationForm" property="fdId"/>
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.base.massage" />">
		<td>
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
					</td><td>
						<c:out value="${geesunOitemsBudgerApplicationForm.docSubject}" />
					</td>
					<c:if test="${geesunOitemsTempletForm.fdTempletType!='1'}">
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.creator.dept"/>
					</td><td>
						<c:out value="${geesunOitemsBudgerApplicationForm.docDeptName}" />
					</td>
					</c:if>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="table.geesunOitemsTemplet"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.fdTemplateName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdApplicantsId"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.fdApplicantsName}" />
					</td>
					
				</tr>
				<tr>
					<td colspan="4"><bean:message  bundle="geesun-oitems" key="geesunOitems.list"/><br>
						<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title"><bean:message key="page.serial"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/></td>
					<td class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.number"/></td>
				</tr>
				<c:forEach items="${geesunOitemsBudgerApplicationForm.geesunOitemsShoppingTrolleyFormList}"
					var="geesunOitemsShoppingTrolleyForm" varStatus="vstatus">
					<tr>
						<td>${vstatus.index+1 }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdNo }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdName }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdCategoryName }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdSpecification }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdBrand }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdUnit }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdReferencePrice }</td>
						<td>${geesunOitemsShoppingTrolleyForm.fdAmount}</td>
						<input type="hidden" name="count" value="${geesunOitemsShoppingTrolleyForm.fdAmount - geesunOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
						<td>
							<c:if test="${geesunOitemsShoppingTrolleyForm.fdAmount - geesunOitemsShoppingTrolleyForm.fdApplicationNumber < 0}">
							<font color="red">${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}</font>
							</c:if>
							<c:if test="${geesunOitemsShoppingTrolleyForm.fdAmount - geesunOitemsShoppingTrolleyForm.fdApplicationNumber >= 0}">
							${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
					</td>
					
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdReason"/>
					</td><td colspan="3">
					<kmss:showText value="${geesunOitemsBudgerApplicationForm.fdReason}" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.fdDesc"/>
					</td><td colspan="3">
					<kmss:showText value="${geesunOitemsBudgerApplicationForm.fdDesc}" />
					</td>
				</tr>
				<tr>
					<!--附件机制-->
					<td class="td_normal_title" width=15%>文档附件</td>
					<td colspan="3"><c:import
						url="/sys/attachment/sys_att_main/sysAttMain_view.jsp"
						charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="formBeanName" value="geesunOitemsBudgerApplicationForm" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName"
							value="com.landray.kmss.geesun.oitems.model.GeesunOitemsBudgerApplication" />
					</c:import></td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreatorId"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.docCreatorName}" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docCreateTime"/>
					</td><td width=35%>
						<c:out value="${geesunOitemsBudgerApplicationForm.docCreateTime}" />
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	<!-- 流程 -->
	<c:import url="/sys/workflow/include/sysWfProcess_view.jsp"
			charEncoding="UTF-8">
			<c:param name="formName" value="geesunOitemsBudgerApplicationForm" />
			<c:param name="fdKey" value="geesunOitemsTemplet" />
	</c:import>
	<!-- 权限 -->
	<tr LKS_LabelName="<bean:message bundle="sys-right" key="right.moduleName" />">
			<td>
				<table class="tb_normal" width=100%>
			<tr>
				<td width="14%" class="td_normal_title"><bean:message  bundle="geesun-oitems" key="geesunOitems.authReaders"/></td>
				<td width="86%" colspan="3"><c:out
					value="${geesunOitemsBudgerApplicationForm.authReaderNames}" />
				</td>
			</tr>
		</table>
			</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
