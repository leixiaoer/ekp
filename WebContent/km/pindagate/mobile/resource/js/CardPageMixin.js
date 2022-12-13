/**
 * 卡片式翻页Mixin
 */
define(["dojo/_base/declare","dojo/ready","dojo/dom-construct","dojo/dom-style","dojo/dom-attr","dojo/dom-geometry","dojo/dom-class",
        "dojo/query","dojox/mobile/_css3","dojo/touch","dojo/_base/array","dojo/topic","dojo/html","dojox/mobile/viewRegistry",
        "dojo/_base/window","mui/dialog/Tip","mui/i18n/i18n!km-pindagate:mobile","dojo/dom","dojo/on"],
		function(declare,ready,domConstruct,domStyle,domAttr,domGeometry,domClass,query,css3,touch,array,topic,html,viewRegistry,win,Tip,msg,dom,on){
	
	return declare("km.pindagate.CardPageMixin",null,{
		
		_pageConnects:[],
		
		cards:[],
		cardCount:1,
		
		currentPage:1,
		totalPage:1,
		
		lock:false,
		
		buildRendering:function(){
			this.inherited(arguments);		
			//当题目数>=3时，最多只显示3个层级
			this.cardCount=1;
			this.buildInternalRender();
			//卡片初始化
			this.drawCards();
			//翻页事件
			//this.bindEvent();
		},
		
		startup:function(){
			this.inherited(arguments);
			var self=this;
			//初始化
			ready(function(){
				var children=self.getChildren();
				//总页数根据题型组件个数来确定(不精准,最好加上instanceof BaseResponse判断)
				self.totalPage=children.length;
				//记录初始化时组件的顺序,后面方便寻址
				self.__children=(function(){
					var c=[];
					for(var i=0;i<children.length;i++){
						c.push(children[i]);
					}
					return c;
				})();
				//填充卡片
				var begin = 0,
					end = begin + self.cardCount;
				for(var i = begin, j=0 ; i < end; i++,j++){
					var card=self.cards[j],
						widget=self.__children[i];
					self.fillCard(card,widget);
				}
				//分页信息
				self.set('currentPage',self.currentPage);
				self.set('totalPage',self.totalPage);
				//翻页事件
				topic.publish('km/pindagate/paging',{
					currentPage : self.currentPage,
					totalPage : self.totalPage,
					pageType : 'custom'
				});
				var statisticNav = dom.byId("statisticNav");
				if (statisticNav!=null) {
					if ( self.currentPage==self.totalPage) {
						domStyle.set(self.navPrev,"display","none");
					}else{
						domStyle.set(self.navPrev,"display","block");
					}
				}
			});
			var self = this;
			var styleTop = dom.byId("topNext");
			var submitButtend = dom.byId("submitButtend");
			var curPage=1;
			//上一页
			topic.subscribe('km/pindagate/mvevent',function(){
				var num = curPage;
				for (; num <= allTopics.length; num--) {
					var _idx = num - 2;
                    if (_idx >= 0 && allTopics[_idx].isShow) {
						curPage = num;
                    	// 显示下一题
						break;
                    }
					if(num < 0) {
						break;
					}
                }
				var navSgin = "";
				navSginVal=dom.byId("navSgin");
				if (navSginVal) {
					navSgin=navSginVal.value;
				}
				if(curPage <= 2 ){
					domClass.remove(styleTop,"active");
				}
				if(curPage > 1 ){
					//移除底部卡片
					var card=self.cards.pop();
					self.destoryCard(card);
					self.__children[curPage -1].hide();	
					
					var currentNow=--curPage;
					if (navSgin) {
						currentNow=checkCurrent(currentNow,navSgin);
						curPage=currentNow;
					}
					
					//翻页
					self.set('currentPage',currentNow);
					
					//顶层添加新的卡片
					card=domConstruct.create('div',{className:'pindagate_body'},self.domNode);
					self.smooth(card,450);//transition
					self.cards.unshift(card);
					
					//顶部卡片内容填充
					self.fillCard(self.cards[0], self.__children[currentNow -1 ]);
					//卡片样式调整
					
					self.drawCards();
					
					//翻页事件
					topic.publish('km/pindagate/paging',{
						currentPage : currentNow,
						totalPage : self.totalPage,
						pageType : 'custom'
					});
					//操作结束
					topic.publish('km/pindagate/touchEnd',self);
				}
			},500); 
			
			function checkCurrent(currentNow,navSgin){
				if (navSgin) {
					navSgin=JSON.parse(navSgin);
					for ( var h in navSgin) {
						if (navSgin[h]==currentNow) {
							currentNow=parseInt(currentNow)-parseInt("1");
							if (navSgin.indexOf(currentNow)>-1) {
								currentNow = checkCurrent(currentNow,JSON.stringify(navSgin));
							}
						}
					}
				}
				return currentNow;
			}; 
			
			//下一页
			var self = this;
			topic.subscribe('km/pindagate/mveventend',function(idx){ // num是题目序号，从1开始
				var num = curPage;
				for (; num < allTopics.length; num++) {
                    if (allTopics[num].isShow) {
                    	// 显示下一题
						curPage = num;
						break;
                    }
                }
				var navSgin = "";
				navSginVal=dom.byId("navSgin");
				if (navSginVal) {
					if (navSginVal.value) {
						navSgin=JSON.parse(navSginVal.value);
					}
				}
				if(curPage > 1 ){
					domClass.add(styleTop,"active");
				}
				if(self.validate){
					result=self.validate(idx-1);//校验
				}
				var method_GET=query('[name="method_GET"]').val();
				if (method_GET!="view") {
					if (!result) {
						return;
					}
				}
				if (self.totalPage>curPage) {
					self.defer(function(){
						//移除顶层卡片
						var card=self.cards.shift();
						this.destoryCard(card);
						//移出来的题目隐藏
						this.__children[curPage - 1].hide();
						//底部添加新的卡片
						card=domConstruct.create('div',{className:'pindagate_body'},self.domNode);
						this.cards.push(card);
						var currentNow=++curPage;
						if (navSgin) {
							for ( var h in navSgin) {
								if (navSgin[h]==currentNow) {
									currentNow=parseInt(currentNow)+parseInt("1");
								}
							}
						}
						if (currentNow>self.totalPage) {
							currentNow=self.totalPage;
						}
						//翻页
						this.set('currentPage',currentNow);
						//底部卡片内容填充
						this.fillCard(this.cards[1 - 1], this.__children[currentNow-1] );
						//卡片样式调整
						this.drawCards();
						
						if (currentNow>self.totalPage) {
							return;
						}
						//翻页事件
						topic.publish('km/pindagate/paging',{
							currentPage : currentNow,
							totalPage : self.totalPage,
							pageType : 'custom'
						});
						
						// topic.publish('km/pindagate/relation');
						
					});
				}
				//操作结束
				topic.publish('km/pindagate/touchEnd',this);
			},500);
			
			function isEmptyObject(obj){  
			     for(var key in obj){  
			           return true; 
			     };  
			     return false;
			};  
			
			topic.subscribe('km/pindagate/navleft',function(){
				var allPanelBody = dom.byId("allPanelBody"),
					countAllSize='';
					children=self.getChildren();
					allPanelBody.innerHTML="";
					var questionSize = dom.byId("questionSize");
					if (questionSize) {
						questionSize=questionSize.value;
						countAllSize=questionSize;
					}
					for(var i=0;i<questionSize;i++){
						var typeSign=dom.byId("type"+i);
						if (typeSign) {
							if (!typeSign.value) {
								countAllSize=parseInt(countAllSize)+parseInt("1");
							}
						}
					}
					//数量填充
					for(var i=0;i<questionSize;i++){
						var navSgin = "";
						navSginVal=dom.byId("navSgin");
						if (navSginVal) {
							navSgin=navSginVal.value;
						}
						
						var navCount=parseInt(i)+parseInt("1");
						var navLeft=domConstruct.create('a',{dataIndex:i+1,innerHTML:i+1,id:'nav'+navCount,className:'pindagate_all_panel_body_item'},allPanelBody);
						if (!self.__children[i]) {
							continue;
						}
						var typeBad=dom.byId("type"+i);
						if (typeBad) {
							if (!typeBad.value) {
								if (isEmptyObject(navSgin)) {
									navSgin=JSON.parse(navSgin);
									for ( var z in navSgin) {
										if (navSgin[z]==navCount) {
											domClass.add(navLeft,'pindagate_display_nav');
										}
									}
								}
								domClass.add(navLeft,'must');
								domConstruct.create('i',{dataIndex:i+1,innerHTML:'*'},navLeft);
								continue;
							}
							var fdOrder=query('[name="fdItems['+i+'].fdOrder"]').val();
							questionResoinseKey=query('[name="questionResoinseKey'+i+'"]')[0];
							questionDef=$(questionResoinseKey).find(".questionDef").val();
							questionDef=JSON.parse(questionDef);
						}
						if (questionDef.willAnswer) {
							domClass.add(navLeft,'must');
							domConstruct.create('i',{dataIndex:i+1,innerHTML:'*'},navLeft);
						}else{
							domClass.remove(navLeft,'must');
						}
						if (isEmptyObject(navSgin)) {
							navSgin=JSON.parse(navSgin);
							for ( var z in navSgin) {
								if (navSgin[z]==navCount) {
									domClass.add(navLeft,'pindagate_display_nav');
								}
							}
							if (navSgin[navCount]) {
								if (navSgin.indexOf(navCount)>-1) {
									domClass.add(navLeft,'pindagate_display_nav');
								}else{
									domClass.remove(navLeft,'pindagate_display_nav');
								}
							}
						}
						var noTypes=dom.byId('noTypes').value;
						var count=i;
						if (noTypes) {
							for (var q = 0; q < noTypes.length; q++) {
								var notTypsVal=noTypes[q];
								if (notTypsVal==",") {
									continue;
								}
								if (parseInt(i)>parseInt(noTypes[q])) {
									count=parseInt(i)-parseInt("1");
								}
							}
						}
						var s=self.__children[i].widget.draftValue;
						var d=self.__children[i].widget.draftValueTxt;
						var flag = false;
						if (s||d) {
							if (self.__children[i].widget.validateResult) {
								cs=self.__children[i].widget.validateResult.canSave;
								if (cs==false) {
									flag=false;
								}else{
									flag=true;
								}
							}else{
								flag=true;
							}
						}else{
							var widgetValue=self.__children[i].widget.value;
							if (self.__children[i].widget.questionDef.defVal==true||self.__children[i].widget.questionDef.strDefVal==true
									||self.__children[i].widget.questionDef.cityVal==true) {
								flag = true;
							}else{
								flag = false;
							}
							if(typeof widgetValue ==="object"){
								for(var key in widgetValue){
									if(widgetValue[key]){
										flag = true;
									}else{
										flag = false;
									}
								}
							}else{
								if(widgetValue){
									flag = true;
								}else{
									flag = false;
								}
							}
						}
						if (navSgin==i) {
							flag == false;
						}
						if(flag == false){
							domClass.remove(navLeft,'done');
						}else{
							domClass.add(navLeft,'done');
						}		
					}
					
					on(query('.pindagate_all_panel_body_item'), "touchstart", function(e){
						curPage = e.target.getAttribute('dataIndex');
						var result = true;
						this.doReset = false;
						if(!result){
							this.dx = 0;self.position = '';
							return;
						}
						if(curPage > 1 ){
							domClass.add(styleTop,"active");
						}else{
							domClass.remove(styleTop,"active");
						}
						self.defer(function(){
							//移除顶层卡片
							var card=self.cards.shift();
							this.destoryCard(card);
							if (curPage==self.totalPage) {
								topic.publish('km/pindagate/display',this.display);
							}
							//移出来的题目隐藏
							
							//底部添加新的卡片
							card=domConstruct.create('div',{className:'pindagate_body'},this.domNode);
							this.cards.push(card);
							
							//翻页
							this.set('currentPage',curPage);
							//底部卡片内容填充
							this.fillCard(this.cards[1 - 1], this.__children[curPage-1] );
							//卡片样式调整
							this.drawCards();
							
							//翻页事件
							topic.publish('km/pindagate/paging',{
								currentPage : curPage,
								totalPage : this.totalPage,
								pageType : 'custom'
							});
							
						});
						//操作结束
						topic.publish('km/pindagate/touchEnd',this);
					}); 
			});
			
			
			//view
			//上一页
			var styleTops = dom.byId("topNexts");
			var styleends = dom.byId("endNexts");
			var statisticNav = dom.byId("statisticNav");
			topic.subscribe('km/pindagate/statistic',function(){
				
				if(self.currentPage == 2 ){
					domClass.remove(styleTops,"active");
				}
				if (self.totalPage>self.currentPage-1) {
					domClass.add(styleends,"active");
				}
				if (statisticNav!=null) {
					if ( self.currentPage-1==self.totalPage) {
						domStyle.set(self.navPrev,"display","none");
					}else if(1==self.totalPage){
						domStyle.set(self.navPrev,"display","none");
					}else{
						domStyle.set(self.navPrev,"display","block");
					}
				}
				if(self.currentPage > 1 ){
					//移除底部卡片
					var card=self.cards.pop();
					self.destoryCard(card);
					//移出来的题目隐藏
					if(self.__children[self.currentPage+ 1])
						self.__children[self.currentPage +1].hide();
					
					//翻页
					self.set('currentPage',--self.currentPage);
					
					//顶层添加新的卡片
					card=domConstruct.create('div',{className:'pindagate_body'},self.domNode);
					self.smooth(card,450);//transition
					self.cards.unshift(card);
					
					//顶部卡片内容填充
					self.fillCard(self.cards[0], self.__children[self.currentPage -1 ]);
					//卡片样式调整
					self.defer(function(){
						self.drawCards();
					},1);
					
					//翻页事件
					topic.publish('km/pindagate/paging',{
						currentPage : self.currentPage,
						totalPage : self.totalPage,
						pageType : 'custom'
					});
					//操作结束
					topic.publish('km/pindagate/touchEnd',self);
				}
			},500); 
			
			//下一页
			topic.subscribe('km/pindagate/statisticend',function(){
				if(self.currentPage == 1 ){
					domClass.add(styleTops,"active");
				}
				if (self.currentPage==self.totalPage-1) {
					domClass.remove(styleends,"active");
				}
				if (statisticNav!=null) {
					if ( self.currentPage+1==self.totalPage) {
						domStyle.set(self.navPrev,"display","none");
					}else{
						domStyle.set(self.navPrev,"display","block");
					}
				}
				if (self.totalPage>self.currentPage) {
					self.defer(function(){
						//移除顶层卡片
						var card=self.cards.shift();
						this.destoryCard(card);
						//移出来的题目隐藏
						this.__children[self.currentPage - 1].hide();
						
						//底部添加新的卡片
						card=domConstruct.create('div',{className:'pindagate_body'},self.domNode);
						this.cards.push(card);
						
						//翻页
						this.set('currentPage',++self.currentPage);
						//底部卡片内容填充
						this.fillCard(this.cards[1 - 1], this.__children[self.currentPage-1] );
						//卡片样式调整
						this.drawCards();
						
						//翻页事件
						topic.publish('km/pindagate/paging',{
							currentPage : this.currentPage,
							totalPage : this.totalPage,
							pageType : 'custom'
						});
						
					});
				}
				//操作结束
				topic.publish('km/pindagate/touchEnd',this);
			},500);
		},
		
		buildInternalRender:function(){
			//edit
			var pindagateNav = dom.byId("pindagateNav");
			var navLeft=domConstruct.create('div',{className:'pindagate_nav_left',"id":"navLeft"},pindagateNav);
			domConstruct.create('div',{className:'pindagate_nav_see'},navLeft);
			domConstruct.create('div',{className:'pindagate_nav_right',"id":"pindagateNavRight"},pindagateNav);
			var nav = dom.byId("pindagateNavRight");
			domConstruct.create('div',{innerHTML:msg['mobile.kmPindagateMain.page.pre'],className:'pindagate_nav_prev','id':'topNext'},nav);
			//分页初始化  muiResponsePage
			this.pageDom=domConstruct.create('div',{className:'pindagate_nav_page pindagate_margin','data-pindagate-widget':'page'},nav);
			this.currentPageInfo=domConstruct.create('span',{innerHTML:this.currentPage},this.pageDom);
			this.totalPageInfo=domConstruct.create('em',{innerHTML:'/'+this.totalPage},this.pageDom);
			this.submit=domConstruct.create('div',{className:'pindagate_nav_submit active',"id":"submitButtend"},nav);
			var method_GET=query('[name="method_GET"]').val();
			if (method_GET=='add') {
				domConstruct.create('a',{innerHTML:msg['mobile.kmPindagate.commitProblem'],'onclick':"saveMethod('save')"},this.submit);
			}else{
				if (method_GET=="view") {
					domConstruct.create('a',{innerHTML:msg['mobile.kmPindagate.commitProblem'],'onclick':""},this.submit);
				}else{
					domConstruct.create('a',{innerHTML:msg['mobile.kmPindagate.commitProblem'],'onclick':"saveMethod('update')"},this.submit);
				}
			}
			
						
			//view
			var statisticNav = dom.byId("statisticNav");
			if (statisticNav!=null) {
				var navLeft=domConstruct.create('div',{className:'pindagate_nav_right',"id":"statisticNavRight"},statisticNav);
				var navs = dom.byId("statisticNavRight");
				domConstruct.create('div',{innerHTML:msg['mobile.kmPindagateMain.page.pre'],className:'pindagate_nav_prev','id':'topNexts'},navs);
				this.pageDoms=domConstruct.create('div',{className:'pindagate_nav_page pindagate_margin','data-pindagate-widget':'page'},navs);
				this.currentPageInfo=domConstruct.create('span',{innerHTML:this.currentPage},this.pageDoms);
				this.totalPageInfo=domConstruct.create('em',{innerHTML:'/'+this.totalPage},this.pageDoms);
				this.navPrev = domConstruct.create('div',{innerHTML:msg['mobile.kmPindagateMain.page.next'],className:'pindagate_nav_prev active','id':'endNexts'},navs);
			}
			
			
			if (dom.byId("topNext")!=null&&dom.byId("navLeft")!=null) {
				on(dom.byId("topNext"), "touchstart", function(e){ 
					topic.publish('km/pindagate/mvevent',this.moveEvent);
			     });
				
				on(dom.byId("navLeft"), "touchstart", function(e){
					e.preventDefault();
					topic.publish('km/pindagate/navleft',this.navLeft);
			     }); 
			}
			if (dom.byId("topNexts")!=null){
				on(dom.byId("topNexts"), "touchstart", function(e){ 
					topic.publish('km/pindagate/statistic',this.statistic);
			     });
				
				on(dom.byId("endNexts"), "touchstart", function(e){
					e.preventDefault();
					topic.publish('km/pindagate/statisticend',this.mveventend);
			     },500); 
			}
			//计算屏幕高度、卡片高度
			if(!this.cssProp){
				this.cssProp={
					height:	win.global.innerHeight,//屏幕高度
					width : win.global.innerWidth
				};
				var cardHeight=this.cssProp.height;
				for (var i = 0, len = this.domNode.childNodes.length; i < len; i++) {
					var node = this.domNode.childNodes[i];
					if(node.nodeType === 1 && node.getAttribute('data-pindagate-widget')){
						if(node.getAttribute('data-pindagate-widget') == 'submit'){
							this.submitDom=node;
						}
						if(node.getAttribute('data-pindagate-widget') == 'page'){
							this.pageDom=node;
						}
						cardHeight = cardHeight - domGeometry.getMarginBox(node).h;
					}
				}
				this.cssProp.cardHeight = cardHeight - 20;
				if(!this.submitDom){
					this.cssProp.cardHeight -=30;
				}
			}
			domStyle.set(this.domNode,'width',this.cssProp.width+'px');
			domStyle.set(this.domNode,'height',this.cssProp.height+'px');
		},
		
		drawCards:function(){
			for(var i=0; i<this.cardCount; i++){
				var card=this.cards[i];
				if(!card){
					card=domConstruct.create('div',{"className":"pindagate_body"},this.domNode);
					this.cards.push(card);
					
				}
				var top=-0+ 'px',
					scale=1 - i * 0.06,
					opacity=1 - i * 0.2,
					dx= i * 1;
				//domStyle.set(card,'z-index',1000-i);//设置层级
				domStyle.set(card,'position',"absolute");
				domStyle.set(card,'top',top);//设置top位置
				domStyle.set(card,'height',(this.cssProp.height-300)+'px');
				domStyle.set(card,'width',this.cssProp.width+'px');
				domStyle.set(card,css3.add({},{
					"-webkit-transform-origin":"bottom right",
					"-webkit-transform": "rotate3d(0, 0, 1, 0deg)"
				}));
			}
		},
		
		bindEvent:function(){
			this.touchStartHandle = this.connect(this.domNode,touch.press, "onTouchStart");
			this.subscribe('km/pindagate/paging','handlePaging');
		},
		
		handlePaging:function(args){	
			var currentPage = args.currentPage,
				totalPage = args.totalPage,
				pageType = args.pageType;
			if(this.submitDom){
				if(currentPage == totalPage){
					domClass.remove(submitButtend,'active');
					this.submitDom.onclick = this.submitDom.onclick || this.submitDom.__onclick;
				}else{
					domClass.add(submitButtend,'active');
					if(this.submitDom.onclick){
						this.submitDom.__onclick = this.submitDom.onclick;
						this.submitDom.onclick = null;
					}
				}
			}
		},
		
		onTouchStart:function(e){
			//this.eventStop(e);
			var view = viewRegistry.getEnclosingView(this.domNode),
				isVisible = view ? view.isVisible() : true;
			
			if(this.lock || !isVisible)
				return;
			this.lock=true;
			this.dx = 0;
			this.dy = 0;
			this._pageConnects.push(this.connect(document.body,touch.move, "onTouchMove"));
			this._pageConnects.push(this.connect(document.body,touch.release, "onTouchEnd"));
			this.startX = e.touches ? e.touches[0].pageX
					: e.clientX;
			this.startY = e.touches ? e.touches[0].pageY
					: e.clientY;
		},
		
		onTouchMove:function(e){
			//this.eventStop(e);
			this.currentX = e.touches ? e.touches[0].pageX : e.clientX;
			this.currentY = e.touches ? e.touches[0].pageY : e.clientY;
			this.dx=this.currentX-this.startX;
			this.dy=this.currentY-this.startY;
			
			this.position=this.getPos(this.dx,this.dy);
			
			//向左滑:下一页
			if(this.dx < -10 &&  this.position=='left' && this.currentPage != this.totalPage  ){
				this.disableInput();//禁用radio、checkbox,防止翻页过程中误点选项
				var dx= this.dx < -180 ? 180 : Math.abs(this.dx);
				for(i = 0;i < this.cardCount - 1; i++){
					var perDeg=i==0 ? 0.25 : 0.15 - i * 0.02 ;
					domStyle.set(this.cards[i],css3.add({},{
						"-webkit-transform":'rotate3d(0,0,1,'+ (0 - perDeg * dx) +'deg)'
					}));//旋转
				}
				this.doReset = true;// 滑动结束后需要回滚
			}
			//向右滑:上一页
			if(this.dx > 10 && this.position == 'right' && this.currentPage != 1 ){
				this.disableInput();
			}
			
		},
		
		onTouchEnd:function(){
			var self=this;
			
			//最后一页了..
			if(this.dx < -10 && this.position=='left' && this.currentPage == this.totalPage ){
				Tip.fail({
					text: msg['mobile.kmPindagateMain.lastPage']
				});
			}
			
			//向左滑:下一页
			if(this.dx < -10 && this.position=='left' && this.currentPage != this.totalPage ){
				var result = true;
				if(this.validate){
					result=this.validate(this.currentPage - 1);//校验
				}
				
				for(i = 0;i < this.cardCount - 1; i++){
					var card=this.cards[i];
					if(i == 0 && result){
						this.smooth(card,800);//transition
						domStyle.set(card,css3.add({},{
							"-webkit-transform":'translate3d(-640px, 0px, 0px)'
						}));
					}else{
						this.smooth(card,250);//transition
						domStyle.set(card,css3.add({},{
							"-webkit-transform":'rotate3d(0,0,1,0deg)'
						}));
					}
				}
				this.doReset = false;
				
				if(!result){
					this.dx = 0;this.position = '';
					return;
				}
				
				this.defer(function(){
					//移除顶层卡片
					var card=this.cards.shift();
					this.destoryCard(card);
					//移出来的题目隐藏
					this.__children[this.currentPage - 1].hide();
					
					//底部添加新的卡片
					card=domConstruct.create('div',{className:'muiResponseCard'},this.domNode);
					this.cards.push(card);
					
					//翻页
					this.set('currentPage',++this.currentPage);
					//底部卡片内容填充
					this.fillCard(this.cards[this.cardCount - 1], this.__children[this.currentPage + this.cardCount - 2] );
					//卡片样式调整
					this.drawCards();
					
					//翻页事件
					topic.publish('km/pindagate/paging',{
						currentPage : this.currentPage,
						totalPage : this.totalPage,
						pageType : 'custom'
					});
					
				},500);
				
				//操作结束
				topic.publish('km/pindagate/touchEnd',this);
			}
			
			if(this.doReset){
				for(i = 0;i < this.cardCount - 1; i++){
					var card=this.cards[i];
					this.smooth(card,250);//transition
					domStyle.set(card,css3.add({},{
						"-webkit-transform":'rotate3d(0,0,1,0deg)'
					}));
				}
				this.doReset = false;
			}
			
			
			//向右滑:上一页
			if(this.dx > 10 &&  this.position=='right' && this.currentPage != 1 ){
				//移除底部卡片
				var card=this.cards.pop();
				this.destoryCard(card);
				//移出来的题目隐藏
				if(this.__children[this.currentPage + this.cardCount - 2])
					this.__children[this.currentPage + this.cardCount - 2].hide();
				
				//翻页
				this.set('currentPage',--this.currentPage);
				
				//顶层添加新的卡片
				card=domConstruct.create('div',{className:'pindagate_body'},this.domNode);
				domStyle.set(card,css3.add({
					"z-index":1000,
				},{
					"-webkit-transform-origin":"top left",
					"-webkit-transform":"rotate3d(0,0,1,3deg) translate3d(-60px, 20px, 0px)"
				}));
				this.smooth(card,450);//transition
				this.cards.unshift(card);
				
				//顶部卡片内容填充
				this.fillCard(this.cards[0], this.__children[this.currentPage -1 ]);
				//卡片样式调整
				this.defer(function(){
					this.drawCards();
				},1);
				
				//翻页事件
				topic.publish('km/pindagate/paging',{
					currentPage : this.currentPage,
					totalPage : this.totalPage,
					pageType : 'custom'
				});
				
				//操作结束
				topic.publish('km/pindagate/touchEnd',this);
			}
			
			//移除事件
			array.forEach(this._pageConnects, function(item) {
				this.disconnect(item);
			}, this);
			this._pageConnects = [];
			this.enableInput();
			
			this.defer(function(){
				this.lock = false;
				this.position = '';
			},300);
			
		},
		
		fillCard:function(card,widget){
			if(card && widget && widget.show){
				for (var i = 0; i <= this.totalPage-1; i++) {
					this.__children[i].hide();
				}
				widget.show();//显示
				domConstruct.place(widget.domNode,card,'last');
				widget.resize();
			}
			
		},
		
		destoryCard:function(card){
			//将放置在卡片中的题目组件移回外层
			if(card.children && card.children.length > 0){
				for(var j=0;j<card.children.length;j++){
					domConstruct.place(card.children[j],this.domNode,'last');
				}
			}
			domConstruct.destroy(card);
		},
		
		eventStop : function(evt) {
			evt.preventDefault();
			evt.stopPropagation();
		},
		
		//transition,让动画更加平滑
		smooth:function(domNode,time){
			var cssKey = '-webkit-transition';
			domStyle.set(domNode, cssKey,
					' -webkit-transform '+time+'ms ease-in');
			this.defer(function() {
				domStyle.set(domNode, cssKey, '')
			}, time);
		},
		
		getPos:function(dx,dy){
			var atan=Math.atan2(dy,dx)*180/Math.PI,
				position='';//
			//上移
			if(atan>=-150&&atan<=-30){
				position='up';
			}
			//下移
			if(atan>=30&&atan<=120){
				position='down';
			}
			//左移
			if(atan>120&&atan<=180||atan>=-180&&atan<-150){
				position='left';
			}
			//右移
			if(atan>-30&&atan<30){
				position='right';
			}
			return position;
		},
		
		_setCurrentPageAttr:function(value){
			this.currentPageInfo.innerHTML =value;
		},
		
		_setTotalPageAttr:function(value){
			this.totalPageInfo.innerHTML ='/'+value;
		},
		
		disableInput:function(){
			var nodes=query('input[type="radio"],input[type="checkbox"]');
			for(var i=0;i<nodes.length;i++){
				domAttr.set(nodes[i],'disabled','disabled');
			}
		},
		
		enableInput:function(){
			var nodes=query('input[type="radio"],input[type="checkbox"]');
			for(var i=0;i<nodes.length;i++){
				domAttr.remove(nodes[i],'disabled');
			}
		},
		
		tip:function(){
			if(this.totalPage > 1){
				var self = this;
				for(i = 0;i < this.cardCount - 1; i++){
					self.smooth(this.cards[i],300);//transition
					var perDeg=i==0 ? 0.35 : 0.15 - i * 0.04 ;
					domStyle.set(this.cards[i],css3.add({},{
						"-webkit-transform":'rotate3d(0,0,1,'+ (0 - perDeg * 10) +'deg)'
					}));//旋转
				}
				setTimeout(function(){
					for(i = 0;i < self.cardCount - 1; i++){
						var card=self.cards[i];
						self.smooth(card,800);//transition
						domStyle.set(card,css3.add({},{
							"-webkit-transform":'rotate3d(0,0,1,0deg)'
						}));
					}
				},800);
			}
		}
		
		
	});
});
