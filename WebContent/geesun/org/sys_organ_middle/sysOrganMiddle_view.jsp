<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<bean:message bundle="geesun-org" key="table.sysOrganMiddle"/>
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
<bean:message bundle="geesun-org" key="table.sysOrganMiddle"/>
</p>
		<div class="lui_form_content_frame" style="padding-top:5px">
			<table class="tb_normal" width=100%>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.objid"/>
					</td>
					<td width="35%">
						<xform:text property="objid" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.stext"/>
					</td>
					<td width="35%">
						<xform:text property="stext" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.objidUp"/>
					</td>
					<td width="35%">
						<xform:text property="objidUp" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.objidSUp"/>
					</td>
					<td width="35%">
						<xform:text property="objidSUp" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.priox"/>
					</td>
					<td width="35%">
						<xform:text property="priox" style="width:85%" />
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.zhrOmJglx"/>
					</td>
					<td width="35%">
						<xform:text property="zhrOmJglx" style="width:85%" />
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.zsfyx"/>
					</td>
					<td width="35%">
						<xform:select property="zsfyx" showStatus="view">
							<xform:enumsDataSource enumsType="common_yesno" />
						</xform:select>
					</td>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="geesun-org" key="sysOrganMiddle.zzDatum"/>
					</td>
					<td width="35%">
						<xform:text property="zzDatum" style="width:85%" />
					</td>
				</tr>
			</table>
		</div>
		 
	</template:replace>
</template:include>
