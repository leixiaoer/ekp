define([ "dojo/_base/declare", "dojo/dom-construct",
		 "dojox/mobile/_ItemBase", "mui/util",
		 "mui/i18n/i18n!sys-evaluation:*",
		 "dojo/html","dojo/dom-geometry","dojo/dom-class","dojo/dom-attr"], function(
		declare, domConstruct, ItemBase, 
		util, msg, html,domGeometry,domClass,domAttr) {
	var item = declare("sys.evaluation.EvaluationItemMixin", [ ItemBase ], {
		
		tag : "li",
		
		fdEvaluationIntervalTime : "",
		
		fdId : "",
		
		fdEvaluationContent : "",
		
		calculateSummaryIntervalSum:0,

		buildRendering : function() {
			this._templated = !!this.templateString;
			if (!this._templated) {
				this.domNode = this.containerNode = this.srcNodeRef
						|| domConstruct.create(this.tag, {
							className : 'muiEvaluationAdditionItem'
						});
			}
			this.inherited(arguments);
			if (!this._templated)
				this.buildInternalRender();
		},

		buildInternalRender : function() {
			this.contentNode = domConstruct.create('div', {
				className : 'muiEvaluationAdditionContent'
			}, this.domNode, 'last');
			
			if(this.fdEvaluator) {
				this.timeNode = domConstruct.create("div", {
					className : "muiEvaluationAddCreated",
					innerHTML : this.fdEvaluator + "&nbsp" +msg["sysEvaluationMain.addition"]
				}, this.contentNode);
			}
			
			if(this.fdEvaluationIntervalTime) {
				this.timeNode = domConstruct.create("div", {
					className : "muiEvaluationIntervalTime ",
					innerHTML : this.fdEvaluationIntervalTime
				}, this.contentNode);
			}
			
			if (this.fdEvaluationContent) {
				
				this.summaryDivNode = domConstruct.create("div", {
					className : "muiEvaluationSummaryDiv",
				}, this.contentNode);
				
				this.summaryNode = domConstruct.create("p", {
					className : "muiEvaluationSummary",
					innerHTML : this.fdEvaluationContent.replace(/&lt;br&gt;/g, '<br>').replace(/&amp;nbsp;/g, ' ')
				}, this.summaryDivNode);
			}
			
			//附件节点
			this.attachmentDiv = domConstruct.create("div", {className:'muiPostAttchment'}, this.contentNode);
			
			var self = this;
			
			var url = "/sys/attachment/mobile/import/view.jsp?fdKey=eval_" + this.fdId + "&fdModelName=com.landray.kmss.sys.evaluation.model.SysEvaluationMain&fdModelId=" + this.fdId;
			
			require(["dojo/text!" + util.formatUrl(url)], function(tmplStr){
				domConstruct.empty(self.attachmentDiv);
				var dhs = new html._ContentSetter({
					node:self.attachmentDiv,
					parseContent : true,
					cleanContent : true
				});
				dhs.set(tmplStr);
				dhs.tearDown();
			});
			
			this.inherited(arguments);
		},

		calculateSummary:function(){
			//已拿到评论高度，与超过1.5秒后停止定时器
			if(domGeometry.position(this.summaryNode).h>0 || this.calculateSummaryIntervalSum>2000){
				window.clearInterval(this.calculateSummaryInterval);
			}
			this.calculateSummaryIntervalSum+=40;
			//超过三行，添加展开收起按钮
			if(domGeometry.position(this.summaryNode).h>45){
				//设置超出隐藏
				domClass.add( this.summaryNode, "muiSummaryExpand" );
				//添加操作按钮
				this.summaryOperationNode = domConstruct.create("span", {
					className : "muiOpenSpan",
					innerHTML : msg["sysEvaluation.operation.open"]
				}, this.summaryDivNode);
				
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
				    	 domClass.remove( this.summaryNode, "muiSummaryExpand" );
				    	 //操作按钮设置为收起
				    	 domClass.replace( this.summaryOperationNode, "muiCloseSpan" );
				    	 this.summaryOperationNode.innerText = msg["sysEvaluation.operation.close"];
					 }else{//收起点击事件
						 //收起评论
				    	 domClass.add( this.summaryNode, "muiSummaryExpand" );
				    	 //操作按钮设置为收起
				    	 domClass.replace( this.summaryOperationNode, "muiOpenSpan" );
				    	 this.summaryOperationNode.innerText = msg["sysEvaluation.operation.open"];
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
			self.calculateSummary();
			self.calculateSummaryInterval=setInterval(function(){
				self.calculateSummary();
			},50)
			
			this.inherited(arguments);
		}
	});
	return item;
});