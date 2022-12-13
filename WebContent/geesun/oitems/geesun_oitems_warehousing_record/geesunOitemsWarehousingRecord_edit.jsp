<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
   <template:replace name="title">
				<c:out value="${geesunOitemsWarehousingRecordForm.fdListingName} - ${ lfn:message('geesun-oitems:geesunOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
			<c:if test="${geesunOitemsWarehousingRecordForm.method_GET=='edit'}">
			  <ui:button text="${lfn:message('button.update') }" order="2" onclick="Com_Submit(document.geesunOitemsWarehousingRecordForm, 'update');">
			  </ui:button>
		   </c:if>
			<c:if test="${geesunOitemsWarehousingRecordForm.method_GET=='add'}">
			  <ui:button text="${lfn:message('button.save') }" order="2" onclick="checkNum();">
			  </ui:button>
			</c:if>
			<ui:button text="${ lfn:message('button.close') }" order="5"  onclick="Com_CloseWindow()">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="content"> 
	<script>
	Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp|eventbus.js", null, "js");
	seajs.use(['lui/dialog'], function(dialog){
		window.dialog=dialog;
	 });

	 function checkNum(){
		   var fdPrice=document.getElementsByName("fdPrice")[0];
		   var fdNumber=document.getElementsByName("fdNumber")[0]; 
		   var fdListingId=document.getElementsByName("fdListingId")[0];  
		   var url="${KMSS_Parameter_ContextPath}geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do?method=checkNumByPrice"; 
		   $.ajax({     
			     type:"post",     
			     url:url,     
			     data:{fdListingId:fdListingId.value,fdPrice:fdPrice.value,fdNumber:fdNumber.value},    
			     async:true,     
			     success:function(data){ 
			    	 var results =  eval("("+data+")");
			    	 if(results['value']=="true"){
				    	 if(results['msg']=="over"){		    		 
			      		   alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.num.modify1"/>');
				    	 }
				    	 if(results['msg']=="notExist"){
				    	   alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.num.modify2"/>');
					    }
			      		  return false;
			      	  } else{
			      		Com_Submit(document.geesunOitemsWarehousingRecordForm, 'save');
			      	  }   
				   }     
		      });			 
		};
function calculateAccountPrice(obj,index){
    if(obj.value!=""){
	if(index == 2){
		if(obj.value.match("^-{0,1}[0-9]+$")==null&&obj.value.length>0){
			dialog.alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.please.integer.negative"/>');
			 obj.value=0;
			 return false; 
		 }
	}
	if(index == 1){
		if(obj.value.match("^[.0-9]+$")==null && obj.value.length>0){
			dialog.alert('<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.please.float"/>');
			 obj.value=0;
			 return false; 
		 }
	}
	var tempValue = obj.value;
	if(index == 1){
		var number = document.getElementsByName("fdNumber")[0].value;
		if(number!=""&&!isNaN(number)){
			document.getElementsByName("fdAccountPrice")[0].value = (parseFloat(number)*parseFloat(tempValue)).toFixed(2);
		}	
	}
	if(index == 2){
		var number = document.getElementsByName("fdPrice")[0].value;
		if(number!=""&&!isNaN(number)){
			document.getElementsByName("fdAccountPrice")[0].value = (parseFloat(number)*parseFloat(tempValue)).toFixed(2);
		}
	}
  }else{
	  document.getElementsByName("fdAccountPrice")[0].value = "";
  }    
}
</script>
<html:form action="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do">
<p class="txttitle"><bean:message  bundle="geesun-oitems" key="table.geesunOitemsWarehousingRecord"/></p>
<div class="lui_form_content_frame" style="padding-top:20px">
<table class="tb_normal" width=100%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
		</td><td width=40%>				
			<html:hidden property="fdListingId"/>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdListingName}"/>							
		</td>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
		</td><td width=40%>				
			<html:hidden property="fdListingNo"/>	
			<c:out value="${geesunOitemsWarehousingRecordForm.fdListingNo}"/>					
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/>
		</td><td width=40%>
			<c:out value="${geesunOitemsWarehousingRecordForm.fdAccountNumber}"/>	
		</td>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdPrice"/>
		</td><td width=40%>
			<xform:text property="fdPrice" validators="currency-dollar min(0)" htmlElementProperties="onchange='calculateAccountPrice(this,1)'" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdNumber"/>
		</td><td width=40%>
			<xform:text property="fdNumber" required="true" style="width:120px" htmlElementProperties="onchange='calculateAccountPrice(this,2)'" />
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.tips"/>
		</td>		
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdAccountPrice"/>
		</td><td width=40%>
			<html:text readonly="true" property="fdAccountPrice"/>			
		</td>			
	</tr>
</table>
</div>
<html:hidden property="method_GET"/>
</html:form>
<script language="JavaScript">
			$KMSSValidation(document.forms['geesunOitemsWarehousingRecordForm']);
</script>
	</template:replace>
</template:include>
