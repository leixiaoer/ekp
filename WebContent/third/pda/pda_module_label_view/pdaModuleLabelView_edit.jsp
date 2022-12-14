<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
Com_IncludeFile("jquery.js|json2.js|data.js|select.js");
</script>
<center>
<table class="tb_normal" width=95%>
	<input type="hidden" name="fdCfgInfo">
	<input type="hidden" name="fdCfgViewId">
	<input type="hidden" name="fdOrder">
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-pda" key="pdaModuleLabelView.fdName"/>
		</td><td width="85%">
			<input name="fdName" class="inputsgl" style="width:85%"> 
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>
			<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.setting"/>
		</td>
		<td width="85%">
			<label>
			   <input type="radio" name="fdCustom" checked value="0" onclick="customRadio(this);"/>
			   <bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.setting.system"/>
			</label>
			<label>
				<input type="radio" name="fdCustom" value="1" onclick="customRadio(this);"/>
				<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.setting.custom"/>
			</label>
		</td>
	</tr>
	<tr id="customTrTitle">
		<td class="td_normal_title" colspan="2">
		 <bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.custom"/>
		</td>
	</tr>
	<tr id="customTrContent">
		<td class="td_normal_title">
		 <bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.custom.path"/>
		</td>
		<td>
		  	<input name="fdExtendUrl" class="inputsgl" style="width:85%"> <br>
		  	<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.custom.path.summary"/>
		</td>
	</tr>
	<tr id="systemTrTitle">
		<td class="td_normal_title" colspan="2">
			<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg"/>
		</td>
	</tr>
	<tr id="systemTrContent">
		<td colspan="2" style="padding: 0px;margin: 0px;border: 0px !important;">
			<table class="tb_normal" width="100%">
				<tr class="tr_normal_title">
					<td width="40%">
						<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.optionBox"/>
					</td>
					<td width="10%"><bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.operation"/></td>
					<td width="40%">
						<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.selectedBox"/>
					</td>
					<td width="10%"><bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.operation"/></td>
				</tr>
				<tr>
					<td valign="top">
						<select id="optionalList" name="optionalList" multiple ondblclick="listTolist('optionalList','selectedList',false);" style="width:100%" size="15"></select>
					</td>
					<td>
						<center>
							<input type=button class="btnopt" value="<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.add"/>" onclick="listTolist('optionalList','selectedList',false);">
							<br><br>
							<input type=button class="btnopt" value="<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.addAll"/>" onclick="listTolist('optionalList','selectedList',true);">
						</center>
					</td>
					<td>
						<select id="selectedList" name="selectedList" multiple ondblclick="listTolist('selectedList','optionalList',false);" style="width:100%" size="15"></select>
					</td>
					<td>
						<center>
							<input type=button class="btnopt" value='<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.move"/>' onclick="removeOption('selectedList',1);">
							<br><br>
							<input type=button class="btnopt" value='<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.down"/>' onclick="removeOption('selectedList',-1);">
							<br><br>
							<input type=button class="btnopt" value='<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.delete"/>' onclick="listTolist('selectedList','optionalList',false);">
							<br><br>
							<input type=button class="btnopt" value='<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.deleteAll"/>' onclick="listTolist('selectedList','optionalList',true);">
						</center>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<a href=javascript:void(0);" onclick="save();"><input class="btnopt" type="button" value="<bean:message key="button.save"/>"></a>
			&nbsp;&nbsp;
			<a href=javascript:void(0);" onclick="window.close();"><input class="btnopt" type="button" value="<bean:message key="button.close"/>"></a>
		</td>
	</tr>
</table>
</center>
<script type="text/javascript">
$(document).ready(function(){
	var obj = window.opener.obj;
	$('input[name="fdName"]').val(obj.fdName);
	$('input[name="fdExtendUrl"]').val(obj.fdExtendUrl);
	var modelName = obj.modelName;
	var data = new KMSSData();
	var url="pdaDictPropertySelectList&modelName="+modelName;
	data.SendToBean(url,initOptionalList);
	var cfgInfo = obj.fdCfgInfo;
	if(cfgInfo != null && cfgInfo != ""){
		var propertyList = cfgInfo.propertyList;
		for(var key in propertyList){
			var selectedfield = $('#selectedList');
			$("<option value='"+JSON.stringify(propertyList[key])+"'>"+propertyList[key].propertyText+"</option>").appendTo(selectedfield);
		}
	}
	if(obj.fdExtendUrl== null || obj.fdExtendUrl==""){
		$('input[name="fdCustom"]').each(function(){
			if($(this).val()=='0') $(this).attr("checked","checked");
			});
		$('#systemTrTitle').show();
		$('#systemTrContent').show();
		$('#customTrTitle').hide();
		$('#customTrContent').hide();
	}else{
		$('input[name="fdCustom"]').each(function(){
			if($(this).val()=='1') $(this).attr("checked","checked");
		});
		$('#customTrTitle').show();
		$('#customTrContent').show();
		$('#systemTrTitle').hide();
		$('#systemTrContent').hide();
	}
});

function customRadio(thisObj){
	if(thisObj.value=="0"){
		$('#systemTrTitle').show();
		$('#systemTrContent').show();
		$('#customTrTitle').hide();
		$('#customTrContent').hide();
	}else{
		$('#customTrTitle').show();
		$('#customTrContent').show();
		$('#systemTrTitle').hide();
		$('#systemTrContent').hide();
	}
}

/*
 * ?????????????????????????????????
 */
function initOptionalList(rtnData){
	var field = $('#optionalList');
	var obj = window.opener.obj;
	var cfgInfo = obj.fdCfgInfo;
	if(rtnData){
		for(var i=0; i<rtnData.GetHashMapArray().length; i++){
			var isSelected = false;
			var obj = rtnData.GetHashMapArray()[i];
			var propertyText = obj['propertyText'];
			var propertyObj = { 'propertyName':obj['propertyName'],
								'propertyType':obj['propertyType'],
								'propertyText':obj['propertyText'],
								'messageKey':obj['messageKey'],
								'enumType':obj['enumType'],
								'displayProp':obj['displayProp'],
								'modelName':obj['modelName'],//??????????????????????????????propertyName??????flowDef???????????????
								'templateModelName':obj['templateModelName'],
								'key':obj['key'],
								'templatePropertyName':obj['templatePropertyName'],
								'moduleMessageKey':obj['moduleMessageKey'],
								'template':obj['template'],
								'type':obj['type']
							  };
			if(cfgInfo != null && cfgInfo != ""){
				var propertyList = cfgInfo.propertyList;
				for(var key in propertyList){
					if(propertyList[key].propertyName == obj['propertyName']){
						isSelected = true;
						continue;
					}
				}
			}
			if(!isSelected)
				$("<option value='"+JSON.stringify(propertyObj)+"'>"+propertyText+"</option>").appendTo(field);
		}
	}
}
/*******************************************
??????:??????select??????option?????????
??????:
	fromid:???list???id.  
	toid:??????list???id.  
	isAll??????(true??????false):???????????????????????????  
*********************************************/
function listTolist(fromid,toid,isAll) {  
	var fromStyle = $("#"+fromid).attr('style');
	var toStyle = $("#"+toid).attr('style');
	var toSelect = $("#"+toid);
	var selectList = null;
    if(isAll == true) { //???????????? 
    	selectList = $("#"+fromid+" option");
    }else{
    	selectList = $("#"+fromid+" option:selected");
    }  
    selectList.each(function() {   
        var option = $(this);
        var hasVal = false;
        var options = toSelect.find("option");
        for(var i=0; i<options.length;i++){
            if(option.val() == $(options).val()){
            	hasVal = true;
            	break;
            }
        }
        if(!hasVal)
        	option.appendTo(toSelect); 
    });   
	$("#"+fromid).attr('style',fromStyle);
	$("#"+toid).attr('style',toStyle);
}
/*******************************************
??????:select??????option????????????
??????:
	selectId:?????????list???id.  
	direct????????????-1???????????????1?????????
*********************************************/
function removeOption(selectId,direct){
	var style = $("#"+selectId).attr('style');
	$("#"+selectId+" option:selected").each(function() {
		if(direct > 0)   
			$(this).prev().before($(this));
		else if(direct < 0)   
			$(this).next().after($(this));   
		
    });   
	$("#"+selectId).attr('style',style);
}
//????????????????????????????????????????????????????????????????????????select??????
function synchroSelectList(){
	if($('input[name="readingMode"]:checked').val() != "newsReadingMode")
		return;
	var obj = window.opener.obj;
	var cfgInfo = obj.fdCfgInfo;
	var subject = $('#subject');
	var summary = $('#summary');
	var content = $('#content');
	subject.text("");
	summary.text("");
	content.text("");
	$('<option>==<bean:message bundle="third-pda" key="pdaModuleConfigView.pleaseSelect"/>==</option>').appendTo(subject);
	$('<option>==<bean:message bundle="third-pda" key="pdaModuleConfigView.pleaseSelect"/>==</option>').appendTo(summary);
	$('<option>==<bean:message bundle="third-pda" key="pdaModuleConfigView.pleaseSelect"/>==</option>').appendTo(content);
	$("#selectedList option").each(function() {
		var property = eval("("+($(this).val())+")");
		if(cfgInfo != null && cfgInfo != ""){
			if(cfgInfo.subject != null && cfgInfo.subject != "" && cfgInfo.subject == property.propertyName){
				$("<option value='"+property.propertyName+"' selected>"+$(this).text()+"</option>").appendTo(subject);
			}else{
				$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(subject);
			}
			if(cfgInfo.summary != null && cfgInfo.summary != "" && cfgInfo.summary.toString().indexOf(property.propertyName) >= 0){
				$("<option value='"+property.propertyName+"' selected>"+$(this).text()+"</option>").appendTo(summary);
			}else{
				$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(summary);
			}
			if(cfgInfo.content != null && cfgInfo.content != "" && cfgInfo.content == property.propertyName){
				$("<option value='"+property.propertyName+"' selected>"+$(this).text()+"</option>").appendTo(content);
			}else{
				$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(content);
			}
		}else{
			$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(subject);
			$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(summary);
			$("<option value='"+property.propertyName+"'>"+$(this).text()+"</option>").appendTo(content);
		}
	});
}
/*******************************************
 ??????????????????
 
 cfgInfo 
 		{
 		 propertyList : [{propertyName:?????????,propertyType???????????????,propertyText:????????????,messageKey???messageKey},...] ,  // ????????????????????????
      	}
*********************************************/
function getCfgInfo(){
	var propertyList = new Array();
	$("#selectedList option").each(function() {
		var property = eval("("+($(this).val())+")");
		propertyList.push(property);
	});
	var isNewsReadingMode = false;//???????????????????????????
	var subject = $('#subject').val();//?????? 
	var summary = $('#summary').val();//??????
	var content = $('#content').val();//??????
	if($('input[name="readingMode"][checked]').val() == "newsReadingMode"){
		isNewsReadingMode = true;
	}
	var cfgInfo = {'propertyList':propertyList};
	return cfgInfo;
}
function save(){
	if(!validate())
		return;
	var obj = window.opener.obj;
	obj.fdName = $('input[name="fdName"]').val();
	if($('input[name="fdCustom"]:checked').val()=="0"){
		obj.fdCfgInfo   = getCfgInfo();
		obj.fdExtendUrl = "";
	}else{
		obj.fdCfgInfo = "";
		obj.fdExtendUrl = $('input[name="fdExtendUrl"]').val();
	}
	window.opener.childrenWindowClose(obj);
	window.close();
}
function validate(){
	var errorMsg = "";
	var canSave = true;
	if($('input[name="fdName"]').val() == ""){
		errorMsg += '<bean:message bundle="third-pda" key="pdaModuleLabelList.fdName"/><bean:message bundle="third-pda" key="validate.notNull"/>\n';
		canSave = false; 
	}
	if($('input[name="fdCustom"]:checked').val()=="0"){
		if(getCfgInfo().propertyList.length <= 0){
			errorMsg += '<bean:message bundle="third-pda" key="pdaModuleLabelView.fdCfgView"/><bean:message bundle="third-pda" key="validate.notNull"/>\n';
			canSave = false; 
		}
	}else{
		if($('input[name="fdExtendUrl"]').val()==""){
			errorMsg += '<bean:message bundle="third-pda" key="pdaModuleConfigView.docDisplayCfg.custom.path"/><bean:message bundle="third-pda" key="validate.notNull"/>';
			canSave = false; 
		}
	}
	if(canSave == false)
		alert(errorMsg);
	return canSave;
}
</script>
<%@ include file="/resource/jsp/edit_down.jsp"%>