<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view">
	<template:replace name="title">
		<c:out value="${ lfn:message('km-asset:module.km.asset') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<script>
		seajs.use([ 'lui/jquery','lui/parser','lui/dialog'],function($,parser,dialog) {
			window.deleteDoc = function(delUrl){
				dialog.confirm('<bean:message key="page.comfirmDelete"/>',function(isOk){
					if(isOk){
						Com_OpenWindow(delUrl,'_self');
					}
				});
			}
			
			window.viewTask = function(fdTaskId){
				window.open('<c:url value="/km/asset/km_asset_apply_task/kmAssetApplyTask.do" />?method=view&fdId='+fdTaskId,"_blank");
			}
			
		});
		</script>
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<c:if test="${kmAssetApplyInventoryForm.docStatus=='10' || kmAssetApplyInventoryForm.docStatus=='11'|| kmAssetApplyInventoryForm.docStatus=='20'}">
			    <kmss:auth requestURL="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=edit&fdId=${param.fdId}" requestMethod="GET">
			      <ui:button text="${ lfn:message('button.edit') }" order="2" 
								onclick="Com_OpenWindow('kmAssetApplyInventory.do?method=edit&fdId=${JsParam.fdId}','_self');">
				  </ui:button>
			    </kmss:auth>
			 </c:if>  
			 <kmss:auth requestURL="/km/asset/km_asset_apply_inventory/kmAssetApplyInventory.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
				 <ui:button text="${ lfn:message('button.delete') }" order="2" 
								onclick="deleteDoc('kmAssetApplyInventory.do?method=delete&fdId=${JsParam.fdId}');">
				  </ui:button>
			</kmss:auth> 
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:combin ref="menu.path.category">
			<ui:varParams  moduleTitle="${ lfn:message('km-asset:module.km.asset') }" 
			    modulePath="/km/asset/" 
				modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" 
			    autoFetch="false" 
			    href="/km/asset/#j_path=/kmAssetInventory_my" 
				categoryId="${kmAssetApplyInventoryForm.fdApplyTemplateId}" />
		</ui:combin>
	</template:replace>
	<template:replace name="content">
		<p class="txttitle">${txttitle}</p>
		<div class="lui_form_content_frame">
		<table class="tb_normal" width=100%>
			<tr>
				<!--标题-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.docSubject" /></td>
				<td colspan="5"><xform:text property="docSubject"
					style="width:85%" /></td>
			</tr>
			<tr>
				<!--所属模板 -->
					<td class="td_normal_title" width=15%><bean:message
						bundle="km-asset" key="kmAssetApplyBase.fdApplyCategory" /></td>
					<td width="25%">
					  <c:out value="${kmAssetApplyInventoryForm.fdApplyTemplateName}"/></td>
					<!--申请单编号 -->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdNo" /></td>
				    <td colspan="3"><xform:text property="fdNo" style="width:35%" />
				</td>
			</tr>
			<tr>
				<!--申请人-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdCreator" /></td>
				<td width="25%"><c:out
					value="${kmAssetApplyInventoryForm.fdCreatorName}" /></td>				
			   <!--申请部门-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdDept" /></td>
				<td width="15%"><c:out
					value="${kmAssetApplyInventoryForm.fdDeptName}" /></td>
				<!--申请日期-->
				<td class="td_normal_title" width=15%><bean:message
					bundle="km-asset" key="kmAssetApplyBase.fdCreateDate" /></td>
				<td width="15%"><xform:datetime property="fdCreateDate" dateTimeType="datetime" /></td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdTask"/>
				</td>
				<td colspan="5">
					<a style="color: #30abe4;" href="javascript:void(0);" onclick="viewTask('${kmAssetApplyInventoryForm.fdTaskId}')"><c:out value="${kmAssetApplyInventoryForm.fdTaskName}"/></a>
				</td>
			</tr>
			<tr>
				<td width="100%" colspan="6">
					<table class="tb_normal" width=100%>
						<tr>
							<td class="td_normal_title" align="center" width=5%>
								<bean:message key="page.serial"/>
							</td>
							<!-- 资产编码 -->
							<td  class="td_normal_title" align="center" width="10%"> 
								<bean:message bundle="km-asset" key="kmAssetCard.fdCode"/>
							</td>
							<!-- 资产名称-->
							<td class="td_normal_title" align="center" width=15%">
								<bean:message bundle="km-asset" key="kmAssetCard.fdName"/>
							</td>
							<!-- 责任人 -->
							<td class="td_normal_title" align="center" width="10%">
								<bean:message bundle="km-asset" key="kmAssetCard.fdResponsiblePerson"/>
							</td>
							<td class="td_normal_title" align="center" width=15%>
								<bean:message bundle="km-asset" key="kmAssetCard.fdAssetAddress"/>
							</td>
							<td class="td_normal_title" align="center" width=15%>
								<bean:message bundle="km-asset" key="kmAssetCard.docDept"/>
							</td>
							<td class="td_normal_title" align="center" width=10%>
								<bean:message bundle="km-asset" key="kmAssetCard.fdAssetStatus"/>
							</td>
							<td class="td_normal_title" align="center" width=25%>
								<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdText"/>
							</td>
						</tr>
						<c:forEach items="${kmAssetApplyInventoryForm.fdDetail_Form}" var="kmAssetApplyInventoryDetailForm" varStatus="vstatus">
							<tr>
								<td align="center">
									${vstatus.index+1}
								</td>
								<!-- 资产编码 -->
								<td align="center"> 
									<c:out value="${kmAssetApplyInventoryDetailForm.fdAssetCardCode }"/>
								</td>
								<!-- 资产名称-->
								<td align="center" >
									<c:out value="${kmAssetApplyInventoryDetailForm.fdAssetCardName }"/>
								</td>
								<!-- 责任人 -->
								<td align="center" >
									<xform:address propertyId="fdDetail_Form[${vstatus.index}].fdResponsiblePersonId" propertyName="fdDetail_Form[${vstatus.index}].fdResponsiblePersonName" orgType="ORG_TYPE_PERSON" style="width:85%" idValue="${kmAssetApplyInventoryDetailForm.fdResponsiblePersonId}" nameValue="${kmAssetApplyInventoryDetailForm.fdResponsiblePersonName}"/>
								</td>
								<td align="center">
								<xform:select property="fdDetail_Form[${vstatus.index}].fdAssetAddressId" value="${kmAssetApplyInventoryDetailForm.fdAssetAddressId}">
									<xform:beanDataSource serviceBean="kmAssetAddressService" selectBlock="fdId,fdAddress" orderBy="fdOrder" />
								</xform:select>
								</td>
								<td align="center">
									<xform:address propertyId="fdDetail_Form[${vstatus.index}].docDeptId" propertyName="fdDetail_Form[${vstatus.index}].docDeptName" orgType="ORG_TYPE_DEPT" style="width:85%" idValue="${kmAssetApplyInventoryDetailForm.docDeptId }" nameValue="${kmAssetApplyInventoryDetailForm.docDeptName }"/>
								</td>
								<td align="center">
									<xform:select property="fdDetail_Form[${vstatus.index}].fdAssetStatus" showPleaseSelect="true">
										<xform:enumsDataSource enumsType="kmAssetCard_fdAssetStatus" />
									</xform:select>
								</td>
								<td align="center">
									<xform:text property="fdDetail_Form[${vstatus.index}].fdText" style="width:85%" />
								</td>
							</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.attachMent" />
				</td>
				<td colspan="5">
					<c:import url="/sys/attachment/sys_att_main/sysAttMain_view.jsp" charEncoding="UTF-8">
						<c:param name="fdKey" value="attachment" />
						<c:param name="fdModelId" value="${param.fdId }" />
						<c:param name="fdModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyInventory" />
					</c:import>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title">
					<bean:message bundle="km-asset" key="kmAssetApplyInventory.fdDescription"/>
				</td>
				<td colspan="5">
					<xform:textarea property="fdDescription" style="width:95%" />
				</td>
			</tr>
		</table>
		</div>
		<ui:tabpage expand="false">
			<c:import url="/sys/workflow/import/sysWfProcess_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyInventoryForm" />
				<c:param name="fdKey" value="KmAssetApplyInventoryDoc" />
			</c:import>
			<c:import url="/sys/right/import/right_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyInventoryForm" />
				<c:param name="moduleModelName" value="com.landray.kmss.km.asset.model.KmAssetApplyInventory" />
			</c:import>
			<c:import url="/sys/readlog/import/sysReadLog_view.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmAssetApplyInventoryForm" />
			</c:import>
		</ui:tabpage>
	</template:replace>
	<template:replace name="nav">
		<c:import url="/sys/relation/import/sysRelationMain_view.jsp" charEncoding="UTF-8">
			<c:param name="formName" value="kmAssetApplyInventoryForm" />
		</c:import>
	</template:replace>
</template:include>