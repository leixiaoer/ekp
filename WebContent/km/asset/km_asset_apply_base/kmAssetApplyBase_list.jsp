<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.util.UserUtil"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%-- <%@include file="kmAssetBaseForSearch_condition.jsp" %> --%>
<template:include file="/sys/profile/resource/template/list.jsp">
	<template:replace name="title">${ lfn:message('km-asset:module.km.asset') }</template:replace>

	<template:replace name="content">
		<list:criteria id="applycriteria">
			<list:cri-ref key="docSubject" ref="criterion.sys.docSubject">
			</list:cri-ref>
			<%-- <list:cri-ref ref="criterion.sys.category" key="fdApplyTemplate"
				multi="false"
				title="${ lfn:message('km-asset:kmAssetApplyBase.nav.fdApplyTemplate')}"
				expand="true">
				<list:varParams
					modelName="com.landray.kmss.km.asset.model.KmAssetApplyTemplate" />
			</list:cri-ref> --%>
			<list:cri-criterion
				title="${ lfn:message('km-asset:kmAssetApply.my')}" key="mydoc"
				multi="false">
				<list:box-select>
					<list:item-select>
						<ui:source type="Static">
							[{text:'${ lfn:message('km-asset:kmAssetApply.create.my') }', value:'create'},{text:'${ lfn:message('km-asset:kmAssetApply.approval.my') }',value:'approval'}, {text:'${ lfn:message('km-asset:kmAssetApply.approved.my') }', value: 'approved'}]
						</ui:source>
					</list:item-select>
				</list:box-select>
			</list:cri-criterion>
			<list:cri-auto
				modelName="com.landray.kmss.km.asset.model.KmAssetApplyBase"
				property="docStatus;fdNo;fdCreator;fdDept;fdCreateDate" />
		</list:criteria>

		<div class="lui_list_operation">
			<div style='color: #979797; float: left; padding-top: 1px;'>${ lfn:message('list.orderType') }：
			</div>
			<div style="float: left">
				<div style="display: inline-block; vertical-align: middle;">
					<ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
					<list:sortgroup>
						<list:sort property="fdCreateDate"
							text="${ lfn:message('km-asset:kmAssetApplyBase.fdCreateDate')}"
							group="sort.list" value="down"></list:sort>
						<list:sort property="docPublishTime"
							text="${ lfn:message('km-asset:kmAssetApplyBase.docPublishTime')}"
							group="sort.list"></list:sort>
					</list:sortgroup>
					</ui:toolbar>
				</div>
			</div>
			<div style="float: left;">
				<list:paging layout="sys.ui.paging.top">
				</list:paging>
			</div>
			<div style="float: right">
				<div style="display: inline-block; vertical-align: middle;">

					<ui:toolbar id="Btntoolbar" count='4'>
						<%-- <kmss:authShow 	roles="ROLE_KMASSETAPPLY_CREATE">
							 <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" ></ui:button>
							</kmss:authShow> --%>
						<!-- 新增 -->
						<c:if
							test="${param.categoryId==null || param.nodeType=='CATEGORY'}">
							<kmss:authShow roles="ROLE_KMASSETAPPLY_CREATE">
								<ui:button text="${lfn:message('button.add')}"
									onclick="addByApplyTemplate();">
								</ui:button>
							</kmss:authShow>
						</c:if>
						<c:if test="${param.nodeType=='TEMPLATE'}">
							<kmss:auth
								requestURL="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=add&fdTemplateId=${param.categoryId}"
								requestMethod="GET">
								<ui:button text="${lfn:message('button.add')}"
									onclick="addByApplyTemplate();">
								</ui:button>
							</kmss:auth>
						</c:if>
						<kmss:auth
							requestURL="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&categoryId=${param.categoryId}&nodeType=${param.nodeType}&docStatus=${param.docStatus}&mydoc=${param.mydoc }">
							<ui:button id="del" text="${lfn:message('button.deleteall')}"
								order="3" onclick="delDoc()"></ui:button>
						</kmss:auth>
						<%-- 收藏 --%>
						<c:import url="/sys/bookmark/import/bookmark_bar_all.jsp"
							charEncoding="UTF-8">
							<c:param name="fdTitleProName" value="docSubject" />
							<c:param name="fdModelName"
								value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
						</c:import>
						<%-- 修改权限 --%>
						<c:import url="/sys/right/import/doc_right_change_button.jsp"
							charEncoding="UTF-8">
							<c:param name="modelName"
								value="com.landray.kmss.km.asset.model.KmAssetApplyBase" />
							<c:param name="authReaderNoteFlag" value="2" />
							<c:param name="categoryId" value="${param.categoryId}" />
							<c:param name="nodeType" value="${param.nodeType}" />
						</c:import>
						<!-- 搜素 -->
						<%-- <ui:button text="${lfn:message('button.search')}"
							onclick="Search_Show();"></ui:button> --%>
					</ui:toolbar>
				</div>
			</div>
		</div>
		<input type="hidden" name="fdTemplateId" value="" />
		<input type="hidden" name="fdTemplateName" value="" />
		<ui:fixed elem=".lui_list_operation"></ui:fixed>
		<list:listview>
			<ui:source type="AjaxJson">
					{url:'/km/asset/km_asset_index/kmAssetIndex.do?method=list&q.fdApplyTemplate=${JsParam.categoryId}'}
			</ui:source>
			<list:colTable isDefault="true" layout="sys.ui.listview.columntable"
				rowHref="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=view4Base&fdId=!{fdId}&fdSubclassModelname=!{fdSubclassModelname}">
				<list:col-checkbox></list:col-checkbox>
				<list:col-serial></list:col-serial>
				<list:col-auto
					props="docSubject;fdNo;fdCreator.fdName;fdCreateDate;docStatus;nodeName;handlerName"></list:col-auto>
			</list:colTable>
		</list:listview>
		<br>
		<list:paging></list:paging>
		<%
			request.setAttribute("isAdmin", UserUtil.getKMSSUser().isAdmin());
		%>
		<script type="text/javascript">
			var SYS_SEARCH_MODEL_NAME = "com.landray.kmss.km.asset.model.KmAssetApplyBase";
			Com_IncludeFile("dialog.js|xform.js|doclist.js|jquery.js|common.js");
			//由于分类放在筛选器中，该变量用来记录当前分类id
			var CATEID = "";
			var NODETYPE = "";
			seajs
					.use(
							[ 'lui/jquery', 'lui/util/str', 'lui/dialog',
									'lui/topic', 'lui/toolbar' ],
							function($, strutil, dialog, topic, toolbar) {

								// 监听新建更新等成功后刷新
								topic.subscribe('successReloadPage',
										function() {
											topic.publish('list.refresh');
										});

								//新建
								/* window.addDoc = function(){
									var tempId = "";
										dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
											if(rtn != false&&rtn != null){
												tempId = document.getElementsByName("fdTemplateId")[0].value;
												addByApplyTemplate(tempId);
											}
									   });
								};*/
								
								 window.addByApplyTemplate = function(tempId){
									var tempId = "";
									 if("${JsParam.categoryId}" !=""&&"${JsParam.nodeType}"=='TEMPLATE'){
										  tempId = "${JsParam.categoryId}";
										  addTemplate(tempId);
									}  else{
										dialog.category('com.landray.kmss.km.asset.model.KmAssetApplyTemplate','fdTemplateId','fdTemplateName',false,function(rtn){
											
											 if(rtn != false&&rtn != null){
													tempId = document.getElementsByName("fdTemplateId")[0].value;
													addTemplate(tempId);
												}
									   });
									} 
									
								};   
								
								window.clearAllValue = function() {

									this.location = "${LUI_ContextPath}/km/asset";
								};
								//删除
								window.delDoc = function(draft) {
									var values = [];
									$("input[name='List_Selected']:checked")
											.each(function() {
												values.push($(this).val());
											});
									if (values.length == 0) {
										dialog
												.alert('<bean:message key="page.noSelect"/>');
										return;
									}
									var url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall"/>&categoryId=${param.categoryId}&nodeType=${param.nodeType}';
									if (draft == '0') {
										url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&status=10"/>';
									}
									dialog
											.confirm(
													'<bean:message key="page.comfirmDelete"/>',
													function(value) {
														if (value == true) {
															window.del_load = dialog
																	.loading();

															$
																	.ajax({
																		url : url,

																		type : 'POST',

																		data : $
																				.param(
																						{
																							"List_Selected" : values
																						},
																						true),

																		dataType : 'json',

																		error : function(
																				data) {
																			if (window.del_load != null) {
																				window.del_load
																						.hide();
																			}
																			if(typeof (data.responseText) != 'undefined'){
																				var obj = eval('(' + data.responseText + ')');
																				if(false==obj.status){
																					var msg =obj.message;
																					dialog.failure(msg[0].msg);
																				}else{
																					topic.publish("list.refresh");
																					dialog.result(data);
																				}
																			}else{
																				topic.publish("list.refresh");
																				dialog.result(data);
																			}
																		},

																		success : delCallback

																	});
														}
													});
								};
								window.delCallback = function(data) {
									if (window.del_load != null) {
										window.del_load.hide();
										topic.publish("list.refresh");
									}
									dialog.result(data);
								};
		<%request.setAttribute("admin", UserUtil.getKMSSUser().isAdmin());%>
			var AuthCache = {};
								//根据筛选器分类异步校验权限
								topic
										.subscribe(
												'criteria.changed',
												function(evt) {
													if ("${admin}" == "false") {
														if (LUI('del')) {
															LUI('Btntoolbar')
																	.removeButton(
																			LUI('del'));
															LUI('del')
																	.destroy();
														}
														if (LUI('docChangeRightBatch')) {
															LUI('Btntoolbar')
																	.removeButton(
																			LUI('docChangeRightBatch'));
															LUI(
																	'docChangeRightBatch')
																	.destroy();
														}
													}
													var cateId = "";
													var nodeType = "";
													for (var i = 0; i < evt['criterions'].length; i++) {
														if (evt['criterions'][i].key == "fdApplyTemplate") {
															document
																	.getElementsByName("fdTemplateId")[0].value = evt['criterions'][i].value[0];
															CATEID = evt['criterions'][i].value[0];
															NODETYPE = evt['criterions'][i].nodeType;
															cateId = evt['criterions'][i].value[0];
															nodeType = evt['criterions'][i].nodeType;
															break;
														}
														if (evt['criterions'][i].key == "docStatus"
																&& evt['criterions'][i].value.length == 1) {
															if (evt['criterions'][i].value[0] == '10') {
																var delBtn = toolbar
																		.buildButton({
																			id : 'del',
																			order : '2',
																			text : '${lfn:message("button.delete")}',
																			click : 'delDoc("0")'
																		});
																LUI(
																		'Btntoolbar')
																		.addButton(
																				delBtn);
															}
														}
													}
													if (cateId != "") {
														if (AuthCache[cateId]) {
															//删除按钮
															if (AuthCache[cateId].delBtn) {
																if (!LUI('del')) {
																	var delBtn = toolbar
																			.buildButton({
																				id : 'del',
																				order : '2',
																				text : '${lfn:message("button.delete")}',
																				click : 'delDoc()'
																			});
																	LUI(
																			'Btntoolbar')
																			.addButton(
																					delBtn);
																}
															} else {
																if (LUI('del')) {
																	LUI(
																			'Btntoolbar')
																			.removeButton(
																					LUI('del'));
																	LUI('del')
																			.destroy();
																}
															}
															//批量修改权限按钮
															if (AuthCache[cateId].changeRightBatchBtn) {
																if (!LUI('docChangeRightBatch')) {
																	var changeRightBatchBtn = toolbar
																			.buildButton({
																				id : 'docChangeRightBatch',
																				order : '4',
																				text : '${lfn:message("sys-right:right.button.changeRightBatch")}',
																				click : 'changeRightCheckSelect("'
																						+ cateId
																						+ '","'
																						+ nodeType
																						+ '")'
																			});
																	LUI(
																			'Btntoolbar')
																			.addButton(
																					changeRightBatchBtn);
																}
															} else {
																if (LUI('docChangeRightBatch')) {
																	LUI(
																			'Btntoolbar')
																			.removeButton(
																					LUI('docChangeRightBatch'));
																	LUI(
																			'docChangeRightBatch')
																			.destroy();
																}
															}
														}
														if (AuthCache[cateId] == null) {
															var checkDelUrl = "/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&categoryId="
																	+ cateId
																	+ "&nodeType="
																	+ nodeType;
															var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.asset.model.KmAssetApplyBase&categoryId="
																	+ cateId
																	+ "&nodeType="
																	+ nodeType;
															var data = new Array();
															data
																	.push([
																			"delBtn",
																			checkDelUrl ]);
															data
																	.push([
																			"changeRightBatchBtn",
																			changeRightBatchUrl ]);
															$
																	.ajax({
																		url : "${LUI_ContextPath}/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
																		dataType : "json",
																		type : "post",
																		data : {
																			"data" : LUI
																					.stringify(data)
																		},
																		async : false,
																		success : function(
																				rtn) {
																			var btnInfo = {};
																			if (rtn.length > 0) {
																				for (var i = 0; i < rtn.length; i++) {
																					if (rtn[i]['delBtn'] == 'true') {
																						btnInfo.delBtn = true;
																						if (!LUI('del')) {
																							var delBtn = toolbar
																									.buildButton({
																										id : 'del',
																										order : '2',
																										text : '${lfn:message("button.delete")}',
																										click : 'delDoc()'
																									});
																							LUI(
																									'Btntoolbar')
																									.addButton(
																											delBtn);
																						}
																					}
																					if (rtn[i]['changeRightBatchBtn'] == 'true') {
																						btnInfo.changeRightBatchBtn = true;
																						if (!LUI('docChangeRightBatch')) {
																							var changeRightBatchBtn = toolbar
																									.buildButton({
																										id : 'docChangeRightBatch',
																										order : '4',
																										text : '${lfn:message("sys-right:right.button.changeRightBatch")}',
																										click : 'changeRightCheckSelect("'
																												+ cateId
																												+ '","'
																												+ nodeType
																												+ '")'
																									});
																							LUI(
																									'Btntoolbar')
																									.addButton(
																											changeRightBatchBtn);
																						}
																					}
																				}
																			} else {
																				btnInfo.delBtn = false;
																				if (LUI('del')) {
																					LUI(
																							'Btntoolbar')
																							.removeButton(
																									LUI('del'));
																					LUI(
																							'del')
																							.destroy();
																				}
																				btnInfo.changeRightBatchBtn = false;
																				if (LUI('docChangeRightBatch')) {
																					LUI(
																							'Btntoolbar')
																							.removeButton(
																									LUI('docChangeRightBatch'));
																					LUI(
																							'docChangeRightBatch')
																							.destroy();
																				}
																			}
																			AuthCache[cateId] = btnInfo;
																		}
																	});
														}
													}
												});
							});
			 
			function addTemplate(id){
				 var data = new KMSSData();
					var CreatUrl = Com_Parameter.ContextPath+"km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="+id;
					data.SendToUrl(CreatUrl,function(data) {
					var results=data.responseText;
					window.setTimeout(function(){
						window.open(Com_Parameter.ContextPath+results);	
			    }, 100);
			 }); 
			}
			
		</script>

		<%-- <c:import url="/resource/jsp/search_bar.jsp" charEncoding="UTF-8">
			<c:param name="fdModelName"
				value="com.landray.kmss.km.asset.model.KmAssetCard" />
		</c:import> --%>
		<%-- <%@ include file="/km/asset/resource/assetcommon.jsp"%> --%>

	</template:replace>
</template:include>