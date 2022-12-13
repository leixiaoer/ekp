<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.xform.TagUtils" %>
<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_38fee9e490ef16' option='content'/></label>

				</td>
				<td >
				
				<xform:dialog subject="公司" title="公司" propertyId="extendDataFormInfo.value(fd_3906f3ec0308fa)" propertyName="extendDataFormInfo.value(fd_3906f3ec0308fa_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f3ec0308fa)','extendDataFormInfo.value(fd_3906f3ec0308fa_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label  class="xform_label" line="normal"  fd_type="textLabel" style="   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_38ff06d03836cc' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_38ff07a608d292)" _xform_type="inputText">
				<xform:xtext property="extendDataFormInfo.value(fd_38ff07a608d292)" required="false" htmlElementProperties="dataReadOnly='true'" mobile="true" subject="${xform:subject('fd_38ff07a608d292','label')}" title="${xform:subject('fd_38ff07a608d292','label')}" onValueChange="__xformDispatch" /></xformflag>
				</td>
	</tr>
	<tr>
				<td colspan="2" >
					<div class="detailTableContent">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="TABLE_DL_fd_3906f1680fb968" >
		<tr style="display:none;">
			<td></td>
		</tr>
			<tr data-dojo-type="mui/form/Template" 
				KMSS_IsReferRow="1"
				style="display:none;" 
				border='0'>
		<td class="detail_wrap_td">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fdId)" />
			<table class="muiSimple muiDetailTable">
				<tr celltr-title="true" onclick="detail_fd_3906f1680fb968_expandRow(this);">
					<td colspan="2" align="left" valign="middle" class="muiDetailTableNo" tableName="<xform:lang id='fd_3906f1680fb968' option='label'/>">
						<div class="muiDetailDisplayOpt muiDetailTableTitleIcon fontmuis muis-put-away"></div>
						<span class="muiDetailTableTitle">
							<xform:lang id='fd_3906f1680fb968' option='label'/>!{index}
						</span>
						<xform:editShow>
							<div class="muiDetailTableDel" onclick="detail_fd_3906f1680fb968_del(this);">
								<bean:message key="button.delete" />
							</div>
						</xform:editShow>
					</td>
				</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_39078b3babe7ac' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.id)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_org.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_org','label')}" title="${xform:subject('fd_org','label')}" required="false" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b76422434e0' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b765296f29a)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b765296f29a)" required="false" subject="${xform:subject('fd_390b765296f29a','label')}" title="${xform:subject('fd_390b765296f29a','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b7648112afe' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b7653c9d72c)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b7653c9d72c)" required="false" subject="${xform:subject('fd_390b7653c9d72c','label')}" title="${xform:subject('fd_390b7653c9d72c','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b764d1555ba' option='content'/></label>

						</td>
						<td>
								
				<xform:text subject="天数" title="天数" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b76567a4b2c)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390a14e1b43f42' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="币种汇率" title="币种汇率" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f926cc92_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390a14ec9978aa' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f2422e26)" _xform_type="inputText">
				<xform:xtext property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390a14f2422e26)" required="false" htmlElementProperties="thousandShow='false' datatype='number' " dataType="Double" mobile="true" subject="${xform:subject('fd_390a14f2422e26','label')}" title="${xform:subject('fd_390a14f2422e26','label')}" validators=" number scaleLength(0)" onValueChange="__xformDispatch" /></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b76216e0888' option='content'/></label>

						</td>
						<td>
								
				<xform:text subject="本币金额" title="本币金额" property="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_390b762ba0e642)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f1699536a2' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="交通工具" title="交通工具" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078328c72fa4_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_390783464350e4' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="地域" title="地域" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_39078349193118_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f16ad7ccd0' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="成本中心" title="成本中心" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3906f3f3ec8212_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f16be8a65a' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="城市" title="城市" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808)','extendDataFormInfo.value(fd_3906f1680fb968.!{index}.fd_3907c3973e0808_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
			</table>
		</td>
			</tr>
		<c:forEach 
			items="${_xformForm.extendDataFormInfo.formData.fd_3906f1680fb968}" 
			var="_xformEachBean" 
			varStatus="vstatus">
		<tr KMSS_IsContentRow="1">
		<td class="detail_wrap_td">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fdId)" />
			<table class="muiSimple muiDetailTable">
				<tr celltr-title="true" onclick="detail_fd_3906f1680fb968_expandRow(this);">
					<td colspan="2" align="left" valign="middle" class="muiDetailTableNo" tableName="<xform:lang id='fd_3906f1680fb968' option='label'/>">
						<div class="muiDetailDisplayOpt muiDetailTableTitleIcon fontmuis muis-put-away"></div>
						<span class="muiDetailTableTitle">
							<xform:lang id='fd_3906f1680fb968' option='label'/>${vstatus.index + 1}
						</span>
						<xform:editShow>
							<div class="muiDetailTableDel" onclick="detail_fd_3906f1680fb968_del(this);">
								<bean:message key="button.delete" />
							</div>
						</xform:editShow>
					</td>
				</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_39078b3babe7ac' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.id)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_org.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_org','label')}" title="${xform:subject('fd_org','label')}" required="false" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b76422434e0' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b765296f29a)" required="false" subject="${xform:subject('fd_390b765296f29a','label')}" title="${xform:subject('fd_390b765296f29a','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b7648112afe' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b7653c9d72c)" required="false" subject="${xform:subject('fd_390b7653c9d72c','label')}" title="${xform:subject('fd_390b7653c9d72c','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b764d1555ba' option='content'/></label>

						</td>
						<td>
								
				<xform:text subject="天数" title="天数" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b76567a4b2c)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390a14e1b43f42' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="币种汇率" title="币种汇率" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f926cc92_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390a14ec9978aa' option='content'/></label>

						</td>
						<td>
								<xformflag id="_xform_extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26)" _xform_type="inputText">
				<xform:xtext property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390a14f2422e26)" required="false" htmlElementProperties="thousandShow='false' datatype='number' " dataType="Double" mobile="true" subject="${xform:subject('fd_390a14f2422e26','label')}" title="${xform:subject('fd_390a14f2422e26','label')}" validators=" number scaleLength(0)" onValueChange="__xformDispatch" /></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal"  fd_type="textLabel" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;">
<xform:lang id='fd_390b76216e0888' option='content'/></label>

						</td>
						<td>
								
				<xform:text subject="本币金额" title="本币金额" property="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_390b762ba0e642)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f1699536a2' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="交通工具" title="交通工具" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078328c72fa4_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_390783464350e4' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="地域" title="地域" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_39078349193118_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f16ad7ccd0' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="成本中心" title="成本中心" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3906f3f3ec8212_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label  class="xform_label" ishiddeninmobile="false" line="normal" style=" color: rgb(0, 0, 0);   overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel">
<xform:lang id='fd_3906f16be8a65a' option='content'/></label>

						</td>
						<td>
								
				<xform:dialog subject="城市" title="城市" propertyId="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808)" propertyName="extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808)','extendDataFormInfo.value(fd_3906f1680fb968.${vstatus.index}.fd_3907c3973e0808_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
			</table>
		</td>
		</tr>
		</c:forEach>

			<tr>
				<td>
					<table class="muiSimple">
						<tr statistic-celltr-title="true" onclick="detail_fd_3906f1680fb968_expandRow(this);">
							<td colspan="2" align="left" valign="middle" class="muiDetailTableStatTitle">
								<div class="muiDetailDisplayOpt muiDetailTableTitleIcon fontmuis muis-put-away"></div>
								<span class="muiDetailTableTitle">
									<bean:message bundle='sys-xform-base' key='sysform.detailsTable.statisticalLine'/>
								</span>
							</td>
						</tr>
					</table>
				</td>
			</tr>
	</table>
</div>
<xform:editShow>
	<div 
		data-dojo-type="sys/xform/mobile/controls/DetailTableAddButton" _hideIcon="true"
		onclick="window.detail_fd_3906f1680fb968_add(event)">
		<bean:message bundle='sys-xform-base' key='sysform.detailsTable.addDetail'/><xform:lang id='fd_3906f1680fb968' option='label'/>
	</div>
	<script type="text/javascript">window["_editShow_fd_3906f1680fb968"] = true</script>
	<c:if test="${empty _xformForm.extendDataFormInfo.formData.fd_3906f1680fb968 }">
		<script type="text/javascript">window["_emptyFormData_fd_3906f1680fb968"] = true</script>
	</c:if>
</xform:editShow>
<script type="text/javascript">DocList_Info.push('TABLE_DL_fd_3906f1680fb968');</script>
<script type="text/javascript">
require(["sys/xform/mobile/controls/detailsTable/mobileDetailsTableScript"], function(){
window._mobileDetailsTableScript.init('fd_3906f1680fb968','TABLE_DL_fd_3906f1680fb968','1','false');
})
</script>

				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				&nbsp;
				</td>
				<td >
				&nbsp;
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				&nbsp;
				</td>
				<td >
				&nbsp;
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				&nbsp;
				</td>
				<td >
				&nbsp;
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				&nbsp;
				</td>
				<td >
				&nbsp;
				</td>
	</tr>
</table>