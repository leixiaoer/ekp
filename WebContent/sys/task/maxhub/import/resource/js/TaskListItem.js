define([ 'dojo/_base/declare',
         'dojo/query',
         'dojo/dom-construct',
         'mhui/list/ItemBase',
         'dojo/dom-class',
         'dojo/dom-style',
         'dojo/on',
         'mhui/dialog/Dialog',
         'dojo/topic',
         'dijit/registry',
         'mui/dialog/Tip'
        ],
	function(declare,query,domConstruct,ItemBase,domClass,domStyle,on,dialog,topic,registry,tip) {
		return declare('sys.task.maxhub.TaskListItem', [ItemBase], {

			renderItem:function(){
				var ctx = this;
				
				//创建列表dom
				var ItemContent = domConstruct.create("div",{className:'mhuiItemTask'},ctx.domNode);
				var subject = domConstruct.create('div',{className:'mhuiTaskSubject'},ItemContent);
				var h4 = domConstruct.create('div',{className:'mhuiTaskTitle',innerHTML:ctx.title},subject);
				var info = domConstruct.create('div',{className:'mhuiTaskInfo',innerHTML:"<div >负责人:</div><div class='performs'>"+ctx.performs+"</div><div class='completeTimeSpan'>完成时间:</div><div>"+ctx.fdPlanCompleteDateTime+"</div>"},subject);
				var progress = domConstruct.create('div',{className:'TaskProgress',innerHTML:''},ItemContent);
				var progressClip = domConstruct.create('div',{className:'progressClip'},progress);
				
				var progressLeft = domConstruct.create('div',{className:'progressLeft'},progressClip);
				var progressRight =domConstruct.create('div',{className:'progressRight rightHidden'},progressClip);
				var num =domConstruct.create('div',{className:'progressValue',innerHTML:ctx.progress+"%"},progress);	
				
          
				/*设置圆形进度条*/
				
				if(ctx.progress<=50&&ctx.progress>=0){
					domStyle.set(progressLeft,"transform",'rotate('+ 3.6*ctx.progress + 'deg)');
				}
				if(ctx.progress>50){
					domStyle.set(progressLeft,"transform",'rotate('+ 3.6*50 + 'deg)');
					domClass.remove(progressRight,"rightHidden");
					domClass.add(progressClip,"progressshow");
					domStyle.set(progressRight,"transform",'rotate('+ 3.6*(ctx.progress-50) + 'deg)');
				}
				//驳回暂停
				if(ctx.fdStatus=="4"||ctx.fdStatus=="5"){
					domStyle.set(progressLeft,"border-color","#EA4335");
					domStyle.set(progressRight,"border-color","#EA4335");
					num.innerHTML = ctx.fdStatusText;
				}
				//完成结项
				if(ctx.fdStatus=="3"||ctx.fdStatus=="6"||ctx.fdStatus=="1"){
					domStyle.set(progressLeft,"border-color","#EBE9E9");
					domStyle.set(progressRight,"border-color","#EBE9E9");
					num.innerHTML = ctx.fdStatusText;
				}
				ctx._updata();
			},
			//此方法用于编辑任务
			_updata:function(){
				var ctx = this;
				var fdModelId = null;
				topic.subscribe("correspond/fdModelId",function(e){
					fdModelId = e;
				});
			
				on(this.domNode,"click",function(e){
					
					var fdId = ctx.fdId;
					var fdModelName = 'com.landray.kmss.km.imeeting.model.KmImeetingMain';
					var iframeUrl = 'sys/task/sys_task_main/sysTaskMain.do?method=edit&fdModelId='+fdModelId+'&fdModelName='+fdModelName+'&fdId='+fdId+'&taskName='+ctx.title;
					var dialogObj = dialog.show({
						  width:"73.75rem",
						  height:"56.5rem",
						  title:"面对面建任务",
						  iframe:location.origin + dojoConfig.baseUrl+iframeUrl,
						  iframeHeight:"46.5rem",
						  buttons:[{text:'取消',onClick:unpdataTaskCancel},{text:'确定',onClick:updateTask}]
					  });
					function updateTask(){
						tip.processing();
						var iframe = query("iframe");
						var commit_promise = iframe[0].contentWindow.task_commit();
						if(commit_promise){
							commit_promise.then(function(){
								dialogObj.hide();
								//为了编辑页面后重新渲染列表页面
								var dataList = registry.byId('datalist');
								dataList.getRequest().then(function(){
									dataList.renderList(dataList.__data,false);
									tip.success();
								});
							});
						}else{
							console.log(new Error("验证未通过"));
						}
							
					}
					
					function unpdataTaskCancel(){
						dialogObj.hide();
					} 
					var iframe = query("iframe");
					
					window.taskInfo={title:ctx.title,appoint:ctx.appoint,created:ctx.created,fdPlanCompleteDateTime:ctx.fdPlanCompleteDateTime,
							fdStatus:ctx.fdStatus,fdStatusText:ctx.fdStatusText,overDay:ctx.overDay,performSrc:ctx.performSrc,
							performs:ctx.performs,personCount:ctx.personCount,progress:ctx.progress,title:ctx.title,performsid:ctx.performsid
					};

				});
			}
		
		
		});
	}
);