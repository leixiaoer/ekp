<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.xform.TagUtils" %>
<table align="center" class="tb_normal" id="fd_374252852c0bd2"   fd_type="standardTable"  layout2col="undefined" style="width:100%;"><tbody><tr style="height: 54px;"><td width="0" class="td_normal_title" style="width: 188.5px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="10%" column="0" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_37425291ea0326' option='content'/></label>
</td><td width="0" class="tb_normal" style="width: 312.79px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="23%" column="1" row="0">
			<label class="xform_address" style="width: 163px; display: inline-block;"  fd_type="address" >
			<xformflag flagid='fd_37425332ffd2f2' id='_xform_extendDataFormInfo.value(fd_37425332ffd2f2.id)' property='extendDataFormInfo.value(fd_37425332ffd2f2.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_37425332ffd2f2.id)" propertyName="extendDataFormInfo.value(fd_37425332ffd2f2.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_37425332ffd2f2','label')}" title="${xform:subject('fd_37425332ffd2f2','label')}" style="width: 120px;" required="true" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>
</td><td width="0" class="td_normal_title" style="width: 181.25px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="10%" column="2" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374252930e2eb0' option='content'/></label>
</td><td width="0" class="tb_normal" style="width: 296.64px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="23%" column="3" row="0">
			<xformflag flagtype="company" flagid="fd_374252eae52b20" _xform_type='company' property='extendDataFormInfo.value(fd_374252eae52b20)' id='_xform_extendDataFormInfo.value(fd_374252eae52b20)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_374252eae52b20)" propertyName="extendDataFormInfo.value(fd_374252eae52b20_name)" required="true" style="width:80%"  subject="申请人公司" title="申请人公司" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_374252eae52b20)','extendDataFormInfo.value(fd_374252eae52b20_name)',Designer_Control_Company_Changed);">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>window.Designer_Control_Company_Event_List=window.Designer_Control_Company_Event_List||{};
window.Designer_Control_Company_Event_List['fd_374252eae52b20']=[];
function Designer_Control_Company_Changed(rtn){for(var i in window.Designer_Control_Company_Event_List['fd_374252eae52b20']){window.Designer_Control_Company_Event_List['fd_374252eae52b20'][i](rtn);}}</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_374252eae52b20","fd_374252eae52b20_name","getDefaultCompany")})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_374252eae52b20')</script></xformflag></td><td width="0" class="td_normal_title" style="width: 159.09px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="10%" column="4" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374252943fc1fc' option='content'/></label>
</td><td width="0" class="tb_normal" style="width: 527.19px; text-align: left; vertical-align: middle;" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="23%" column="5" row="0">
			<label class="xform_address" style="width: 129px; display: inline-block;"  fd_type="address" >
			<xformflag flagid='fd_37425334cb401a' id='_xform_extendDataFormInfo.value(fd_37425334cb401a.id)' property='extendDataFormInfo.value(fd_37425334cb401a.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_37425334cb401a.id)" propertyName="extendDataFormInfo.value(fd_37425334cb401a.name)" mulSelect="false" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" subject="${xform:subject('fd_37425334cb401a','label')}" title="${xform:subject('fd_37425334cb401a','label')}" style="width: 120px;" required="true" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>

	<%-- 隐藏字段 --%>
</td></tr><tr style="height: 97px;"><td width="0" class="td_normal_title" style="width: 188.5px;" column="0" row="1">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_37425295b9581e' option='content'/></label>
</td><td width="0" style="width: auto;" colspan="5" column="1,2,3,4,5" row="1">
			<div class="xform_textArea" style="word-wrap:break-word;word-break:break-all;width: 971px; height: <xform:editShow>80px</xform:editShow><xform:viewShow>auto</xform:viewShow>; color: rgb(0, 0, 0); display: <xform:editShow>inline</xform:editShow><xform:viewShow>inline-block</xform:viewShow>;"  fd_type="textarea" >
			<xformflag flagid='fd_374252fcb7dcbc' id='_xform_extendDataFormInfo.value(fd_374252fcb7dcbc)' property='extendDataFormInfo.value(fd_374252fcb7dcbc)' flagtype='xform_textarea' _xform_type='textarea'><xform:textarea property="extendDataFormInfo.value(fd_374252fcb7dcbc)" style="width:956px;height:80px;color:rgb(0,0,0);display:inline-block;" className="xform_textArea" required="true" subject="${xform:subject('fd_374252fcb7dcbc','label')}" title="${xform:subject('fd_374252fcb7dcbc','label')}" placeholder="${xform:subject('fd_374252fcb7dcbc','tipInfo')}" onValueChange="__xformDispatch" />
</xformflag></div>
</td></tr><tr style="height: 66px;"><td width="0" class="td_normal_title" style="width: 188.5px;" column="0" row="2">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; overflow-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_37689ded580fac' option='content'/></label>
</td><td width="0" style="width: auto;" colspan="5" column="1,2,3,4,5" row="2" class="">
			<xformflag flagtype='project' flagid='fd_37689df08409d2' _xform_type='project' property='extendDataFormInfo.value(fd_37689df08409d2)' id='_xform_extendDataFormInfo.value(fd_37689df08409d2)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37689df08409d2)" propertyName="extendDataFormInfo.value(fd_37689df08409d2_name)" style="width:50%"  subject="项目" title="项目" dialogJs="Designer_DialogSelect(false,'fssc_base_project_fdParent','extendDataFormInfo.value(fd_37689df08409d2)','extendDataFormInfo.value(fd_37689df08409d2_name)',null,{fdCompanyId:'fd_374252eae52b20',fdProjectType:'1'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Project_List=window.Designer_Control_Project_List||[];
window.Designer_Control_Project_List.push('fd_37689df08409d2')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Project_Load);
</script><script>Designer_Control_ReplaceTag('fd_37689df08409d2')</script></xformflag>
			<xform:viewShow>
<ui:button text="订机票" name="ctripSSOButton" onclick="bookticketOfPc(this);" />
<script>
window.bookticketOfPc = function(obj){
var fdCompanyId = '${fsscFeeMainForm.getExtendDataFormInfo().getValue('fd_374252eae52b20')}';
var docNumber = '${fsscFeeMainForm.getExtendDataFormInfo().getValue('fd_38b46624eed31a')}';
var fdDetailNo = $(obj).parent().parent().find('td').eq(0).html();
if(!(fdDetailNo*1)){fdDetailNo='1'}
console.log(fdCompanyId+'@@'+docNumber+'@@'+fdDetailNo+'@@'+'fd_38b46624eed31a');
window.open('<c:url value="/fssc/ctrip/fssc_ctrip_app_message/fsscCtripAppMessage.do" />?method=bookPlaneTicketOfPc&fdCompanyId='+fdCompanyId+'&docNumber='+docNumber+'&fdDetailNo='+fdDetailNo);
}
</script>
</xform:viewShow></td></tr><tr><td width="0" class="td_normal_title" style="width: 188.5px;" column="0" row="3">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_3742529749a8ba' option='content'/></label>
</td><td width="0" style="width: auto;" colspan="5" column="1,2,3,4,5" row="3">
			<xformflag flagid='fd_3742531f2f9e92' id='_xform_extendDataFormInfo.value(fd_3742531f2f9e92)' property='extendDataFormInfo.value(fd_3742531f2f9e92)' flagtype='xform_relation_attachment' _xform_type='attachment'>
<c:import url="/sys/attachment/sys_att_main/sysAttMain_${empty _xformRight ? ((_xformMainForm.method_GET == 'add' || _xformMainForm.method_GET == 'edit') ? 'edit' : 'view') : (_xformRight == 'edit' ? 'edit' : 'view')}.jsp" charEncoding="UTF-8">
	<c:param name="fdAttType" value="byte" />
	<c:param name="fdMulti" value="true" />
	<c:param name="fdShowMsg" value="true" />
	<c:param name="fdModelId" value="${_xformMainForm.fdId}" />
	<c:param name="fdModelName" value="${_xformMainForm.modelClass.name}" />
	<c:param name="fdImgHtmlProperty" />

	<c:param name="isShowDownloadCount" value="true" />
	<c:param name="otherCanNotDelete" value="null" />
<c:param name="allCanNotDelete" value="null" />
<c:param name="fdLabel" value="附件" />
	<c:param name="fdGroup" value="xform" />
	<c:param name="fdGroupName" value="${lfn:message('sys-xform:xform.attachment.group')}"  />
	<c:param name="fdKey" value="fd_3742531f2f9e92" />
	<c:param name="formBeanName" value="_xformMainForm" />
<c:param name="fdRequired" value="false" />
</c:import>

</xformflag><xform:editShow>
<script>
	var ids = {
		fdStartDate	:	'fd_374254c3f61e8c',//开始日期
		fdEndDate		:	'fd_374254c2b4c6b4'//结束日期
	}
	var tb = 'fd_37425415d18482'//明细
	Com_AddEventListener(window,'load',function(){
		$("[name*='"+ids['fdStartDate']+"'],[name*='"+ids['fdEndDate']+"']").on("blur",validateDate);
		$("[id*="+tb+"]").find(".opt_add_style").parent().on("click",function(){
			$("[name*='"+ids['fdStartDate']+"'],[name*='"+ids['fdEndDate']+"']").on("blur",validateDate);
		})
	})
	function validateDate(){
		var e = window.event||arguments[0];
 		e = e.srcElement||e.target;
		if(!e.value){
			return;
		}
		var index = e.name.replace(/\S+\.(\d+)\.\S+/,'$1');
		var fdStartDate = $("[name*='."+index+"."+ids['fdStartDate']+"']").val();
		var fdEndDate = $("[name*='."+index+"."+ids['fdEndDate']+"']").val();
		if(!fdStartDate||!fdEndDate)return;
		fdStartDate = new Date(fdStartDate.replace(/\-/g,'/'));
		fdEndDate = new Date(fdEndDate.replace(/\-/g,'/'));
		if(fdEndDate.getTime()<fdStartDate.getTime()){
			e.value=  '';
			alert("开始日期不能大于结束日期")
		}
	}
</script>
</xform:editShow>
</td></tr><tr style="height: 31px;"><td width="0" class="td_normal_title" style="width: auto;" colspan="6" column="0,1,2,3,4,5" row="4">
<xform:editShow><script>$(function(){var tb=document.getElementById('TABLE_DL_fd_37425415d18482');tb.setAttribute('tbdraggable','true');});</script></xform:editShow>
<xform:viewShow><script>$(function(){var tb=document.getElementById('TABLE_DL_fd_37425415d18482');tb.setAttribute('tbdraggable','false');$(tb).css('margin-bottom','1px');});</script></xform:viewShow>
<script>Com_IncludeFile('doclist.js');</script><script>DocList_Info.push('TABLE_DL_fd_37425415d18482');</script>
<script>Com_IncludeFile('detailsTableFreeze.css', Com_Parameter.ContextPath + 'sys/xform/designer/resource/css/', 'css', true);</script>
<script>Com_IncludeFile('detailsTableFreeze.js', Com_Parameter.ContextPath + 'sys/xform/designer/resource/js/', 'js', true);</script>
<xform:editShow><c:choose><c:when test="${empty _xformForm.extendDataFormInfo.formData.fd_37425415d18482}"><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {for (var i = 0; i < 1; i ++) {DocList_AddRow(document.getElementById('TABLE_DL_fd_37425415d18482'))};tableFreezeStarter('TABLE_DL_fd_37425415d18482',false, -1, false, true, 'add');}, 500);});</script></c:when><c:otherwise><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {tableFreezeStarter('TABLE_DL_fd_37425415d18482',false, -1, false, true, 'edit');}, 500);});</script></c:otherwise></c:choose>
<script>function sys_xfrom_detailsTable_requiredInit_TABLE_DL_fd_37425415d18482(){DocList_Xform_DetailsTable_AddInputPosition('TABLE_DL_fd_37425415d18482','required');}Com_AddEventListener(window, 'load', sys_xfrom_detailsTable_requiredInit_TABLE_DL_fd_37425415d18482);</script>
</xform:editShow><xform:viewShow><script>Com_AddEventListener(window, 'load', function(){ setTimeout(function() {tableFreezeStarter('TABLE_DL_fd_37425415d18482',false, -1, false, true, 'view');}, 500);});</script>
</xform:viewShow>
<table width="100%" align="center" class="tb_normal" id="TABLE_DL_fd_37425415d18482" style="width: 100%;" required="true"  fd_type="detailsTable"  layout2col="mobile" tablename="fd_374252852c0bd2" label="明细表1" data-multihead="false" showindex="true" showrow="1" showstatisticrow="true" showcopyopt="true" excelexport="true" excelimport="true" aligment="default" dataentrymode="multipleRow" defaultfreezetitle="false" defaultfreezecol="-1">
<tr class="tr_normal_title" style="height: 33px;" type="titleRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'></td>
</xform:editShow><td align="center" class="td_normal_title" style="width: 25px; white-space: nowrap;" column="1" row="0" coltype="noTitle"><kmss:message key="page.serial" /></TD><td align="center" class="td_normal_title" valign="middle" style="width: 4%;" style_width="4%" column="2" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_3742545ef3d044' option='content'/></label>
</td><td align="center" class="td_normal_title" valign="middle" style="width: 7%;" style_width="7%" column="3" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374254608972de' option='content'/></label>
</td><td align="center" class="td_normal_title" valign="middle" style="width: 7%;" style_width="7%" column="4" row="0">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_37425461970b20' option='content'/></label>
</td><td align="center" valign="middle" style="width: 4%;" style_width="4%" column="5" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374254629309d0' option='content'/></label>
</td><td align="center" valign="middle" style="width: 4%;" style_width="4%" column="6" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374254638b8450' option='content'/></label>
</td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="7" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_374254649678a4' option='content'/></label>
</td><td align="center" valign="middle" style="width: 7%;" style_width="7%" column="8" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_37425465e3ac46' option='content'/></label>
</td><td align="center" column="9" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_3742546718a176' option='content'/></label>
</td><td align="center" valign="middle" style="width: 7%;" style_width="7%" column="10" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_375843db70f380' option='content'/></label>
</td><td align="center" valign="middle" style="width: 7%;" style_width="7%" column="11" row="0" data-ismultiheadcol="false" class="">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_3742546826171a' option='content'/></label>
</td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="12" row="0" data-ismultiheadcol="false" class="">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_3742549ab6b1b0' option='content'/></label>
</td><td align="center" valign="middle" style="width: 4%;" style_width="4%" column="13" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_37425469717364' option='content'/></label>
</td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="14" row="0" data-ismultiheadcol="false" class="">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_3742549c056b3a' option='content'/></label>
</td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="15" row="0" data-ismultiheadcol="false">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_374254a847dbda' option='content'/></label>
</td>
<xform:editShow><td align="center" class="td_normal_title" valign="middle" style="width:48px;" style_width="15" column="16" row="0" coltype="blankTitleCol"></TD>
</xform:editShow></tr>
<%-- 基准行 --%>
<tr KMSS_IsReferRow="1" style="display:none"  type="templateRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'><input type='checkbox' name='DocList_Selected' onclick='DocList_SelectRow(this);'/></td>
</xform:editShow><td align="center" style="width: 25px;" column="1" row="1" coltype="noTemplate" KMSS_IsRowIndex=1>{1}</TD><td align="center" column="2" row="1">
			<label class="xform_address" style="width: 89px; display: inline-block;"  fd_type="address" >
			<xformflag flagid='fd_37425415d18482.!{index}.fd_374254b781a860' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.id)' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.id)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_37425415d18482.!{index}.fd_374254b781a860','label')}" title="${xform:subject('fd_37425415d18482.!{index}.fd_374254b781a860','label')}" style="width: 80px;" required="true" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>

			<%-- 明细表行ID --%>
			<xform:text showStatus="noShow"  property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fdId)" />
</td><td align="center" valign="middle" style="width: 8%;" style_width="8%" column="3" row="1">
			<xformflag flagtype="costCenter" flagid='fd_37425415d18482.!{index}.fd_374254bae4f150' _xform_type='costCenter' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150_name)" required="true" style="width:100px"  subject="成本中心" title="成本中心" dialogJs="Designer_DialogSelect(false,'fssc_base_cost_center_selectCostCenter','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150_name)',null,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Cost_Center_List=window.Designer_Control_Cost_Center_List||[];
window.Designer_Control_Cost_Center_List.push('fd_37425415d18482.!{index}.fd_374254bae4f150')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Cost_Center_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_37425415d18482.!{index}.fd_374254bae4f150","fd_37425415d18482.!{index}.fd_374254bae4f150_name","getDefaultCostCenter",{fdCompanyId:"fd_374252eae52b20"})})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_374254bae4f150')</script></xformflag></td><td align="center" valign="middle" style="width: 8%;" style_width="8%" column="4" row="1" class="">
			<xformflag flagtype='expenseItem' flagid='fd_37425415d18482.!{index}.fd_374254bd820e1a' _xform_type='expenseItem' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a_name)" required="true" style="width:90px"  subject="费用类型" title="费用类型" dialogJs="Designer_DialogSelect(false,'fssc_base_expense_Item_selectExpenseItem','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a_name)',null,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Expense_Item_List=window.Designer_Control_Expense_Item_List||[];
window.Designer_Control_Expense_Item_List.push('fd_37425415d18482.!{index}.fd_374254bd820e1a')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Expense_Item_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_374254bd820e1a')</script></xformflag></td><td align="center" column="5" row="1">
			<label class="xform_datetime" style=" display: inline-block;"  fd_type="datetime" >
			<xformflag flagid='fd_37425415d18482.!{index}.fd_374254c3f61e8c' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c3f61e8c)' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c3f61e8c)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c3f61e8c)" style="width: 110px;" required="true" showScheduling="false" subject="${xform:subject('fd_37425415d18482.!{index}.fd_374254c3f61e8c','label')}" title="${xform:subject('fd_37425415d18482.!{index}.fd_374254c3f61e8c','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" column="6" row="1">
			<label class="xform_datetime" style=" display: inline-block;"  fd_type="datetime" >
			<xformflag flagid='fd_37425415d18482.!{index}.fd_374254c2b4c6b4' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c2b4c6b4)' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c2b4c6b4)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c2b4c6b4)" style="width: 110px;" required="true" showScheduling="false" subject="${xform:subject('fd_37425415d18482.!{index}.fd_374254c2b4c6b4','label')}" title="${xform:subject('fd_37425415d18482.!{index}.fd_374254c2b4c6b4','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" column="7" row="1">
<xformflag flagtype='dayCount' _xform_type='dayCount' flagid='fd_37425415d18482.!{index}.fd_374254c73c8c6c' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c73c8c6c)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c73c8c6c)'>
			<xform:text property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c73c8c6c)" required="true" showStatus="readOnly" style="width:40px" /><script>
if(!window.Designer_Control_DayCount_Props)window.Designer_Control_DayCount_Props=JSON.parse("{'width':'40px','id':'fd_374254c73c8c6c','subject':'天数','matchType':'2','matchTableId':'fd_37425415d18482','startDateId':'fd_37425415d18482.fd_374254c3f61e8c','endDateId':'fd_37425415d18482.fd_374254c2b4c6b4','isPlusOne':'1'}".replace(/'/g,'"'));
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td align="center" column="8" row="1">
			<xformflag flagtype="area" flagid='fd_37425415d18482.!{index}.fd_374254ce440280' _xform_type='area' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280_name)" required="true" style="width:60px"  subject="出发地" title="出发地" dialogJs="Designer_SelectArea('fd_374252eae52b20','fd_374254ce440280');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_37425415d18482.!{index}.fd_374254ce440280')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_374254ce440280')</script></xformflag></td><td align="center" column="9" row="1">
			<xformflag flagtype="area" flagid='fd_37425415d18482.!{index}.fd_374254cf7a094e' _xform_type='area' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e_name)" required="true" style="width:60px"  subject="到达地" title="到达地" dialogJs="Designer_SelectArea('fd_374252eae52b20','fd_374254cf7a094e');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_37425415d18482.!{index}.fd_374254cf7a094e')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_374254cf7a094e')</script></xformflag></td><td align="center" column="10" row="1">
			<xformflag flagtype='vehicle' flagid='fd_37425415d18482.!{index}.fd_375843e7870d7a' _xform_type='vehicle' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)'>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_berth_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_vehicle_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_vehicle_name)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_name)" required="true" style="width:60px"  subject="交通工具" title="交通工具" dialogJs="Designer_DialogSelect(false,'fssc_base_berth_fdParent','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_name)',function(rtn,id){Designer_Control_Vehicle_Berth_Changed(rtn,id,'fd_37425415d18482.!{index}.fd_375843e7870d7a_vehicle_id','fd_37425415d18482.!{index}.fd_375843e7870d7a_vehicle_name')},{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Vehicle_Berth_List=window.Designer_Control_Vehicle_Berth_List||[];
window.Designer_Control_Vehicle_Berth_List.push('fd_37425415d18482.!{index}.fd_375843e7870d7a')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Vehicle_Berth_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_375843e7870d7a')</script></xformflag></td><td align="center" column="11" row="1">
			<xformflag flagtype='currency' flagid='fd_37425415d18482.!{index}.fd_374254d1b75512' _xform_type='currency' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)'>
<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_cost_rate)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_budget_rate)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_name)" required="true" style="width:60px"  subject="币种/汇率" title="币种/汇率" dialogJs="Designer_DialogSelect(false,'fssc_base_currency_selectCurrency','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_name)',Designer_Control_Currency_Evnet_Changed,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Currency_List=window.Designer_Control_Currency_List||[];
window.Designer_Control_Currency_List.push('fd_37425415d18482.!{index}.fd_374254d1b75512')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Currency_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_37425415d18482.!{index}.fd_374254d1b75512","fd_37425415d18482.!{index}.fd_374254d1b75512_name","getDefaultCurrency",{fdCompanyId:"fd_374252eae52b20"},['_cost_rate','_budget_rate'])})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.!{index}.fd_374254d1b75512')</script></xformflag></td><td align="center" column="12" row="1">
			<div class="xform_inputText" style="width: 97px; display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;"  fd_type="inputText"  canshow="true"><xformflag flagid='fd_37425415d18482.!{index}.fd_374254d5c436d8' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d5c436d8)' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d5c436d8)' flagtype='xform_text' _xform_type='text'><xform:number pattern="##,###.##" format="money" showChinese="false" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d5c436d8)" style="width: 97px; display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;width:80px;" required="true" className="inputsgl xform_inputText" htmlElementProperties="thousandShow='false' dataType='number' "  subject="${xform:subject('fd_37425415d18482.!{index}.fd_374254d5c436d8','label')}" title="${xform:subject('fd_37425415d18482.!{index}.fd_374254d5c436d8','label')}" validators=" number number scaleLength(2)" onValueChange="__xformDispatch" />
</xformflag></div>
</td><td align="center" column="13" row="1">
<xformflag flagtype='accountMoney' _xform_type='accountMoney' flagid='fd_37425415d18482.!{index}.fd_374254d37fabb2' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d37fabb2)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d37fabb2)'>
			<xform:text property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d37fabb2)" required="true" showStatus="readOnly" style="width:80px" /><script>
if(!window.Designer_Control_AccountMoney_Props)window.Designer_Control_AccountMoney_Props=JSON.parse("{'width':'80px','id':'fd_374254d37fabb2','subject':'本位币金额','matchType':'2','matchTableId':'fd_37425415d18482','currencyId':'fd_37425415d18482.fd_374254d1b75512','moneyId':'fd_37425415d18482.fd_374254d5c436d8'}".replace(/'/g,'"'));
Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
<xformflag flagid='fd_37425415d18482.!{index}.fd_392241d6599c40' id='_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_392241d6599c40)' property='extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_392241d6599c40)' flagtype='xform_validator' _xform_type='validator'>
	
			<script>Com_IncludeFile('validatorControl_script.js','../sys/xform/designer/');</script>
<xform:viewShow><xform:viewValueTag fields="fd_37425415d18482.fd_374254d37fabb2" /></xform:viewShow><input type='hidden' validator='true' name='param' param='[{&quot;expressionId&quot;:&quot;$fd_37425415d18482.fd_374254d37fabb2$ &gt;= 1000&quot;,&quot;expressionName&quot;:&quot;$明细表1.本位币金额$ &gt;= 1000&quot;,&quot;message&quot;:&quot;本位币金额不允许大于1000&quot;,&quot;expressionShow&quot;:&quot;1&quot;}]' isRow = 'true'/>

</xformflag></td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="14" row="1" class="">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_377ae5c8711bc0_budget_status)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_377ae5c8711bc0_budget_info)"/><div id='budget_status_!{index}'></div><script>Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
if(!window.Designer_Control_Budget_Rule_Props)window.Designer_Control_Budget_Rule_Props=JSON.parse("{'id':'fd_377ae5c8711bc0','subject':'预算状态','fdListenToId':'fd_374252eae52b20;fd_37425415d18482.fd_374254b781a860;fd_37425415d18482.fd_374254bae4f150;fd_37425415d18482.fd_374254bd820e1a;fd_37425415d18482.fd_374254d1b75512;fd_37425415d18482.fd_374254d5c436d8','fdMatchType':'2','fdMatchTable':'fd_37425415d18482','fdCompanyId':'fd_374252eae52b20','fdCostCenterId':'fd_37425415d18482.fd_374254bae4f150','fdExpenseItemId':'fd_37425415d18482.fd_374254bd820e1a','fdProjectId':'fd_37689df08409d2','fdWbsId':'','fdInnerOrderId':'','fdCurrencyId':'fd_37425415d18482.fd_374254d1b75512','fdMoneyId':'fd_37425415d18482.fd_374254d5c436d8','fdPersonId':'fd_37425415d18482.fd_374254b781a860','fdDeptId':'fd_37425334cb401a','fdShowType':'2','fdShowMoney':'1;4'}".replace(/'/g,'"'))</script>
<link rel='stylesheet' href='${LUI_ContextPath}/fssc/fee/fssc_fee_xform/css/budgetRule.css'/></td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="15" row="1" class="">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_38b84dcc41608c_standard_status)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_38b84dcc41608c_standard_info)"/><div id='standard_status_!{index}' class='budget_container'></div><script>Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
if(!window.Designer_Control_Standard_Rule_Props)window.Designer_Control_Standard_Rule_Props=JSON.parse("{'id':'fd_38b84dcc41608c','subject':'标准状态','fdListenToId':'fd_374252eae52b20;fd_37425415d18482.fd_374254b781a860;fd_37425415d18482.fd_374254bd820e1a;fd_37425415d18482.fd_374254c73c8c6c;fd_37425415d18482.fd_374254cf7a094e;fd_37425415d18482.fd_375843e7870d7a;fd_37425415d18482.fd_374254d1b75512;fd_37425415d18482.fd_374254d5c436d8','fdMatchType':'2','fdMatchTable':'fd_37425415d18482','fdCompanyId':'fd_374252eae52b20','fdExpenseItemId':'fd_37425415d18482.fd_374254bd820e1a','fdPersonId':'fd_37425415d18482.fd_374254b781a860','fdAreaId':'fd_37425415d18482.fd_374254cf7a094e','fdVehicleId':'fd_37425415d18482.fd_375843e7870d7a','fdSpecialId':'','fdTravelDays':'fd_37425415d18482.fd_374254c73c8c6c','fdMoneyId':'fd_37425415d18482.fd_374254d5c436d8','fdCurrencyId':'fd_37425415d18482.fd_374254d1b75512','fdPersonNumberId':''}".replace(/'/g,'"'))</script>
<link rel='stylesheet' href='${LUI_ContextPath}/fssc/fee/fssc_fee_xform/css/budgetRule.css'/></td>
<xform:editShow>
<td align="center" valign="middle" style="width: 8px;" style_width="8" column="16" row="1" coltype="copyCol"><nobr><span style='cursor:pointer' class='optStyle opt_copy_style'  title='<bean:message bundle="sys-xform" key="xform.button.copy" />' onmousedown='DocList_CopyRow();'></span>&nbsp;&nbsp;<span style='cursor:pointer' class='optStyle opt_del_style' title='<bean:message bundle="sys-xform" key="xform.button.delete" />' onmousedown='DocList_DeleteRow_ClearLast();XFom_RestValidationElements();'></span>&nbsp;&nbsp;</nobr></TD>
</xform:editShow>
</tr>
<%-- 内容行 --%>
<c:forEach items="${_xformForm.extendDataFormInfo.formData.fd_37425415d18482}" var="_xformEachBean" varStatus="vstatus">
<tr KMSS_IsContentRow="1"  type="templateRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'><input type='checkbox' name='DocList_Selected' onclick='DocList_SelectRow(this);'/></td>
</xform:editShow><td align="center" style="width: 25px;" column="1" row="1" coltype="noTemplate" KMSS_IsRowIndex=1>${vstatus.index + 1}</TD><td align="center" column="2" row="1">
			<label class="xform_address" style="width: 89px; display: inline-block;"  fd_type="address" >
			<xformflag flagid='fd_37425415d18482.${vstatus.index}.fd_374254b781a860' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.id)' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.id)' flagtype='xform_address' _xform_type='address'><xform:address propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.id)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254b781a860','label')}" title="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254b781a860','label')}" style="width: 80px;" required="true" onValueChange="function(value, domElement){__xformDispatch.call(this,value,domElement);$(document).trigger($.Event('relation_event_setvalue'),Address_GetIdByInputField(this));}" isLoadDataDict="false" />
</xformflag></label>

			<%-- 明细表行ID --%>
			<xform:text showStatus="noShow"  property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fdId)" />
</td><td align="center" valign="middle" style="width: 8%;" style_width="8%" column="3" row="1">
			<xformflag flagtype="costCenter" flagid='fd_37425415d18482.${vstatus.index}.fd_374254bae4f150' _xform_type='costCenter' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150_name)" required="true" style="width:100px"  subject="成本中心" title="成本中心" dialogJs="Designer_DialogSelect(false,'fssc_base_cost_center_selectCostCenter','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150_name)',null,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Cost_Center_List=window.Designer_Control_Cost_Center_List||[];
window.Designer_Control_Cost_Center_List.push('fd_37425415d18482.${vstatus.index}.fd_374254bae4f150')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Cost_Center_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_37425415d18482.${vstatus.index}.fd_374254bae4f150","fd_37425415d18482.${vstatus.index}.fd_374254bae4f150_name","getDefaultCostCenter",{fdCompanyId:"fd_374252eae52b20"})})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_374254bae4f150')</script></xformflag></td><td align="center" valign="middle" style="width: 8%;" style_width="8%" column="4" row="1" class="">
			<xformflag flagtype='expenseItem' flagid='fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a' _xform_type='expenseItem' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a_name)" required="true" style="width:90px"  subject="费用类型" title="费用类型" dialogJs="Designer_DialogSelect(false,'fssc_base_expense_Item_selectExpenseItem','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a_name)',null,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Expense_Item_List=window.Designer_Control_Expense_Item_List||[];
window.Designer_Control_Expense_Item_List.push('fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Expense_Item_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a')</script></xformflag></td><td align="center" column="5" row="1">
			<label class="xform_datetime" style=" display: inline-block;"  fd_type="datetime" >
			<xformflag flagid='fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c)' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c)" style="width: 110px;" required="true" showScheduling="false" subject="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c','label')}" title="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" column="6" row="1">
			<label class="xform_datetime" style=" display: inline-block;"  fd_type="datetime" >
			<xformflag flagid='fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4)' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4)' flagtype='xform_datetime' _xform_type='datetime'><xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4)" style="width: 110px;" required="true" showScheduling="false" subject="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4','label')}" title="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4','label')}" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false" />
</xformflag></label>
</td><td align="center" column="7" row="1">
<xformflag flagtype='dayCount' _xform_type='dayCount' flagid='fd_37425415d18482.${vstatus.index}.fd_374254c73c8c6c' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c73c8c6c)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c73c8c6c)'>
			<xform:text property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c73c8c6c)" required="true" showStatus="readOnly" style="width:40px" /><script>
if(!window.Designer_Control_DayCount_Props)window.Designer_Control_DayCount_Props=JSON.parse("{'width':'40px','id':'fd_374254c73c8c6c','subject':'天数','matchType':'2','matchTableId':'fd_37425415d18482','startDateId':'fd_37425415d18482.fd_374254c3f61e8c','endDateId':'fd_37425415d18482.fd_374254c2b4c6b4','isPlusOne':'1'}".replace(/'/g,'"'));
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
</td><td align="center" column="8" row="1">
			<xformflag flagtype="area" flagid='fd_37425415d18482.${vstatus.index}.fd_374254ce440280' _xform_type='area' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280_name)" required="true" style="width:60px"  subject="出发地" title="出发地" dialogJs="Designer_SelectArea('fd_374252eae52b20','fd_374254ce440280');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_37425415d18482.${vstatus.index}.fd_374254ce440280')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_374254ce440280')</script></xformflag></td><td align="center" column="9" row="1">
			<xformflag flagtype="area" flagid='fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e' _xform_type='area' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e)'>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e_name)" required="true" style="width:60px"  subject="到达地" title="到达地" dialogJs="Designer_SelectArea('fd_374252eae52b20','fd_374254cf7a094e');">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_AreaCategory_List=window.Designer_Control_AreaCategory_List||[];
window.Designer_Control_AreaCategory_List.push('fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_AreaCategory_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e')</script></xformflag></td><td align="center" column="10" row="1">
			<xformflag flagtype='vehicle' flagid='fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a' _xform_type='vehicle' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)'>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_berth_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_vehicle_id)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_vehicle_name)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_name)" required="true" style="width:60px"  subject="交通工具" title="交通工具" dialogJs="Designer_DialogSelect(false,'fssc_base_berth_fdParent','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_name)',function(rtn,id){Designer_Control_Vehicle_Berth_Changed(rtn,id,'fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_vehicle_id','fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_vehicle_name')},{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Vehicle_Berth_List=window.Designer_Control_Vehicle_Berth_List||[];
window.Designer_Control_Vehicle_Berth_List.push('fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Vehicle_Berth_Load);
</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a')</script></xformflag></td><td align="center" column="11" row="1">
			<xformflag flagtype='currency' flagid='fd_37425415d18482.${vstatus.index}.fd_374254d1b75512' _xform_type='currency' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)'>
<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_cost_rate)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_budget_rate)"/>
			<xform:dialog propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_name)" required="true" style="width:60px"  subject="币种/汇率" title="币种/汇率" dialogJs="Designer_DialogSelect(false,'fssc_base_currency_selectCurrency','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_name)',Designer_Control_Currency_Evnet_Changed,{fdCompanyId:'fd_374252eae52b20'});">
						
			</xform:dialog>
<script>Com_IncludeFile("dialog.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
window.Designer_Control_Currency_List=window.Designer_Control_Currency_List||[];
window.Designer_Control_Currency_List.push('fd_37425415d18482.${vstatus.index}.fd_374254d1b75512')
window.Designer_Control_Company_Event_List['fd_374252eae52b20'].push(Designer_Control_Currency_Load);
</script><script>Com_AddEventListener(window,'load',function(){setDefaultValue("fd_37425415d18482.${vstatus.index}.fd_374254d1b75512","fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_name","getDefaultCurrency",{fdCompanyId:"fd_374252eae52b20"},['_cost_rate','_budget_rate'])})</script><script>Com_IncludeFile("defaultValue.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script><script>Designer_Control_ReplaceTag('fd_37425415d18482.${vstatus.index}.fd_374254d1b75512')</script></xformflag></td><td align="center" column="12" row="1">
			<div class="xform_inputText" style="width: 97px; display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;"  fd_type="inputText"  canshow="true"><xformflag flagid='fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8)' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8)' flagtype='xform_text' _xform_type='text'><xform:number pattern="##,###.##" format="money" showChinese="false" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8)" style="width: 97px; display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;width:80px;" required="true" className="inputsgl xform_inputText" htmlElementProperties="thousandShow='false' dataType='number' "  subject="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8','label')}" title="${xform:subject('fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8','label')}" validators=" number number scaleLength(2)" onValueChange="__xformDispatch" />
</xformflag></div>
</td><td align="center" column="13" row="1">
<xformflag flagtype='accountMoney' _xform_type='accountMoney' flagid='fd_37425415d18482.${vstatus.index}.fd_374254d37fabb2' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d37fabb2)' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d37fabb2)'>
			<xform:text property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d37fabb2)" required="true" showStatus="readOnly" style="width:80px" /><script>
if(!window.Designer_Control_AccountMoney_Props)window.Designer_Control_AccountMoney_Props=JSON.parse("{'width':'80px','id':'fd_374254d37fabb2','subject':'本位币金额','matchType':'2','matchTableId':'fd_37425415d18482','currencyId':'fd_37425415d18482.fd_374254d1b75512','moneyId':'fd_37425415d18482.fd_374254d5c436d8'}".replace(/'/g,'"'));
Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);
Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);
</script></xformflag>
<xformflag flagid='fd_37425415d18482.${vstatus.index}.fd_392241d6599c40' id='_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_392241d6599c40)' property='extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_392241d6599c40)' flagtype='xform_validator' _xform_type='validator'>
	
			<script>Com_IncludeFile('validatorControl_script.js','../sys/xform/designer/');</script>
<xform:viewShow><xform:viewValueTag fields="fd_37425415d18482.fd_374254d37fabb2" /></xform:viewShow><input type='hidden' validator='true' name='param' param='[{&quot;expressionId&quot;:&quot;$fd_37425415d18482.fd_374254d37fabb2$ &gt;= 1000&quot;,&quot;expressionName&quot;:&quot;$明细表1.本位币金额$ &gt;= 1000&quot;,&quot;message&quot;:&quot;本位币金额不允许大于1000&quot;,&quot;expressionShow&quot;:&quot;1&quot;}]' isRow = 'true'/>

</xformflag></td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="14" row="1" class="">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_377ae5c8711bc0_budget_status)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_377ae5c8711bc0_budget_info)"/><div id='budget_status_${vstatus.index}'></div><script>Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
if(!window.Designer_Control_Budget_Rule_Props)window.Designer_Control_Budget_Rule_Props=JSON.parse("{'id':'fd_377ae5c8711bc0','subject':'预算状态','fdListenToId':'fd_374252eae52b20;fd_37425415d18482.fd_374254b781a860;fd_37425415d18482.fd_374254bae4f150;fd_37425415d18482.fd_374254bd820e1a;fd_37425415d18482.fd_374254d1b75512;fd_37425415d18482.fd_374254d5c436d8','fdMatchType':'2','fdMatchTable':'fd_37425415d18482','fdCompanyId':'fd_374252eae52b20','fdCostCenterId':'fd_37425415d18482.fd_374254bae4f150','fdExpenseItemId':'fd_37425415d18482.fd_374254bd820e1a','fdProjectId':'fd_37689df08409d2','fdWbsId':'','fdInnerOrderId':'','fdCurrencyId':'fd_37425415d18482.fd_374254d1b75512','fdMoneyId':'fd_37425415d18482.fd_374254d5c436d8','fdPersonId':'fd_37425415d18482.fd_374254b781a860','fdDeptId':'fd_37425334cb401a','fdShowType':'2','fdShowMoney':'1;4'}".replace(/'/g,'"'))</script>
<link rel='stylesheet' href='${LUI_ContextPath}/fssc/fee/fssc_fee_xform/css/budgetRule.css'/></td><td align="center" valign="middle" style="width: 5%;" style_width="5%" column="15" row="1" class="">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_38b84dcc41608c_standard_status)"/>
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_38b84dcc41608c_standard_info)"/><div id='standard_status_${vstatus.index}' class='budget_container'></div><script>Com_IncludeFile("Number.js", "${LUI_ContextPath}/fssc/common/resource/js/", 'js', true);</script><script>Com_IncludeFile("event.js",Com_Parameter.ContextPath+"fssc/fee/fssc_fee_xform/extendJs/","js",true);</script>
<script>
if(!window.Designer_Control_Standard_Rule_Props)window.Designer_Control_Standard_Rule_Props=JSON.parse("{'id':'fd_38b84dcc41608c','subject':'标准状态','fdListenToId':'fd_374252eae52b20;fd_37425415d18482.fd_374254b781a860;fd_37425415d18482.fd_374254bd820e1a;fd_37425415d18482.fd_374254c73c8c6c;fd_37425415d18482.fd_374254cf7a094e;fd_37425415d18482.fd_375843e7870d7a;fd_37425415d18482.fd_374254d1b75512;fd_37425415d18482.fd_374254d5c436d8','fdMatchType':'2','fdMatchTable':'fd_37425415d18482','fdCompanyId':'fd_374252eae52b20','fdExpenseItemId':'fd_37425415d18482.fd_374254bd820e1a','fdPersonId':'fd_37425415d18482.fd_374254b781a860','fdAreaId':'fd_37425415d18482.fd_374254cf7a094e','fdVehicleId':'fd_37425415d18482.fd_375843e7870d7a','fdSpecialId':'','fdTravelDays':'fd_37425415d18482.fd_374254c73c8c6c','fdMoneyId':'fd_37425415d18482.fd_374254d5c436d8','fdCurrencyId':'fd_37425415d18482.fd_374254d1b75512','fdPersonNumberId':''}".replace(/'/g,'"'))</script>
<link rel='stylesheet' href='${LUI_ContextPath}/fssc/fee/fssc_fee_xform/css/budgetRule.css'/></td>
<xform:editShow>
<td align="center" valign="middle" style="width: 8px;" style_width="8" column="16" row="1" coltype="copyCol"><nobr><span style='cursor:pointer' class='optStyle opt_copy_style'  title='<bean:message bundle="sys-xform" key="xform.button.copy" />' onmousedown='DocList_CopyRow();'></span>&nbsp;&nbsp;<span style='cursor:pointer' class='optStyle opt_del_style' title='<bean:message bundle="sys-xform" key="xform.button.delete" />' onmousedown='DocList_DeleteRow_ClearLast();XFom_RestValidationElements();'></span>&nbsp;&nbsp;</nobr></TD>
</xform:editShow>
</tr>
</c:forEach>
<tr type="statisticRow">
<xform:editShow><td row='1' column='0' align='center' coltype='selectCol' style='width: 15px;'></td>
</xform:editShow><td align="center" style="width: 25px;" column="1" row="2" coltype="noFoot">&nbsp;</TD><td align="center" column="2" row="2">&nbsp;</td><td align="center" column="3" row="2">&nbsp;</td><td align="center" column="4" row="2">&nbsp;</td><td align="center" column="5" row="2">&nbsp;</td><td align="center" column="6" row="2">&nbsp;</td><td align="center" column="7" row="2">&nbsp;</td><td align="center" column="8" row="2">&nbsp;</td><td align="center" column="9" row="2">&nbsp;</td><td align="center" column="10" row="2">&nbsp;</td><td align="center" column="11" row="2">&nbsp;</td><td align="center" column="12" row="2" class="" style="">&nbsp;</td><td align="center" column="13" row="2">&nbsp;</td><td align="center" column="14" row="2">&nbsp;</td><td align="center" column="15" row="2">&nbsp;</td>
<xform:editShow><td align="center" style="width: 48px;" column="16" row="2" coltype="emptyCell">&nbsp;</TD>
</xform:editShow></tr>
<tr class="tr_normal_opt" type="optRow">
<xform:editShow>
<td align="center" colspan="17" column="0" row="3" coltype="optCol" class=""><div class="tr_normal_opt_content" style="min-width:580px;;" >
<div class="tr_normal_opt_l"  ><label class="opt_ck_style" style="position:relative;top:3px;"><input type="checkbox" name='DocList_SelectAll' onclick='DocList_SelectAllRow(this);'/><span style="margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.selectAll" /><span></label><span style="margin-left:15px;" onclick='DocList_BatchDeleteRow();XFom_RestValidationElements();'><span class="optStyle opt_batchDel_style" style="margin-left:0px; "  title='<bean:message bundle="sys-xform" key="xform.button.delete" />'></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;" ><bean:message bundle="sys-xform" key="xform.button.delete" /></span></span></div>
<div class="tr_normal_opt_c"  ><span onclick='DocList_AddRow();XFom_RestValidationElements();'><span class="optStyle opt_add_style"  title='<bean:message bundle="sys-xform" key="xform.button.add" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.add" /></span></span><span style="margin-left:15px;" onclick='DocList_MoveRowBySelect(-1);'><span class="optStyle opt_up_style" title='<bean:message bundle="sys-xform" key="xform.button.moveup" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.moveup" /></span></span><span style="margin-left:15px;" onclick='DocList_MoveRowBySelect(1);'><span class="optStyle opt_down_style" title='<bean:message bundle="sys-xform" key="xform.button.movedown" />' ></span><span style="position:relative;top:3px;cursor: pointer;margin-left: 6px;"><bean:message bundle="sys-xform" key="xform.button.movedown" /></span></span></div>
<div class="tr_normal_opt_r"  ><span class="optStyle" style="margin-left:0px;" onclick='DocList_exportExcelInEdit("TABLE_DL_fd_37425415d18482","fd_37425415d18482","${param.formFilePath}","true");'><span class="optStyle opt_export_style"></span><span style='cursor: pointer;position:relative;top:4px;'><bean:message bundle="sys-xform" key="xform.button.dataExport" /></span></span><span class="optStyle" style="margin-left:15px;" onclick='DocList_importExcel("TABLE_DL_fd_37425415d18482","fd_37425415d18482","${param.formFilePath}","true");'><span class="optStyle opt_import_style"></span><span style='cursor: pointer;position:relative;top:4px;'><bean:message bundle="sys-xform" key="xform.button.dataImport" /></span></span>
</div></div></div></TD>
</xform:editShow>

<xform:viewShow>
<td row='3' column='0' align='center' coltype='optCol'><div class="tr_normal_opt_content" style="min-width:580px;;" ><div class="tr_normal_opt_r" ><span class="optStyle" onclick='DocList_exportExcel("${param.fdId}","fd_37425415d18482","${param.mainModelName}","true");'><span class="optStyle opt_export_style"></span><span style='cursor: pointer;'><bean:message bundle="sys-xform" key="xform.button.dataExport" /></span></span></div></div></td>
</xform:viewShow>
</tr>
			</table>
</td></tr><tr><td width="0" class="td_normal_title" style="width: 188.5px;" column="0" row="5">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false"><xform:lang id='fd_3742571323b8dc' option='content'/></label>
</td><td width="0" style="width: auto;" colspan="2" column="1,2" row="5">
	<%if ("readOnly".equals(request.getAttribute("SysForm.base.showStatus"))) {%>
			<script>Com_IncludeFile('calculation_script.js','../sys/xform/designer/calculation/');</script>
	<%}%>

			<xformflag flagid='fd_374257254b2f80' id='_xform_extendDataFormInfo.value(fd_374257254b2f80)' property='extendDataFormInfo.value(fd_374257254b2f80)' flagtype='xform_calculate' _xform_type='text'><div class = 'xform_Calculation xform_calculation_readonly' style='display:inline-block;'><xform:number format="money" showChinese="false" pattern="##,###.##" property="extendDataFormInfo.value(fd_374257254b2f80)" style="display: inline-block; width: 200px;" className="inputsgl xform_Calculation" subject="申请总金额" title="申请总金额" htmlElementProperties=" calculation='true' readonly  isRow='false' expression='$XForm_CalculatioFuns_Sum$($fd_37425415d18482.fd_374254d5c436d8$)' autoCalculate='true' thousandShow='true' paramDefault='false' scale='2'" />
</div>
</xformflag><xform:editShow>
<script>
AttachXFormValueChangeEventById("fd_37425332ffd2f2",function(){
	var pid = "fd_37425332ffd2f2"//申请人控件ID
	var fdPersonId = GetXFormFieldValueById(pid+".id")[0];
	var data = new KMSSData();
	data.AddBeanData("fsscFeeDataService&type=changePerson&fdPersonId="+fdPersonId);
	data = data.GetHashMapArray();
	if(data&&data.length>0){
		var dd = 'fd_37425334cb401a'//申请人部门控件ID
		emptyNewAddress("extendDataFormInfo.value("+dd+".name)",null,null,false);
		$('[name="extendDataFormInfo.value('+dd+'.id)"]').val(data[0].fdParentId);
		$('[name="extendDataFormInfo.value('+dd+'.name)"]').val(data[0].fdParentName);
		var addressInput = $("[xform-name='mf_extendDataFormInfo.value("+dd+".name)']")[0];
		var addressValues = new Array();
		addressValues.push({id:data[0].fdParentId,name:data[0].fdParentName});
		newAddressAdd(addressInput,addressValues);
		
		$("[name='extendDataFormInfo.value(fd_374252eae52b20)']").val("fd_3737eca6031f94.id",data[0].fdCompanyId)
		$("[name='extendDataFormInfo.value(fd_374252eae52b20_name)']").val(data[0].fdCompanyName)
		
		var tb = "fd_37425415d18482"//明细表控件ID
		var pr = 'ffd_374254b781a860';//出差人控件ID
		var cost = 'fd_374254bae4f150'//成本中心控件ID
		var fdPersonName = GetXFormFieldValueById(pid+".name")[0];
		try{
			$("[id*="+tb+"] tr:gt(0)").each(function(i){
				var id = tb+"."+i+"."+pr;
				var cd = tb+"."+i+"."+cost;
				
				emptyNewAddress("extendDataFormInfo.value("+id+".name)",null,null,false);
				$('[name="extendDataFormInfo.value('+id+'.id)"]').val(fdPersonId);
				$('[name="extendDataFormInfo.value('+id+'.name)"]').val(fdPersonName);
				var addressInput = $("[xform-name='mf_extendDataFormInfo.value("+id+".name)']")[0];
				var addressValues = new Array();
				addressValues.push({id:fdPersonId,name:fdPersonName});
				newAddressAdd(addressInput,addressValues);

				$("[name='extendDataFormInfo.value("+cd+")']").val("fd_3737eca6031f94.id",data[0].fdCostCenterId)
				$("[name='extendDataFormInfo.value("+cd+"_name)']").val(data[0].fdCostCenterName)
			});
		}catch(e){
			console.log(e)
		}
	}
})
</script>
</xform:editShow>
			
</td><td width="0" style="width: auto; text-align: left; vertical-align: middle;" column="3" row="5" class="td_normal_title" style_textalign="left" style_verticalalign="middle" style_borderleftwidth="null" style_borderrightwidth="null" style_bordertopwidth="null" style_borderbottomwidth="null" style_width="auto">
			<label class="xform_label" style="width: auto; color: rgb(0, 0, 0); display: inline-block; -ms-word-break: break-all; -ms-word-wrap: break-word;;word-break:break-all;;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal"><xform:lang id='fd_3779ec8ad9881a' option='content'/></label>
</td><td width="0" style="width: auto;" colspan="2" column="4,5" row="5" class="">
			<div class="xform_chinaValue" id="fd_3779ec91775752" style="width: 450px; display: inline-block;"  fd_type="chinaValue"  canshow="true" tablename="fd_374252852c0bd2" label="总金额大写" relatedid="fd_374257254b2f80" chinavalue_mode="notRow">
			<xformflag flagid='fd_3779ec91775752' id='_xform_extendDataFormInfo.value(fd_3779ec91775752)' property='extendDataFormInfo.value(fd_3779ec91775752)' flagtype='xform_chinavalue' _xform_type='chinavalue'>
<script>Com_IncludeFile('chinaValue_script.js','../sys/xform/designer/chinaValue/');</script>
<xform:xtext editReadOnlyStyle="inputread_normal xform_chinaValue" className="inputread_normal xform_chinaValue" dataType="String" htmlElementProperties=" relatedid='fd_374257254b2f80' chinavalue='true' isrow='false' " showStatus='readOnly'  property="extendDataFormInfo.value(fd_3779ec91775752)" style="width: 450px; display: inline-block;" subject="总金额大写" title="总金额大写" onValueChange="__xformDispatch" />
</xformflag>
			</div></td></tr></tbody></table>