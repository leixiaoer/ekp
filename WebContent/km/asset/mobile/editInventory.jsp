<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/mobile/jsp/ajax-accept.jsp" %>
<template:include ref="mobile.edit" compatibleMode="true" >
	<template:replace name="title">
		<c:if test="${empty  kmAssetApplyInventoryForm.docSubject}">
			<c:out value="${lfn:message('km-asset:table.kmAssetApplyInventory.create') }"></c:out>
		</c:if>
		<c:out value="${kmAssetApplyInventoryForm.docSubject}"></c:out>
	</template:replace>
	<template:replace name="head">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sys/attend/map/mobile/resource/css/location.css?s_cache=${MUI_Cache}"></link>
	</template:replace>
	<template:replace name="content">
	<xform:config orient="vertical">
		<html:form action="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=save">
			<div data-dojo-type="mui/view/DocScrollableView" data-dojo-mixins="mui/form/_ValidateMixin" id="scrollView">
				<div data-dojo-type="mui/panel/AccordionPanel">
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-asset" key="kmAsset.config.base"/>',icon:'mui-ul'">
						<div class="muiFormContent">
							<html:hidden property="fdAssetCardId" />
							<html:hidden property="fdAssetCardName" />
							<html:hidden property="fdId" />
							<html:hidden property="docStatus" />
							<html:hidden property="method_GET" />
							<html:hidden property="fdCreatorId" />
							<html:hidden property="fdDeptId" />
							<html:hidden property="docStatus" />
							<html:hidden property="docCreatorId" />
							<html:hidden property="docCreateTime" />
							<html:hidden property="fdTaskId" />
							<html:hidden property="fdTaskDetailRef" />
							<html:hidden property="fdAssetCardId" />
							<html:hidden property="fdApplyTemplateId"/>
							<html:hidden property="fdApplyTemplateName" />
							<html:hidden property="titleRegulation" />
							<table class="muiSimple" cellpadding="0" cellspacing="0">
								<tr>
									<td>
										<c:if test="${kmAssetApplyInventoryForm.titleRegulation==null || kmAssetApplyInventoryForm.titleRegulation=='' }">
											<xform:text property="docSubject" style="width:97%" required="true"/>
										</c:if>
										<c:if test="${kmAssetApplyInventoryForm.titleRegulation!=null && kmAssetApplyInventoryForm.titleRegulation!='' }">
											<xform:text property="docSubject" style="width:97%" showStatus="readOnly" value="${lfn:message('km-asset:kmAssetApplyBase.docSubject.info') }" />
										</c:if>
									</td>
								</tr>
									<td>
										<xform:text property="fdTaskName" showStatus="view" mobile="true" subject="${lfn:message('km-asset:kmAssetApplyInventory.fdTask') }"/>
									</td>
							</table>
						</div>
					</div>
					<div data-dojo-type="mui/panel/Content" data-dojo-props="title:'<bean:message  bundle="km-asset" key="kmAssetCard.config.base"/>',icon:'mui-ul'">
						<div class="muiFormContent">
							<table class="muiSimple" cellpadding="0" cellspacing="0">
							<tr>
								<td>
								<html:hidden property="fdDetail_Form[0].fdId" value="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdId}"/>
								<html:hidden property="fdDetail_Form[0].fdTaskDetailRef" value="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdTaskDetailRef}"/>
								<html:hidden property="fdDetail_Form[0].fdAssetCardId" value="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdAssetCardId}"/>
								<xform:text property="fdDetail_Form[0].fdAssetCardCode" value="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdAssetCardCode}" showStatus="view" mobile="true" subject="${lfn:message('km-asset:kmAssetCard.fdCode') }"/>
								</td>
							</tr>
							<tr>
								<td>
								<xform:text property="fdDetail_Form[0].fdAssetCardName" value="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdAssetCardName}" showStatus="view" mobile="true"  subject="${lfn:message('km-asset:kmAssetCard.fdName') }"/>
								</td>
							</tr>
							<tr>
								<td>
								<xform:address isLoadDataDict="false" mobile="true" subject="${lfn:message('km-asset:kmAssetApplyChangeList.fdResponsiblePerson') }" propertyId="fdDetail_Form[0].fdResponsiblePersonId" propertyName="fdDetail_Form[0].fdResponsiblePersonName" idValue="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdResponsiblePersonId}" nameValue="${kmAssetApplyInventoryForm.fdDetail_Form[0].fdResponsiblePersonName}" orgType='ORG_TYPE_PERSON' htmlElementProperties=""></xform:address>
								</td>
							</tr>
							<tr>
								<td>
								<xform:select property="fdDetail_Form[0].fdAssetAddressId" mobile="true" subject="${lfn:message('km-asset:kmAssetApplyTask.fdAssetAddress') }">
											<xform:beanDataSource serviceBean="kmAssetAddressService" selectBlock="fdId,fdAddress" orderBy="fdOrder" />
								</xform:select>
								</td>
							</tr>
							<tr>
								<td>
								<xform:address isLoadDataDict="false" mobile="true" subject="${lfn:message('km-asset:kmAssetApplyChangeList.fdNewDept') }" propertyId="fdDetail_Form[0].docDeptId" propertyName="fdDetail_Form[0].docDeptName" idValue="${kmAssetApplyInventoryForm.fdDetail_Form[0].docDeptId}" nameValue="${kmAssetApplyInventoryForm.fdDetail_Form[0].docDeptName}" orgType='ORG_TYPE_DEPT'></xform:address>
								</td>
							</tr>
							<tr>
								<td>
									<xform:select property="fdDetail_Form[0].fdAssetStatus" showStatus="edit" style="width:100%" mobile="true" subject="${lfn:message('km-asset:kmAssetCard.fdAssetStatus') }">
			                    	 <xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus"/>
			                  		 </xform:select>
								</td>
							</tr>
							<tr>
								<td>
								<xform:text property="fdDetail_Form[0].fdText" mobile="true"/>
								</td>
							</tr>
							
							<tr>
							    <td>
								    <c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
										<c:param name="formName" value="kmAssetApplyInventoryForm"></c:param>
										<c:param name="fdKey" value="attachment"></c:param>
									</c:import>
							    </td>
							</tr>
							<tr>
								<td>
								<xform:textarea property="fdDescription" mobile="true"  subject="${lfn:message('km-asset:kmAssetCard.fdContent') }"></xform:textarea>
								</td>
							</tr>
							</table>
						</div>
					</div>
				</div>
				<ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
				  	
				   	<li data-dojo-type="mui/tabbar/TabBarButton" class="muiBtnNext " 
				  		data-dojo-props='colSize:2,moveTo:"lbpmView",transition:"slide"'><bean:message bundle="km-asset" key="button.next" /></li>
				   	
				</ul>
			</div>
			<c:import url="/sys/lbpmservice/mobile/import/edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyInventoryForm" />
				<c:param name="fdKey" value="KmAssetApplyInventoryDoc" />
				<c:param name="viewName" value="lbpmView" />
				<c:param name="backTo" value="scrollView" />
				<c:param name="onClickSubmitButton" value="commitMethod('save');" />
			</c:import>
					<script type="text/javascript">
					require(['dojo/topic',
					         'dojo/ready',
					         'dijit/registry',
					         'dojox/mobile/TransitionEvent',
					         "mui/util", 
					         'mui/device/adapter',
					         'mui/form/ajax-form!kmAssetApplyInventoryForm'
					         ],function(topic,ready,registry,TransitionEvent,util,adapter){
							 var validorObj=null;
							ready(function(){
								validorObj=registry.byId('scrollView');
							});
							function _validate(){
								var result=validorObj.validate();
								return result;
								}
							window.commitMethod=function(method,saveDraft){
								var docStatus = document.getElementsByName("docStatus")[0];
								if (saveDraft != null && saveDraft == 'true'){
									docStatus.value = "10";
								} else {
									docStatus.value = "20";
								}
								if( _validate()){
								   if(method == 'save')
									   Com_Submit(document.forms[0],'save');
								   else if(method == 'update')
									   Com_Submit(document.forms[0],'update');
								} 
							};
						window.openDeatailCardView = function(obj){
							var opts = {
									transition : 'slide',
									transitionDir:1,
									moveTo:'cardDetailInfoView'
								};
								new TransitionEvent(obj, opts).dispatch();
						}
						window.backToDocView=function(obj){
							var opts = {
								transition : 'slide',
								transitionDir:-1,
								moveTo:'scrollView'
							};
							new TransitionEvent(obj, opts).dispatch();
						}
						
						window.choseTask=function(obj){
							$(".mblListItemLabel").html($(obj).html());
							$("input[name='fdTaskId']").val($(obj).attr("id"));
							backToDocView(document.getElementsByName("basicInfoHeaderBack")[0]);
						}
						
					});
					</script>
		</html:form>
		</xform:config>
	</template:replace>
</template:include>
