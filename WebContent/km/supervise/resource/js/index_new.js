seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/framework/module', 'lang!km-supervise'],
		function($, strutil, dialog, topic, Module, lang){
	
	var module = Module.find('supervise');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		
		//路由配置
		$router.define({
			startpath : '/workbench',
			routes : [{
				path : '/myManage', //我分管的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'WoFenGuande' : { title : lang['py.WoFenGuande'], route:{ path: '/myManage' }, cri :{'mydoc':'fenguan','j_path':'/myManage'} , selected : true }
						}
					}
				}
			},{
				path : '/myCharge', //我负责的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'WoFuZeDe' : { title : lang['py.WoFuZeDe'], route:{ path: '/myCharge' }, cri :{'mydoc':'duty','j_path':'/myCharge'} , selected : true }
						}
					}
				}
			},{
				path : '/myUndertake', //我承办的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'WoChengBanDe' : { title : lang['py.WoChengBanDe'], route:{ path: '/myUndertake' }, cri :{'mydoc':'undertake','j_path':'/myUndertake'} , selected : true }
						}
					}
				}
			},{
				path : '/myConcern', //我关注的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'WoGuanZhuDe' : { title : lang['py.WoGuanZhuDe'], route:{ path: '/myConcern' }, cri :{ 'mydoc':'concern','j_path':'/myConcern' } , selected : true }
						}
					}
				}
			},{
				path : '/ItemView', //督办事项
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'ItemView' : { title : lang['py.DuBanShiXiang'], route:{ path: '/ItemView' }, cri :{'j_path':'/ItemView'} , selected : true }
						}
					}
				}
			},{
				path : '/mySup', //我协办的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'WoXieBanDe' : { title : lang['py.WoXieBanDe'], route:{ path: '/mySup' }, cri :{'mydoc':'sup','j_path':'/mySup'} , selected : true }
						}
					}
				}
			},{
				path : '/audit', //我审批的
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_main/supervise_audit.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/workbench', //督办工作台
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'workbench' : { title : lang['py.DuBanGongZuoTai'], route:{ path: '/workbench' }, cri :{'j_path':'/workbench'} , selected : true }
						}	
					}
				}
			},{
				path : '/myCreate', //督办发起
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'myCreate' : { title : lang['py.DuBanFaQi'], route:{ path: '/myCreate' }, cri :{'j_path':'/myCreate'} , selected : true }
						}
					}
				}
			},{
				path : '/superviseItem', //督办事项
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'superviseItem' : { title : lang['py.DuBanShiXiang'], route:{ path: '/superviseItem' }, cri :{'j_path':'/superviseItem'} , selected : true }
						}
					}
				}
			},{
				path : '/taskPlan', //任务指派
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'taskPlan' : { title : lang['py.RenWuZhiPai'], route:{ path: '/taskPlan' }, cri :{'j_path':'/taskPlan'} , selected : true }
						}
					}
				}
			},{
				path : '/evaluate', //督办考评
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'evaluate' : { title : lang['py.DuBanKaoPing'], route:{ path: '/evaluate' }, cri :{'j_path':'/evaluate'} , selected : true }
						}
					}
				}
			},{
				path : '/openSearch', //督办查询
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'openSearch' : { title : lang['py.openSearch'], route:{ path: '/openSearch' }, cri :{'j_path':'/openSearch'} , selected : true }
						}
					}
				}
			},{
				path : '/dbNavTree', //数据统计
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'dbNavTree' : { title : lang['py.dataChart'], route:{ path: '/dbNavTree' }, cri :{'j_path':'/dbNavTree'} , selected : true }
						}
					}
				}
			},{
				path : '/history', //历史督办
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'LiShiDuBan' : { title : lang['py.LiShiDuBan'], route:{ path: '/history' }, cri :{'j_path':'/history'} , selected : true }
						}
					}
				}
			},{
				path : '/createReview', //立项流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'createReview' : { title : lang['py.LiXiangLiuCheng'], route:{ path: '/createReview' }, cri :{'j_path':'/createReview'} , selected : true }
						}	
					}
				}
			},{
				path : '/changeReview', //变更流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'changeReview' : { title : lang['py.BianGengLiuCheng'], route:{ path: '/changeReview' }, cri :{'j_path':'/changeReview'} , selected : true }
						}	
					}
				}
			},{
				path : '/backReview', //反馈流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'backReview' : { title : lang['py.FanKuiLiuCheng'], route:{ path: '/backReview' }, cri :{'j_path':'/backReview'} , selected : true }
						}	
					}
				}
			},{
				path : '/finishReview', //办结流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'finishReview' : { title : lang['py.BanJieLiuCheng'], route:{ path: '/finishReview' }, cri :{'j_path':'/finishReview'} , selected : true }
						}	
					}
				}
			},{
				path : '/stopReview', //终止流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'stopReview' : { title : lang['py.ZhongZhiLiuCheng'], route:{ path: '/stopReview' }, cri :{'j_path':'/stopReview'} , selected : true }
						}	
					}
				}
			},{
				path : '/listDiscard',
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'listDiscard' : { title : lang['py.abandon'], route:{ path: '/listDiscard' }, cri :{ 'docStatus':'00','j_path':'/listDiscard' } , selected : true }
						}
					}
				}
			},{
				path : '/recover', //回收站
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'recover' : { title : lang['py.recycle'], route:{ path: '/recover' }, cri :{'j_path':'/recover'} , selected : true }
						}	
					}
				}
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/supervise/tree.jsp',
						target : '_rIframe'
					}
				}
			}]
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
	});
});