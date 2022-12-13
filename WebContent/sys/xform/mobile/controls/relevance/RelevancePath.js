define( [ "dojo/_base/declare", "mui/category/CategoryPath","dojo/dom-construct","dojo/topic",
          "dojo/dom-style" , "dojo/request", "dojo/_base/array", "mui/util","dojox/mobile/_ScrollableMixin","mui/i18n/i18n!sys-xform-base:mui"],
	function(declare,CategoryPath,domConstruct,topic,domStyle,request,array,util,ScrollableMixin,Msg) {
		var path = declare("sys.xform.mobile.controls.relevance.RelevancePath", [ CategoryPath,ScrollableMixin], {
				
				scrollDir : "h",
			
				modelName: null ,
				
				//获取详细信息地址
				detailUrl : '/sys/xform/controls/relevance.do?method=pathList&cateId=!{curId}&fdKey=!{fdKey}',
				
				buildRendering : function() {
					this.detailUrl += '&fdControlId='+this.fdControlId+'&extendXmlPath='+this.extendXmlPath;
					this.inherited(arguments);
				},
				
				postCreate : function() {
					this.inherited(arguments);
					this.subscribe("/sys/xform/relevance/category/changed","_chgHeaderInfo");
					//调整宽度
					domStyle.set(this.domNode,{width:'max-content'});
					domStyle.set(this.domNode,{minWidth:'100%'});
				},
				
				_createPathItem:function(item,label) {
					var itemTag = domConstruct.create('div', {
						value:item.fdId
					},this.containerNode);
					var textNode = domConstruct.create('div', {
						className : ''
					},itemTag);
					if (label) {													
						var labelNode = domConstruct.create('span', {
							className :''
						}, textNode);
						labelNode.innerHTML = label;
					}
					
					this.connect(itemTag, "onclick", function(){
						if(item.fdId != this.curId){
							this._chgHeaderInfo(this,{
								'fdId':item.fdId,
								'fdKey':item.fdKey
							});
							topic.publish("/mui/category/changed",this,{
								'fdId':item.fdId,
								'label':item.label,
								'fdTemplateId':item.fdTemplateId,
								'modelPath':item.modelPath,
								'fdKey':item.fdKey
							});
							
						}
					});
				},
				 _createTitleNode: function() {
					 var itemTag = domConstruct.create('div', {
						},this.containerNode);
					 var textNode = domConstruct.create('div', {
						 className : ''
					 },itemTag);
					 var labelNode = domConstruct.create('span', {
						 className :''
					 }, textNode);
					 labelNode.innerHTML = Msg["mui.relevance.path.all"];
					
					 this.connect(itemTag, "onclick", function(){
						 this._chgHeaderInfo(this,{});
						 topic.publish("/mui/category/changed",this,{});
					 });
                 },
				_chgHeaderInfo : function(srcObj,evt){
					if(srcObj.key==this.key){
						if(evt){
							if(evt.fdId){
								domStyle.set(this.domNode,{display:'block'});
								if(this.curId != evt.fdId || this.containerNode.innerHTML == Msg["mui.relevance.path.all"]){
									this.curId = evt.fdId;
									this.fdKey = evt.fdKey;
									var _url = util.urlResolver(this.detailUrl,this);
									_url = util.formatUrl(_url);
									var promise = request.post(_url, {
										handleAs : 'json'
									});
									var _self = this;
									promise.then(function(items) {
										if(items.length>0){
											_self.containerNode.innerHTML='';
											_self._createTitleNode();
											if(items.length < 3){
												array.forEach(items, function(item,index) {
													_self._createPathItem(item,item.label);
												}, this);
											}else{
												var item_length = items.length;
												array.forEach(items, function(item,index) {
													if(index == (item_length-3)){
														_self._createPathItem(item,'...');
													}else if(index > (item_length-3)){ 
														_self._createPathItem(item,item.label);
													}else{
														return;
													}
												}, this);
											}
										}else{
											//错误处理
										}
									}, function(data) {
										//错误处理
									});
								}
							}else{
								this.containerNode.innerHTML=Msg["mui.relevance.path.all"];
								this.connect(this.containerNode, "onclick", function(){
									topic.publish("/mui/category/changed",this,{
										'fdId':'',
										'fdKey':''
									});
								});
								//domStyle.set(this.domNode,{display:'none'});
							}
						}
					}
				}
			});
			return path;
});