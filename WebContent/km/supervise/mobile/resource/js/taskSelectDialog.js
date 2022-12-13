define([ "dojo/_base/declare", "dijit/_WidgetBase", "dojo/dom-construct",
		"dojo/dom-style", "dojo/dom-class", "dojo/_base/array",
		"dojo/_base/lang", 'dojo/parser', "mui/iconUtils" ,"dojo/request","mui/util","dojo/on","dojox/mobile/viewRegistry","dojo/query","dojo/topic","mui/i18n/i18n!sys-mobile"], function(declare,
		WidgetBase, domConstruct, domStyle, domClass, array, lang, parser,
		iconUtils,request,util,on,viewRegistry,query,topic,Msg) {

	return  declare('km.supervise.mobile.resource.js.taskSelectDialog', [ WidgetBase], {

		buttons : [],
		
		callback : null,
				
		sectionTitles:[],

		showClass : 'ekp-ledger-customer-filter-warp',
		//是否首次创建
		firstFlag:true,
		
		buildRendering:function(){
			this.inherited(arguments);
			var showNode = domConstruct.toDom('<div class="muiSupervisePicker muiFontSizeM muiFontColorInfo">'+Msg['mui.select.filter']+'<i class="mui mui-sort-filter"></i></div>');
			domConstruct.place(showNode,this.domNode);
			this.connect(showNode, 'click', '_onShowClick');
		},
		
		_onShowClick : function() {
			if(this.firstFlag){
				this.buildSelectRender();
			}else{
				//显示遮罩层
				domStyle.set( this.maskNode,"display","block");
				//显示面板
				domStyle.set(this.panelNode,"display","block");
			}
			
		},

		buildSelectRender : function() {
			this.inherited(arguments);
			this.firstFlag=false;
			this.pickNode = domConstruct.create('div', {
				className :  this.showClass
			}, document.body, 'last');
			//面板
			this.panelNode = domConstruct.create('div', {
				className : 'ekp-ledger-customer-filter-panel'
			}, this.pickNode);
			domStyle.set(this.panelNode,"display","block");
			//遮罩层
			this.maskNode = domConstruct.create('div', {
				className : 'ekp-ledger-customer-filter-mask'
			}, this.pickNode);
			domStyle.set( this.maskNode,"display","block");
			this.connect(this.maskNode, 'click', '_onMaskClick');

			// 标题节点
			var titleNode = domConstruct.create('h4', {
				className :'ekp-ledger-customer-filter-title',
				innerHTML : Msg['mui.select.filter'] 
			}, this.panelNode);		
			
			// 内容节点
			var self = this;
			this.contentNode = domConstruct.create('div', {
				className : 'ekp-ledger-customer-filter-condition'
			},this. panelNode);
			
			this.spanDom=[];
			this.allofDom=[];
			if(this.sectionTitles.length>0){
				array.forEach(this.sectionTitles, lang.hitch(this, function(item) {
						
						var sectionNode= domConstruct.create('section',{
							className : ''
						},  this.contentNode);
						var stl=  domConstruct.create('h5', {
							className :'ekp-ledger-gray-title',
                            innerHTML : item.title
						}, sectionNode);
						var ul=  domConstruct.create('ul', {
							className :'ekp-ledger-customer-filter-list'
						}, sectionNode);
						var itemDom=[];
						var li=  domConstruct.create('li',{
									className : ''
								}, ul);
						var spanNode = domConstruct.create('span', {	className :'active',innerHTML:'全部',value:'all'},li);
						on(spanNode, 'click', function(){
						    	for(var i = 0; i < itemDom.length; i++){
						    		domClass.remove (itemDom[i],"active");
						    		domClass.add(this,"active");
                     			}
						    	if(self.sectionTitles.length==1){
					    			self._onDoneClick();
					    		}
						 })
						itemDom.push(spanNode);
						this.allofDom.push(spanNode);
						if(item.type!=null){						
							var url = "/km/supervise/km_supervise_task/kmSuperviseTask.do?method=getDataItem&type="+item.type+"&defaultValues="+item.defaultValues+"&fdTaskId="+item.fdTaskId;
							request.get(util.formatUrl(url),
									{handleAs:'json'}).then(
									   function(data){
									              //成功后回调
										   array.forEach(data, lang.hitch(this, function(dataItem) {
											 var li=  domConstruct.create('li',{
													className : ''
												}, ul);
											var spanNode = domConstruct.create('span', {	className :'',innerHTML:dataItem.name,value:dataItem.type+'='+dataItem.value},li); 
											itemDom.push(spanNode);									
											    on(spanNode, 'click', function(){
											    	for(var i = 0; i < itemDom.length; i++){
											    		domClass.remove (itemDom[i],"active");
											    		domClass.add(this,"active");
					                       			}
											    	if(self.sectionTitles.length==1){
										    			self._onDoneClick();
										    		}
					                               })
					                           self.spanDom.push(spanNode);
											}));   	  
									},function(error){
									           //错误回调
									});
						}else{
							//其他情况
							  array.forEach(item.data, lang.hitch(this, function(dataItem) {
								   var li=  domConstruct.create('li',{
										className : ''
									}, ul);
								   var spanNode = domConstruct.create('span', {	className :'',innerHTML:dataItem.name,value:item.type+'='+dataItem.value},li); 
									itemDom.push( spanNode)
								   on(spanNode, 'click', function(){
								    	for(var i = 0; i < itemDom.length; i++){
								    		domClass.remove (itemDom[i],"active");
								    		domClass.add(this,"active");
		                       			}
								    	
								    	if(self.sectionTitles.length==1){
							    			self._onDoneClick();
							    		}
                                  })
                                self.spanDom.push(spanNode);
								}));   	
						}
				}));
			}
			if(this.sectionTitles.length>1){
			this.buttonsNode = domConstruct.create('div', {
				className :'ekp-ledger-customer-filter-btn'
			}, this.panelNode);
			var resetBtn= domConstruct.create('button', {
				className :'filter-btn reset',
				innerHTML : Msg['mui.button.reset'] 
			}, this.buttonsNode);
			this.connect(resetBtn, 'click', '_onResetClick');
			
			var doneBtn= domConstruct.create('button', {
				className :'filter-btn done',
				innerHTML :Msg['mui.button.done'] 
			}, this.buttonsNode);
			this.connect(doneBtn, 'click', '_onDoneClick');
		}

		},
		
		_onMaskClick:function() {
			//隐藏遮罩层
			domStyle.set( this.maskNode,"display","none");
			//隐藏面板
			domStyle.set(this.panelNode,"display","none");
		},
		
		_onResetClick:function() {
			for (var i = 0; i < this.allofDom.length; i++) {
				domClass.add(this.allofDom[i],"active");
			}
			for (var i = 0; i < this.spanDom.length; i++) {
				domClass.remove(this.spanDom[i],"active");
			}
		},
		
       _onDoneClick:function() { 
    	   this.defer(function(){
    	   var paramStrs=[];
    	   for (var i = 0; i < this.spanDom.length; i++) {
				if(domClass.contains(this.spanDom[i],'active')){
					if(this.spanDom[i]){
						paramStrs.push(this.spanDom[i].value);
					}
				}
			}
    	    var params = {};
			for(var j = 0;j < paramStrs.length;j++){
				params[paramStrs[j].split("=")[0]] = paramStrs[j].split("=")[1];
			}
			reloadTask(params);
    	    this._onMaskClick();
    	   },350);
		}
	});
});