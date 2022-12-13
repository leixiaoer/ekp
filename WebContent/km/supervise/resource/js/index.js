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
			startpath : '/DuBanALL',
			routes : [{
				path : '/WoDuBanDe', //我督办的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.WoDuBanDe'], route:{ path: '/WoDuBanDe' }, cri :{'mydoc':'duban','j_path':'/WoDuBanDe'} , selected : true }
						}
					}
				}
			},{
				path : '/WoFuZeDe', //我负责的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.WoFuZeDe'], route:{ path: '/WoFuZeDe' }, cri :{'mydoc':'duty','j_path':'/WoFuZeDe'} , selected : true }
						}
					}
				}
			},{
				path : '/SuoYouDuBan', //我经办的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.SuoYouDuBan'], route:{ path: '/SuoYouDuBan' }, cri :{'mydoc':'manage','j_path':'/SuoYouDuBan'} , selected : true }
						}
					}
				}
			},{
				path : '/WoGuanZhuDe', //我关注的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.WoGuanZhuDe'], route:{ path: '/WoGuanZhuDe' }, cri :{ 'mydoc':'concern','j_path':'/WoGuanZhuDe' } , selected : true }
						}
					}
				}
			},{
				path : '/ChaoSongWoDe', //抄送我的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.ChaoSongWoDe'], route:{ path: '/ChaoSongWoDe' }, cri :{ 'mydoc':'copy','j_path':'/ChaoSongWoDe' } , selected : true }
						}
					}
				}
			},{
				path : '/DuBanGaiLan', //督办概览
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_overview/supervise_overview.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/DuBanLiXiang', //督办立项
				action : function (){
					var mainModelName = 'com.landray.kmss.km.supervise.model.KmSuperviseMain',
						modelName = 'com.landray.kmss.km.supervise.model.KmSuperviseTemplet';
					createDoc(mainModelName,modelName);
				}
			},{
				path : '/audit', //督办审核
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_main/supervise_audit.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/RenWuZhiPai', //任务指派
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_task/index.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/DuBanKaoPing', //督办考评
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_main/kmSuperviseMain_remark.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/openSearch', //督办查询
				action : function(){
					var modelName = 'com.landray.kmss.km.supervise.model.KmSuperviseMain';
					openSearch(modelName);
				}
			},{
				path : '/DuBanALL', //所有督办
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.DuBanALL'], route:{ path: '/DuBanALL' }, cri :{'mydoc':'all','j_path':'/DuBanALL'} , selected : true }
						}
					}
				}
			},{
				path : '/supervise_docStatus50', //已撤销
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.DuBanALL'], route:{ path: '/DuBanALL' }, cri :{'mydoc':'all', 'cri.q':'docStatus:50'} , selected : true }
						}
					}
				}
			},{
				path : '/supervise_docStatus20', //未启动
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.DuBanALL'], route:{ path: '/DuBanALL' }, cri :{'mydoc':'all', 'cri.q':'docStatus:20'} , selected : true }
						}
					}
				}
			},{
				path : '/supervise_docStatus30', //进行中
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.DuBanALL'], route:{ path: '/DuBanALL' }, cri :{'mydoc':'all', 'cri.q':'docStatus:30'} , selected : true }
						}
					}
				}
			},{
				path : '/supervise_docStatus40', //已办结
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmSupervisePanel',
						contents : {
							'kmSuperviseContent' : { title : lang['py.DuBanALL'], route:{ path: '/DuBanALL' }, cri :{'mydoc':'all', 'cri.q':'docStatus:40'} , selected : true }
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
							'kmSuperviseContent' : { title : lang['py.abandon'], route:{ path: '/listDiscard' }, cri :{ 'docStatus':'00','j_path':'/listDiscard' } , selected : true }
						}
					}
				}
			},{
				path : '/recover', //回收站
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/supervise/km_supervise_main/sysRecycleBox.jsp',
						target : '_rIframe'
					}
				}
			}]
		});
		
		
		function createDoc(mainModelName, modelName){
			var url = $var.$contextPath + '/km/supervise/km_supervise_main/createDoc.jsp';
			url = Com_SetUrlParameter(url, 'mainModelName', mainModelName);
			url = Com_SetUrlParameter(url, 'modelName', modelName);
			url = Com_SetUrlParameter(url, 'isSimpleCategory', 'false');
			LUI.pageOpen(url, '_rIframe');
		};
		
		//查询
		function openSearch(modelName){
			var title = $lang.kmSuperviseSearch;
			var url = $var.$contextPath + '/sys/search/ui/nav_search_new.jsp';
			url = Com_SetUrlParameter(url, 'modelName', modelName);
			if(title){
				url = Com_SetUrlParameter(url, 'searchTitle', encodeURIComponent(title));
			}
			LUI.pageOpen(url, '_rIframe');
		}
		
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
		/* var cateId= '', nodeType = '',docStatus = 0;
		
		//根据筛选器分类异步校验权限
		topic.subscribe('criteria.spa.changed',function(evt){
			if($var.isAdmin == 'false'){
				if(LUI('btnDelete')){
					LUI('Btntoolbar').removeButton(LUI('btnDelete'));
					LUI('btnDelete').destroy();
				}
			}
			var hasCate = false;
			for(var i=0;i<evt['criterions'].length;i++){
				  //获取分类id和类型
             	  if(evt['criterions'][i].key == "fdTemplate"){
             		 hasCate = true;
                 	 cateId= evt['criterions'][i].value[0];
	                 nodeType = evt['criterions'][i].nodeType;
             	  }
             	   if(evt['criterions'][i].key == 'docStatus') {
					  docStatus = evt['criterions'][i].value[0];
				  }
				}
				//分类变化刷新
				showButtons(cateId,nodeType);
				//筛选器全部清空的情况
				if(evt['criterions'].length==0){
					 showButtons('','');
				}
		});
		
		function showButtons(categoryId, nodeType){
			var checkDelUrl = "/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteall&categoryId="+categoryId+"&nodeType="+nodeType;
			  
			var data = new Array();
			data.push(["delBtn",checkDelUrl]);
            $.ajax({
            	url: $var.$contextPath + "/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
            	dataType : 'json',
      			type : 'post',
      			data:{  data : LUI.stringify(data) },
      			async : false,
      			success : function(rtn){
      				for(var i = 0;i < rtn.length;i++){
      					if(rtn[i]['delBtn'] == 'true'){
      						if(!LUI('btnDelete')){
		                 		var delBtn = toolbar.buildButton({ id:'btnDelete',order:'3',text:$lang['buttonDelete'], click:'window.moduleAPI.supervise.deleteAll()'});
		    					LUI('Btntoolbar').addButton(delBtn);
		                	  }
      					}
      					
      				}
      			}
            });
		}*/
		
		
		
	});
});