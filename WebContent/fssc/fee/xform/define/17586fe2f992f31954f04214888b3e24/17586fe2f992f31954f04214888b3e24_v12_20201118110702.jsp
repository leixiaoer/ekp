<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.xform.TagUtils" %>
<table id="fd_38fee948945046"  align="center" class="tb_normal"  layout2col="undefined"  fd_type="standardTable" style="width:100%;"><tbody><tr><td row="0" column="0" class="td_normal_title" width="284">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_38fee9e490ef16' option='content'/></label>
</td><td row="0" column="1" width="567">
			<xformflag flagtype="company" flagid="fd_3906f3ec0308fa" _xform_type='company' property='extendDataFormInfo.value(fd_3906f3ec0308fa)' id='_xform_extendDataFormInfo.value(fd_3906f3ec0308fa)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f3ec0308fa)" propertyName="extendDataFormInfo.value(fd_3906f3ec0308fa_name)" style="width:85%"  subject="公司" title="公司" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f3ec0308fa)','extendDataFormInfo.value(fd_3906f3ec0308fa_name)',Designer_Control_Company_Changed);">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>window.Designer_Control_Company_Event_List=window.Designer_Control_Company_Event_List||{};
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa']=[];
function Designer_Control_Company_Changed(rtn){for(var i in window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa']){window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'][i](rtn);}}</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_3906f3ec0308fa","fd_3906f3ec0308fa_name","getDefaultCompany")})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_3906f3ec0308fa')</script></xformflag></td><td row="0" column="2" class="td_normal_title" width="264">
			<label  class="xform_label" line="normal"  fd_type="textLabel" style="display: inline-block; width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_38ff06d03836cc' option='content'/></label>
</td><td row="0" column="3" width="373">
			<div  class="xform_inputText" canshow="true" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;"  fd_type="inputText"><xformflag flagid='fd_38ff07a608d292' id='_xform_extendDataFormInfo.value(fd_38ff07a608d292)' property='extendDataFormInfo.value(fd_38ff07a608d292)' flagtype='xform_text' _xform_type='text'><xform:xtext property="extendDataFormInfo.value(fd_38ff07a608d292)" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;width:120px;" required="false" className="inputread_normal xform_inputText" htmlElementProperties="dataReadOnly='true'"  subject="${xform:subject('fd_38ff07a608d292','label')}" title="${xform:subject('fd_38ff07a608d292','label')}" onValueChange="__xformDispatch" />
</xformflag></div>
</td></tr><tr><td row="1" column="0,1,2,3" class="td_normal_title" colspan="4" style="width: auto;" width="1489">
<xform:editShow><script>$(function(){var tb=document.getElementById('TABLE_DL_fd_3906f1680fb968');tb.setAttribute('tbdraggable','true');});</script></xform:editShow>
<xform:viewShow><script>$(function(){var tb=document.getElementById('TABLE_DL_fd_3906f1680fb968');tb.setAttribute('tbdraggable','false');$(tb).css('margin-bottom','1px');});</script></xform:viewShow>
<script>Com_IncludeFile('doclist.js');</script><script>DocList_Info.push('TABLE_DL_fd_3906f1680fb968');</script>
<script>Com_IncludeFile('detailsTableFreeze.css', Com_Parameter.ContextPath + 'sys/xform/designer/resource/css/', 'css', true);</script>
<script>Com_IncludeFile('detailsTableFreeze.js', Com_Parameter.ContextPath + 'sys/xform/designer/resource/js/', 'js', true);</script>
<xform:editShow><c:choose><c:when test="${empty _xformForm.extendDataFormInfo.formData.fd_3906f1680fb968}"><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {for (var i = 0; i < 1; i ++) {DocList_AddRow(document.getElementById('TABLE_DL_fd_3906f1680fb968'))};tableFreezeStarter('TABLE_DL_fd_3906f1680fb968',false, -1, false, true, 'add');}, 500);});</script></c:when><c:otherwise><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {tableFreezeStarter('TABLE_DL_fd_3906f1680fb968',false, -1, false, true, 'edit');}, 500);});</script></c:otherwise></c:choose>
</xform:editShow><xform:viewShow><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {tableFreezeStarter('TABLE_DL_fd_3906f1680fb968',false, -1, false, true, 'view');}, 500);});</script>
</xform:viewShow>
<table label="明细表1" id="TABLE_DL_fd_3906f1680fb968"  align="center" class="tb_normal" tablename="fd_38fee948945046" style="width: 100%;" data-multihead="false" width="100%" showindex="true" showrow="1" showstatisticrow="true" showcopyopt="true" dataentrymode="multipleRow" required="false" excelexport="true" excelimport="true" defaultfreezetitle="false" defaultfreezecol="-1" layout2col="mobile"  fd_type="detailsTable" aligment="default">
<tr class="tr_normal_title" type="titleRow" style="height: 33px;">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'></td>
</xform:editShow><td row="0" column="1" align="center" class="td_normal_title" coltype="noTitle" style="width: 25px; white-space: nowrap;"><kmss:message key="page.serial" /></TD><td align="center" row="0" column="2" data-ismultiheadcol="false" class="" style="">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_39078b3babe7ac' option='content'/></label>
</td><td align="center" row="0" column="3" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390b76422434e0' option='content'/></label>
</td><td align="center" row="0" column="4" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390b7648112afe' option='content'/></label>
</td><td align="center" row="0" column="5" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390b764d1555ba' option='content'/></label>
</td><td align="center" row="0" column="6" data-ismultiheadcol="false" class="" style="">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390a14e1b43f42' option='content'/></label>
</td><td align="center" row="0" column="7" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390a14ec9978aa' option='content'/></label>
</td><td align="center" row="0" column="8" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"><xform:lang id='fd_390b76216e0888' option='content'/></label>
</td><td row="0" column="9" align="center" class="td_normal_title" style="">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_3906f1699536a2' option='content'/></label>
</td><td align="center" row="0" column="10" data-ismultiheadcol="false">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_390783464350e4' option='content'/></label>
</td><td row="0" column="11" align="center" class="td_normal_title" style="">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_3906f16ad7ccd0' option='content'/></label>
</td><td row="0" column="12" align="center" class="td_normal_title">
			<label  class="xform_label" ishiddeninmobile="false" line="normal" style="display: inline-block; color: rgb(0, 0, 0); width: auto; word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"><xform:lang id='fd_3906f16be8a65a' option='content'/></label>
</td>
<xform:editShow><td row="0" column="13" align="center" class="td_normal_title" coltype="blankTitleCol" style="width:48px;"></TD>
</xform:editShow></tr>
<%-- 基准行 --%>
<tr KMSS_IsReferRow="1" style="display:none"  type="templateRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'><input type='checkbox' name='DocList_Selected' onclick='DocList_SelectRow(this);'/></td>
</xform:editShow><td row="1" column="1" align="center" coltype="noTemplate" style="width: 25px;" KMSS_IsRowIndex=1>{1}</TD><td align="center" row="1" column="2">
			<label  class="xform_address" style="display: inline-block; width: 171px;"  fd_type="address">
			<xformflag flagid='fd_3906f1680fb968.!{index}.fd_org' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.id)' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.id)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_3906f1680fb968.!{index}.fd_org','label')}" title="${xform:subject('fd_3906f1680fb968.!{index}.fd_org','label')}" style="width:120px;" required="false" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>

			<%-- 明细表行ID --%>
			<xform:text showStatus="noShow"  property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fdId)" />
</td><td align="center" row="1" column="3">
			<label  class="xform_datetime"  fd_type="datetime" style="display: inline-block; ">
			<xformflag flagid='fd_3906f1680fb968.!{index}.fd_390b765296f29a' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b765296f29a)' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b765296f29a)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b765296f29a)" style="width:120px;" required="false" showScheduling="false" subject="${xform:subject('fd_3906f1680fb968.!{index}.fd_390b765296f29a','label')}" title="${xform:subject('fd_3906f1680fb968.!{index}.fd_390b765296f29a','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" row="1" column="4">
			<label  class="xform_datetime"  fd_type="datetime" style="display: inline-block; ">
			<xformflag flagid='fd_3906f1680fb968.!{index}.fd_390b7653c9d72c' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b7653c9d72c)' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b7653c9d72c)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b7653c9d72c)" style="width:120px;" required="false" showScheduling="false" subject="${xform:subject('fd_3906f1680fb968.!{index}.fd_390b7653c9d72c','label')}" title="${xform:subject('fd_3906f1680fb968.!{index}.fd_390b7653c9d72c','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" row="1" column="5">
<xformflag flagtype='dayCount' _xform_type='dayCount' flagid='fd_3906f1680fb968.!{index}.fd_390b76567a4b2c' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b76567a4b2c)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b76567a4b2c)'>
			<xform:text property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b76567a4b2c)" required="true" showStatus="readOnly" style="width:85%" /><script>
if(!window.Designer_Control_DayCount_Props)window.Designer_Control_DayCount_Props=JSON.parse("{'width':'85%','id':'fd_390b76567a4b2c','subject':'天数','matchType':'2','matchTableId':'fd_3906f1680fb968','startDateId':'fd_3906f1680fb968.fd_390b765296f29a','endDateId':'fd_3906f1680fb968.fd_390b7653c9d72c','isPlusOne':'1'}".replace(/'/g,'"'));
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td align="center" row="1" column="6">
			<xformflag flagtype='currency' flagid='fd_3906f1680fb968.!{index}.fd_390a14f926cc92' _xform_type='currency' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)'>
<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_cost_rate)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_budget_rate)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_name)" style="width:85%"  subject="币种汇率" title="币种汇率" dialogJs="Designer_DialogSelect(false,'fssc_base_currency_selectCurrency','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_name)',Designer_Control_Currency_Evnet_Changed,{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Currency_List=window.Designer_Control_Currency_List||[];
window.Designer_Control_Currency_List.push('fd_3906f1680fb968.!{index}.fd_390a14f926cc92')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Currency_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_3906f1680fb968.!{index}.fd_390a14f926cc92","fd_3906f1680fb968.!{index}.fd_390a14f926cc92_name","getDefaultCurrency",{fdCompanyId:"fd_3906f3ec0308fa"},['_cost_rate','_budget_rate'])})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.!{index}.fd_390a14f926cc92')</script></xformflag></td><td align="center" row="1" column="7">
			<div  class="xform_inputText" canshow="true"  fd_type="inputText" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;"><xformflag flagid='fd_3906f1680fb968.!{index}.fd_390a14f2422e26' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f2422e26)' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f2422e26)' flagtype='xform_text' _xform_type='text'><xform:xtext property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f2422e26)" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;width:120px;" required="false" className="inputsgl xform_inputText" htmlElementProperties="thousandShow='false' dataType='number' "  dataType="Double" subject="${xform:subject('fd_3906f1680fb968.!{index}.fd_390a14f2422e26','label')}" title="${xform:subject('fd_3906f1680fb968.!{index}.fd_390a14f2422e26','label')}" validators=" number number scaleLength(0)" onValueChange="__xformDispatch" />
</xformflag></div>
</td><td align="center" row="1" column="8">
<xformflag flagtype='accountMoney' _xform_type='accountMoney' flagid='fd_3906f1680fb968.!{index}.fd_390b762ba0e642' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b762ba0e642)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b762ba0e642)'>
			<xform:text property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b762ba0e642)" required="true" showStatus="readOnly" style="width:85%" /><script>
if(!window.Designer_Control_AccountMoney_Props)window.Designer_Control_AccountMoney_Props=JSON.parse("{'width':'85%','id':'fd_390b762ba0e642','subject':'本币金额','matchType':'2','matchTableId':'fd_3906f1680fb968','currencyId':'fd_3906f1680fb968.fd_390a14f926cc92','moneyId':'fd_3906f1680fb968.fd_390a14f2422e26'}".replace(/'/g,'"'));
Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td row="1" column="9" align="center">
			<xformflag flagtype='vehicle' flagid='fd_3906f1680fb968.!{index}.fd_39078328c72fa4' _xform_type='vehicle' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)'>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_berth_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_vehicle_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_vehicle_name)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_name)" style="width:85%"  subject="交通工具" title="交通工具" dialogJs="Designer_DialogSelect(false,'fssc_base_berth_fdParent','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_name)',function(rtn,id){Designer_Control_Vehicle_Berth_Changed(rtn,id,'fd_3906f1680fb968.!{index}.fd_39078328c72fa4_vehicle_id','fd_3906f1680fb968.!{index}.fd_39078328c72fa4_vehicle_name')},{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Vehicle_Berth_List=window.Designer_Control_Vehicle_Berth_List||[];
window.Designer_Control_Vehicle_Berth_List.push('fd_3906f1680fb968.!{index}.fd_39078328c72fa4')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Vehicle_Berth_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.!{index}.fd_39078328c72fa4')</script></xformflag></td><td align="center" row="1" column="10">
			<xformflag flagtype="area" flagid='fd_3906f1680fb968.!{index}.fd_39078349193118' _xform_type='area' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118_name)" style="width:85%"  subject="地域" title="地域" dialogJs="Designer_SelectArea('fd_3906f3ec0308fa','fd_39078349193118');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_3906f1680fb968.!{index}.fd_39078349193118')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.!{index}.fd_39078349193118')</script></xformflag></td><td row="1" column="11" align="center" class="" style="">
			<xformflag flagtype="costCenter" flagid='fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212' _xform_type='costCenter' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212_name)" style="width:85%"  subject="成本中心" title="成本中心" dialogJs="Designer_DialogSelect(false,'fssc_base_cost_center_selectCostCenter','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212_name)',null,{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Cost_Center_List=window.Designer_Control_Cost_Center_List||[];
window.Designer_Control_Cost_Center_List.push('fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Cost_Center_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212')</script></xformflag></td><td row="1" column="12" align="center">
			<xformflag flagtype="area" flagid='fd_3906f1680fb968.!{index}.fd_3907c3973e0808' _xform_type='area' property='extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808_name)" style="width:85%"  subject="城市" title="城市" dialogJs="Designer_SelectArea('fd_3906f3ec0308fa','fd_3907c3973e0808');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_3906f1680fb968.!{index}.fd_3907c3973e0808')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.!{index}.fd_3907c3973e0808')</script></xformflag></td>
<xform:editShow>
<td row="1" column="13" align="center" coltype="copyCol" style="width: 48px;"><nobr><span style='cursor:pointer' class='optStyle opt_copy_style'  title='<bean:message bundle="sys-xform" key="xform.button.copy" />' onmousedown='DocList_CopyRow();'></span>&nbsp;&nbsp;<span style='cursor:pointer' class='optStyle opt_del_style' title='<bean:message bundle="sys-xform" key="xform.button.delete" />' onmousedown='DocList_DeleteRow_ClearLast();XFom_RestValidationElements();'></span>&nbsp;&nbsp;</nobr></TD>
</xform:editShow>
</tr>
<%-- 内容行 --%>
<c:forEach items="${_xformForm.extendDataFormInfo.formData.fd_3906f1680fb968}" var="_xformEachBean" varStatus="vstatus">
<tr KMSS_IsContentRow="1"  type="templateRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'><input type='checkbox' name='DocList_Selected' onclick='DocList_SelectRow(this);'/></td>
</xform:editShow><td row="1" column="1" align="center" coltype="noTemplate" style="width: 25px;" KMSS_IsRowIndex=1>${vstatus.index + 1}</TD><td align="center" row="1" column="2">
			<label  class="xform_address" style="display: inline-block; width: 171px;"  fd_type="address">
			<xformflag flagid='fd_3906f1680fb968.${vstatus.index}.fd_org' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.id)' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.id)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_org','label')}" title="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_org','label')}" style="width:120px;" required="false" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>

			<%-- 明细表行ID --%>
			<xform:text showStatus="noShow"  property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fdId)" />
</td><td align="center" row="1" column="3">
			<label  class="xform_datetime"  fd_type="datetime" style="display: inline-block; ">
			<xformflag flagid='fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a)' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a)" style="width:120px;" required="false" showScheduling="false" subject="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a','label')}" title="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" row="1" column="4">
			<label  class="xform_datetime"  fd_type="datetime" style="display: inline-block; ">
			<xformflag flagid='fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c)' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c)" style="width:120px;" required="false" showScheduling="false" subject="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c','label')}" title="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" row="1" column="5">
<xformflag flagtype='dayCount' _xform_type='dayCount' flagid='fd_3906f1680fb968.${vstatus.index}.fd_390b76567a4b2c' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b76567a4b2c)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b76567a4b2c)'>
			<xform:text property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b76567a4b2c)" required="true" showStatus="readOnly" style="width:85%" /><script>
if(!window.Designer_Control_DayCount_Props)window.Designer_Control_DayCount_Props=JSON.parse("{'width':'85%','id':'fd_390b76567a4b2c','subject':'天数','matchType':'2','matchTableId':'fd_3906f1680fb968','startDateId':'fd_3906f1680fb968.fd_390b765296f29a','endDateId':'fd_3906f1680fb968.fd_390b7653c9d72c','isPlusOne':'1'}".replace(/'/g,'"'));
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td align="center" row="1" column="6">
			<xformflag flagtype='currency' flagid='fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92' _xform_type='currency' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)'>
<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_cost_rate)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_budget_rate)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_name)" style="width:85%"  subject="币种汇率" title="币种汇率" dialogJs="Designer_DialogSelect(false,'fssc_base_currency_selectCurrency','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_name)',Designer_Control_Currency_Evnet_Changed,{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Currency_List=window.Designer_Control_Currency_List||[];
window.Designer_Control_Currency_List.push('fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Currency_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92","fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_name","getDefaultCurrency",{fdCompanyId:"fd_3906f3ec0308fa"},['_cost_rate','_budget_rate'])})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92')</script></xformflag></td><td align="center" row="1" column="7">
			<div  class="xform_inputText" canshow="true"  fd_type="inputText" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;"><xformflag flagid='fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26)' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26)' flagtype='xform_text' _xform_type='text'><xform:xtext property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26)" style="display: inline-block; width: 147px; word-break: break-all; overflow-wrap: break-word;width:120px;" required="false" className="inputsgl xform_inputText" htmlElementProperties="thousandShow='false' dataType='number' "  dataType="Double" subject="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26','label')}" title="${xform:subject('fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26','label')}" validators=" number number scaleLength(0)" onValueChange="__xformDispatch" />
</xformflag></div>
</td><td align="center" row="1" column="8">
<xformflag flagtype='accountMoney' _xform_type='accountMoney' flagid='fd_3906f1680fb968.${vstatus.index}.fd_390b762ba0e642' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b762ba0e642)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b762ba0e642)'>
			<xform:text property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b762ba0e642)" required="true" showStatus="readOnly" style="width:85%" /><script>
if(!window.Designer_Control_AccountMoney_Props)window.Designer_Control_AccountMoney_Props=JSON.parse("{'width':'85%','id':'fd_390b762ba0e642','subject':'本币金额','matchType':'2','matchTableId':'fd_3906f1680fb968','currencyId':'fd_3906f1680fb968.fd_390a14f926cc92','moneyId':'fd_3906f1680fb968.fd_390a14f2422e26'}".replace(/'/g,'"'));
Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td row="1" column="9" align="center">
			<xformflag flagtype='vehicle' flagid='fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4' _xform_type='vehicle' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)'>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_berth_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_vehicle_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_vehicle_name)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_name)" style="width:85%"  subject="交通工具" title="交通工具" dialogJs="Designer_DialogSelect(false,'fssc_base_berth_fdParent','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_name)',function(rtn,id){Designer_Control_Vehicle_Berth_Changed(rtn,id,'fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_vehicle_id','fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_vehicle_name')},{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Vehicle_Berth_List=window.Designer_Control_Vehicle_Berth_List||[];
window.Designer_Control_Vehicle_Berth_List.push('fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Vehicle_Berth_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4')</script></xformflag></td><td align="center" row="1" column="10">
			<xformflag flagtype="area" flagid='fd_3906f1680fb968.${vstatus.index}.fd_39078349193118' _xform_type='area' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118_name)" style="width:85%"  subject="地域" title="地域" dialogJs="Designer_SelectArea('fd_3906f3ec0308fa','fd_39078349193118');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_3906f1680fb968.${vstatus.index}.fd_39078349193118')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.${vstatus.index}.fd_39078349193118')</script></xformflag></td><td row="1" column="11" align="center" class="" style="">
			<xformflag flagtype="costCenter" flagid='fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212' _xform_type='costCenter' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212_name)" style="width:85%"  subject="成本中心" title="成本中心" dialogJs="Designer_DialogSelect(false,'fssc_base_cost_center_selectCostCenter','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212_name)',null,{fdCompanyId:'fd_3906f3ec0308fa'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Cost_Center_List=window.Designer_Control_Cost_Center_List||[];
window.Designer_Control_Cost_Center_List.push('fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_Cost_Center_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212')</script></xformflag></td><td row="1" column="12" align="center">
			<xformflag flagtype="area" flagid='fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808' _xform_type='area' property='extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808)' id='_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808_name)" style="width:85%"  subject="城市" title="城市" dialogJs="Designer_SelectArea('fd_3906f3ec0308fa','fd_3907c3973e0808');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808')
window.Designer_Control_Company_Event_List['fd_3906f3ec0308fa'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808')</script></xformflag></td>
<xform:editShow>
<td row="1" column="13" align="center" coltype="copyCol" style="width: 48px;"><nobr><span style='cursor:pointer' class='optStyle opt_copy_style'  title='<bean:message bundle="sys-xform" key="xform.button.copy" />' onmousedown='DocList_CopyRow();'></span>&nbsp;&nbsp;<span style='cursor:pointer' class='optStyle opt_del_style' title='<bean:message bundle="sys-xform" key="xform.button.delete" />' onmousedown='DocList_DeleteRow_ClearLast();XFom_RestValidationElements();'></span>&nbsp;&nbsp;</nobr></TD>
</xform:editShow>
</tr>
</c:forEach>
<tr type="statisticRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'></td>
</xform:editShow><td row="2" column="1" align="center" coltype="noFoot" style="width: 25px;">&nbsp;</TD><td align="center" row="2" column="2">&nbsp;</td><td align="center" row="2" column="3">&nbsp;</td><td align="center" row="2" column="4">&nbsp;</td><td align="center" row="2" column="5">&nbsp;</td><td align="center" row="2" column="6">&nbsp;</td><td align="center" row="2" column="7">&nbsp;</td><td align="center" row="2" column="8">&nbsp;</td><td row="2" column="9" align="center">&nbsp;</td><td align="center" row="2" column="10">&nbsp;</td><td row="2" column="11" align="center">&nbsp;</td><td row="2" column="12" align="center">&nbsp;</td>
<xform:editShow><td row="2" column="13" align="center" coltype="emptyCell" style="width: 48px;">&nbsp;</TD>
</xform:editShow></tr>
<tr type="optRow" class="tr_normal_opt">
<xform:editShow>
<td row="3" column="0" align="center" coltype="optCol" colspan="14" style=""><div class="tr_normal_opt_content" style="min-width:580px;;" >
<div class="tr_normal_opt_l"  ><label class="opt_ck_style" style="position:relative;top:3px;"><input type="checkbox" name='DocList_SelectAll' onclick='DocList_SelectAllRow(this);'/><span style="margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.selectAll" /><span></label><span style="margin-left:15px;" onclick='DocList_BatchDeleteRow();XFom_RestValidationElements();'><span class="optStyle opt_batchDel_style" style="margin-left:0px; "  title='<bean:message bundle="sys-xform" key="xform.button.delete" />'></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;" ><bean:message bundle="sys-xform" key="xform.button.delete" /></span></span></div>
<div class="tr_normal_opt_c"  ><span onclick='DocList_AddRow();XFom_RestValidationElements();'><span class="optStyle opt_add_style"  title='<bean:message bundle="sys-xform" key="xform.button.add" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.add" /></span></span><span style="margin-left:15px;" onclick='DocList_MoveRowBySelect(-1);'><span class="optStyle opt_up_style" title='<bean:message bundle="sys-xform" key="xform.button.moveup" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.moveup" /></span></span><span style="margin-left:15px;" onclick='DocList_MoveRowBySelect(1);'><span class="optStyle opt_down_style" title='<bean:message bundle="sys-xform" key="xform.button.movedown" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.movedown" /></span></span></div>
<div class="tr_normal_opt_r"  ><span class="optStyle" style="margin-left:0px;" onclick='DocList_exportExcelInEdit("TABLE_DL_fd_3906f1680fb968","fd_3906f1680fb968","${param.formFilePath}","true");'><span class="optStyle opt_export_style"></span><span style='cursor: pointer;position:relative;top:4px;'><bean:message bundle="sys-xform" key="xform.button.dataExport" /></span></span><span class="optStyle" style="margin-left:15px;" onclick='DocList_importExcel("TABLE_DL_fd_3906f1680fb968","fd_3906f1680fb968","${param.formFilePath}","true");'><span class="optStyle opt_import_style"></span><span style='cursor: pointer;position:relative;top:4px;'><bean:message bundle="sys-xform" key="xform.button.dataImport" /></span></span>
</div></div></div></TD>
</xform:editShow>

<xform:viewShow>
<td row='3' column='0' align='center' coltype='optCol'><div class="tr_normal_opt_content" style="min-width:580px;;" ><div class="tr_normal_opt_r" ><span class="optStyle" onclick='DocList_exportExcel("${param.fdId}","fd_3906f1680fb968","${param.mainModelName}","true");'><span class="optStyle opt_export_style"></span><span style='cursor: pointer;'><bean:message bundle="sys-xform" key="xform.button.dataExport" /></span></span></div></div></td>
</xform:viewShow>
</tr>
			</table>
</td></tr><tr><td row="2" column="0" class="td_normal_title" width="284">&nbsp;</td><td row="2" column="1" width="566">&nbsp;</td><td row="2" column="2" class="td_normal_title" width="267">&nbsp;</td><td row="2" column="3" width="372">&nbsp;</td></tr><tr><td row="3" column="0" class="td_normal_title" width="284">&nbsp;</td><td row="3" column="1" width="564" class="" style="">&nbsp;</td><td row="3" column="2" class="td_normal_title" width="271">&nbsp;</td><td row="3" column="3" width="373">&nbsp;</td></tr></tbody></table>