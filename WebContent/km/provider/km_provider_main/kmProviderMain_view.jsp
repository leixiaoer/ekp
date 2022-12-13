<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.edit"/>"
			onclick="Com_OpenWindow('kmProviderMain.do?method=edit&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<kmss:auth requestURL="/km/provider/km_provider_main/kmProviderMain.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmProviderMain.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><bean:message bundle="km-provider" key="table.kmProviderMain"/></p>

<center>
<table id="Label_Tabel" width=95%>
		<!--基础信息 -->
		<tr LKS_LabelName="<bean:message bundle="km-provider" key="kmProviderMain.lbl.baseInfo" />">
			<td>
				<table class="tb_normal" width=95%>
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
							<xform:text property="fdCode" style="width:85%" />
						</td>
					</tr>
				
					<tr>
						<!-- 供应商类别 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.docCategory"/>
						</td>
						<td width="35%">
							<c:out value="${kmProviderMainForm.docCategoryName}" />
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
							<xform:datetime property="fdCreateDate" />
						</td>
					</tr>
					
					<tr>
						<!-- 注册资金 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdRegMoney"/>
						</td>
						<td width="35%">
							<xform:text property="fdRegMoney" style="width:85%" />
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
							<xform:text property="fdWwwAddress" style="width:85%" />
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
							<xform:text property="fdPhoneNo" style="width:85%" />
						</td>
					</tr>
					
					<tr>
						<!-- 邮箱 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdEmail"/>
						</td>
						<td width="35%">
							<xform:text property="fdEmail" style="width:85%" />
						</td>
						<!-- 传真 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdFax"/>
						</td>
						<td width="35%">
							<xform:text property="fdFax" style="width:85%" />
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
							<xform:text property="fdAccountPoint" style="width:85%" />
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
							<c:out value="${kmProviderMainForm.authReaderNames}" />
						</td>
					</tr>
				
					<tr>
						<!-- 是否有效 -->
						<td class="td_normal_title" width=15%>
							<bean:message bundle="km-provider" key="kmProviderMain.fdIsvalidate"/>
						</td>
						<td width="35%" colspan="3">
							<xform:radio property="fdIsvalidate">
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
					<%--
					<tr>
						<!-- 序号 -->
						<td class="td_normal_title" width="5%" align="center" >
							<bean:message bundle="km-provider"  key="kmProviderMain.title.fdNo" />
						</td>
						<!-- 名称 -->
						<td class="td_normal_title" width=25% align="center" >
							<bean:message bundle="km-provider" key="kmProviderMain.title.fdName" />
						</td>
						<!-- 附件 -->
						<td class="td_normal_title" width="20%" align="center" >
							<bean:message	bundle="km-provider" key="kmProviderMain.title.att" />
						</td>
						<!-- 按钮 -->
						<td class="td_normal_title" width="20%" align="center"></td>
					</tr>
					 --%>
					<tr>
					 	<td class="td_normal_title" width=15%>
					 		<bean:message	bundle="km-provider" key="kmProviderMain.attachment" />
					 	</td>
					 	<td colspan="3">
							<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
								<c:param name="fdKey" value="proof"/>
								<c:param name="formBeanName" value="kmProviderMainForm"/>
							</c:import>
					 	</td>
					 </tr>
					
				</table>
			</td>
		</tr>
		
	</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>