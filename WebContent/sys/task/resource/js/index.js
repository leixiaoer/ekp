seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/framework/module'],
		function($, strutil, dialog, topic, Module){
	
	window.onload = function(){
		topic.publish('lui.page.resize');
	}
	
	var module = Module.find('sysTask');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/listAttention',
			routes : [
			        {
			        	path : '/listAttention', //我关注的
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskMainContent : { title : $lang.listAttention, route:{ path: '/listAttention' }, cri :{'flag':'0'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/listAppoint', //我指派的
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskMainContent : { title : $lang.listAppoint, route:{ path: '/listAppoint' }, cri :{'flag':'1'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/listPerform', //我负责的
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskMainContent : { title : $lang.listPerform, route:{ path: '/listPerform' }, cri :{'flag':'2'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/listCopy', //抄送任务
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskMainContent : { title : $lang.listCopy, route:{ path: '/listCopy' }, cri :{'flag':'3'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/listAll', //所有任务
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskMainContent : { title : $lang.listAll, route:{ path: '/listAll' }, cri :{'mydoc':'all'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/calendar', //任务日历
						action : function() {
							LUI.pageOpen($var.$contextPath + '/sys/task/sys_task_ui/calendar.jsp','_rIframe');
						}
			   		},
			   		{
			        	path : '/load', //负荷分析
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskAnalyzeContent : { title : $lang.load, route:{ path: '/load' }, cri :{'type':'1'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/degree', //满意度分析
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskAnalyzeContent : { title : $lang.degree, route:{ path: '/degree' }, cri :{'type':'2'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/type', //类型分析
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskAnalyzeContent : { title : $lang.type, route:{ path: '/type' }, cri :{'type':'4'} , selected : true }
								}
							}
						}
			   		},
			   		{
			        	path : '/trend', //趋势分析
						action : {
							type : 'tabpanel',
							options : {
								panelId : 'sysTaskPanel',
								contents : {
									sysTaskAnalyzeContent : { title : $lang.trend, route:{ path: '/trend' }, cri :{'type':'5'} , selected : true }
								}
							}
						}
			   		}
			   		,{
						path : '/sys/subordinate', // 下属工作
						action : {
							type : 'pageopen',
							options : {
								url : $var.$contextPath + '/sys/subordinate/moduleindex.jsp?moduleMessageKey=sys-task:module.sys.task',
								target : '_rIframe'
							}
						}
					}
			   		,{
			   			path : '/management', // 后台管理
			   			action : {
			   				type : 'pageopen',
			   				options : {
			   					url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/sys/task/tree.jsp',
			   					target : '_rIframe'
			   				}
			   			}
			   		}
			   ]
		});
	});
});