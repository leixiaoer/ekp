			seajs.use(
							['lui/framework/module', 'lui/jquery', 'lui/dialog', 'lui/topic',
									'lui/toolbar', 'lui/qrcode','lang!km-pindagate'],
							function(Module,$, dialog, topic, toolbar, qrcode,lang) {
								
								var module = Module.find('kmPindagate');
								
								/**
								 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
								 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
								 */
								module.controller(function($var, $lang, $function,$router){
									//路由配置
									$router.define({
										startpath : '/joinAll',
										routes : [{
											path : '/joinAll', //所有问卷
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateContent' : { title : lang['kmPindagate.tree.all'], route:{ path: '/joinAll' }, cri :{'join':'all'} , selected : true }
													}
												}
											}
										},{
											path : '/joinMine', //我参与的
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateContent' : { title : lang['kmPindagate.tree.join.mine'], route:{ path: '/joinMine' }, cri :{'join':'mine'} , selected : true }
													}
												}
											}
										},{
											path : '/mydocMine', //所有问卷
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateUiContent' : { title : lang['kmPindagate.tree.all'], route:{ path: '/mydocMine' }, cri :{'mydoc':'mine','j_path':'/mydocMine'} , selected : true }
													}
												}
											}
										},{
											path : '/mydocCreate', //我发起的
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateUiContent' : { title :lang['kmPindagate.tree.create.mine'], route:{ path: '/mydocCreate' }, cri :{'mydoc':'create','j_path':'/mydocCreate'} , selected : true }
													}
												}
											}
										},{
											path : '/mydocApproval', //待我审的
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateUiContent' : { title :$lang['listApproval'] , route:{ path: '/mydocApproval' }, cri :{'mydoc':'approval','j_path':'/mydocApproval'} , selected : true }
													}
												}
											}
										},{
											path : '/mydocApproved', //我已审的
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateUiContent' : { title : $lang['listApproved'], route:{ path: '/mydocApproved' }, cri :{'mydoc':'approved','j_path':'/mydocApproved'} , selected : true }
													}
												}
											}
										},{
											path : '/indagating', //调查中
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateResultContent' : { title : lang['kmPindagate.tree.status.indagating'], route:{ path: '/indagating' }, cri :{'docStatus':'31'} , selected : true }
													}
												}
											}
										},{
											path : '/complete', //已结束
											action : {
												type : 'tabpanel',
												options : {
													panelId : 'kmPindagatePanel',
													contents : {
														'kmPindagateResultContent' : { title : lang['kmPindagate.tree.status.complete'], route:{ path: '/complete' }, cri :{'docStatus':'32'} , selected : true }
													}
												}
											}
										},{
											path : '/management', // 后台管理
											action : {
												type : 'pageopen',
												options : {
													url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/pindagate/tree.jsp',
													target : '_rIframe'
												}
											}
										}]
									});
								
							});
					});
			