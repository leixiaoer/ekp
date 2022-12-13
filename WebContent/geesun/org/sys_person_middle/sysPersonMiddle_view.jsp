<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<bean:message bundle="geesun-org" key="table.sysPersonMiddle"/>
	</template:replace>
	<template:replace name="toolbar">
	  <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
		<ui:button text="${ lfn:message('button.close') }" order="2" onclick="Com_CloseWindow();">
		</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		    <ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
			</ui:menu>
	</template:replace>
	<template:replace name="content">
<p class="txttitle">
<bean:message bundle="geesun-org" key="table.sysPersonMiddle"/>
</p>
		<div class="lui_form_content_frame" style="padding-top:5px">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.pernr"/>
					</td>
					<td width="35%">
						<xform:text property="pernr" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.nachn"/>
					</td>
					<td width="35%">
						<xform:text property="nachn" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.vnamc"/>
					</td>
					<td width="35%">
						<xform:text property="vnamc" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.orger"/>
					</td>
					<td width="35%">
						<xform:text property="orger" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.plans01"/>
					</td>
					<td width="35%">
						<xform:text property="plans01" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.plans02"/>
					</td>
					<td width="35%">
						<xform:text property="plans02" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.phone"/>
					</td>
					<td width="35%">
						<xform:text property="phone" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.email"/>
					</td>
					<td width="35%">
						<xform:text property="email" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.ccall"/>
					</td>
					<td width="35%">
						<xform:text property="ccall" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.wxid"/>
					</td>
					<td width="35%">
						<xform:text property="wxid" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzj"/>
					</td>
					<td width="35%">
						<xform:text property="zhrOmGwzj" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.zhrOmGwzd"/>
					</td>
					<td width="35%">
						<xform:text property="zhrOmGwzd" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.gender"/>
					</td>
					<td width="35%">
						<xform:text property="gender" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.zsfyx"/>
					</td>
					<td width="35%">
						<xform:select property="zsfyx" showStatus="view">
							<xform:enumsDataSource enumsType="common_yesno" />
						</xform:select>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysPersonMiddle.zzDatum"/>
					</td>
					<td colspan="3">
						<xform:text property="zzDatum" style="width:85%" />
					</td>
				</tr>
			</table>
		</div>
		 
	</template:replace>
</template:include>
