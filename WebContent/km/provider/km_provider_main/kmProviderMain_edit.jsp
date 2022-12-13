<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script>
Com_IncludeFile("dialog.js|doclist.js|calendar.js");
Com_IncludeFile("validator.jsp|validation.js|plugin.js|validation.jsp", null, "js");
</script>
<script language="JavaScript">
	//防止没有选择类别而直接进入编辑页面
   var fdModelId='${JsParam.fdModelId}';
   var fdModelName='${JsParam.fdModelName}';
   var url='<c:url value="/km/provider/km_provider_main/kmProviderMain.do" />?method=add&categoryId=!{id}&categoryName=!{name}';
   if(fdModelId!=null&&fdModelId!=''){
		url+="&fdModelId="+fdModelId+"&fdModelName="+fdModelName;
	}  
	
	//供应商代码唯一性校验
	function code_checkUnique(bean, fdCode,fdId) {
		var url = encodeURI(Com_Parameter.ResPath + "jsp/ajax.jsp?&serviceName=" 
				+ bean + "&fdCode=" + fdCode+"&fdId="+fdId+"&date="+new Date());
		var xmlHttpRequest;
		if (window.XMLHttpRequest) { // Non-IE browsers
			xmlHttpRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) { // IE
			try {
				xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (othermicrosoft) {
				try {
					xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (failed) {
					xmlHttpRequest = false;
				}
			}
		}
		if (xmlHttpRequest) {
			xmlHttpRequest.open("GET", url, false);
			xmlHttpRequest.send();
			var result = xmlHttpRequest.responseText.replace(/\s/g, "").replace(
					/;/g, "\n");
			if (result != "") {
				return false;
			}
		}
		return true;
	}
</script>

<html:form action="/km/provider/km_provider_main/kmProviderMain.do">
<input type="hidden" name="cateId" value=""/>
<input type="hidden" name="cateName" value=""/>
<div id="optBarDiv">
	<c:if test="${kmProviderMainForm.method_GET=='edit'}">
		<input type=button value="<bean:message key="button.update"/>"
			onclick="Com_Submit(document.kmProviderMainForm, 'update');">
	</c:if>
	<c:if test="${kmProviderMainForm.method_GET=='add'}">
		<input type=button value="<bean:message key="button.save"/>"
			onclick="Com_Submit(document.kmProviderMainForm, 'save');">
		<input type=button value="<bean:message key="button.saveadd"/>"
			onclick="Com_Submit(document.kmProviderMainForm, 'saveadd');">
	</c:if>
	<input type="button" value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-provider" key="table.kmProviderMain"/></p>

<center>
	<table id="Label_Tabel" width=95%>
		<!--基础信息 -->
		<tr LKS_LabelName="<bean:message bundle="km-provider" key="kmProviderMain.lbl.baseInfo" />">
			<td>
				<table class="tb_normal" width=100%>
					<tr>
						<!-- 供应商名称 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdName"/>
						</td>
						<td width="35%">
							<xform:text property="fdName" style="width:85%" />
						</td>
						<!-- 供应商代码 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdCode"/>
						</td>
						<td width="35%">
							<xform:text property="fdCode" style="width:85%" validators="fdCode"/>
						</td>
					</tr>
					
					<tr>
						<!-- 供应商类别 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.docCategory"/>
						</td>
						<td width="35%">
							<html:hidden property="docCategoryId" />
							<xform:text property="docCategoryName" style="width:85%" showStatus="view"></xform:text>
						</td>
						<!-- 采购标的 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdBiao"/>
						</td>
						<td width="35%">
							<xform:text property="fdBiao" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 法人代表 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdLegal"/>
						</td>
						<td width="35%">
							<xform:text property="fdLegal" style="width:85%" />
						</td>
						<!-- 成立日期 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdCreateDate"/>
						</td>
						<td width="35%">
							<xform:datetime property="fdCreateDate" dateTimeType="date" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 注册资金 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdRegMoney"/>
						</td>
						<td width="35%">
							<xform:text property="fdRegMoney" style="width:80%" validators="regMoney"/>
							<bean:message bundle="km-provider" key="kmProviderMain.fdRegMoney.unit"/>
						</td>
						<!-- 人员规模 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdPersonNum"/>
						</td>
						<td width="35%">
							<xform:text property="fdPersonNum" style="width:85%" />
						</td>
					</tr>
					
					<!-- 分隔符 -->
					<tr><td colspan="4">&nbsp;</td></tr>
					
					<tr>
						<!-- 所属国家 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdCountry"/>
						</td>
						<td width="35%">
							<xform:text property="fdCountry" style="width:85%" />
						</td>
						<!-- 所属城市 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdCity"/>
						</td>
						<td width="35%">
							<xform:text property="fdCity" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 公司地址 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdAddress"/>
						</td>
						<td width="35%" colspan="3">
							<xform:text property="fdAddress" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 邮编 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdPost"/>
						</td>
						<td width="35%">
							<xform:text property="fdPost" style="width:85%" />
						</td>
						<!-- 网址 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdWwwAddress"/>
						</td>
						<td width="35%">
							<xform:text property="fdWwwAddress" validators="URL" style="width:85%"   />
						</td>
					</tr>
					
					<tr>
						<!-- 联系人 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdContactPerson"/>
						</td>
						<td width="35%">
							<xform:text property="fdContactPerson" style="width:85%" />
						</td>
						<!-- 联系电话 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdPhoneNo"/>
						</td>
						<td width="35%">
							<xform:text required="true" property="fdPhoneNo" validators="phone" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 邮箱 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdEmail"/>
						</td>
						<td width="35%">
							<xform:text property="fdEmail" style="width:85%" validators="email" />
						</td>
						<!-- 传真 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdFax"/>
						</td>
						<td width="35%">
							<xform:text validators="fax" property="fdFax" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 公司介绍 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdSummary"/>
						</td>
						<td width="35%" colspan="3">
							<xform:textarea property="fdSummary" style="width:85%" />
						</td>
					</tr>
					
					<!-- 分隔符 -->
					<tr><td colspan="4">&nbsp;</td></tr>
				
					<tr>
						<!-- 户名 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdAccountName"/>
						</td>
						<td width="35%">
							<xform:text property="fdAccountName" style="width:85%" />
						</td>
						<!-- 税务号 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdTaxationNo"/>
						</td>
						<td width="35%">
							<xform:text property="fdTaxationNo" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 开户行 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdAccountBank"/>
						</td>
						<td width="35%">
							<xform:text property="fdAccountBank" style="width:85%" />
						</td>
						<!-- 联行网点号 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdAccountPoint"/>
						</td>
						<td width="35%">
							<xform:text property="fdAccountPoint" style="width:85%"/>
						</td>
					</tr>
					
					<tr>
						<!-- 银行帐号  -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdAccountNo"/>
						</td>
						<td width="35%">
							<xform:text property="fdAccountNo" style="width:85%" />
						</td>
						<!-- 组织机构代码 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdOrganizNo"/>
						</td>
						<td width="35%">
							<xform:text property="fdOrganizNo" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 备注 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdRemark"/>
						</td>
						<td width="35%" colspan="3">
							<xform:textarea property="fdRemark" style="width:85%" />
						</td>
					</tr>
					
					<!-- 分隔符 -->
					<tr><td colspan="4">&nbsp;</td></tr>
					
					<tr>
						<!-- 可使用者 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.authReaders"/>
						</td>
						<td width="35%" colspan="3">
							<xform:address propertyId="authReaderIds" propertyName="authReaderNames" mulSelect="true" orgType="ORG_TYPE_ALL" textarea="true" style="width:85%" />
							<div class="description_txt">
								<bean:message	bundle="km-provider" key="kmProviderMain.description.authReaders" />
							</div>
						</td>
					</tr>
					
					<tr>
						<!-- 是否有效 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdIsvalidate"/>
						</td>
						<td width="35%" colspan="3">
							<xform:radio property="fdIsvalidate" >
								<xform:enumsDataSource enumsType="km_provider_main_fd_isvalidate" />
							</xform:radio>
						</td>
					</tr>			
				</table>
			</td>
		</tr>
		
		<!-- 资质证明 -->
		<tr LKS_LabelName="<bean:message bundle="km-provider" key="kmProviderMain.lbl.proof" />">
			<td>
				<table class="tb_normal" width=100% id="TABLE_DocList">
					 <tr>
					 	<td class="td_normal_title" width=15%>
					 		<bean:message	bundle="km-provider" key="kmProviderMain.attachment" />
					 	</td>
					 	<td colspan="3">
					 			<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
									<c:param name="fdKey" value="proof" />									
							</c:import>
					 	</td>
					 </tr>
				</table>
			</td>
		</tr>
		
	</table>
</center>
<html:hidden property="fdId" />
<html:hidden property="docStatus" />
<html:hidden property="method_GET" />
<script>
	if("${JsParam.categoryId}"==""&&"${kmProviderMainForm.method_GET}"=="add"){
		Dialog_SimpleCategory('com.landray.kmss.km.provider.model.KmProviderCategory','cateId',"cateName",false,";","02",function(rtn){
			var tempId = document.getElementsByName("cateId")[0].value;
			if(tempId!=null&&tempId!=""){
				 var Createurl=Com_GetCurDnsHost()+'<c:url value="/km/provider/km_provider_main/kmProviderMain.do" />?method=add&categoryId='+tempId;
				setTimeout(function(){
					window.open(Createurl,"_self");
				}, 100);
			}
		});
	}
</script>
<script>
	var _validation=$KMSSValidation(document.forms['kmProviderMainForm']);
	//增加校验器:联系电话、传真、URL、供应商代码唯一性、注册资金非负数
	_validation.addValidator('phone','<bean:message	bundle="km-provider" key="kmProviderMain.validate.phone"/>',function(v, e, o) {
		if(/^\d+-?\d*$/.test(v)||/^0?1(3|5|8)\d{9}$/.test(v)||this.getValidator('isEmpty').test(v)) {
		     return true; // 校验通过
		 }
		 return false;
	});
	_validation.addValidator('fax','<bean:message bundle="km-provider" key="kmProviderMain.validate.fax"/>',function(v, e, o) {
		if(/^\d+-?\d*$/.test(v)||this.getValidator('isEmpty').test(v)) {
		     return true; // 校验通过
		 }
		 return false;
	});
	_validation.addValidator('URL','<bean:message bundle="km-provider" key="kmProviderMain.validate.url"/>',function(v, e, o) {
		if(/^((http|https|ftp):\/\/)?(([A-Z0-9][A-Z0-9_-]*)(\.[A-Z0-9][A-Z0-9_-]*)+)(:(\d+))?\/?/i.test(v)||this.getValidator('isEmpty').test(v)) {
		     return true; // 校验通过
		 }
		 return false;
	});		
	_validation.addValidator('fdCode','<bean:message bundle="km-provider" key="kmProviderMain.validate.fdCode"/>',function(v, e, o) {
		var fdId=document.getElementsByName("fdId")[0].value;
		return code_checkUnique("kmProviderMainService",v,fdId);
	});
	_validation.addValidator('regMoney','<bean:message bundle="km-provider" key="kmProviderMain.validate.regMoney.tip1"/>',function(v, e, o) {
		var validator = this.getValidator('regMoney');
		var fdRegMoney=document.getElementsByName("fdRegMoney")[0].value;
		if((!this.getValidator('isEmpty').test(v)) && fdRegMoney<0){
			validator.error = '<bean:message bundle="km-provider" key="kmProviderMain.validate.regMoney.tip1"/>';
			return false;
		}
		if((!(this.getValidator('isEmpty').test(v)) && !(!isNaN(v) && !/^\s+$/.test(v)&& /^.{1,20}$/.test(v) ))){
			validator.error = '<bean:message bundle="km-provider" key="kmProviderMain.validate.regMoney.tip2"/>';
			return false;
		}
		return true;
	});
	
</script>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>