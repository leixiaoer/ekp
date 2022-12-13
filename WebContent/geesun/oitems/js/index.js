seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lang!geesun-oitems'],
		function(Module, jquery, dialog, topic ,lang){
	
	var module = Module.find('geesunOitems');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/listCreate',
			routes : [{
				path : '/listAll', //所有流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'geesunOitemsPanel',
						contents : {
							'geesunOitemsContent' : { title : lang['geesunOitems.tree.my.all'], route:{ path: '/listAll' }, cri :{'mydoc':'all','j_path':'/listAll'} , selected : true }
						}
					}
				}
			},{
				path : '/listCreate', //我起草的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'geesunOitemsPanel',
						contents : {
							'geesunOitemsContent' : { title : lang['geesunOitems.tree.my.submit'], route:{ path: '/listCreate' }, cri :{'mydoc':'create','j_path':'/listCreate'} , selected : true }
						}
					}
				}
			},{
				path : '/listApproved', //我已审的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'geesunOitemsPanel',
						contents : {
							'geesunOitemsContent' : { title : lang['geesunOitems.tree.my.approved'], route:{ path: '/listApproved' }, cri :{'mydoc':'approved','j_path':'/listApproved'} , selected : true }
						}
					}
				}
			},{
				path : '/listApproval', //待审我的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'geesunOitemsPanel',
						contents : {
							'geesunOitemsContent' : { title : lang['geesunOitems.tree.my.approval'], route:{ path: '/listApproval' }, cri :{ 'mydoc':'approval','j_path':'/listApproval'} , selected : true }
						}
					}
				}
			},{
				path : '/listAllListing', //当前库存
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing_ui/index.jsp');
				}
			},{
				path : '/showRecordList', //快速录入
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=showRecordList');
				}
			},{
				path : '/showStockCount', //库存查询
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=showStockCount');
				}
			},{
				path : '/monthReport', //月领用报表
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_month_report_ui/index.jsp');
				}
			},{
				path : '/receiveCount', //领用统计
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing_receiveCount.jsp');
				}
			},{
				path : '/inCount', //入库统计
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=inCount');
				}
			},{
				path : '/outCount', //出库统计
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=outCount');
				}
			},{
				path : '/toReceiveCount', //待领养统计
				action : function(){
					openPage($var.$contextPath +'/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do?method=receiveCount');
				}
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/geesun/oitems/tree.jsp',
						target : '_rIframe'
					}
				}
			}]
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
		//新建
		$function.addDoc = function(type) {
			Com_OpenWindow($var.$contextPath +'/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=add&type='+type);
		};
		//删除
		$function.delDoc = function(){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
			if(values.length==0){
				dialog.alert($lang['pageNoSelect']);
				return;
			}
			dialog.confirm($lang['confirmFiled'],function(value){
				if(value==true){
					window.del_load = dialog.loading();
					$.post($var.$contextPath +'/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do?method=deleteall',
							$.param({"List_Selected":values},true),delCallback,'json');
				}
			});
		};
		function delCallback(data){
			if(window.del_load!=null)
				window.del_load.hide();
			if(data!=null && data.status==true){
				topic.publish("list.refresh");
				dialog.success($lang['optSuccess']);
			}else{
				dialog.failure($lang['optFailure']);
			}
		}
	});
});
