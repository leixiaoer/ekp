define([ "dojo/_base/declare", "dojo/dom-construct", "dojo/dom-class",
		"dojo/dom-style", "dojo/dom-attr", "dojox/mobile/_ItemBase",
		"mui/rating/Rating", "mui/util",
		"sys/evaluation/mobile/js/EvaluationReplyListMixin",
		"dojo/html","dojo/dom-geometry","dojo/dom-class","mui/i18n/i18n!sys-evaluation:*"], function(
		declare, domConstruct, domClass, domStyle, domAttr, ItemBase, Rating,
		util, EvaluationReplyListMixin, html,domGeometry,domClass,msg) {
	var item = declare("sys.evaluation.EvaluationItemMixin", [ ItemBase,
			EvaluationReplyListMixin ], {
		tag : "li",
		// 简要信息
		summary : "",
		// 创建时间
		created : "",
		// 点评分数
		score : 0,
		// 标题
		label : "",
		// 创建者图像
		icon : "",
		tabIndex : "",

		// pc端表情src
		faceUrl : '/sys/evaluation/import/resource/images/bq/',

		buildRendering : function() {
			this._templated = !!this.templateString;
			if (!this._templated) {
				this.domNode = this.containerNode = this.srcNodeRef
						|| domConstruct.create(this.tag, {
							className : 'muiEvaluationItem'
						});
			}
			this.inherited(arguments);
			if (!this._templated)
				this.buildInternalRender();
		},

		buildInternalRender : function() {
			if (this.icon) {
				var imgDivNode = domConstruct.create("div", {
					className : "muiEvaluationIcon"
				}, this.containerNode);
				this.imgNode = domConstruct.create("div", {
					className : "muiEvaluationImg",
				}, imgDivNode);
				domStyle.set(this.imgNode, { 
					"background-image" : "url(" + util.formatUrl(this.icon) + ")" ,
					"background-size" : "cover"
				});
			}
			this.contentNode = domConstruct.create('div', {
				className : 'muiEvaluationContent'
			}, this.domNode, 'last');
		
			this.contentHeadNode = domConstruct.create('div', {
				className : 'muiEvaluationContentHead'
			}, this.contentNode);
			
			this.contentLeftNode = domConstruct.create('div', {
				className : 'muiEvaluationContentLeft'
			}, this.contentHeadNode);
			
			this.contentRigthNode = domConstruct.create('div', {
				className : 'muiEvaluationContentRigth'
			}, this.contentHeadNode);
			
			if (this.label) {
				this.labelNode = domConstruct.create("div", {
					className : "muiEvaluationInfo"
				}, this.contentLeftNode);
				domConstruct.create("span", {
					className : "muiEvaluationLabel muiAuthor",
					innerHTML : this.label
				}, this.labelNode);
				var widget = new Rating({
					value : 5 - parseInt(this.score, 10)
				});
				this.contentRigthNode.appendChild(widget.domNode);
			}

			if (this.created) {
				this.createdNode = domConstruct.create("div", {
					className : "muiEvaluationCreateTime",
					innerHTML : this.created
				}, this.contentLeftNode);
			}

			if (this.summary) {
				
				this.summaryDivNode = domConstruct.create("div", {
					className : "muiEvaluationSummaryDiv",
				}, this.contentNode);
				
				this.summaryNode = domConstruct.create("p", {
					className : "muiEvaluationSummary",
					innerHTML : this.summary
							.replace(/\[face(\d*)\]/g, '<img src="' + util.formatUrl(this.faceUrl) + '$1.gif" type="face" /></img>')
							.replace(/\n/g, '<br>')
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
			
			this.additionNode = domConstruct.create("ul", {
				className : "muiEvaluationAdditionNode",
				"data-addition-node" : this.fdId
			}, this.domNode);
			
			this.contentBottomNode = domConstruct.create('div', {
				className : 'contentBottomDiv'
			}, this.contentNode, 'last');
			
			this.contentBottomOpNode = domConstruct.create('div', {
				className : 'contentBottomOp'
			}, this.contentBottomNode);
			
			this.inherited(arguments);
			
		},
		
		calculateSummary:function(){
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
			this.calculateSummary();
		},

		_setLabelAttr : function(text) {
			if (text)
				this._set("label", text);
		}
	});
	return item;
});