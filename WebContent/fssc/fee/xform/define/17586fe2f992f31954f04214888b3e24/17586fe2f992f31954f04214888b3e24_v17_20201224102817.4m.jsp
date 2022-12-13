<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.web.taglib.xform.TagUtils" %>
<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425291ea0326' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_37425332ffd2f2)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_37425332ffd2f2.id)" propertyName="extendDataFormInfo.value(fd_37425332ffd2f2.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_37425332ffd2f2','label')}" title="${xform:subject('fd_37425332ffd2f2','label')}" required="true" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374252930e2eb0' option='content'/></label>

				</td>
				<td >
				
				<xform:dialog subject="申请人公司" title="申请人公司" propertyId="extendDataFormInfo.value(fd_374252eae52b20)" propertyName="extendDataFormInfo.value(fd_374252eae52b20_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_374252eae52b20)','extendDataFormInfo.value(fd_374252eae52b20_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374252943fc1fc' option='content'/></label>

				</td>
				<td <xform:viewShow>class="muiFormMultiControlView"</xform:viewShow>>
				<xformflag id="_xform_extendDataFormInfo.value(fd_37425334cb401a)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_37425334cb401a.id)" propertyName="extendDataFormInfo.value(fd_37425334cb401a.name)" mulSelect="false" orgType="ORG_TYPE_ORG|ORG_TYPE_DEPT" subject="${xform:subject('fd_37425334cb401a','label')}" title="${xform:subject('fd_37425334cb401a','label')}" required="true" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425295b9581e' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_374252fcb7dcbc)" _xform_type="textarea">
				<xform:textarea property="extendDataFormInfo.value(fd_374252fcb7dcbc)" required="true" subject="${xform:subject('fd_374252fcb7dcbc','label')}" title="${xform:subject('fd_374252fcb7dcbc','label')}" mobile="true" placeholder="${xform:subject('fd_374252fcb7dcbc','tipInfo')}" onValueChange="__xformDispatch">
				</xform:textarea>
</xformflag>
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- overflow-wrap: break-word;;word-break:break-all;;word-wrap:break-word;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37689ded580fac' option='content'/></label>

				</td>
				<td <xform:viewShow>class="muiFormMultiControlView"</xform:viewShow>>
				
				<xform:dialog subject="项目" title="项目" propertyId="extendDataFormInfo.value(fd_37689df08409d2)" propertyName="extendDataFormInfo.value(fd_37689df08409d2_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37689df08409d2)','extendDataFormInfo.value(fd_37689df08409d2_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742529749a8ba' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_3742531f2f9e92)" _xform_type="attachment">
				<c:import url="/sys/attachment/mobile/import/${empty _xformRight ? ((_xformMainForm.method_GET == 'add' || _xformMainForm.method_GET == 'edit') ? 'edit' : 'view') : (_xformRight == 'edit' ? 'edit' : 'view')}.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="_xformMainForm" />
				<c:param name="fdKey" value="fd_3742531f2f9e92" />
				<c:param name="fdName" value="extendDataFormInfo.value(fd_3742531f2f9e92)" />
				<c:param name="fdRequired" value="false" />
				<c:param name="otherCanNotDelete" />
				<c:param name="allCanNotDelete" />
				<c:param name="fdInDetail" value="false" />
				<c:param name="fdViewType" value="simple" />
				<c:param name="fdMulti" value="true" />
				<c:param name="label" value="${xform:subject('fd_3742531f2f9e92','label')}" />
<c:param name="orient" value="<%= (String)TagUtils.getAttribute(request,\"orient\")%>" />
				</c:import>
</xformflag>
				</td>
	</tr>
	<tr>
				<td colspan="2" >
					<div class="detailTableContent">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="TABLE_DL_fd_37425415d18482" >
		<tr style="display:none;">
			<td></td>
		</tr>
			<tr data-dojo-type="mui/form/Template" 
				KMSS_IsReferRow="1"
				style="display:none;" 
				border='0'>
		<td class="detail_wrap_td">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fdId)" />
			<table class="muiSimple muiDetailTable">
				<tr celltr-title="true" onclick="detail_fd_37425415d18482_expandRow(this);">
					<td colspan="2" align="left" valign="middle" class="muiDetailTableNo" tableName="<xform:lang id='fd_37425415d18482' option='label'/>">
						<div class="muiDetailDisplayOpt muiDetailTableTitleIcon fontmuis muis-put-away"></div>
						<span class="muiDetailTableTitle">
							<xform:lang id='fd_37425415d18482' option='label'/>!{index}
						</span>
						<xform:editShow>
							<div class="muiDetailTableDel" onclick="detail_fd_37425415d18482_del(this);">
								<bean:message key="button.delete" />
							</div>
						</xform:editShow>
					</td>
				</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742545ef3d044' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.id)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254b781a860.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_374254b781a860','label')}" title="${xform:subject('fd_374254b781a860','label')}" required="true" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254608972de' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="成本中心" title="成本中心" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bae4f150_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425461970b20' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="费用类型" title="费用类型" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254bd820e1a_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254629309d0' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c3f61e8c)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c3f61e8c)" required="true" subject="${xform:subject('fd_374254c3f61e8c','label')}" title="${xform:subject('fd_374254c3f61e8c','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254638b8450' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c2b4c6b4)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c2b4c6b4)" required="true" subject="${xform:subject('fd_374254c2b4c6b4','label')}" title="${xform:subject('fd_374254c2b4c6b4','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254649678a4' option='content'/></label>

						</td>
						<td>
									
				<xform:text subject="天数" title="天数" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254c73c8c6c)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425465e3ac46' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="出发地" title="出发地" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254ce440280_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742546718a176' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="到达地" title="到达地" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254cf7a094e_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_375843db70f380' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="交通工具" title="交通工具" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_375843e7870d7a_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742546826171a' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="币种/汇率" title="币种/汇率" propertyId="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)" propertyName="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512)','extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d1b75512_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742549ab6b1b0' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d5c436d8)" _xform_type="inputText">
				<xform:number property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d5c436d8)" required="true" pattern="##,###.##" format="money" showChinese="false" htmlElementProperties="thousandShow='false' datatype='number' " mobile="true" subject="${xform:subject('fd_374254d5c436d8','label')}" title="${xform:subject('fd_374254d5c436d8','label')}" validators=" number scaleLength(2)" onValueChange="__xformDispatch" /></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_37425469717364' option='content'/></label>

						</td>
						<td>
									
				<xform:text subject="本位币金额" title="本位币金额" property="extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_374254d37fabb2)">
				</xform:text>
<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_392241d6599c40)" _xform_type="validatorControl">
				<div data-dojo-type="sys/xform/mobile/controls/Validator" data-dojo-props='"name":"extendDataFormInfo.value(fd_37425415d18482.!{index}.fd_392241d6599c40)","subject":"校验器","value":"${(_xformForm.extendDataFormInfo.formData.fd_392241d6599c40==null)?'':(_xformForm.extendDataFormInfo.formData.fd_392241d6599c40)}","onValueChange":"__xformDispatch","showStatus":"view"' validator="true" isRow="true" expression="[{&amp;quot;expressionId&amp;quot;:&amp;quot;$fd_37425415d18482.fd_374254d37fabb2$ &amp;gt;= 1000&amp;quot;,&amp;quot;expressionName&amp;quot;:&amp;quot;$明细表1.本位币金额$ &amp;gt;= 1000&amp;quot;,&amp;quot;message&amp;quot;:&amp;quot;本位币金额不允许大于1000&amp;quot;,&amp;quot;expressionShow&amp;quot;:&amp;quot;1&amp;quot;}]"></div></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742549c056b3a' option='content'/></label>

						</td>
						<td>
									<c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='0'}">无预算</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='1'}">预算内</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='2'}">超预算</c:if>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_374254a847dbda' option='content'/></label>

						</td>
						<td>
									<c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='0'}">无标准</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='1'}">标准内</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='2'}">超标准</c:if>
						</td>
					</tr>
			</table>
		</td>
			</tr>
		<c:forEach 
			items="${_xformForm.extendDataFormInfo.formData.fd_37425415d18482}" 
			var="_xformEachBean" 
			varStatus="vstatus">
		<tr KMSS_IsContentRow="1">
		<td class="detail_wrap_td">
			<xform:text showStatus="noShow" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fdId)" />
			<table class="muiSimple muiDetailTable">
				<tr celltr-title="true" onclick="detail_fd_37425415d18482_expandRow(this);">
					<td colspan="2" align="left" valign="middle" class="muiDetailTableNo" tableName="<xform:lang id='fd_37425415d18482' option='label'/>">
						<div class="muiDetailDisplayOpt muiDetailTableTitleIcon fontmuis muis-put-away"></div>
						<span class="muiDetailTableTitle">
							<xform:lang id='fd_37425415d18482' option='label'/>${vstatus.index + 1}
						</span>
						<xform:editShow>
							<div class="muiDetailTableDel" onclick="detail_fd_37425415d18482_del(this);">
								<bean:message key="button.delete" />
							</div>
						</xform:editShow>
					</td>
				</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742545ef3d044' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860)" _xform_type="address">
				<xform:address propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.id)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254b781a860.name)" mulSelect="false" orgType="ORG_TYPE_PERSON" subject="${xform:subject('fd_374254b781a860','label')}" title="${xform:subject('fd_374254b781a860','label')}" required="true" mobile="true" onValueChange="__xformDispatch" isLoadDataDict="false">
				</xform:address>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254608972de' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="成本中心" title="成本中心" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bae4f150_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425461970b20' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="费用类型" title="费用类型" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254bd820e1a_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254629309d0' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c3f61e8c)" required="true" subject="${xform:subject('fd_374254c3f61e8c','label')}" title="${xform:subject('fd_374254c3f61e8c','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254638b8450' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4)" _xform_type="datetime">
				<xform:datetime property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c2b4c6b4)" required="true" subject="${xform:subject('fd_374254c2b4c6b4','label')}" title="${xform:subject('fd_374254c2b4c6b4','label')}" mobile="true" onValueChange="__xformDispatch" dateTimeType="date" isLoadDataDict="false">
				</xform:datetime>
</xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_374254649678a4' option='content'/></label>

						</td>
						<td>
									
				<xform:text subject="天数" title="天数" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254c73c8c6c)">
				</xform:text>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_37425465e3ac46' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="出发地" title="出发地" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254ce440280_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742546718a176' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="到达地" title="到达地" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254cf7a094e_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_375843db70f380' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="交通工具" title="交通工具" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_375843e7870d7a_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742546826171a' option='content'/></label>

						</td>
						<td>
									
				<xform:dialog subject="币种/汇率" title="币种/汇率" propertyId="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)" propertyName="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_name)" dialogJs="Designer_DialogSelect(false,'fssc_base_company_fdCompany','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512)','extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d1b75512_name)',Designer_Control_Company_Changed);">
				</xform:dialog>

						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742549ab6b1b0' option='content'/></label>

						</td>
						<td>
									<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8)" _xform_type="inputText">
				<xform:number property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d5c436d8)" required="true" pattern="##,###.##" format="money" showChinese="false" htmlElementProperties="thousandShow='false' datatype='number' " mobile="true" subject="${xform:subject('fd_374254d5c436d8','label')}" title="${xform:subject('fd_374254d5c436d8','label')}" validators=" number scaleLength(2)" onValueChange="__xformDispatch" /></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_37425469717364' option='content'/></label>

						</td>
						<td>
									
				<xform:text subject="本位币金额" title="本位币金额" property="extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_374254d37fabb2)">
				</xform:text>
<xformflag id="_xform_extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_392241d6599c40)" _xform_type="validatorControl">
				<div data-dojo-type="sys/xform/mobile/controls/Validator" data-dojo-props='"name":"extendDataFormInfo.value(fd_37425415d18482.${vstatus.index}.fd_392241d6599c40)","subject":"校验器","value":"${(_xformEachBean.fd_392241d6599c40==null)?'':(_xformEachBean.fd_392241d6599c40)}","onValueChange":"__xformDispatch","showStatus":"view"' validator="true" isRow="true" expression="[{&amp;quot;expressionId&amp;quot;:&amp;quot;$fd_37425415d18482.fd_374254d37fabb2$ &amp;gt;= 1000&amp;quot;,&amp;quot;expressionName&amp;quot;:&amp;quot;$明细表1.本位币金额$ &amp;gt;= 1000&amp;quot;,&amp;quot;message&amp;quot;:&amp;quot;本位币金额不允许大于1000&amp;quot;,&amp;quot;expressionShow&amp;quot;:&amp;quot;1&amp;quot;}]"></div></xformflag>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3742549c056b3a' option='content'/></label>

						</td>
						<td>
									<c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='0'}">无预算</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='1'}">预算内</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_377ae5c8711bc0_budget_status']=='2'}">超预算</c:if>
						</td>
					</tr>
					<tr data-celltr="true">
						<td class="muiTitle">
							<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_374254a847dbda' option='content'/></label>

						</td>
						<td>
									<c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='0'}">无标准</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='1'}">标准内</c:if><c:if test="${fsscFeeMainForm.extendDataFormInfo.formData['fd_37425415d18482'][vstatus.index]['fd_38b84dcc41608c_standard_status']=='2'}">超标准</c:if>
						</td>
					</tr>
			</table>
		</td>
		</tr>
		</c:forEach>

			<tr>
				<td>
					<table class="muiSimple">
						<tr statistic-celltr-title="true" onclick="detail_fd_37425415d18482_expandRow(this);">
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
		onclick="window.detail_fd_37425415d18482_add(event)">
		<bean:message bundle='sys-xform-base' key='sysform.detailsTable.addDetail'/><xform:lang id='fd_37425415d18482' option='label'/>
	</div>
	<script type="text/javascript">window["_editShow_fd_37425415d18482"] = true</script>
	<c:if test="${empty _xformForm.extendDataFormInfo.formData.fd_37425415d18482 }">
		<script type="text/javascript">window["_emptyFormData_fd_37425415d18482"] = true</script>
	</c:if>
</xform:editShow>
<script type="text/javascript">DocList_Info.push('TABLE_DL_fd_37425415d18482');</script>
<script type="text/javascript">
require(["sys/xform/mobile/controls/detailsTable/mobileDetailsTableScript"], function(){
window._mobileDetailsTableScript.init('fd_37425415d18482','TABLE_DL_fd_37425415d18482','1','true');
})
</script>

				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false">
<xform:lang id='fd_3742571323b8dc' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_374257254b2f80)" _xform_type="calculation">
				<div data-dojo-type="sys/xform/mobile/controls/Calculation" data-dojo-props='"dataType":"BigDecimal_Money","name":"extendDataFormInfo.value(fd_374257254b2f80)","subject":"${xform:subject('fd_374257254b2f80','label')}","value":"${(_xformForm.extendDataFormInfo.formData.fd_374257254b2f80==null)?'':(_xformForm.extendDataFormInfo.formData.fd_374257254b2f80)}","onValueChange":"__xformDispatch","showStatus":"${_xformRight!=null?_xformRight:param['optType']}"' calculation="true" isRow="false" expression="$XForm_CalculatioFuns_Sum$($fd_37425415d18482.fd_374254d5c436d8$)" autoCalculate="true" isReadOnly="true" thousandShow="true" paramDefault="false" scale="2"></div></xformflag>
				</td>
	</tr>
	<tr>
				<td class="muiTitle" style="width:30%;">
				<label class="xform_label" style=" color: rgb(0, 0, 0);  -ms- -ms-word-wrap: break-word;;word-break:break-all;;word-wrap:break-word;;"  fd_type="textLabel"  ishiddeninmobile="false" line="normal">
<xform:lang id='fd_3779ec8ad9881a' option='content'/></label>

				</td>
				<td >
				<xformflag id="_xform_extendDataFormInfo.value(fd_3779ec91775752)" _xform_type="chinaValue">
				<div data-dojo-type="sys/xform/mobile/controls/ChinaValue" data-dojo-props='"dataType":"String","name":"extendDataFormInfo.value(fd_3779ec91775752)","subject":"${xform:subject('fd_3779ec91775752','label')}","value":"${(_xformForm.extendDataFormInfo.formData.fd_3779ec91775752==null)?'':(_xformForm.extendDataFormInfo.formData.fd_3779ec91775752)}","onValueChange":"__xformDispatch","showStatus":"${_xformRight!=null?_xformRight:param['optType']}"' relatedid="fd_374257254b2f80" isrow="false"></div></xformflag>
				</td>
	</tr>
</table>