define(
		[ "dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
				"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
				"mui/util", "mui/form/editor/EditorUtil", "dojo/topic",
				"dijit/registry",
				"sys/evaluation/mobile/js/EvaluationReplyPostMixin",
				"sys/evaluation/mobile/js/_EvaluationReplyLinkItem","mui/i18n/i18n!sys-evaluation:*" ,"dojo/dom-geometry"],
		function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase,
				util, EditorUtil, topic, registry, EvaluationReplyPostMixin,
				_EvaluationReplyLinkItem,Msg,domGeometry) {
			var item = declare(
					"sys.evaluation.EvaluationReplyItemMixin",
					[ ItemBase, EvaluationReplyPostMixin,
							_EvaluationReplyLinkItem ],
					{

						"class" : "muiEvalReplyLi",

						tabIndex : "",
						// 回复内容
						replyContent : "",
						// 回复id
						replyId : "",
						// 回复时间
						replyTime : "",
						// 回复者id
						replyerId : "",
						// 回复者名字
						replyerName : "",
						// 回复回复者名字
						parentReplyerName : "",
						// 回复回复id
						parentReplyerId : "",
						// 当前用户id
						currentUserId : "",

						// pc端表情src
						faceUrl : '/sys/evaluation/import/resource/images/bq/',
						
						calculateReplyIntervalSum:0,

						buildRendering : function() {
							this.inherited(arguments);
							this.contentNode = domConstruct.create('div', {
								className : "muiEvalReplyContent"
							}, this.domNode);
							
							//头像
							if (this.imgUrl) {
								var imgDivNode = domConstruct.create("div", {
									className : "muiEvaluationIcon"
								}, this.contentNode);
								this.imgNode = domConstruct.create("div", {
									className : "muiEvaluationImg",
								}, imgDivNode);
								domStyle.set(this.imgNode, { 
									"background-image" : "url(" + this.imgUrl + ")" ,
									"background-size" : "cover"
								});
							}
							var parentName = this.parentReplayerName ? ("<span class='muitReplyText'>"+Msg["mui.sysEvaluation.mobile.btnReply"]+"</span>"
									+ this.parentReplayerName): "";
							this.replyNode = domConstruct
									.create(
											'div',
											{
												className : "muiEvalReplyContentRight",
												innerHTML : "<div class='muiEvaluationLabel'>"
														+ this.replyerName+ parentName
														+ "</div>"
														+ "<div class='muiEvaluationReplyCreated'>"
														+ this.replyTime
														+ "</div>"
											}, this.contentNode);
							
							this.replyContentDivNode = domConstruct.create("div", {
								className : "muiEvaluationSummaryDiv",
							}, this.replyNode);
							
							this.replyContentNode = domConstruct.create("p", {
								className : "muiEvaluationSummary",
								innerHTML : this.replyContent
										.replace(/\[face(\d*)\]/g, '<img src="' + util.formatUrl(this.faceUrl) + '$1.gif" type="face" /></img>')
										.replace(/\n/g, '<br>')
							}, this.replyContentDivNode);
						},

						_onClick : function(evt) {
							if (this.currentUserId == this.replyerId)
								return false;
							this.inherited(arguments);
							//this.replyClick(evt);
						},

						replyClick : function(evt) {
							var self = this;
							var parent = this.getParent(), parents = parent
									.getParent();
							this._onReplyClick({
								name : 'replyContent',
								data : {
									fdEvaluationId : parent.fdId,
									mainModelId : parents.fdModelId,
									mainModelName : parents.fdModelName,
									evalMark : 1,
									replyId : self.replyId
								},
								placeholder : Msg["mui.sysEvaluation.mobile.btnReply"] + this.replyerName + "："
							});
						},
						
						calculateReplyContent:function(){
							//已拿到评论高度，与超过1.5秒后停止定时器
							if(domGeometry.position(this.replyContentNode).h>0 || this.calculateReplyIntervalSum>2000){
								window.clearInterval(this.calculateReplyInterval);
							}
							this.calculateReplyIntervalSum+=40;
							//超过三行，添加展开收起按钮
							if(domGeometry.position(this.replyContentNode).h>45){
								//设置超出隐藏
								domClass.add( this.replyContentNode, "muiSummaryExpand" );
								//添加操作按钮
								this.summaryOperationNode = domConstruct.create("span", {
									className : "muiOpenSpan",
									innerHTML : Msg["sysEvaluation.operation.open"]
								}, this.replyContentDivNode);
								
								// 绑定“展开收起”按钮点击事件
						    	var self = this;
							    this.connect(this.summaryOperationNode, "click", function(e){
							    	 //阻止冒泡与苹果手机点击2次
							    	 e.stopPropagation();
									 if(self.click_doing){
										return;
									 }
									 self.click_doing = true;
									 setTimeout(function(){
										self.click_doing = false;
									 },100)
									 
									 if(domAttr.get(this.summaryOperationNode,"class")=="muiOpenSpan"){//展开点击事件
										 //展开评论
								    	 domClass.remove( this.replyContentNode, "muiSummaryExpand" );
								    	 //操作按钮设置为收起
								    	 domClass.replace( this.summaryOperationNode, "muiCloseSpan" );
								    	 this.summaryOperationNode.innerText =  Msg["sysEvaluation.operation.close"];
									 }else{//收起点击事件
										 //收起评论
								    	 domClass.add( this.replyContentNode, "muiSummaryExpand" );
								    	 //操作按钮设置为收起
								    	 domClass.replace( this.summaryOperationNode, "muiOpenSpan" );
								    	 this.summaryOperationNode.innerText =  Msg["sysEvaluation.operation.open"];
									 }	 
							    });
							}
						},

						startup : function() {
							if (this._started) {
								return;
							}
							this.inherited(arguments);
						},
						
						postCreate : function() {
							var self = this;
							self.calculateReplyContent();
							self.calculateReplyInterval=setInterval(function(){
								self.calculateReplyContent();
							},50)
							
							this.inherited(arguments);
						},

						_setLabelAttr : function(text) {
							if (text)
								this._set("label", text);
						}
					});
			return item;
		});