<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.language.utils.SysLangUtil,java.lang.String" %>
<template:include ref="config.profile.edit" sidebar="no">
<template:replace name="content">
<html:form action="/sys/appconfig/sys_appconfig/sysAppConfig.do">
<div style="margin-top:25px">
<p class="configtitle">${lfn:message('sys-attachment:attachment.config') }</p>
<center>
<table class="tb_normal" width=85%>
	<tr>
		<td class="td_normal_title" width=30%>
			<bean:message key="attachment.config.onlineToolType" bundle="sys-attachment" />
		</td>
		<td>
			<xform:radio property="value(onlineToolType)" onValueChange="changeOnlineToolType(this.value);">
			  <xform:enumsDataSource enumsType="sys_att_config_onlineToolType"></xform:enumsDataSource>
			</xform:radio>
			<br>
			<br>
			<%-- <bean:message key="attachment.config.onlineToolType.tips" bundle="sys-attachment" /> --%>
			<span id="onlineToolType_tip">
			</span>

		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=30%>
			<bean:message key="attachment.config.mobile.onlineToolType" bundle="sys-attachment" />
		</td>
		<td id="first">
			<xform:radio property="value(onlineMobileToolTypeFirst)" onValueChange="changeMobileOnlineToolType(this.value,'mobile_tip_first');">
			  <xform:enumsDataSource enumsType="sys_att_config_mobile_onlineToolType_first"></xform:enumsDataSource>
			</xform:radio>
			<%-- <bean:message key="attachment.config.mobile.onlineToolType.tips.0" bundle="sys-attachment" /> --%>
			<br>
			<span id="mobile_tip_first">
			</span>
		</td>
		<td id="second">
			<xform:radio property="value(onlineMobileToolTypeSecond)" onValueChange="changeMobileOnlineToolType(this.value,'mobile_tip_second');">
			  <xform:enumsDataSource enumsType="sys_att_config_mobile_onlineToolType_second"></xform:enumsDataSource>
			</xform:radio>
			<%-- <bean:message key="attachment.config.mobile.onlineToolType.tips.1" bundle="sys-attachment" /> --%>
			<br>
			<span id="mobile_tip_second">
			</span>
		</td>
		<td id="third">
			<xform:radio property="value(onlineMobileToolTypeThird)" onValueChange="changeMobileOnlineToolType(this.value,'mobile_tip_third');">
			  <xform:enumsDataSource enumsType="sys_att_config_mobile_onlineToolType_third"></xform:enumsDataSource>
			</xform:radio>
			<%-- <bean:message key="attachment.config.mobile.onlineToolType.tips.2" bundle="sys-attachment" /> --%>
			<br>
			<span id="mobile_tip_third">
			</span>

		</td>
	</tr>
	<tr class="useLinuxView" style="display: none">
		<td class="td_normal_title" width=30%>
			是否强制使用在线预览阅读
		</td>
		<td id="first">
			<ui:switch property="value(useWpsLinuxView)" checkVal="2" unCheckVal="1" enabledText="启用" disabledText="禁用"></ui:switch>	
		</td>
	</tr>
	<tr class="wpsCloudAutoSave" style="display: none">
	    <!-- WPS云文档编辑时是否启用内容自动保存  -->
		<td class="td_normal_title" width=30%>
			<bean:message key="attachment.config.wps.cloud.auto.save.type" bundle="sys-attachment" />
		</td>
		<td>
			<xform:radio property="value(wpsCloudAutosave)" onValueChange="wpsCloudAutoSaveNo()">
			  <xform:enumsDataSource enumsType="sys_att_config_wpsCloud_autosave"></xform:enumsDataSource>
			</xform:radio>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="wpsCloudAutoSaveNo">
				<a href="javascript:void(0)" onclick="openWpsCloudAutoSaveNo();" style='color:blue;'>
					<bean:message key="attachment.config.wps.cloud.auto.save.except" bundle="sys-attachment" />
				</a>
			</span>
			<html:hidden property="value(wpsCloudAutoSaveExcept)"/>
			<br>
			<p><bean:message key="attachment.config.wps.cloud.auto.save.type.tips" bundle="sys-attachment" /></p>
		</td>
	</tr>
	
	<tr class="jgConfig" style="display: none">
	    <!-- 默认启用阅读加速模式  -->
		<td class="td_normal_title" width=30%>
			<bean:message key="attachment.config.showWindow" bundle="sys-attachment" />
		</td>
		<td>
			<xform:radio property="value(showWindow)">
			  <xform:enumsDataSource enumsType="sys_att_config_showWindow"></xform:enumsDataSource>
			</xform:radio>
		</td>
	</tr>
	<tr class="jgConfig" style="display: none">
	    <!-- 正文是否展开  -->
		<td class="td_normal_title" width=30%>
		  <bean:message key="attachment.config.readpdf" bundle="sys-attachment" />
		</td>
		<td>
			<xform:radio property="value(readpdf)">
				<xform:simpleDataSource value="1">
					<bean:message key="attachment.config.readpdf.canread" bundle="sys-attachment" />
					<%
						String currentLocaleCountry = SysLangUtil.getCurrentLocaleCountry();
						if(currentLocaleCountry != null && currentLocaleCountry.equals("US")){
							%>
							<img src="<c:url value='/sys/attachment/sys_att_main/pdf/images/canread_EN.png'/>" width="450px" height="135px"/>
							<% 
						}
						if(currentLocaleCountry != null && currentLocaleCountry.equals("CN")){
							%>
							<img src="<c:url value='/sys/attachment/sys_att_main/pdf/images/canread.png'/>" width="450px" height="135px"/>
							<% 
						}
					%>
					
					<br><br>
				</xform:simpleDataSource>
				<xform:simpleDataSource value="0">
					<bean:message key="attachment.config.readpdf.noread" bundle="sys-attachment" />
					<%
						String currentLocaleCountry = SysLangUtil.getCurrentLocaleCountry();
						if(currentLocaleCountry != null && currentLocaleCountry.equals("US")){
							%>
							<img src="<c:url value='/sys/attachment/sys_att_main/pdf/images/noread_EN.png'/>" width="450px" height="135px"/>
							<% 
						}
						if(currentLocaleCountry != null && currentLocaleCountry.equals("CN")){
							%>
							<img src="<c:url value='/sys/attachment/sys_att_main/pdf/images/noread.png'/>"  width="450px" height="145px"/>
							<% 
						}
					%>
				</xform:simpleDataSource>
			</xform:radio>
		</td>
	</tr>
</table>
<div style="margin-bottom: 10px;margin-top:25px">
	   <ui:button text="${lfn:message('button.save')}" height="35" width="120" onclick="commitMethod();" order="1" ></ui:button>
</div>
</center>
</div>
</html:form> 
<script>
function commitMethod(value){
	Com_Submit(document.sysAppConfigForm, 'update');
}
</script>
<script>
Com_IncludeFile("jquery.js");
</script>
<script>
$(document).ready(function (){
	init();
   var onlineToolType = document.getElementsByName("value(onlineToolType)");
   for(var i = 0;i<onlineToolType.length;i++){
	  if(onlineToolType[i].checked){
		  changeOnlineToolType(onlineToolType[i].value);
	  }
   }
});
/****
 * 初始化
*/
function init(){
	var readpdf = $('input[name="value(readpdf)"][type="hidden"]');
	var radio = "input[name='value(readpdf)'][type='radio'][value='"+readpdf.val()+"']";
	$(radio).attr("checked","checked");
	$('input[name="value(readpdf)"][type="radio"]').each( function() {
			$(this).bind('click', function() {
				//readpdf.val(this.value);
			});
	});
	
//	$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='0']").attr("checked","checked");
	changeMobileOnlineToolType('0','mobile_tip_first');
	$("#second").hide();
	$("#third").hide();
	initClickEvent();
}

function initClickEvent()
{
	
	$('input[name="value(onlineMobileToolTypeFirst)"][type="radio"]').each( function() {
		$(this).bind('click', function() {
			//清除对应选择
			if(this.value == '0')
			{
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='1']").attr("checked",false);
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='2']").attr("checked",false);
			}
			else if(this.value == '1')
			{
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='0']").attr("checked",false);
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='2']").attr("checked",false);
			}
			else if(this.value == '2')
			{
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='0']").attr("checked",false);
				$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='1']").attr("checked",false);
			}
			
			//新选择
			$("input[name='value(onlineMobileToolTypeFirst)'][type='radio'][value='"+this.value+"']").attr("checked","checked");
		});
	});
	
	$('input[name="value(onlineMobileToolTypeSecond)"][type="radio"]').each( function() {
		$(this).bind('click', function() {
			//清除对应选择
			if(this.value == '1')
			{
				$("input[name='value(onlineMobileToolTypeSecond)'][type='radio'][value='2']").attr("checked",false);
			}
			else
			{
				$("input[name='value(onlineMobileToolTypeSecond)'][type='radio'][value='1']").attr("checked",false);
			}
			
			//新选择
			$("input[name='value(onlineMobileToolTypeSecond)'][type='radio'][value='"+this.value+"']").attr("checked","checked");
		});
	});
	
	$('input[name="value(onlineMobileToolTypeThird)"][type="radio"]').each( function() {
		$(this).bind('click', function() {
			//$("input[name='value(onlineMobileToolTypeThird)'][type='radio'][value='"+this.value+"']").attr("checked","checked");
			
			//清除对应选择
			if(this.value == '1')
			{
				$("input[name='value(onlineMobileToolTypeThird)'][type='radio'][value='2']").attr("checked",false);
			}
			else
			{
				$("input[name='value(onlineMobileToolTypeThird)'][type='radio'][value='1']").attr("checked",false);
			}
			
			//新选择
			$("input[name='value(onlineMobileToolTypeThird)'][type='radio'][value='"+this.value+"']").attr("checked","checked");
		});
	});
}
function changeOnlineToolType(val,name){
//debugger;
	if(val == "0"){
		$(".jgConfig").show();
	}else{
		$(".jgConfig").hide();
	}
	
	if(val == "0")
	{
		$("#first").show();
		$("#second").hide();
		$("#third").hide();
		mobileExistValue(val,'onlineMobileToolTypeFirst', 'mobile_tip_first');
	}
	else if(val == '3')
	{
		$("#first").hide();
		$("#second").show();
		$("#third").hide();
		mobileExistValue(val,'onlineMobileToolTypeSecond', 'mobile_tip_second');
	}
	else if(val == '1')
	{
		$("#first").hide();
		$("#second").hide();
		$("#third").show();
		mobileExistValue(val,'onlineMobileToolTypeThird', 'mobile_tip_third');
	}
	wpsCloudAutoSave();
	changePCOnlineToolType(val);
	useLinuxView();
}
function useLinuxView(){
	var pc=$('input[name="value(onlineToolType)"][type="radio"]:checked').val();
	if(pc==="3" || pc==="0")
		$(".useLinuxView").show();
	else
		$(".useLinuxView").hide();
}

function wpsCloudAutoSave(){
	var pc=$('input[name="value(onlineToolType)"][type="radio"]:checked').val();
	if(pc==="0"){
		var mobileFirst=$('input[name="value(onlineMobileToolTypeFirst)"][type="radio"]:checked').val();
		if(mobileFirst==="2")
			$(".wpsCloudAutoSave").show();
		else
			$(".wpsCloudAutoSave").hide();
	}
	if(pc==="1"){
		$(".wpsCloudAutoSave").show();
	}
	if(pc==="3"){
		var mobileSecond=$('input[name="value(onlineMobileToolTypeSecond)"][type="radio"]:checked').val();
		if(mobileSecond==="2")
			$(".wpsCloudAutoSave").show();
		else
			$(".wpsCloudAutoSave").hide();
	}
	
	wpsCloudAutoSaveNo();
}

function wpsCloudAutoSaveNo(){
	var wpsCloudAutosave=$('input[name="value(wpsCloudAutosave)"][type="radio"]:checked').val();
	if(wpsCloudAutosave==="0")
		$(".wpsCloudAutoSaveNo").show();
	else
		$(".wpsCloudAutoSaveNo").hide();
}

function openWpsCloudAutoSaveNo(){
	
	seajs.use([ 'lui/dialog', 'lui/topic' ],function(dialog, topic) {
		top.window.autoSaveExcept = $('input[name="value(wpsCloudAutoSaveExcept)"]').val();
		dialog.iframe("/sys/attachment/wpsCloudAutoExcept.jsp","${lfn:message('sys-attachment:attachment.config.wps.cloud.auto.save.except')}",
				function() {}, 
				{
		            width:980,
					height:550,
		            buttons:[{
		                name : "${lfn:message('button.ok')}",
						value : true,
						focus : true,
						fn : function(value,_dialog) {
						    var moduleInfo = _dialog.content.iframeObj[0].contentWindow.getSelectModule();
					    	$('input[name="value(wpsCloudAutoSaveExcept)"]').val(moduleInfo);
					    	_dialog.hide();
						    
						}
		            },{
		                name : "${lfn:message('button.cancel')}",
						styleClass:"lui_toolbar_btn_gray iframeBtn",
						value : false,
						fn : function(value, _dialog) {
							_dialog.hide();
						}
		            }]
		        }		
		);
	});
}

//PC端选项改变后，移动端选项跟着变
//initValue 初始值  radioName：单选的名称   mobilTip：提示信息
function mobileExistValue(initValue,radioName, mobilTip )
{
	var checked = false;
	
	$('input[name="value('+radioName+')"][type="radio"]').each( function() {
		if($(this).attr("checked"))
			{
				changeMobileOnlineToolType(this.value,mobilTip);
				checked = true;
			}

	});
	
	if(!checked)
	{
		$("input[name='value("+radioName+")'][type='radio'][value="+initValue+"]").attr("checked","checked");
		changeMobileOnlineToolType(initValue,mobilTip);
	}
}

//PC配置信息说明  val:第几个选项 name:单选项名称
function changePCOnlineToolType(val)
{
	if(val == '0')
	{
		var tip="${lfn:message('sys-attachment:attachment.config.onlineToolType.tips.0')}";
		$("#onlineToolType_tip").html("<br>"+tip);
	}
	else if(val == '3')
	{
		var tip="${lfn:message('sys-attachment:attachment.config.onlineToolType.tips.1')}";
		tip=tip.replace('http://www.landray.com.cn',Com_Parameter.serverPrefix);
		$("#onlineToolType_tip").html("<br>"+tip);
	}
	else if(val == '1')
	{
		var tip="${lfn:message('sys-attachment:attachment.config.onlineToolType.tips.2')}";
		$("#onlineToolType_tip").html("<br>"+tip);
	}
}
//移动配置信息说明  val:第几个选项 name:单选项名称
function changeMobileOnlineToolType(val, name)
{
	if(val == '0')
	{
		var mobilTip="${lfn:message('sys-attachment:attachment.config.mobile.onlineToolType.tips.0')}";
		$("#" + name).html("<br>"+mobilTip);
	}
	else if(val == '1')
	{
		var mobilTip="${lfn:message('sys-attachment:attachment.config.mobile.onlineToolType.tips.1')}";
		$("#" + name).html("<br>"+mobilTip);
	}
	else if(val == '2')
	{
		var mobilTip="${lfn:message('sys-attachment:attachment.config.mobile.onlineToolType.tips.2')}";
		$("#" + name).html("<br>"+mobilTip);
	}
	
	wpsCloudAutoSave();
}

//点击可跳转到WPS集成配置页面，如果并未出库WPS集成，则提示“产品暂不包括WPS集成组件，无法进行配置”
function forwardWPSConfig()
{
	var redirectUrl = "${LUI_ContextPath }/sys/profile/index.jsp#integrate/other/third/wps";
	var _url = "${LUI_ContextPath }/sys/profile/sys_profile_main/sysCfgProfileConfig.do?method=data&type=other&t=1602465908660&s_ajax=true";
	$.ajax({ 
	       url:_url, 
	       type: "GET" , 
	       dataType: 'json',
	       success: function (data){ 
	         for(var i = 0; i < data.length; i++)
	        {
	        	 var info = data[i];
	        	 if(info.key == 'third/wps')
	        	{
	        		 window.open(redirectUrl);
	        		 return;
	        	}
	        }
	         
	        alert("${lfn:message('sys-attachment:attachment.config.reforward.tip')}");
	       }, 
	       error : function(e)
	       {
	    	   
	    	   alert("${lfn:message('sys-attachment:attachment.config.reforward.tip')}");
			} 
	     });
	}
seajs.use([ 'theme!list', 'theme!portal' ]);
seajs.use([ 'lui/dialog', 'lui/topic' ],function(dialog, topic) {
	//方案说明 
	window.detailConfig = function() {
		dialog.iframe("/sys/attachment/detailConfig.jsp","${lfn:message('sys-attachment:sysAttMain.tip')}",
				function() {}, {width : 550,height : 280});
	};
});

</script>
</template:replace>
</template:include>