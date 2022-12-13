<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.landray.kmss.util.SpringBeanUtil,com.landray.kmss.third.mall.service.IThirdMallAuthorizeService,com.landray.kmss.third.mall.model.ThirdMallAuthorize"%>
<%@ page import="java.util.List,com.landray.kmss.sys.config.util.LicenseUtil,com.landray.kmss.sys.cluster.util.NetUtil"%>
<%@ page import="com.landray.kmss.util.StringUtil,com.landray.kmss.third.mall.util.MallUtil"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%
	IThirdMallAuthorizeService authService = (IThirdMallAuthorizeService) SpringBeanUtil.getBean("thirdMallAuthorizeService");
	String customer = LicenseUtil.get("license-customer-id");
	String corpID = MallUtil.getCustomerId();
	String fdClientName = LicenseUtil.get("license-to");
	String fdEnabel = "";
	String fdBusKeys = "";
	String msg = "";
	if (StringUtil.isNull(customer)) {
		if (StringUtil.isNull(fdClientName)) {
			fdClientName = MallUtil.getMd5Name();
		}
		msg = "<span style='color:red;'>（非许可ID，需要商城提供单独授权，IP: " + NetUtil.getLocalAddress() + " ）</span>";
	}
	List<ThirdMallAuthorize> list = authService.findClientAuthorize(corpID);
	if(!list.isEmpty()) {
		ThirdMallAuthorize auth = list.get(0);
		fdBusKeys = auth.getFdBusKeys();
		fdEnabel = auth.getFdEnable();
	}
	request.setAttribute("__fdClientId", corpID);
	request.setAttribute("__fdMallEnable", fdEnabel);
	request.setAttribute("__fdBusKeys", fdBusKeys);
	request.setAttribute("_fdClientName", fdClientName);
	request.setAttribute("_msg", msg);
%>
<template:include ref="config.profile.edit" sidebar="no">
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/third/mall/resource/css/mall.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="content">
		<div class="luiMallBox">
			<div class="luiMallBoxWrap">
				<h3>
					<bean:message bundle="third-mall" key="thirdMall.config.title" />
				</h3>
				<h4>
					<bean:message bundle="third-mall" key="thirdMallAuthorize.fdClientId" />：
					${__fdClientId}
					${_msg}
				</h4>
				<c:if test="${__fdMallEnable!='1'}">
					<div class="luiMallOpt">
						<div class="luiMallBtn" onclick="enableMall()">
							<bean:message bundle="third-mall" key="thirdMall.config.open" />
						</div>
						<div class="luiMallOptInfo">
							<div>
								<bean:message bundle="third-mall" key="thirdMall.config.tips" />
							</div>
						</div>
					</div>
				</c:if>
				<c:if test="${__fdMallEnable=='1'}">
					<div class="cm-start-edit">
						<p>
							<bean:message bundle="third-mall"
								key="thirdMall.config.enterprise" />${_fdClientName }</p>
						<div class="cm-start-btn-box">
							<div class="luiMallBtn" onclick="onMallChange()">
								<bean:message bundle="third-mall"
									key="thirdMall.config.change.auth" />
							</div>
							<div class="luiMallBtn close" onclick="onMallClose()">
								<bean:message bundle="third-mall" key="thirdMall.config.close" />
							</div>
						</div>
					</div>
				</c:if>

				<div class="luiMallCards">
					<div class="luiMallCardItem">
						<div class="luiMallCardItemWrap ">
							<div class="luiMallCardIcon"></div>
							<c:set var="active" value="" />
							<c:if
								test="${__fdMallEnable=='1' && fn:contains(__fdBusKeys,'sys_xform')}">
								<c:set var="active" value="active" />
							</c:if>
							<div class="luiMallCardDetail ${active}">
								<div>
									<p>
										<bean:message bundle="third-mall"
											key="thirdMallAuthorize.xform.name" />
									</p>
									<c:choose>
										<c:when
											test="${__fdMallEnable=='1' && fn:contains(__fdBusKeys,'sys_xform')}">
											<span><bean:message bundle="third-mall"
													key="thirdMallAuthorize.opened" /></span>
										</c:when>
										<c:otherwise>
											<span><bean:message bundle="third-mall"
													key="thirdMallAuthorize.closed" /></span>
										</c:otherwise>
									</c:choose>
								</div>
								<span><bean:message bundle="third-mall"
										key="thirdMallAuthorize.xform.desc" /></span>
								<c:if test="${__fdMallEnable=='1'}">
									<div>
										<a href="#" style="text-decoration: underline; color: blue"
											onclick="enterTemplateConf()"><bean:message
												bundle="third-mall" key="thirdMall.config.into.xform" />></a>
									</div>
								</c:if>
							</div>
						</div>
					</div>
					<div class="luiMallCardItem">
						<div class="luiMallCardItemWrap">
							<div class="luiMallCardIcon"></div>
							<c:set var="active" value="" />
							<c:if
								test="${__fdMallEnable=='1' && fn:contains(__fdBusKeys,'sys_portal')}">
								<c:set var="active" value="active" />
							</c:if>
							<div class="luiMallCardDetail ${active}">
								<div>
									<p>
										<bean:message bundle="third-mall"
											key="thirdMallAuthorize.portal.name" />
									</p>
									<c:choose>
										<c:when
											test="${__fdMallEnable=='1' && fn:contains(__fdBusKeys,'sys_portal')}">
											<span><bean:message bundle="third-mall"
													key="thirdMallAuthorize.opened" /></span>
										</c:when>
										<c:otherwise>
											<span><bean:message bundle="third-mall"
													key="thirdMallAuthorize.closed" /></span>
										</c:otherwise>
									</c:choose>
								</div>
								<span><bean:message bundle="third-mall"
										key="thirdMallAuthorize.portal.desc" /></span>
							</div>
						</div>
					</div>
					<div class="luiMallCardItem">
						<div class="luiMallCardItemWrap">
							<div class="luiMallCardIcon"></div>
							<div class="luiMallCardDetail">
								<div>
									<p>
										<bean:message bundle="third-mall"
											key="thirdMallAuthorize.material.name" />
									</p>
									<span><bean:message bundle="third-mall"
											key="thirdMallAuthorize.closed" /></span>
								</div>
								<span><bean:message bundle="third-mall"
										key="thirdMallAuthorize.material.desc" /></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</template:replace>
</template:include>
<script>
	seajs.use(['lui/dialog','lui/jquery'], function(dialog,$) {
		window.enableMall = function(){
			var url = "${KMSS_Parameter_ContextPath}third/mall/thirdMallAuthorize.do?method=authorize";
			Com_OpenWindow(url,'blank');
		}
		window.onMallChange = function(){
			var url = "${KMSS_Parameter_ContextPath}third/mall/thirdMallAuthorize.do?method=authorize";
			Com_OpenWindow(url,'blank');
		}
		window.onMallClose = function(){
			dialog.confirm('<bean:message bundle="third-mall" key="thirdMall.config.close.confirm" />', function(value){
				if(!value){
					return;
				}
				var datas = {};
				$.ajax({
		            type: "post", 
		            url: "${LUI_ContextPath}/third/mall/thirdMallAuthorize.do?method=disableMall", 
		            dataType: "json",
		            data:datas,
		            success: function (data) {
		            	if(data && data.errcode==0){
		            		dialog.success('<bean:message key="return.optSuccess" />');
		            		//window.location='${LUI_ContextPath}/sys/profile/index.jsp#integrate/saas/mall';
		            		location.reload();
		            	}else{
		            		dialog.failure('<bean:message key="return.optFailure" />');
		            	}
		            },
		            error: function(data){
						dialog.failure('<bean:message key="return.optFailure" />');
					}
				});
			});
			
		}
		
		window.enterTemplateConf = function() {
			window.location='${LUI_ContextPath}/sys/profile/moduleindex.jsp?nav=/km/review/tree.jsp';
		}
	});
	
</script>