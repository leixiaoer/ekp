<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<bean:message bundle="geesun-org" key="module.geesun.org"/>
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
<bean:message bundle="geesun-org" key="module.geesun.org"/>
</p>
		<div class="lui_form_content_frame" style="padding-top:5px">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.fdResult"/>
					</td>
					<td width="35%">
						<xform:select property="fdResult" showStatus="view">
							<xform:enumsDataSource enumsType="geesunOrgEkp_fdResult" />
						</xform:select>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.fdType"/>
					</td>
					<td width="35%">
						<xform:select property="fdType" showStatus="view">
							<xform:enumsDataSource enumsType="geesunOrgEkp_fdType" />
						</xform:select>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.fdInput"/>
					</td>
					<td colspan="3">
						<xform:text property="fdInput" style="width:85%"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.fdReturns"/>
					</td>
					<td colspan="3">
						<xform:textarea property="fdReturns" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.fdMessage"/>
					</td>
					<td colspan="3">
						<xform:rtf property="fdMessage" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="geesunOrgEkp.docCreateTime"/>
					</td>
					<td colspan="3">
						<xform:datetime property="docCreateTime" />
					</td>
				</tr>
			</table>
		</div>
		 
	</template:replace>
</template:include>
