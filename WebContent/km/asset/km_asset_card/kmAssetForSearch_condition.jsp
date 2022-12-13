<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple"   sidebar="no">
<template:replace name="body">
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js");
	Com_IncludeFile("selectAddress.js", Com_Parameter.ContextPath+ "km/asset/resource/", "js", true);
	Com_IncludeFile("selectassetcarddialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
	Com_IncludeFile("providerDialog.js",Com_Parameter.ContextPath + "km/provider/resource/js/","js",true); 
</script>
<script type="text/javascript" charset="UTF-8">
 $(document).ready(function(){ 
	 $('span[class="txtstrong"]').hide();
	 var datastatus = "${JsParam.datastatus}";
	 if(datastatus == '1'){
	 var TbObj = document.getElementById("condition");
		for(var i=1;i <TbObj.rows.length;i++){
			TbObj.rows[i].style.display = '';
     	}
		var imgdiv = document.getElementsByName("imgdiv")[0];
		imgdiv.setAttribute('data-status', datastatus);
		imgdiv.src = '../resource/image/arrow_up.jpg';
	 }
	 	document.getElementsByName("fdAssetCategoryId")[0].value="${JsParam.fdAssetCategoryId}";//fdAssetCategoryId
	 	document.getElementsByName("fdAssetCategoryName")[0].value="${JsParam.fdAssetCategoryName}";//fdAssetCategoryName
		document.getElementsByName("fdName")[0].value="${JsParam.fdName}";//fdName
		document.getElementsByName("fdResponsiblePersonId")[0].value="${JsParam.fdResponsiblePersonId}";//fdResponsiblePersonId 
		document.getElementsByName("fdResponsiblePersonName")[0].value="${JsParam.fdResponsiblePersonName}";//fdResponsiblePersonName
		document.getElementsByName("docDeptId")[0].value="${JsParam.docDeptId}";//docDeptId
		document.getElementsByName("docDeptName")[0].value="${JsParam.docDeptName}";//docDeptName
		document.getElementsByName("fdAssetStatus")[0].value="${JsParam.fdAssetStatus}";//fdAssetStatus
		document.getElementsByName("fdAssetAddressId")[0].value="${JsParam.fdAssetAddressId}";//fdAssetAddressId
		document.getElementsByName("fdAssetAddressName")[0].value="${JsParam.fdAssetAddressName}";//fdAssetAddressName
		document.getElementsByName("fdFirstValueStart")[0].value="${JsParam.fdFirstValueStart}";//fdFirstValueStart
		document.getElementsByName("fdFirstValueEnd")[0].value="${JsParam.fdFirstValueEnd}";//fdFirstValueEnd
		document.getElementsByName("fdCode")[0].value="${JsParam.fdCode}";//fdCode
		
		$('#imgdiv').attr("onclick",function(){
		 	showCondiction();
		 });
 }); 

</script>
<script type="text/javascript">
function doSerch(){
	var fdAssetCategoryId = document.getElementsByName("fdAssetCategoryId")[0].value; 
	var fdAssetCategoryName = document.getElementsByName("fdAssetCategoryName")[0].value; 
	var fdName = document.getElementsByName("fdName")[0].value; 
	var fdResponsiblePersonId = document.getElementsByName("fdResponsiblePersonId")[0].value; 
	var fdResponsiblePersonName = document.getElementsByName("fdResponsiblePersonName")[0].value; 
	var docDeptId= document.getElementsByName("docDeptId")[0].value; 
	var docDeptName= document.getElementsByName("docDeptName")[0].value; 
	var fdAssetStatus = document.getElementsByName("fdAssetStatus")[0].value; 
	var fdAssetAddressId = document.getElementsByName("fdAssetAddressId")[0].value;
	var fdAssetAddressName = document.getElementsByName("fdAssetAddressName")[0].value;
	var fdFirstValueStart = document.getElementsByName("fdFirstValueStart")[0].value; 
	var fdFirstValueEnd = document.getElementsByName("fdFirstValueEnd")[0].value; 
	var fdCode = document.getElementsByName("fdCode")[0].value;
	var imgdiv = document.getElementsByName("imgdiv")[0];
	var datastatus=imgdiv.getAttribute('data-status');
	window.location.href = 'kmAssetCard.do?method=list'
	                       + '&fdAssetCategoryId='+fdAssetCategoryId
	                       + '&fdAssetCategoryName='+encodeURI(fdAssetCategoryName)
	                       + '&fdName='+encodeURI(fdName)
	                       + '&fdResponsiblePersonId='+fdResponsiblePersonId
	                       + '&fdResponsiblePersonName='+encodeURI(fdResponsiblePersonName)
	                       + '&docDeptId='+docDeptId
	                       + '&docDeptName='+encodeURI(docDeptName)
	                       +'&fdAssetStatus='+fdAssetStatus
	                       + '&fdAssetAddressId=' + fdAssetAddressId 
	                       + '&fdAssetAddressName=' +encodeURI(fdAssetAddressName) 
	                       + '&fdFirstValueStart=' + fdFirstValueStart 
	                       + '&fdFirstValueEnd=' + fdFirstValueEnd
	                       + '&fdCode=' + encodeURI(fdCode)
	                       + '&datastatus=' + datastatus
	                       + '&isDialog=${lfn:escapeJs(isDialog)}'
	                       <c:if test="${isDialog!=0}">
	                       +'&s_path='+encodeURI("${JsParam.s_path}")
						   </c:if>
						   +'&status=${JsParam.status}'
	                       ;
	}

function doReset(){

	window.location.href = 'kmAssetCard.do?method=list'
		 + '&isDialog=${requestScope.isDialog}&status=${requestScope.status}'
         <c:if test="${requestScope.isDialog!=0}">
         +'&s_path=${JsParam.s_path}'
		   </c:if>
         ;
}

function showCondiction(){
	var obj=document.getElementsByName("imgdiv")[0];
	var show = obj.getAttribute('data-status') !='1';
	obj.setAttribute('data-status', show?'1':'0');
	var TbObj = document.getElementById("condition");
	var isDialog='${requestScope.isDialog}';
	var i=1;
	if(isDialog=='0')
	{
		i=1;
	}
	else
	{
		i=2;
	}
	for(var j=i;j <TbObj.rows.length;j++){
		TbObj.rows[j].style.display = show?'':'none';
	}
	obj.src = show?'../resource/image/arrow_up.jpg':'../resource/image/arrow_down.jpg';
}

</script>
<div style="display: block;">
		<table id="condition" class="tb_normal" width=99%>
			<tr>
				<td class="td_normal_title"  style="width:15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetCategory"/>
				</td>
				<td width=20%>
					<input name="fdAssetCategoryId" id="fdAssetCategoryId" type="hidden"/>
					<xform:dialog  propertyId="fdAssetCategoryId" propertyName="fdAssetCategoryName" 
						style="width:90%" showStatus="edit"  
						dialogJs="Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','fdAssetCategoryId','fdAssetCategoryName',false,',','00',null,null,null,null);"/> 
				</td>
				<td class="td_normal_title" style="width:15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
				</td>
				<td style="width:20%">
					<xform:text property="fdName" style="width:90%"  showStatus="edit"/>
				</td>
				<td colspan="2">
					<input type="button" class="lui_form_button" value="<bean:message key="button.search"/>"  onclick="doSerch();">
					<input type="button" class="lui_form_button" value="<bean:message key="button.reset"/>"  onclick="doReset();">
				</td>
			</tr>
			<tr <c:if test="${requestScope.isDialog==0 }"> style="display:none"</c:if>>
				<td class="td_normal_title" style="width:15%">
				<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
				</td>
				<td width=20%>
					<xform:address propertyId="fdResponsiblePersonId" propertyName="fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:90%" showStatus="edit"/>
				</td>
				<td class="td_normal_title" style="width:15%">
					<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
				</td>
				<td width=20%>
					<xform:address propertyId="docDeptId" propertyName="docDeptName" orgType="ORG_TYPE_DEPT" style="width:90%" showStatus="edit"/>
				</td>
				<td class="td_normal_title" style="width:15%">
				<c:if test="${requestScope.isDialog!='0'}">
					<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
				</c:if>&nbsp;
				</td>
				<td>
				<c:if test="${requestScope.isDialog!='0'}">
					<xform:select property="fdAssetStatus" showStatus="edit" style="width:90%">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
					</xform:select>&nbsp;
				</c:if>
				<c:if test="${requestScope.isDialog=='0'}">
					<xform:select property="fdAssetStatus" showStatus="noShow">
						<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
					</xform:select>&nbsp;
				</c:if>
				</td>
			</tr>
			<tr style="display:none">
				<td class="td_normal_title" style="width:15%">
				<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
				</td>
				<td width=20%>
					<xform:dialog  propertyId="fdAssetAddressId" propertyName="fdAssetAddressName" style="width:90%" showStatus="edit"  dialogJs="selectResourceNew('fdAssetAddressId','fdAssetAddressName',null,'true');"/> 
				</td>
				
				<td class="td_normal_title" style="width:15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdFirstValue"/>
				</td>
				<td width=20%>
					<xform:text property="fdFirstValueStart" showStatus="edit" style="width:35%"/>—<xform:text property="fdFirstValueEnd"  style="width:35%" showStatus="edit"/>
				</td>
				<td class="td_normal_title" style="width:15%">
					<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
				</td>
				<td>
					<xform:text property="fdCode" style="width:90%" showStatus="edit"/>
				</td>
			</tr>
		</table>
		<center>
		<div>
		  <img id="imgdiv" name="imgdiv" src="../resource/image/arrow_down.jpg" data-status="0" onclick="showCondiction();" style="cursor:pointer"/>
		</div>	
		</center>
</div>
</template:replace>
</template:include>
