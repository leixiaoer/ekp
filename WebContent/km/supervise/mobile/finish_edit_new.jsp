<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<template:include ref="mobile.edit" compatibleMode="true" newMui="true">
	<template:replace name="title" >
		${ lfn:message('km-supervise:py.DuBanBanJie') }
	</template:replace>
	<template:replace name="head">
		<mui:min-file name="mui-supervise-edit.css"/>
		<script type="text/javascript">
		   	require(["dojo/store/Memory","dojo/topic","dijit/registry"],function(Memory,topic,registry){
		   		var navData = [{'text':'01  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.info" />',
		   			'moveTo':'scrollView','selected':true},{'text':'02  /  <bean:message bundle="km-supervise" key="mui.kmSupervise.mobile.review" />',
			   		'moveTo':'lbpmView'}]
		   		window._narStore = new Memory({data:navData});
		   		var changeNav = function(view){
		   			var wgt = registry.byId("_flowNav");
		   			for(var i=0;i<wgt.getChildren().length;i++){
		   				var tmpChild = wgt.getChildren()[i];
		   				if(view.id == tmpChild.moveTo){
		   					tmpChild.beingSelected(tmpChild.domNode);
		   					return;
		   				}
		   			}
		   		}
		   		topic.subscribe("mui/form/validateFail",function(view){
		   			changeNav(view);
		   		});
				topic.subscribe("mui/view/currentView",function(view){
					changeNav(view);
		   		});
		   	});
	   </script>
	</template:replace>
	<template:replace name="content">
		<xform:config orient="vertical">
		<html:form action="/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do">
			<div>
				<div data-dojo-type="mui/fixed/Fixed" class="muiFlowEditFixed">
					<div data-dojo-type="mui/fixed/FixedItem" class="muiFlowEditFixedItem">
						<div data-dojo-type="mui/nav/NavBarStore" id="_flowNav" data-dojo-props="store:_narStore">
						</div>
					</div>
				</div>
			
				<div data-dojo-type="mui/view/DocScrollableView" 
					data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
					<div class="muiFlowInfoW muiFormContent">
						<html:hidden property="fdId" />
						<html:hidden property="docSubject" />
					    <html:hidden property="fdMainId" />
					    <html:hidden property="docStatus" />
					    <html:hidden property="method_GET" />
						<table class="muiSimple" cellpadding="0" cellspacing="0">
						<!-- 办结人 -->
							<tr>
								<td>
									<xform:address propertyName="fdOperatorName" propertyId="fdOperatorId" showStatus="readOnly" required="true" subject="${lfn:message('km-supervise:kmSuperviseMainFinish.fdOperator') }" mobile="true"/>
								</td>
							</tr>
							
							<!-- 办结日期 -->
							<tr>
								<td >
									<xform:datetime property="fdRealFinishTime" showStatus="edit" required="true" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMainFinish.fdRealFinishTime') }" />
								</td>
							</tr>
							
							<!-- 办结情况 -->
							<tr>
								<td>
									<xform:textarea property="fdFinishDesc" style="width:90%;"
										required="true" showStatus="edit" validators="maxLength(1500)" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseMainFinish.fdFinishDesc') }"></xform:textarea>
								</td>
							</tr>
									
							<tr>
								<td>
									<span style="margin-right: 0.3rem;color: #999;font-size: 1.3rem;">
										<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
									</span>
									<c:import
										url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmSuperviseMainFinishForm"></c:param>
										<c:param name="fdKey" value="attFinish" />
										<c:param name="fdMulti" value="true" />
									</c:import>
								</td>
							</tr>
						</table>
						
					</div>
					<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
					  	<li data-dojo-type="mui/tabbar/TabBarButton"
					  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'>
					  		<bean:message  bundle="km-supervise"  key="button.next" /></li>
					</ul>
				</div>
				<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
					<c:param name="formName" value="kmSuperviseMainFinishForm" />
					<c:param name="fdKey" value="kmSuperviseSetup" />
					<c:param name="viewName" value="lbpmView" />
					<c:param name="backTo" value="scrollView" />
					<c:param name="onClickSubmitButton" value="finish_submit();" />
				</c:import>
				<script type="text/javascript">
					require(["mui/form/ajax-form!kmSuperviseMainFinishForm"]);
					require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
				         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip'], 
						function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip){
							window.finish_submit = function(){
								var validorObj = registry.byId('scrollView');
								if(!validorObj.validate()){
									return;
								}
								var status = document.getElementsByName("docStatus")[0];
								var method = Com_GetUrlParameter(location.href,'method');
								query('[name="docStatus"]').val('20');
								if(method=='add'){
									Com_Submit(document.forms[0],'save');
								}else{
									Com_Submit(document.forms[0],'update');
								}
							};
					});
				</script>
			</div>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>