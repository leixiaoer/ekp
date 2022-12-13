seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lui/spa/Spa'],
		function(Module, $, dialog, topic ,Spa){
	
	var module = Module.find('kmProvider');
	
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/providerAll',
			routes : [{
				path : '/providerAll', 
				action : function(){
					kmProvider.clear();
					kmProvider.open('cri.q','fdIsvalidate:true');
				}
			},{
				path : '/providerCreate', 
				action :function(){
					kmProvider.clear();
					kmProvider.open('cri.q','fdIsvalidate:false');
				}
			},{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/provider/tree_config.jsp',
						target : '_rIframe'
					}
				}
			}]
		});		
		
		window.kmProvider = {
				open : function(key, value) {
					Spa.spa.setValue(key, value);
				},
				clear : function() {
					Spa.spa.clear();
				}
			};
	 	// 增加
 		$function.add = function() {
 			var docCategory = Spa.spa.getValue('docCategory') || '';
 			//新建
			dialog.simpleCategoryForNewFile(
					'com.landray.kmss.km.provider.model.KmProviderCategory',
					'/km/provider/km_provider_main/kmProviderMain.do?method=add&categoryId=!{id}',false,null,null,docCategory);
 		};
 	// 增加
 		$function.importExcel = function() {
 			Com_OpenWindow($var.$contextPath+'/km/provider/km_provider_main/kmProviderMain_import.jsp');
 		};
 		
 	// 编辑
 		$function.edit = function(id) {
	 		if(id)
 				Com_OpenWindow($var.$contextPath + '/km/provider/km_provider_main/kmProviderMain.do?method=edit&fdId=' + id);
 		};
		//删除文档
		$function.deleteAll = function(){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
			if(values.length==0){
				dialog.alert($lang['pageNoSelect']);
				return;
			}
			var docCategory = Spa.spa.getValue('docCategory') || '';
			var url = $var.$contextPath + '/km/provider/km_provider_main/kmProviderMain.do?method=deleteall';
			url = Com_SetUrlParameter(url, 'categoryId', docCategory);
			dialog.confirm('一旦选择了删除，所选记录的相关数据都会被删除，无法恢复！您确认要执行此删除操作吗？', function(value) {
				if(values) {
					window.del_load = dialog.loading();
					$.ajax({
						url : url,
						type : 'POST',
						data : $.param({"List_Selected" : values}, true),
						dataType : 'json',
						error : function(data) {
							if(window.del_load != null) {
								window.del_load.hide(); 
							}
							dialog.result(data.responseJSON);
						},
						success: function(data) {
							if(window.del_load != null) {
								window.del_load.hide(); 
							}
						
							dialog.result(data);
						}
				   });
				}
			});
		};
		
		window.delCallback = function(data){
			if(window.del_load!=null){
				window.del_load.hide();
				topic.publish("list.refresh");
			}
			dialog.result(data);
		};
		
		$function.invalidateAll = function(id){
			var values = [];
			if(id){
				values.push(id);
			}else{
				$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
				if(values.length==0){
					dialog.alert($lang.pageNoSelect);
					return;
				}
			}
			dialog.confirm($lang.comfirmAbandon,function(value){
				if(value==true){
					window.del_load = dialog.loading();
					$.post($var.$contextPath+'/km/provider/km_provider_main/kmProviderMain.do?method=invalidateAll',
							$.param({"List_Selected":values},true),delCallback,'json');
				}
			});
		};

		$function.validateAll = function(id){
			var values = [];
			if(id){
				values.push(id);
			}else{
				$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
				if(values.length==0){
					dialog.alert($lang.pageNoSelect);
					return;
				}
			}
			dialog.confirm($lang.comfirmUse,function(value){
				if(value==true){
					window.del_load = dialog.loading();
					$.post($var.$contextPath+'/km/provider/km_provider_main/kmProviderMain.do?method=validateAll',
							$.param({"List_Selected":values},true),delCallback,'json');
				}
			});
		};

		topic.subscribe('successReloadPage', function() {
			topic.publish('list.refresh');
		});
		
		//根据筛选项显示启用或禁用按钮
		topic.subscribe('criteria.spa.changed',function(evt){
			$('#validate').hide();
			$('#invalidate').hide();
			for(var i=0;i<evt['criterions'].length;i++){
         	  if(evt['criterions'][i].key=="fdIsvalidate"){
             	  var isValidate = evt['criterions'][i].value[0];
             	  if(isValidate=='true'){
             		 $('#invalidate').show();
             	  }else if(isValidate=='false'){
             		 $('#validate').show();
             	  }
         	  }
			}
			openQuery(); //#114106
		});
		
	});
});