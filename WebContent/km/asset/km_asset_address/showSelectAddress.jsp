<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple"   sidebar="no">
<template:replace name="body">
<script type="text/javascript">
seajs.use(['theme!form']);
Com_IncludeFile("jquery.js");
</script>
<script type="text/javascript">
$(document).ready(function(){	
	 search();
});

	function showQueryResult(){
		var isdisplay;
		if(document.all.F_Name_Query.click)
			isdisplay="";
		else
			isdisplay="none";
		Table_Select.rows[2].style.display=isdisplay;

		if(document.all.F_Name_Query.click)
			isdisplay="";
		else
			isdisplay="none";
		Table_Select.rows[2].style.display=isdisplay;
	}

	function search(){
	    	// document.kmAssetAddressForm.submit();
	    		var fdAddress = document.getElementsByName("fdAddress")[0].value ; 
	    		var fdcateIds = document.getElementsByName("fdAssetAddressCateId")[0].value ; 
	    		var form=document.getElementsByName("kmAssetAddressForm")[0];
	    		form.action=form.action.split("&")[0]+"&isDialog=1"+"&fdAddressName="+encodeURI(fdAddress)+"&fdAssetAddressCateId="+fdcateIds+"&isMul=${isMul}";
	    		form.submit();
	}
	
	
	function  selectResource(){	 
		var i;
		var selectedId="",selectedName="";
		var ids = window.frames["iframe"].document.getElementsByName("fdAddressId");
		var names =window.frames["iframe"].document.getElementsByName("fdAddressName");
		var count = 0;
		for(i=0;i<ids.length;i++) {
			if(ids[i].checked) {
				selectedId += ids[i].value;
				selectedId += ';';
				selectedName += names[i].value;
				selectedName += ';';
				count ++;
			}
		}
		if(count ==0){
			alert("<bean:message bundle="km-asset" key="kmAssetAddress.alertNotNull" />");
			return false;
		}
		selectedId +="|";
		selectedId = selectedId.replace(";|","");
		selectedName +="|";
		selectedName = selectedName.replace(";|","");
		var rtnArray = new Array(selectedId,selectedName);
		$dialog.hide(rtnArray);
		return true;
	}
	//取消选定
	function  selectHoldPlaceNone()
	{	 				
		$dialog.hide("cancelselect");
		return false;			
	}
</script>
<center>
<div class="txttitle"><bean:message
	bundle="km-asset"
	key="kmAssetAddress.selectAddress" /></div>
<br>
<html:form
	action="/km/asset/km_asset_address/kmAssetAddress.do?method=list&isDialog=1" target="iframe">

	<table
		name="tableMain"
		class="tb_normal"
		width="95%">
		<tr>
			<td
				class="td_normal_title"
				width="15%"><bean:message
				bundle="km-asset"
				key="kmAssetAddress.fdAddress" /></td>
			<td width="35%">
				<html:text property="fdAddress" style="width:85%" />
			</td>
		</tr>
		<tr>
			<td
				class="td_normal_title"
				width="15%"><bean:message
				bundle="km-asset"
				key="kmAssetAddressCate.fdCategoryId" /></td>
			<td width="35%">
			    <xform:dialog  propertyId="fdAssetAddressCateId" propertyName="fdAssetAddressCateName"  style="width:90%" showStatus="edit"
				dialogJs = "Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetAddressCate','fdAssetAddressCateId','fdAssetAddressCateName',false,',','02',null,null,null,null);"/>
			</td>
		</tr>

		<tr >
			<td
				colspan="2"
				align="center">
					<table  
				            id="Table_sub" >
						<tr>
						   <%--查询按钮--%>
							<td style="border:none">
								<input
								type="button"  class="lui_form_button" 
								value="<bean:message bundle="km-asset" key="kmAssetAddress.search" />"
								name="F_Name_Query"
								onclick="search();">
							</td>
						</tr>
					</table>
				</td>
		</tr>
		
		<tr>
			<td
				colspan=2 width="100%"  height="250px;"
				id="listTxt"><iframe
				id="iframe"
				name="iframe"
				width="100%"
				height="100%"
				frameborder="0"
				src=""> </iframe></td>
		</tr>
		<tr>
			<td
				colspan="2"
				align="center"><input
				type="button"
				value="<bean:message
			bundle="km-asset"
			key="kmAssetAddress.select" />"
				name="F_Select" class="lui_form_button" 
				onclick="selectResource();">&nbsp;&nbsp;&nbsp;
			<input
				type="button"
				value="<bean:message
			key="button.cancel" />"
				name="F_Select" class="lui_form_button" 
				onclick="$dialog.hide();">&nbsp;&nbsp;&nbsp;
			<input
				type="button"
				value="<bean:message
			key="dialog.selectNone" />"
				name="F_Select" class="lui_form_button" 
				onclick="selectHoldPlaceNone();">
				
			</td>
		</tr>
	</table>
	<input type="hidden" name="fdIsExtra"/>
</html:form></center>
</template:replace>
</template:include>
