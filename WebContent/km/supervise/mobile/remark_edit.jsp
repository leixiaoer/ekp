<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:py.DuBanCheXiao') }
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-edit.css"/>
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_main/kmSuperviseMain.do">
		
			<html:hidden property="fdId" />
			<html:hidden property="method_GET" />
		
			<div data-dojo-type="mui/view/DocScrollableView" 
						data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
						<div class="muiFlowInfoW muiFormContent">
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSupervise.items')}
									</td>
									<td>
										<xform:text property="docSubject"></xform:text>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseMain.fdRepealer')}
									</td>
									<td>
										<html:hidden property="fdOperatorId" /> 
										<xform:text property="fdOperatorName" />
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseMain.fdRepealOrg')}
									</td>
									<td>
										<xform:address propertyName="fdOperatorUnitName" propertyId="fdOperatorUnitId" showStatus="edit" orgType="ORG_TYPE_ORGORDEPT" mobile="true"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseMain.fdRepealTime')}
									</td>
									<td>
										<xform:datetime property="fdRepealTime" dateTimeType="date"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseMain.fdRepealDesc')}
									</td>
									<td>
										<xform:textarea property="fdRepealDesc" showStatus="edit" mobile="true"/>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseMain.attFinish')}
									</td>
									<td>
										<c:import
											url="/sys/attachment/mobile/import/edit.jsp"
											charEncoding="UTF-8">
											<c:param name="formName" value="kmSuperviseMainForm"></c:param>
											<c:param name="fdKey" value="attRepeal" />
											<c:param name="fdMulti" value="true" />
										</c:import>
									</td>
								</tr>
								
							</table>
							
						</div>
						<div class="muiProgressBox">
						<%-- 进度 --%>
							<input data-dojo-type="dojox/mobile/Slider" 
								data-dojo-mixins="km/supervise/mobile/resource/js/_ProgressSliderMixin"
								data-dojo-props="valueText:${kmSuperviseMainForm.fdSuperviseProgress }"
								id="fdSuperviseProgress" name="fdProgress" class="progress"/>
						</div>
								
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
					
					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
						data-dojo-props='colSize:1,href:"javascript:submitForm();"'>提交</li>
					
				</ul>
			</div>

		</html:form>
		</xform:config>
	</template:replace>
</template:include>

<script type="text/javascript">
	require(["mui/form/ajax-form!kmSuperviseMainForm"]);
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
		
		//校验对象
		var validorObj = null;
		
		//防止重复提交
		var isSubmit = false;
		
		ready(function(){
			validorObj = registry.byId('scrollView');
		});
		
		window.submitForm = function(){
			
			if(!validorObj.validate()){
				return;
			}
			Com_Submit(document.forms[0],'saveAddFinish'); 
			/* if(!isSubmit){
				isSubmit = true;
			}else{
				return ;
			}

			dojo.xhrPost({
			  	url: '${LUI_ContextPath}/km/supervise/km_supervise_main/kmSuperviseMain.do?method=saveAddFinish',
				form: document.forms[0],
				load: function(data){
					Tip.success({
						text: '操作成功!',
						callback: function(){
							history.back();
						}
					});
				},
				error: function(error){
					alert(error);
				}
			}); */
		}

		
	});
	

</script>