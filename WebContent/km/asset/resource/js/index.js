seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lang!km-asset','lui/util/env'],
		function(Module, $, dialog, topic ,lang,env){
	
	var module = Module.find('kmAsset');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/kmAsset_buy',
			routes : [{
				path : '/kmAssetCard_my', 
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCardContent' : { title : lang['kmAssetCard.my'], route:{ path: '/kmAssetCard_my' }, cri :{'mycard':'responsible','except':'fdAssetStatus:5','addShow':'true','j_path':'/kmAssetCard_my'},selected : true }
						}
					}
				}
			},{
				path : '/kmAssetApply_my', 
				children : [{
				path : '/create', 
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApply_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApply_my/create'},selected : true },
							'kmAssetApplyApprovalContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApply_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00','j_path':'/kmAssetApply_my/approval'}},
							'kmAssetApplyApprovedContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApply_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApply_my/approved'}},
							'kmAssetApplyDraftsContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApply_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApply_my/drafts'}}
								}
							}
						}
			},{
				path : '/approval',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApply_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApply_my/create'}},
							'kmAssetApplyApprovalContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApply_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00','j_path':'/kmAssetApply_my/approval'},selected : true },
							'kmAssetApplyApprovedContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApply_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApply_my/approved'}},
							'kmAssetApplyDraftsContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApply_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApply_my/drafts'}}
								}
							}
						}
			},{
				path : '/approved',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApply_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApply_my/create'}},
							'kmAssetApplyApprovalContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApply_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00','j_path':'/kmAssetApply_my/approval'}},
							'kmAssetApplyApprovedContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApply_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApply_my/approved'},selected : true },
							'kmAssetApplyDraftsContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApply_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApply_my/drafts'}}
								}
							}
						}
			},{
				path : '/drafts',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApply_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApply_my/create'}},
							'kmAssetApplyApprovalContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApply_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00','j_path':'/kmAssetApply_my/approval'}},
							'kmAssetApplyApprovedContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApply_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApply_my/approved'}},
							'kmAssetApplyDraftsContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApply_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApply_my/drafts'},selected : true }
								}
							}
						}
			}]
			},{
				path : '/kmAssetApplyTask_my', 
				children : [{
				path : '/create', 
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateTaskContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApplyTask_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/create'},selected : true },
							'kmAssetApplyApprovalTaskContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApplyTask_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetApplyTask_my/approval'}},
							'kmAssetApplyApprovedTaskContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApplyTask_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/approved'}},
							'kmAssetApplyDraftsTaskContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApplyTask_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApplyTask_my/drafts'}}
								}
							}
						}
			},{
				path : '/approval',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateTaskContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApplyTask_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/create'}},
							'kmAssetApplyApprovalTaskContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApplyTask_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetApplyTask_my/approval'},selected : true },
							'kmAssetApplyApprovedTaskContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApplyTask_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/approved'}},
							'kmAssetApplyDraftsTaskContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApplyTask_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApplyTask_my/drafts'}}
								}
							}
						}
			},{
				path : '/approved',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateTaskContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApplyTask_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/create'}},
							'kmAssetApplyApprovalTaskContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApplyTask_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetApplyTask_my/approval'}},
							'kmAssetApplyApprovedTaskContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApplyTask_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/approved'},selected : true },
							'kmAssetApplyDraftsTaskContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApplyTask_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApplyTask_my/drafts'}}
								}
							}
						}
			},{
				path : '/drafts',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kmAssetApplyCreateTaskContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetApplyTask_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/create'}},
							'kmAssetApplyApprovalTaskContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetApplyTask_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetApplyTask_my/approval'}},
							'kmAssetApplyApprovedTaskContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetApplyTask_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetApplyTask_my/approved'}},
							'kmAssetApplyDraftsTaskContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetApplyTask_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetApplyTask_my/drafts'},selected : true }
								}
							}
						}
			}]
			},{
				path : '/kmAssetInventory_my', 
				children : [{
				path : '/create', 
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kAssetApplyCreateInventoryContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetInventory_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetInventory_my/create'},selected : true },
							'kAssetApplyApprovalInventoryContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetInventory_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetInventory_my/approval'}},
							'kAssetApplyApprovedInventoryContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetInventory_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetInventory_my/approved'}},
							'kAssetApplyDraftsInventoryContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetInventory_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetInventory_my/drafts'}}
								}
							}
						}
			},{
				path : '/approval',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kAssetApplyCreateInventoryContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetInventory_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetInventory_my/create'}},
							'kAssetApplyApprovalInventoryContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetInventory_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetInventory_my/approval'},selected : true },
							'kAssetApplyApprovedInventoryContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetInventory_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetInventory_my/approved'}},
							'kAssetApplyDraftsInventoryContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetInventory_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetInventory_my/drafts'}}
								}
							}
						}
			},{
				path : '/approved',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kAssetApplyCreateInventoryContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetInventory_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetInventory_my/create'}},
							'kAssetApplyApprovalInventoryContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetInventory_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetInventory_my/approval'}},
							'kAssetApplyApprovedInventoryContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetInventory_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetInventory_my/approved'},selected : true },
							'kAssetApplyDraftsInventoryContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetInventory_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetInventory_my/drafts'}}
								}
							}
						}
			},{
				path : '/drafts',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'kAssetApplyCreateInventoryContent' : { title : lang['kmAssetApply.create.my'], route:{ path: '/kmAssetInventory_my/create' }, cri :{'mydoc':'create','except':'docStatus:00','j_path':'/kmAssetInventory_my/create'}},
							'kAssetApplyApprovalInventoryContent' : { title : lang['kmAssetApply.approval.my'], route:{ path: '/kmAssetInventory_my/approval' }, cri :{'mydoc':'approval','except':'docStatus:00_30','j_path':'/kmAssetInventory_my/approval'}},
							'kAssetApplyApprovedInventoryContent' : { title : lang['kmAssetApply.approved.my'], route:{ path: '/kmAssetInventory_my/approved' }, cri :{'mydoc':'approved','except':'docStatus:00','j_path':'/kmAssetInventory_my/approved'}},
							'kAssetApplyDraftsInventoryContent' : { title : lang['kmAsset.drafts'], route:{ path: '/kmAssetInventory_my/drafts' }, cri :{'mydoc':'create','docStatus':'10','status':'draft','j_path':'/kmAssetInventory_my/drafts'},selected : true }
								}
							}
						}
			}]
			},{
				path : '/kmAsset_buy', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_buy.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_get', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_get.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_return', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_return.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_stock', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_stock.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_in', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_in.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_rent', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_rent.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_divert', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_divert.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_repair', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_repair.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_change', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_change.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_deal', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_deal.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_bank', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetCard_base.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_task', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_task.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_inventory', 
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/asset/import/kmAssetApply_inventory.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/kmAsset_abandom', 
				children : [{
				path : '/abandomCard', 
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'abandomCard' : { title : lang['kmAsset.abandom.card'], route:{ path: '/kmAsset_abandom/abandomCard' }, cri :{'fdAssetStatus':'5','j_path':'/kmAsset_abandom/abandomCard'},selected : true },
							'abandomApply' : { title : lang['kmAsset.abandom.apply'], route:{ path: '/kmAsset_abandom/abandomApply' }, cri :{'docStatus':'00','j_path':'/kmAsset_abandom/abandomApply'}},
								}
							}
						}
			},{
				path : '/abandomApply',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmAssetPanel',
						contents : {
							'abandomCard' : { title : lang['kmAsset.abandom.card'], route:{ path: '/kmAsset_abandom/abandomCard' }, cri :{'fdAssetStatus':'5','j_path':'/kmAsset_abandom/abandomCard'} },
							'abandomApply' : { title : lang['kmAsset.abandom.apply'], route:{ path: '/kmAsset_abandom/abandomApply' }, cri :{'docStatus':'00','j_path':'/kmAsset_abandom/abandomApply'},selected : true},
								}
							}
						}
			}]
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/asset/tree_config.jsp',
						target : '_rIframe'
					}
				}
			}]
		});		
		

		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage',
				function() {
					topic.publish('list.refresh');
				});

		//新建
		$function.addDoc = function() {
			var tempId = "";
			dialog.category(
							'com.landray.kmss.km.asset.model.KmAssetApplyTemplate',
							'fdTemplateId',
							'fdTemplateName',
							false,
							function(rtn) {
								if (rtn != false
										&& rtn != null) {
									tempId = document
											.getElementsByName("fdTemplateId")[0].value;
									addByApplyTemplate(tempId);
								}
							});
		};

		$function.addByApplyTemplate = function(tempId) {
			if (tempId != null && tempId != '') {
				var data = new KMSSData();
				var url = Com_Parameter.ContextPath
						+ "km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=loadAssetApplyTemplate&tempId="
						+ tempId;
				var results;
				data.SendToUrl(url, function(data) {
					results = data.responseText;

				}, false);
				document
						.getElementsByName("fdTemplateId")[0].value = "";
				document
						.getElementsByName("fdTemplateName")[0].value = "";
				window.open(Com_Parameter.ContextPath
						+ results, '_blank');
			}
		};
		$function.clearAllValue = function() {

			this.location = "${LUI_ContextPath}/km/asset";
		};
		//删除
		$function.delDoc = function(draft) {
			var values = [];
			$("input[name='List_Selected']:checked")
					.each(function() {
						values.push($(this).val());
					});
			if (values.length == 0) {
				dialog.alert('<bean:message key="page.noSelect"/>');
				return;
			}
			var url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall"/>&categoryId='
					+ CATEID + '&nodeType=' + NODETYPE;
			if (draft == '0') {
				url = '<c:url value="/km/asset/km_asset_apply_base/kmAssetApplyBase.do?method=deleteall&status=10"/>';
			}
			dialog.confirm(
							'<bean:message key="page.comfirmDelete"/>',
							function(value) {
								if (value == true) {
									window.del_load = dialog.loading();

									$.ajax({
												url : url,

												type : 'POST',

												data : $.param(
																{
																	"List_Selected" : values
																},
																true),

												dataType : 'json',

												error : function(data) {
													if (window.del_load != null) {
														window.del_load.hide();
													}
													dialog.result(data.responseJSON);
												},

												success : delCallback

											});
								}
							});
		};
		$function.delCallback = function(data) {
			if (window.del_load != null) {
				window.del_load.hide();
				topic.publish("list.refresh");
			}
			dialog.result(data);
		};
		var AuthCache = {};
		//根据筛选器分类异步校验权限
		topic.subscribe('criteria.spa.changed',function(evt){
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
									data.push([
													"delBtn",
													checkDelUrl ]);
									data.push([
													"changeRightBatchBtn",
													changeRightBatchUrl ]);
									$.ajax({
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
});