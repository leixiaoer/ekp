<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:table.kmSuperviseBack') }
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-edit.css"/>
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_back/kmSuperviseBack.do">
		
			<div data-dojo-type="mui/view/DocScrollableView" 
						data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
						<div class="muiFlowInfoW muiFormContent">
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseBack.suoShuJieDuan')}
									</td>
									<td>
										<xform:config  orient="none">
											<xform:datetime property="fdStartTime" showStatus="edit" mobile="true" required="true" subject="${lfn:message('km-supervise:mobile.startTime')}"/>
										</xform:config>&nbsp;
										<bean:message bundle="km-supervise" key="kmSuperviseBack.suoShuJieDuan.to" />&nbsp;
										<xform:config  orient="none">
											<xform:datetime property="fdEndTime" showStatus="edit" mobile="true" required="true" subject="${lfn:message('km-supervise:mobile.endTime')}"/>
										</xform:config>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseBack.fdRequire')}
									</td>
									<td>
										<xform:config  orient="none">
											<xform:textarea property="fdRequire" mobile="true" showStatus="edit"/>
										</xform:config>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseBack.fdResult')}
									</td>
									<td>
										<xform:config  orient="none">
											<xform:textarea property="fdResult" mobile="true" showStatus="edit"/>
										</xform:config>
									</td>
								</tr>
								<tr>
									<td class="muiTitle">
										${lfn:message('km-supervise:kmSuperviseBack.attBack')}
									</td>
									<td>
										<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
											<c:param name="fdKey" value="attBack" />
											<c:param name="formName" value="kmSuperviseBackForm" />
											<c:param name="fdMulti" value="true" />
										</c:import>
									</td>
								</tr>
								
							</table>
							
						</div>
						<div class="muiProgressBox">
							<input data-dojo-type="dojox/mobile/Slider" 
								data-dojo-mixins="km/supervise/mobile/resource/js/_ProgressSliderMixin"
								data-dojo-props="valueText:0" value="${kmSuperviseBackForm.fdProgress }"
								id="fdProgress" name="fdProgress" class="progress"/>
						</div>
								
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom" data-dojo-props='fill:"grid"'>
					
					<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnSubmit" 
						data-dojo-props='colSize:1,href:"javascript:submitForm();"'>${lfn:message('button.update')}</li>
					
				</ul>
			</div>
			<html:hidden property="fdId" value="${param.fdId }"/>
  			<html:hidden property="fdBackId" value="${kmSuperviseBackForm.fdId }" />
		    <html:hidden property="method_GET" />
		    <html:hidden property="fdSuperviseId" value="${fdSuperviseId }"/>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>

<script type="text/javascript">
	require(["mui/form/ajax-form!kmSuperviseBackForm"]);
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
			if(!checkFinishTime()){
				return;
			}
			Com_Submit(document.forms[0],'save');
		/* 	dojo.xhrPost({
			  	url: '${LUI_ContextPath}/km/supervise/km_supervise_back/kmSuperviseBack.do?method=save',
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
		};
		window.checkFinishTime = function(){
			var fdStartTime = query('[name="fdStartTime"]')[0].value;
			var fdEndTime = query('[name="fdEndTime"]')[0].value;
			if(new Date(fdStartTime.replace(/\-/g, '/')) >= new Date(fdEndTime.replace(/\-/g, '/'))){
				Tip.fail({
					text : "${lfn:message('km-supervise:mobile.validation.tip4')}"
				});
				return false;
			}
			return true;
		};

		
	});
	

</script>