define([
    "dojo/_base/declare",
    "dojo/ready",
    "dojo/dom-construct",
    "dojo/dom-style",
    "dojo/dom-attr",
    "dojo/dom-class",
    "dojox/mobile/viewRegistry",
    "mui/util","mui/i18n/i18n!sys-task:mui.sysTaskMain"
	], function(declare,ready,domConstruct,domStyle,domAttr,domClass,viewRegistry,util,Msg) {
	
	return declare("sys.task.list._CollpaseListItemMixin", null , {
		
		maxCount:10,
		
		collpase:true,
		
		buildRendering:function(){
			this.inherited(arguments);
			var self=this,
				maxCount=this.maxCount;
			
			this.url=util.setUrlParameter(this.url,'rowsize',maxCount);
			
			var parentWidget = this.getParent();
			if(parentWidget){
				domClass.add(parentWidget.domNode,'muiTaskPanel');
			}
			this.subscribe('/mui/list/loaded', function(widget,items){
				if(this == widget ){
					//var children=widget.getChildren();
					//总数超过maxcount，多余行隐藏(点击可展开)
					var page=items.page,
						leftCount=page.totalSize-(page.currentPage*page.pageSize);
					if(self.collpase && leftCount > 0){
						//for(var i=maxCount;i<children.length;i++){
						//	domStyle.set(children[i].domNode,'display','none');
						//}
						self.buildToggleDom(items);//构造展开节点
					}else{
						self.collpase=false;
						self.buildToggleDom(items);//销毁展开节点
					}
				}
			});
			//this.subscribe('/mui/navitem/_selected','resizeList');
		},
		
		buildToggleDom:function(items){
			if(!this.toggleDom){
				this.toggleDom=domConstruct.create('li',{className:'toggle'},this.domNode,'last');
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
				domAttr.set(this.toggleDom,'innerHTML',Msg['mui.sysTaskMain.remaining']+leftCount+Msg['mui.sysTaskMain.item']);
				domConstruct.create('i',{className:'mui mui-down-n'},this.toggleDom);
				domConstruct.place(this.toggleDom,this.domNode,'last');
			}else{
				domConstruct.destroy(this.toggleDom);
				//domAttr.set(this.toggleDom,'innerHTML','');
				//domConstruct.create('i',{className:'mui mui-up-n'},this.toggleDom);
			}
		},
		
		buildLoadingDom:function(){
			if(this.toggleDom){
				domConstruct.empty(this.toggleDom);
				domAttr.set(this.toggleDom,'innerHTML',Msg['mui.sysTaskMain.loading']);
			}
		},
		
		___toggle:function(){
			if(this.collpase){
				
				if(this._loadOver){
					
				}else{
					this.buildLoadingDom();
					this.loadMore();
				}
				
				//for(var i=this.maxCount;i<children.length;i++){
				//	domStyle.set(children[i].domNode,'display','block');
				//}
				//this.collpase=false;
			}else{
				//for(var i=this.maxCount;i<children.length;i++){
				//	domStyle.set(children[i].domNode,'display','none');
				//}
				//this.collpase=true;
			}
			//this.buildToggleDom();
		},
		
		handleOnPush:function(){
			//滑动到底部不刷加载更多操作
		},
		
		hasResize:false,
		
		resizeList:function(){
			var parentView = viewRegistry.getEnclosingView(this.domNode);
			if(!parentView)
				return;
			if(!this.hasResize && parentView.isVisible()){
				if(this.tempItem){
					var parentWidget = this.getParent();
					var	h = parentWidget.domNode.offsetHeight;
					domStyle.set(this.tempItem.domNode,{
						'height' : h + 'px',
						'line-height' : h + 'px'
					});
				}
				this.hasResize = true;
			}
		}
		
	});
});