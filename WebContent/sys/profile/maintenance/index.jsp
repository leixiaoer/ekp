<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.sys.config.util.LicenseUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.landray.kmss.sys.organization.interfaces.ISysOrgCoreService"%>
<%@ page import="com.landray.kmss.sys.cluster.model.SysClusterParameter"%>
<%@ page import="com.landray.kmss.sys.log.service.ISysLogOnlineService"%>
<%@ page import="com.landray.kmss.constant.SysOrgConstant"%>
<%@ page import="com.landray.kmss.util.DateUtil"%>
<%@ page import="com.landray.kmss.util.version.VersionXMLUtil"%>
<%@ page import="com.landray.kmss.sys.authorization.util.TripartiteAdminUtil"%>
<%@ page import="com.landray.kmss.util.ResourceUtil"%>
<%@ page import="com.landray.kmss.util.StringUtil"%>
<%@ page import="com.landray.kmss.sys.profile.service.ISysProfileBlueAfterService" %>

<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="head">
		<%@ include file="/sys/ui/jsp/jshead.jsp"%>
		<link charset="utf-8" rel="stylesheet" href="${LUI_ContextPath}/sys/profile/resource/css/maintenanceIndex.css?s_cache=${LUI_Cache}">
	</template:replace>
	<template:replace name="body">
		<div class="lui_profile_version_container">
			<div class="lui_profile_version_header">
				<span class="company_name"><em><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.companyName"/></em><%=LicenseUtil.get("license-to")%></span>
				<%
	        		if(LicenseUtil.get("license-product-name") != null) {
	        	%>
	        	<style>
	        		.lui_profile_version_header {
						padding-top: 7px;
					}
					.lui_profile_version_header .company_name{
						display: block;
						line-height: 32px;
					}
				</style>
				<span class="company_name"><em><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.productName"/></em><%=LicenseUtil.get("license-product-name")%></span>
				<%
	        		}
	        	%>
			</div>
			<div class="lui_profile_version_content">
				<div class="lui_profile_version_main_content">
				
					<%
					com.alibaba.fastjson.JSONObject jsonObject = ((ISysProfileBlueAfterService)SpringBeanUtil.getBean("sysProfileBlueAfterService")).getBlueAfterData();
						boolean flag = false;
						if(jsonObject != null){
							flag = true;
						}
						request.setAttribute("blueData",jsonObject);
						if(flag){
					%>
						<div class="lui_profile_version_item item06">
							<i class="version_icon"></i>
							<h3 class="version_title">${ lfn:message('sys-profile:sys.profile.maintenance.customerName') }</h3>
							<div class="version_info">
								<span>${ lfn:message('sys-profile:sys.profile.maintenance.expired.date') }
									<i class="lui_landray_number">${blueData.serveEndDay}
									</i>${ lfn:message('sys-profile:sys.profile.maintenance.expired.day') }</span>
								<a href="${blueData.indexUrl}" target="_blank" >
									<span class="version_continue">${ lfn:message('sys-profile:sys.profile.maintenance.renew.right') }</span>
								</a>
							</div>
							<div class="version_info version_info_items">
								<a href="${blueData.buildingProjectUrl}" target="_blank">
									<span>${ lfn:message('sys-profile:sys.profile.maintenance.projects.under.construction') }<i class="lui_landray_number">${blueData.buildingProjectCount}</i>${ lfn:message('sys-profile:sys.profile.maintenance.individual') }</span>
									<span class="version_more"></span>
								</a>
							</div>
							<div class="version_info version_info_items">
								<a href="${blueData.warningUrl}" target="_blank" >
									<span>${ lfn:message('sys-profile:sys.profile.maintenance.safety.reminder') }<i class="lui_landray_number">${blueData.warningCount}</i>${ lfn:message('sys-profile:sys.profile.maintenance.strip') }</span>
									<span class="version_more"></span>
								</a>
							</div>
							<div class="version_footer">
								<a href="${blueData.activityUrl}" target="_blank">
									<span class="version_footer_text">${blueData.activityName}</span>
									<span>${ lfn:message('sys-profile:sys.profile.maintenance.activity.details') }</span>
								</a>
							</div>
						</div>
					<% } %>
					<div class="lui_profile_version_item item01">
						<i class="version_icon"></i>
						<h3 class="version_title"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.license"/>
						<%
							String license = ResourceUtil.getKmssConfigString("kmss.sysLicense");

			        		if(LicenseUtil.get("license-type") != null &&LicenseUtil.get("license-type").equalsIgnoreCase("Official")){

								if(StringUtil.isNull(license)){
			        	%>
			        			<bean:message key="sysLicense.official" bundle="sys-config" />
			        	<% 
								}else{
									out.print(license);
								}
			        	%>	
			        		</h3>
			        	<%
			        		} else {
			        			String expire = LicenseUtil.get("license-expire");
								int expireDate = (int) ((DateUtil.convertStringToDate(expire, "yyyy-MM-dd").getTime() - System.currentTimeMillis()) / DateUtil.DAY);
								pageContext.setAttribute("expireDate", expireDate);
								if(StringUtil.isNull(license)){
			        	%>
			        			<bean:message key="sysLicense.trial" bundle="sys-config" />
			        	<% 
								}else{
									out.print(license);
								}
			        	%>	

							</h3>
							<p class="version_info"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.expireDate1"/><%=expire%></p>
							<div class="version_footer"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.expireDate2" arg0="${expireDate}"/></div>
			        	<%
			        		}
			        	%>
					</div>
					<div class="lui_profile_version_item item02">
						<%
							String unlimit = ResourceUtil.getString("sysLicense.licenseType.unlimit", "sys-config");
				        	int licenseOrgPerson = StringUtil.getIntFromString(LicenseUtil.get("license-org-person"), 9999999);
				    		String licenseOrgPersonString = licenseOrgPerson == 9999999  ? unlimit : String.valueOf(licenseOrgPerson) + " " + ResourceUtil.getString("sys.profile.maintenance.overview.currentPerson.total", "sys-profile");
				    		int currentPerson  = ((ISysOrgCoreService)SpringBeanUtil.getBean("sysOrgCoreService")).getAllCount(SysOrgConstant.ORG_TYPE_PERSON);
				    		long onlineCount = ((ISysLogOnlineService)SpringBeanUtil.getBean("sysLogOnlineService")).getOnlineUserNum();
				    		pageContext.setAttribute("onlineCount", onlineCount);
			        	%>
						<i class="version_icon"></i>
						<h3 class="version_title" style="padding-top: 15px"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.currentPerson"/></h3>
						<p class="version_info">
							<em><%=currentPerson%></em><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.currentPerson.label"/>
							 / <%=licenseOrgPersonString%>
							 / <bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.online" arg0="${onlineCount}"/>
						</p>
					</div>
					<div class="lui_profile_version_item item03">
						<%
				    		int licenseCluster = StringUtil.getIntFromString(LicenseUtil.get("license-cluster"), 1);
				    		String licenseClusterString = licenseCluster < 0 ? unlimit : String.valueOf(licenseCluster);
				    		List sysClusterServerList = SysClusterParameter.getInstance().getAllServers();
				    		pageContext.setAttribute("sysClusterServerSize", sysClusterServerList.size());
				    		pageContext.setAttribute("licenseClusterString", licenseClusterString);
			        	%>
						<i class="version_icon"></i>
						<h3 class="version_title"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.licenseCluster"/></h3>
						<p class="version_info"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.cluster" arg0="${sysClusterServerSize}" arg1="${licenseClusterString}"/></p>
						<div class="version_footer"><a href="<c:url value="/sys/profile/index.jsp#maintenance/server/"/>" target="_blank"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.allCluster"/></a></div>
					</div>
					<div class="lui_profile_version_item item04">
						<i class="version_icon"></i>
						<h3 class="version_title"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.licenseServer"/></h3>
						<% 
					    	Map<String,String> serverHwaddr = LicenseUtil.getServerHwaddr();
					    	if(StringUtil.isNotNull(serverHwaddr.get("error"))){ %>
					    		<p class="version_info" title="<%=serverHwaddr.get("error")%>"><bean:message key="sysLicense.licenseServer.error" bundle="sys-config" />：<%=serverHwaddr.get("error")%></p>
					    	<%} else { %>
					    		<p class="version_info"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.ip"/><%=serverHwaddr.get("ip")%></p>
								<p class="version_info"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.mac"/><%=serverHwaddr.get("mac")%></p>   
					    	<% } if(StringUtil.isNotNull(serverHwaddr.get("suggest"))){ %>
					    		<p class="version_info"><bean:message key="sysLicense.licenseServer.suggest" bundle="sys-config" />&nbsp;：&nbsp;<%=serverHwaddr.get("suggest")%></p>
							<%}
						%>
					</div>
					<div class="lui_profile_version_item item05">
						<% 
							String path = request.getSession().getServletContext().getRealPath("/");
							path = path.replaceAll("\\\\", "/");
							if (!path.endsWith("/")) {
								path += "/";
							}
							String file = path + "WEB-INF/KmssConfig/version/description.xml";
							String version = VersionXMLUtil.getInstance(file).getDescriprion().getModule().getBaseline();
							StringBuffer buf = new StringBuffer();
							if(version != null) {
								int count = 0;
								for(int i=0; i<version.length(); i++) {
									if(version.charAt(i) == '.') {
										count++;
										if(count > 1) break;
									}
									buf.append(version.charAt(i));
								}
							}
						%>
						<i class="version_icon"></i>
						<h3 class="version_title"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.version"/></h3>
						<p class="version_info"><em><%=buf.toString()%></em></p>
						<% 
							String __path = "/all.version";
							if(!TripartiteAdminUtil.isGeneralUser()) { // 非三员管理 才显示的内容
								__path = "/sys/profile/tripartiteAdminAction.do?method=showVersion&path=/all.version";
							}
							__path = request.getContextPath() + __path;
						%>
						<div class="version_footer"><a href="<%=__path%>" target="_blank"><bean:message bundle="sys-profile" key="sys.profile.maintenance.overview.allVersion"/></a></div>
					</div>
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
		</script>
	</template:replace>
</template:include>	
	