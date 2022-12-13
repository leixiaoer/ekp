seajs.use(['lui/framework/module','lui/jquery','lui/dialog','lui/topic','lui/spa/const','lui/framework/router/router-utils','lui/toolbar','lang!km-review'],
		function(Module, jquery, dialog, topic,spaConst,routerUtils ,toolbar,lang){
	
	var module = Module.find('kmReview');
	
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
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.all'], route:{ path: '/listAll' }, cri :{'mydoc':'all','j_path':'/listAll','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/listCreate', //我起草的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.create.my'], route:{ path: '/listCreate' }, cri :{'mydoc':'create','j_path':'/listCreate','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/listApproved', //我已审的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.approved.my'], route:{ path: '/listApproved' }, cri :{'mydoc':'approved','j_path':'/listApproved','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/listApproval', //待审我的
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.approval.my'], route:{ path: '/listApproval' }, cri :{ 'mydoc':'approval','cri.q':'docStatus:20' ,'j_path':'/listApproval','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/overview', //分类概览
				action : function(){
					openPage($var.$contextPath +'/km/review/km_review_main/kmReviewMain_preview.jsp');
				}
			},{
				path : '/create', //发起流程
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/review/km_review_ui/createDoc.jsp?isSimpleCategory=false&mainModelName=com.landray.kmss.km.review.model.KmReviewMain&modelName=com.landray.kmss.km.review.model.KmReviewTemplate',
						target : '_rIframe'
					}
				}
			},{
				path : '/listExamine', //流程审批
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.examine'], route:{ path: '/listExamine' }, cri :{ 'doctype':'examine','cri.q':'docStatus:20','j_path':'/listExamine','cri.q':$var.startAndEndTime } , selected : true }
						}
					}
				}
			},{
				path : '/listFollow', //流程跟踪
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.follow'], route:{ path: '/listFollow' }, cri :{ 'doctype':'follow' ,'j_path':'/listFollow','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/listFeedback', //流程反馈
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.feedback'], route:{ path: '/listFeedback' }, cri :{ 'doctype':'feedback','cri.q':'docStatus:41' ,'j_path':'/listFeedback','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/search', //流程查询
				action : function(){
					openSearch();
				}
			},{
				path : '/dbNavTree', //图表中心
				action : function(){
					openDbNavTree();
				}
			},{
				path : '/listFiling', //归档箱
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.filed'], route:{ path: '/listFiling' }, cri :{ 'fdIsFile':'1','j_path':'/listFiling','cri.q':$var.startAndEndTime } , selected : true }
						}
					}
				}
			},{
				path : '/listDiscard', //废弃箱
				action : {
					type : 'tabpanel',
					options : {
						panelId : 'kmReviewPanel',
						contents : {
							'kmReviewContent' : { title : lang['kmReview.nav.discard'], route:{ path: '/listDiscard' }, cri :{ 'docStatus':'00' ,'j_path':'/listDiscard','cri.q':$var.startAndEndTime} , selected : true }
						}
					}
				}
			},{
				path : '/recover', //回收站
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/km/review/km_review_ui/sysRecycleBox.jsp',
						target : '_rIframe'
					}
				}
			},{
				path : '/sys/subordinate', // 下属工作
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/subordinate/moduleindex.jsp?moduleMessageKey=km-review:module.km.review',
						target : '_rIframe'
					}
				}
			},
			{
				path : '/management', // 后台管理
				action : {
					type : 'pageopen',
					options : {
						url : $var.$contextPath + '/sys/profile/moduleindex.jsp?nav=/km/review/tree.jsp',
						target : '_rIframe'
					}
				}
			}
			]
		});
		
		// 监听新建更新等成功后刷新
		topic.subscribe('successReloadPage', function() {
			setTimeout(function(){
				topic.publish('list.refresh');
			},300);
		});
		
		$function.openPreview = function(id){
			if (seajs.data.env.isSpa) {
				topic.publish("nav.operation.clearStatus", null);
				var router = routerUtils.getRouter();
				if (router) {
					router.push('/listAll',{
						cri : { 'cri.q' : 'fdTemplate:' + id }
					});
				}
			}
		};
		
		
		//查询
		function openSearch(){
			var url = $var.$contextPath + '/sys/search/ui/nav_search_new.jsp';
			url = Com_SetUrlParameter(url, 'showTree', "true");
			url = Com_SetUrlParameter(url, 'modelName', "com.landray.kmss.km.review.model.KmReviewMain");
			url = Com_SetUrlParameter(url, 'searchTitle',  encodeURIComponent(lang['kmReview.nav.search']));
			LUI.pageOpen(url, '_rIframe');
		}
		
		//图表中心
		function openDbNavTree(){
			var url = $var.$contextPath + '/dbcenter/echarts/application/navTree/nav.jsp';
			url = Com_SetUrlParameter(url, 'mainModelName', "com.landray.kmss.km.review.model.KmReviewTemplate");
			url = Com_SetUrlParameter(url, 'fdKey', "kmReviewMainDoc");
			url = Com_SetUrlParameter(url, 'title',  encodeURIComponent(Data_GetResourceString("dbcenter-echarts:module.dbcenter.dataChart")));
			LUI.pageOpen(url, '_rIframe');
		}
		
		 var cateId= '', nodeType = '',docStatus = 0,fdIsNotFile = false;
		
		//根据筛选器分类异步校验权限
		topic.subscribe('criteria.spa.changed',function(evt){
			if($var.isAdmin == 'false'){
				if(typeof $var.isDel =='undefined' || !($var.isDel == 'true')){
					if(LUI('del')){
						LUI('Btntoolbar').removeButton(LUI('del'));
						LUI('del').destroy();
					}
				}
				if(typeof $var.isChgCate =='undefined' || !($var.isChgCate == 'true')){
					if(LUI('chgCate')){
						LUI('Btntoolbar').removeButton(LUI('chgCate'));
						LUI('chgCate').destroy();
					}
				}
				if(LUI('docChangeRightBatch')){
					LUI('Btntoolbar').removeButton(LUI('docChangeRightBatch'));
					LUI('docChangeRightBatch').destroy();
				}	
				if(LUI('fileBtn')){
					LUI('Btntoolbar').removeButton(LUI('fileBtn'));
					LUI('fileBtn').destroy();
				}		
				
			}
			//筛选器变化时清空分类和节点类型的值
			cateId = "";  
			nodeType = "";
			var hasCate = false;
			fdIsNotFile = false;
			/*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-开始*/
			var _docStatus = "";
			/*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-结束*/
			for(var i=0;i<evt['criterions'].length;i++){
				  //获取分类id和类型
             	  if(evt['criterions'][i].key == "fdTemplate"){
             		 hasCate = true;
                 	 cateId= evt['criterions'][i].value[0];
	                 nodeType = evt['criterions'][i].nodeType;
             	  }
             	   if(evt['criterions'][i].key == 'docStatus') {
             		  /*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-开始*/
					  /*docStatus = evt['criterions'][i].value[0];*/
					  _docStatus = docStatus = evt['criterions'][i].value[0];
					  /*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-结束*/
				  }
             	  if(evt['criterions'][i].key == 'fdIsFile') {
             		 fdIsNotFile = evt['criterions'][i].value[0] == '0';
				  }
			}
			//分类变化刷新
			if(hasCate){
				showButtons(cateId,nodeType);
			}
			
			//筛选器全部清空的情况
			if(evt['criterions'].length==0){
				 showButtons('','');
			}
			
			/*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-开始*/
			if(!_docStatus || (_docStatus!="31" && _docStatus!="41")){
				LUI("feedbackPanel").element.find('[data-lui-val]').removeClass('selected');
			}
			/*#130243-流程反馈的列表数据包含未结束的文档，选择已反馈再点击流程反馈，状态还是被选择-结束*/
			
			/*#131393-流程审核的筛选项功能，取消选中后还是被选中的颜色-开始*/
			if(!_docStatus || (_docStatus!="20" && _docStatus!="11")){
				LUI("examinePanel").element.find('[data-lui-val]').removeClass('selected');
			}
			/*#131393-流程审核的筛选项功能，取消选中后还是被选中的颜色-结束*/
		});
		
		function showButtons(categoryId, nodeType){
			var checkChgCateUrl = "/km/review/km_review_main/kmReviewMain.do?method=changeTemplate&categoryId="+categoryId+"&nodeType="+nodeType;
			var changeRightBatchUrl = "/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=com.landray.kmss.km.review.model.KmReviewMain&categoryId="+categoryId+"&nodeType="+nodeType;
			var checkDelUrl = "/km/review/km_review_main/kmReviewMain.do?method=deleteall&categoryId="+categoryId+"&nodeType="+nodeType;
			var checkFileDocUrl = "/km/archives/km_archives_file_template/kmArchivesFileTemplate.do?method=fileDocAll&modelName=com.landray.kmss.km.review.model.KmReviewMain&categoryId="+categoryId+"&nodeType="+nodeType;
			  
			var data = new Array();
			data.push(["delBtn",checkDelUrl]);
            data.push(["chgcateBtn",checkChgCateUrl]);
            data.push(["changeRightBatchBtn",changeRightBatchUrl]);
            data.push(["fileBtn",checkFileDocUrl]);
            $.ajax({
            	url: $var.$contextPath + "/sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
            	dataType : 'json',
      			type : 'post',
      			data:{  data : LUI.stringify(data) },
      			async : false,
      			success : function(rtn){
      				for(var i = 0;i < rtn.length;i++){
      					if(rtn[i]['delBtn'] == 'true'){
      						if(!LUI('del')){
		                 		var delBtn = toolbar.buildButton({ id:'del',order:'3',text:$lang['buttonDelete'], click:'window.moduleAPI.kmReview.delDoc()'});
		    					LUI('Btntoolbar').addButton(delBtn);
		                	  }
      					}
      					if(rtn[i]['chgcateBtn'] == 'true'){
      						if(!LUI('chgCate')){
			                 	var chgcateBtn = toolbar.buildButton({id:'chgCate',order:'5',text:lang['button.translate'] ,click:'window.moduleAPI.kmReview.chgSelect()'});
			    				LUI('Btntoolbar').addButton(chgcateBtn);
		                	  }
      					}
      					if(rtn[i]['changeRightBatchBtn'] == 'true'){
      						if(!LUI('docChangeRightBatch')){
			                 	var changeRightBatchBtn = toolbar.buildButton({id:'docChangeRightBatch',order:'4',text:$lang['changeRightBatch'],click:'changeRightCheckSelect("'+categoryId+'","'+nodeType+'")'});
			    				LUI('Btntoolbar').addButton(changeRightBatchBtn);
      						}
      					} 
      					if(rtn[i]['fileBtn'] == 'true'){
      						if(!LUI('fileBtn') && (docStatus == '30' || docStatus == '31') && fdIsNotFile){
		                 		var fileBtn = toolbar.buildButton({ id:'fileBtn',order:'2',text: $lang['buttonFiled'] ,click:'window.moduleAPI.kmReview.file_doc()'});
		    					LUI('Btntoolbar').addButton(fileBtn);
      						}
      					}
      				}
      			}
            });
		}
		
		//新建文档
		$function.addDoc = function(){
			dialog.categoryForNewFile(
					'com.landray.kmss.km.review.model.KmReviewTemplate',
					'/km/review/km_review_main/kmReviewMain.do?method=add&fdTemplateId=!{id}',false,null,null,cateId,null,null,true);
		};
		
		//删除文档
		$function.delDoc = function(draft){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
			if(values.length==0){
				dialog.alert($lang['pageNoSelect']);
				return;
			}
			var url = $var.$contextPath + '/km/review/km_review_main/kmReviewMain.do?method=deleteall';
			url = Com_SetUrlParameter(url, 'categoryId', cateId);
			url = Com_SetUrlParameter(url, 'nodeType', nodeType); 
			if(draft == '0'){
				url = $var.$contextPath + '/km/review/km_review_main/kmReviewMain.do?method=deleteall&status=10';
			}
			var config = {
				url : url, // 删除数据的URL
				data : $.param({"List_Selected":values},true), // 要删除的数据
				modelName : "com.landray.kmss.km.review.model.KmReviewMain" // 主要是判断此文档是否有部署软删除
			};
			// 通用删除方法
			function delCallback(data){
				topic.publish("list.refresh");
				dialog.result(data);
			}
			Com_Delete(config, delCallback);
		};
		
		//分类转移
		$function.chgSelect = function(){
			var values = '';
			$("input[name='List_Selected']:checked").each(function(){
				values += "," + $(this).val();
			});
			if(values==''){
				dialog.alert(lang['message.trans_doc_select']);
				return;
			}
			values = values.substring(1);
			var cfg={
				modelName : 'com.landray.kmss.km.review.model.KmReviewTemplate',
				mulSelect : false,
				authType : '01',
				action : function(value,____dialog){
					if(value && value.id){
						window.chg_load = dialog.loading();
						$.post($var.$contextPath + '/km/review/km_review_main/kmReviewMain.do?method=changeTemplate',
								$.param({ values : values, fdTemplateId : value.id },true),function(data){
									if(window.chg_load!=null)
										window.chg_load.hide();
									if(data!=null && data.status==true){
										topic.publish("list.refresh");
										dialog.success($lang['optSuccess']);
									}else{
										dialog.failure($lang['optFailure']);
									}
							},'json');
					}
				}
			};
			dialog.category(cfg);
		};
		
		//批量打印
		$function.batchPrint = function(){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
			if(values.length==0){
				dialog.alert($lang['pageNoSelect']);
				return;
			}
			if(values.length>50){
				dialog.alert(lang['kmReviewMain.print.hint']);
				return;
			}
			var url =  $var.$contextPath + '/km/review/km_review_main/kmReviewMain.do?method=printBatch&fdIds=' + values;
			Com_OpenWindow(url);
		};
		
		$function.file_doc = function(){
			var values = [];
			$("input[name='List_Selected']:checked").each(function(){
				values.push($(this).val());
			});
			if(values.length==0){
				dialog.alert($lang['pageNoSelect']);
				return;
			}
			var url = $var.$contextPath + '/km/archives/km_archives_file_template/kmArchivesFileTemplate.do?method=fileDocAll';
			dialog.confirm($lang['confirmFiled'],function(value){
				if(value == true){
					window.file_load = dialog.loading();
					$.ajax({
						url: url,
						type: 'POST',
						data:$.param({'List_Selected' : values, 'serviceName' : 'kmReviewMainService'},true),
						dataType: 'json',
						error: function(data){
							if(window.file_load!=null){
								window.file_load.hide(); 
							}
							dialog.result(data.responseJSON);
						},
						success: function(data){
							if(window.file_load!=null){
								window.file_load.hide(); 
							}
							topic.publish('list.refresh');
							dialog.result(data);
						}
				   });
				}
			});
		};
		
		
	});
});