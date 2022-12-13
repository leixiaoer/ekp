seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lang!km-carmng'],
		function(Module, jquery, dialog, topic ,lang){
	
	var module = Module.find('kmCarmng');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/listCreate',
			routes : [
			{
				path : '/useCarCalendar', //用车日历
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_calendar/kmCarmng_use_calendar.jsp');
				}
			},{
				path : '/listAll', //所有流程
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmCarmngPanel',
						contents : {
							'kmCarmngContent' : { title : lang['kmCarmng.use.all'], route:{ path: '/listAll' }, cri :{'mydoc':'all','j_path':'/listAll'} , selected : true }
						}
					}
				}
			},{
				path : '/listCreate', //我起草的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmCarmngPanel',
						contents : {
							'kmCarmngContent' : { title : lang['kmCarmng.tree.my.submit'], route:{ path: '/listCreate' }, cri :{'mydoc':'create','j_path':'/listCreate'} , selected : true }
						}
					}  
				}
			},{
				path : '/listApproved', //我已审的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmCarmngPanel',
						contents : {
							'kmCarmngContent' : { title : lang['kmCarmng.tree.my.approved'], route:{ path: '/listApproved' }, cri :{'mydoc':'approved','j_path':'/listApproved'} , selected : true }
						}
					}
				}
			},{
				path : '/listApproval', //待审我的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmCarmngPanel',
						contents : {
							'kmCarmngContent' : { title : lang['kmCarmng.tree.my.approval'], route:{ path: '/listApproval' }, cri :{ 'mydoc':'approval','j_path':'/listApproval'} , selected : true }
						}
					}
				}
			},{
				path : '/listUse', //用车查询
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_dispatchers_info_list/kmCarmngDispatchersInfoList.do?method=search');
				}
			},{
				path : '/infringeInfo', //违章信息
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_infringeInfo_ui/index.jsp');
				}
			},{
				path : '/insuranceInfo', //保险信息
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_insuranceInfo_ui/index.jsp');
				}
			},{
				path : '/maintenanceInfo', //保养信息
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_maintenanceInfo_ui/index.jsp');
				}
			},{
				path : '/rescalendar', //用车日历
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_calendar/rescalendar.jsp');
				}
			},{
				path : '/listByDispatchers', //用车调度
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_listByDispatchers_ui/index.jsp');
				}
			},{
				path : '/dispatchersInfo', //调度信息
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_dispatchersInfo_ui/index.jsp');
				}
			},{
				path : '/evaluation', //满意度
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_evaluation_ui/index.jsp');
				}
			}/*,{
				path : '/UserFeeInfoCount', //出车统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=count');
				}
			}*/,{
				path : '/CarUseCount', //车辆使用统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_count/kmCarmngCount_car_list.jsp?type=carFee');
				}
			},{
				path : '/DeptCarCount', //部门用车统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_count/kmCarmngCount_org_list.jsp?type=dept');
				}
			},{
				path : '/PersonCarCount', //个人用车统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_count/kmCarmngCount_org_list.jsp?type=person');
				}
			},{
				path : '/DriverCount', //驾驶员出车统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_count/kmCarmngCount_driver_list.jsp?type=driver');
				}
			},{
				path : '/CarFeeCount', //车辆费用汇总统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_count/kmCarmngCount_car_fee_list.jsp?type=carFee');
				}
			},{
				path : '/MaintenanceInfoCount', //保养统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=count');
				}
			},{
				path : '/InfringeInfoCount', //违章统计
				action : function(){
					openPage($var.$contextPath +'/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=count');
				}
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/carmng/tree_config.jsp',
						target : '_rIframe'
					}
				}
			}
			]
		});
	});
});