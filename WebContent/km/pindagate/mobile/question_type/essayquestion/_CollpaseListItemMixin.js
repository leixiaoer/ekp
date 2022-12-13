define([
    "dojo/_base/declare",
    "dojo/ready",
    "dojo/dom-construct",
    "dojo/dom-style",
    "dojo/dom-attr",
    "mui/util",
    "dojo/topic"
	], function(declare,ready,domConstruct,domStyle,domAttr,util,topic) {
	
	return declare("km.pindagate.essayquestion._CollpaseListItemMixin", null , {
		
		collpase:true,
		
		isLoding:false,
		
		buildRendering:function(){
			this.inherited(arguments);
			var self=this;
			
			this.subscribe('/km/pindagate/essayquestion/loaded', function(widget,items){
				if(this == widget ){
					var page=items.page,
						leftCount=page.totalSize - (page.currentPage * page.pageSize);
					if(self.collpase && leftCount > 0){
						self.buildToggleDom(items);//构造展开节点
					}else{
						self.collpase=false;
						self.buildToggleDom(items);//销毁展开节点
					}
					this.isLoding = false;
				}
			});
		},
		
		buildToggleDom:function(items){
			if(!this.toggleDom){
				this.toggleDom=domConstruct.create('div',{className:'toggle'},this.renderNode,'last');
				domStyle.set(this.toggleDom,{
					'text-align':'center',
					'margin':'0.5rem 0'
				});
				this.connect(this.toggleDom,'click','___toggle');
			}
			if(this.collpase){
				//折叠情况,显示dom为展开
				var page=items.page,
					leftCount=page.totalSize-(page.currentPage*page.pageSize);
				domConstruct.empty(this.toggleDom);
				domAttr.set(this.toggleDom,'innerHTML','还有'+leftCount+'人');
				domConstruct.create('i',{className:'mui mui-down-n'},this.toggleDom);
				domConstruct.place(this.toggleDom,this.renderNode,'last');
			}else{
				domConstruct.destroy(this.toggleDom);
			}
		},
		
		buildLoadingDom:function(){
			if(this.toggleDom){
				domConstruct.empty(this.toggleDom);
				domAttr.set(this.toggleDom,'innerHTML','正在加载...');
				this.isLoding = true;
			}
		},
		
		___toggle:function(evt){
			if(!this.isLoding){
				if(this.collpase && !this._loadOver){
					this.buildLoadingDom();
					topic.publish('/km/pindagate/essayquestion/toggle',this)
					//this.loadMore();
				}
			}
			
		}
		
	});
});