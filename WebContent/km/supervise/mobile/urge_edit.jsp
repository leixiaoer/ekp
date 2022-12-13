<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title">
		<bean:message bundle="km-supervise" key="py.CuiBan" />
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-view.css"/>
	</template:replace>
	<template:replace name="content">
		<html:form action="/km/supervise/km_supervise_urge/kmSuperviseUrge.do">
			<div>
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
					<div class="muiFlowInfoW muiFormContent">
						<table class="muiSimple" cellpadding="0" cellspacing="0">
                             <tr>
                                <td class="muiTitle">
                                    <bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyPersons" />
                                </td>
                                <td>
									<xform:checkbox property="fdNotifyPersons" showStatus="edit" required="true" mobile="true">
										<xform:simpleDataSource value="10"><bean:message key="kmSuperviseUrge.fdLeads" bundle="km-supervise"/></xform:simpleDataSource>
										<xform:simpleDataSource value="20"><bean:message key="kmSuperviseUrge.fdSponsor" bundle="km-supervise"/></xform:simpleDataSource>
										<xform:simpleDataSource value="30"><bean:message key="kmSuperviseUrge.current.task.fdSponsor" bundle="km-supervise"/></xform:simpleDataSource>
										<c:if test="${kmSuperviseUrgeForm.fdSysUnitEnable eq 'true'}">
											<xform:simpleDataSource value="40"><bean:message key="kmSuperviseUrge.fdSysUnit" bundle="km-supervise"/></xform:simpleDataSource>
										</c:if>
									</xform:checkbox>
                                </td>
                            </tr>
                            
                            <tr>
                                <td class="muiTitle">
                                	<bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyType"/>
                                </td>
                                <td>
									<kmss:editNotifyType property="fdNotifyType"  mobile="true"/>
                                </td>
                            </tr>
                            
                            <tr>
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseUrge.fdNotifyMessage"/>
								</td>
								<td>
									<xform:textarea property="fdNotifyMessage" style="width:95%;" mobile="true" required="true" showStatus="edit" validators="maxLength(1500)" placeholder="请输入您的催办意见"></xform:textarea>
								</td>
							</tr>
						</table>
					</div>
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" >
						<li data-dojo-type="mui/tabbar/TabBarButton"
							onclick="clickOk();"><bean:message key="button.ok"/></li>
					</ul>
				</div>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmSuperviseUrgeForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
				         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
							window.clickOk = function(){
								var validorObj = registry.byId('scrollView');
								if(!validorObj.validate()){
									return;
								}
								var formObj = document.kmSuperviseUrgeForm;
								Com_Submit(formObj, "urgeSupervise");
							};
					});
				</script>
				
				
			</div>
		</html:form>
	</template:replace>
</template:include>
