define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,openProxyMixin) {
	var item = declare("sys.lbpmperson.mobile.FastReviewTodoListItem", [ItemBase,openProxyMixin], {
		tag:"li",

		//流程简要信息
		lbpmCurrNodeValue:"",
		
		//模块名称
		modelNameText:"",
		
		//创建时间
		created:"",
		
		//创建者
		creator:"",
		
		//创建人图像
		icon:"",
		
		//状态
		status:"",
		
		reviewOp:"",
		
		uuid:"",
		
		buildRendering:function(){
			this.inherited(arguments);
			this.contentNode = domConstruct.create( this.tag, { className : 'muiFastReviewTodoListItem' });
	        this.buildContentRender();
	        this.buildOperateBtnRender();
			domConstruct.place(this.contentNode,this.containerNode);
		},
		
		/**
		 * 构建基本信息
		 */		
		buildContentRender : function() {
			
	    	// 流程快速审批内容外层容器DOM
	        var fastReviewTodoContentContainer = domConstruct.create("div", {className: "muiFastReviewTodoContentContainer"}, this.contentNode);
			
	        // 流程标题
	        var fastReviewToTitleDom = domConstruct.create("div", {className: "muiFastReviewToTitleLabel muiFontSizeM muiFontColorInfo", innerHTML:this.label }, fastReviewTodoContentContainer); 
			// 绑定标题点击事件
			if(this.href){
				this.proxyClick(fastReviewToTitleDom, this.href, '_blank');
			}
	        
	        // 消息基本信息容器DOM（展示：人员头像、人员姓名、时间日期、模块名称、流程节点名称）
	        var muiFastReviewTodoBaseInfo = domConstruct.create("div", {className: "muiFastReviewTodoBaseInfo muiFontSizeS muiFontColorMuted"}, fastReviewTodoContentContainer);
	        
			// 人员头像图标
			if(this.icon){
			   var personHeadIconNode = domConstruct.create('div', {className : 'muiFastReviewTodoPersonHeadIcon'}, muiFastReviewTodoBaseInfo);
			   domConstruct.create('img', {src :util.formatUrl(this.icon),className : 'muiFastReviewTodoPersonHeadImg'}, personHeadIconNode);
			}
	        
			// 基本信息文本容器DOM
			var fastReviewTodoTextNode = domConstruct.create('div', {className : 'muiFastReviewTodoTextInfo muiFontSizeS'}, muiFastReviewTodoBaseInfo);
			
			
			// 人员姓名
			if(this.creator){
			   var creatorNode = domConstruct.create('span', { innerHTML:this.creator, className:'muiFastReviewTodoPersonName' }, fastReviewTodoTextNode);
			}
			  
		    // 时间日期
		    if(this.created){
			   var createdNode = domConstruct.create('span', { innerHTML:this.created, className:'muiFastReviewTodoDate' }, fastReviewTodoTextNode);
		    }
		  
		    // 业务模块名称
		    if(this.modelNameText){
			   var modelNode = domConstruct.create('span', { innerHTML:this.modelNameText, className:'muiFastReviewTodoModelName' }, fastReviewTodoTextNode);
		    }
		  
		    // 流程节点状态
            if(this.lbpmCurrNodeValue) {
        	   var processStatusNode = domConstruct.create('span', { innerHTML:this.lbpmCurrNodeValue, className:'muiFastReviewTodoProcessStatus' }, fastReviewTodoTextNode);
            }
			
		},
		
		
		/**
		 * 构建操作按钮（通过、驳回...）
		 */	      
		buildOperateBtnRender: function() {
	    	  // 操作按钮展示外层容器DOM
	          var notifyOperateBtnContainer = domConstruct.create("div", {className: "muiFastReviewTodoOperateBtnContainer muiFontSizeS muiFontColor","id":"reviewOp_"+this.uuid}, this.contentNode);	
	          notifyOperateBtnContainer.appendChild(domConstruct.toDom(this.reviewOp));
	    },		
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});