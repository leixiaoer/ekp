/**
 * 网上调查改成卡片式翻页(逻辑实现在QuestionResponseList中),分页组件废弃
 */
define(["dojo/_base/declare","dijit/_WidgetBase","dojo/_base/array","dojo/query","dojo/dom-construct","dojo/dom-style","dojo/topic","dojo/ready"],
		function(declare,WidgetBase,array,query,domConstruct,domStyle,topic,ready){
	
	return declare("km.pindagate.QuestionPage",[WidgetBase],{
		
		currentPage:1,
		totalPage:1,
		
		lock:false,
		
		pagingTopic:'km/pindagate/paging',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.preButton=domConstruct.create('div',{className:'pageOpt pre'},this.domNode);//上一页
			domConstruct.create('i',{className:'mui mui mui-back'},this.preButton);
			domConstruct.create('span',{innerHTML:'上一页'},this.preButton);
			
			this.nextButton=domConstruct.create('div',{className:'pageOpt next'},this.domNode);//下一页
			domConstruct.create('span',{innerHTML:'下一页'},this.nextButton);
			domConstruct.create('i',{className:'mui mui-forward'},this.nextButton);
			
			this.bindEvent();
			this.setDisplay();
			
		},
		
		bindEvent:function(){
			this.connect(this.preButton,"click",function(evt){
				if(this.currentPage <= 1)
					return;
				this.currentPage--;
				this.setDisplay();
				topic.publish(this.pagingTopic,{currentPage:this.currentPage,pageType:'many' });
			});
			this.connect(this.nextButton,"click",function(evt){
				if(this.currentPage >= this.totalPage)
					return;
				this.currentPage++;
				this.setDisplay();
				topic.publish(this.pagingTopic,{currentPage:this.currentPage,pageType:'many' });
			});
		},
		
		setDisplay:function(){
			//当前页数为第一页时不显示
			domStyle.set(this.preButton,'display','');
			domStyle.set(this.nextButton,'display','');
			if(this.currentPage == 1){
				domStyle.set(this.preButton,'display','none');
			}
			if(this.currentPage==this.totalPage){
				domStyle.set(this.nextButton,'display','none');
			}
			if(this.totalPage == 1){
				domStyle.set(this.preButton,'display','none');
				domStyle.set(this.nextButton,'display','none');
			}
		},
		
		startup:function(){
			var self=this;
			this.inherited(arguments);
			ready(function(){
				topic.publish(self.pagingTopic,{currentPage:self.currentPage,pageType:'many' });
			});
		}
		
	});
});
