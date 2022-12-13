seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog','lui/topic','lui/framework/module','lui/toolbar','lui/spa/Spa', 'lui/spa/const', 'lui/util/env'],
		function($, strutil, dialog, topic, Module, toolbar, Spa, spaConst, env){
	var module = Module.find('kmInstitution');
	var lang = seajs.require('lang!');
	var lang_ui = seajs.require('lang!sys-ui');
	/**
	 * 内置参数:  $var:安装模块时传入变量；$lang:安装模块时传入多语言信息；$function:需要注册成全局的方法；$router : 全局路有对象； $ondestroy:销毁函数
	 * 内置参数的声明无顺序要求，你可以这样function($var,$function){}、或者这样function($lang,$var){}，但是参数名字必须使用$var、$lang、$function
	 */
	module.controller(function($var, $lang, $function,$router){
		//路由配置
		$router.define({
			startpath : '/allDoc',
			routes : [
			        {
			        	path : '/allDoc', //所有文档
						action : {
							type : 'content',
							options : {
								cri : {'j_path':'/allDoc','cri.q':'docStatus:30'}
							}
						}
			   		},
			   		{
			        	path : '/approval', // 待我审的
//						action : {
//							type : 'content',
//							options : {
//								cri : {mydoc : "approval,"+$lang.approval,'j_path':'/approval'}
//							}
//						}
						action : function() {
							examineDoc('approval');
						}
			   		},
			   		{
			        	path : '/approved', //我已审的
//						action : {
//							type : 'content',
//							options : {
//								cri:{mydoc:'approved,'+$lang.approved,'j_path':'/approved'}
//							}
//						}
						action : function() {
							examineDoc('approved');
						}
			   		},
			   		{
			        	path : '/create', // 我上传的
						action : {
							type : 'content',
							options : {
								cri:{mydoc:'create,'+$lang.create,'j_path':'/create'}
							}
						}
			   		},
			   		{
						path : '/management',
						action : {
							type : 'pageopen',
							options : {
								url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/institution/tree.jsp',
								target : '_rIframe'
							}
						}
					}
			   ]
		});

		function examineDoc(type){
			var url = $var.$contextPath+'/km/institution/examineDoc.jsp?type=' + type;
			LUI.pageOpen(url, '_rIframe');
		};
		
		//删除 <bean:message key="page.noSelect"/>
		$function.delDoc = function(){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
					values.push($(this).val());
				});
			if(values.length==0){
				dialog.alert(lang['page.noSelect']);
				return;
			}
			
			var delUrl = $var.$contextPath + '/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&categoryId=' + Spa.spa.getValue('docCategory');
			dialog.iframe('/sys/edition/import/doc_delete_iframe.jsp?fdModelName=com.landray.kmss.km.doc.model.Institution&fdType=POST',
					lang_ui['ui.dialog.operation.title'],
					function (value){
	                    // 回调方法
						if(value) {
							if(window.del_load!=null)
								window.del_load.hide();
							if(typeof (value.responseText) != 'undefined'){
								var obj = eval('(' + value.responseText + ')');
								if(false==obj.status){
									var msg =obj.message;
									dialog.failure(msg[0].msg);
								}else{
									topic.publish("list.refresh");
									dialog.result(value);
								}
							}else{
								topic.publish("list.refresh");
								dialog.result(value);
							}
						}
					},
					{width:400,height:170,params:{url:delUrl,data:$.param({"List_Selected":values},true)}}
			);
		};
		
	});
	
	topic.subscribe(spaConst.SPA_CHANGE_VALUES, function(evt) {
		LUI.pageHide('_rIframe');
	});
	
	// 监听新建更新等成功后刷新
	topic.subscribe('successReloadPage', function() {
		topic.publish('list.refresh');
	});

	//新建
	window.addDoc = function() {
			dialog.simpleCategoryForNewFile(
					'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
					'/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,Spa.spa.getValue('docCategory'));
	};
	
	
	window.delCallback = function(data){
		if(window.del_load!=null)
			window.del_load.hide();
		if(data!=null && data.status==true){
			topic.publish("list.refresh");
			dialog.success(lang["return.optSuccess"]);
		}else{
			dialog.failure(lang["return.optFailure"]);
		}
	};
	
	//搜索条件改变时,失效按钮是否显示
	topic.subscribe('criteria.changed', function(evt){
		var showAbolish = false;
		if (evt['criterions'].length > 0) {
			for ( var i = 0; i < evt['criterions'].length; i++) {
				// 筛选条件切换成“失效”时，显示失效时间和连接
				var docStatus = evt['criterions'][i];
				if (docStatus.key == "docStatus" && docStatus.value.length == 1 && docStatus.value[0] == "50") {
					showAbolish = true;
					break;
				}
			}
		}
		if(showAbolish) {
			// 显示常规字段，另显示“失效时间”和“失效连接”
			LUI("colTable").columns[3].properties = "fdNumber;docStatus;docDept.fdName;docCreator;fdAbolishTime;fdAbolishLink";
		} else {
			// 显示常规字段，另显示“发布时间”
			LUI("colTable").columns[3].properties = "fdNumber;docStatus;docDept.fdName;docCreator;docPublishTime;";
		}
	});
	
	window.setCategory = function(cateId) {
		var url = "";
		if(Com_GetUrlParameter(window.location.href, "categoryId") != null) {
			url = Com_SetUrlParameter(window.location.href, "categoryId", cateId);
		} else {
			var temp = location.href.split("#");
			url = temp[0] + "?categoryId=" + cateId;
			if (temp.length > 1) {
				url += "#" + temp[1];
			}
		}
		window.location.href = url;
	};
	
	//根据地址获取key对应的筛选值
    window.getValueByHash = function(key){
        var hash = window.location.hash;
        if(hash.indexOf(key)<0){
            return "";
         }
    	var url = hash.split("cri.q=")[1];
		    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
	    var r=url.match(reg);
		    if(r!=null){
		    	 return unescape(r[2]);
		    }
		    return "";
        };
});