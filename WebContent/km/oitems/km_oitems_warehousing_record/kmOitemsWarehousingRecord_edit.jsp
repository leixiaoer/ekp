<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="no">
   <template:replace name="title">
				<c:out value="${kmOitemsWarehousingRecordForm.fdListingName} - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float"> 
			<c:if test="${kmOitemsWarehousingRecordForm.method_GET=='edit'}">
			  <ui:button text="${lfn:message('button.update') }" order="2" onclick="Com_Submit(document.kmOitemsWarehousingRecordForm, 'update');">
			  </ui:button>
		   </c:if>
			<c:if test="${kmOitemsWarehousingRecordForm.method_GET=='add'}">
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
		   var url="${KMSS_Parameter_ContextPath}km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=checkNumByPrice"; 
		   $.ajax({     
			     type:"post",     
			     url:url,     
			     data:{fdListingId:fdListingId.value,fdPrice:fdPrice.value,fdNumber:fdNumber.value},    
			     async:true,     
			     success:function(data){ 
			    	 var results =  eval("("+data+")");
			    	 if(results['value']=="true"){
				    	 if(results['msg']=="over"){		    		 
			      		   alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.num.modify1"/>');
				    	 }
				    	 if(results['msg']=="notExist"){
				    	   alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.num.modify2"/>');
					    }
			      		  return false;
			      	  } else{
			      		Com_Submit(document.kmOitemsWarehousingRecordForm, 'save');
			      	  }   
				   }     
		      });			 
		};
function calculateAccountPrice(obj,index){
    if(obj.value!=""){
	if(index == 2){
		if(obj.value.match("^-{0,1}[0-9]+$")==null&&obj.value.length>0){
			dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.please.integer.negative"/>');
			 obj.value=0;
			 return false; 
		 }
	}
	if(index == 1){
		if(obj.value.match("^[.0-9]+$")==null && obj.value.length>0){
			dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.please.float"/>');
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
<html:form action="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do">
<p class="txttitle"><bean:message  bundle="km-oitems" key="table.kmOitemsWarehousingRecord"/></p>
<div class="lui_form_content_frame" style="padding-top:20px">
<table class="tb_normal" width=100%>
		<html:hidden property="fdId"/>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
		</td><td width=40%>				
			<html:hidden property="fdListingId"/>
			<c:out value="${kmOitemsWarehousingRecordForm.fdListingName}"/>							
		</td>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
		</td><td width=40%>				
			<html:hidden property="fdListingNo"/>	
			<c:out value="${kmOitemsWarehousingRecordForm.fdListingNo}"/>					
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
		</td><td width=40%>
			<c:out value="${kmOitemsWarehousingRecordForm.fdAccountNumber}"/>	
		</td>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdPrice"/>
		</td><td width=40%>
			<xform:text property="fdPrice" validators="currency-dollar min(0)" htmlElementProperties="onchange='calculateAccountPrice(this,1)'" />
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdNumber"/>
		</td><td width=40%>
			<xform:text property="fdNumber" required="true" style="width:120px" htmlElementProperties="onchange='calculateAccountPrice(this,2)'" />
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.tips"/>
		</td>		
		<td class="td_normal_title" width=10%>
			<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdAccountPrice"/>
		</td><td width=40%>
			<html:text readonly="true" property="fdAccountPrice"/>			
		</td>			
	</tr>
</table>
</div>
<html:hidden property="method_GET"/>
</html:form>
<script language="JavaScript">
			$KMSSValidation(document.forms['kmOitemsWarehousingRecordForm']);
</script>
	</template:replace>
</template:include>
