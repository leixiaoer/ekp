define([ 'dojo/_base/declare',
         'mhui/list/ItemListBase',
         "dojo/request",
         './TaskListItem',
         'dojo/_base/array',
         'mhui/util',
         'dojo/topic',
         'dojo/query',
         "dojo/dom-class",
         'dojo/dom-construct'
        ],
	function(declare,ItemListBase,request,ItemRender,array,util,topic,query,domClass,domCtr) {
	
		return declare('sys.task.maxhub.TaskListMixin', [ItemListBase], {
			
			url:"",
			taskTitle:'',/*item 中的数据标题*/
			taskTime:'',/*item时间*/			
			taskProgressValue:0,
			taskStatus:null,
			itemRenderer:ItemRender,
			__data:[],
			getRequest:function(){
				var ctx = this;
				var rootNode = query(".taskList")[0].parentNode;
				
				return request.post(this.url,{
					handleAs:'json',
					data:{
						pageno:1
					}
				}).then(function(response){
					if(response.datas.length>0){
						var data = [];
						domClass.remove(rootNode,"noTaskImage");
						for(var i = 0;i<response.datas.length;i++){
							var temp = {};
							array.forEach(response.datas[i],function(item){
								temp[item.col]=item.value;
							});
							data.push(temp);
						}
					}else{
						var imgNode = domCtr.create("div",{class:"noTaskImage"},rootNode);
						domCtr.create("div",{class:"notImage",innerHTML:"暂无会议任务"},imgNode);
					}
					ctx.__data = data;
				});		
			},
			getList:function(cb){
				var ctx = this;
				var fdModelId = util.getUrlParameter(ctx.url,"fdModelId");
				ctx.getRequest().then(function(){
					cb(ctx.__data);
					topic.publish("correspond/fdModelId",fdModelId);
				});	
			},	
		});
	}
);