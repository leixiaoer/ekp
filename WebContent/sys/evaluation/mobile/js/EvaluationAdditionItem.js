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
			
			//้ไปถ่็น
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
			//ๅทฒๆฟๅฐ่ฏ่ฎบ้ซๅบฆ๏ผไธ่ถ่ฟ1.5็งๅๅๆญขๅฎๆถๅจ
			if(domGeometry.position(this.summaryNode).h>0 || this.calculateSummaryIntervalSum>2000){
				window.clearInterval(this.calculateSummaryInterval);
			}
			this.calculateSummaryIntervalSum+=40;
			//่ถ่ฟไธ่ก๏ผๆทปๅ?ๅฑๅผๆถ่ตทๆ้ฎ
			if(domGeometry.position(this.summaryNode).h>45){
				//่ฎพ็ฝฎ่ถๅบ้่
				domClass.add( this.summaryNode, "muiSummaryExpand" );
				//ๆทปๅ?ๆไฝๆ้ฎ
				this.summaryOperationNode = domConstruct.create("span", {
					className : "muiOpenSpan",
					innerHTML : msg["sysEvaluation.operation.open"]
				}, this.summaryDivNode);
				
				// ็ปๅฎโๅฑๅผๆถ่ตทโๆ้ฎ็นๅปไบไปถ
		    	var self = this;
			    this.connect(this.summaryOperationNode, "click", function(e){
			    	 //้ปๆญขๅๆณกไธ่นๆๆๆบ็นๅป2ๆฌก
			    	 e.stopPropagation();
					 if(self.click_doing){
						return;
					 }
					 self.click_doing = true;
					 setTimeout(function(){
						self.click_doing = false;
					 },100)
					 
					 if(domAttr.get(this.summaryOperationNode,"class")=="muiOpenSpan"){//ๅฑๅผ็นๅปไบไปถ
						 //ๅฑๅผ่ฏ่ฎบ
				    	 domClass.remove( this.summaryNode, "muiSummaryExpand" );
				    	 //ๆไฝๆ้ฎ่ฎพ็ฝฎไธบๆถ่ตท
				    	 domClass.replace( this.summaryOperationNode, "muiCloseSpan" );
				    	 this.summaryOperationNode.innerText = msg["sysEvaluation.operation.close"];
					 }else{//ๆถ่ตท็นๅปไบไปถ
						 //ๆถ่ตท่ฏ่ฎบ
				    	 domClass.add( this.summaryNode, "muiSummaryExpand" );
				    	 //ๆไฝๆ้ฎ่ฎพ็ฝฎไธบๆถ่ตท
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