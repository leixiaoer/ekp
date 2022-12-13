define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/list/item/_ListLinkItemMixin",
   	"mui/i18n/i18n!km-vote"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, _ListLinkItemMixin,voteMsg) {
	var item = declare("km.vote.list.item.VoteItemMixin", [ItemBase, _ListLinkItemMixin], {
		tag:"li",
		baseClass:"muiCardItem muiListItem vote_card muiFontColorInfo",

		//主题
		docSubject:"",
		//创建者
		creator:"",
		//创建人图像
		icon:"",
		//分类
		category:"",
		//投票数
		voteNum:"",
		//截止时间
		expireTime:"",
		//链接
		href:"",
		//是否已投票
		isVoted:"",
		
		buildRendering:function(){
			this.domNode = domConstruct.create('li', {className : ''}, this.containerNode);
			this.inherited(arguments);
			this.buildInternalRender();
		},
		buildInternalRender : function() {
			var itemClass = this.href ? {}:{className:'lock'};
			this.contentNode = domConstruct.create('div', itemClass);
			
			var headNode = domConstruct.create("div",{className:"vote_top"},this.contentNode); // figure
			
			var statusTagHtml = "";
			if(this.isVoted == 'true'){
				// 已投票（Tag标签）
				statusTagHtml += '<span class="vote_status vote_status_blue muiFontSizeMS">'+voteMsg['mui.kmVoteMain.isVoted']+'</span>';
			}else{
				// 
				if(this.expireTime != voteMsg['mui.kmVoteMain.unlimited']){
					var expireDate = new Date(this.expireTime.replace(/-/g, "/"));
					if(expireDate<new Date()){		
						// 已结束（Tag标签）
						statusTagHtml += '<span class="vote_status vote_status_gray muiFontSizeMS">'+voteMsg['mui.kmVoteMain.ended']+'</span>';
					}
				}
			}
            
			// 标题
			var subject = domConstruct.create("div",{className:"muiFontSizeM vote_title",innerHTML: '<div class="vote_title_inner">' + statusTagHtml +this.docSubject+ '</div>'},headNode);
			
			// 人员图标
			var personImgBoxNode = domConstruct.create("div",{className:"vote_per_img_box"},headNode);
			if(this.icon){
				//用户头像
				domConstruct.create("span", { className: "vote_per_img",style:{background:'url(' + this.icon +') center center no-repeat',backgroundSize:'cover',display:'inline-block'}}, personImgBoxNode);
			}else{
				var bookImgNode = domConstruct.create("span",{className:"vote_book_img"},personImgBoxNode);
				//自定义列表图标
				var listIcon = this.listIcon? this.listIcon : "mui-bookLogo";
				domConstruct.create("i", { className: "mui " + listIcon}, bookImgNode);
			}
			
			// 创建人
			if(this.creator){
				var creatorNode = domConstruct.create("div",{className:"vote_creator muiFontSizeS muiFontColorMuted"},headNode);
				creatorNode.innerText = this.creator;
			}
			
			// 分类名称
			if(this.category){
				var categoryNode = domConstruct.create("div",{className:"vote_category muiFontSizeS muiFontColorMuted"},headNode);
				categoryNode.innerText = this.category;
			}
			
			
			//vote_vote投票数量
			var voteTopRight = domConstruct.create("div",{className:"vote_vote"},headNode);
			if(this.voteNum){
				domConstruct.create("div",{className:"vote_num_text muiFontSizeS",innerHTML:this.voteNum},voteTopRight);
			}
			
			if(this.href){
				this.makeLinkNode(this.contentNode);  // makeLinkNode 继承自 _ListLinkItemMixin.js
			}else{
				lock = domConstruct.toDom("<div class='icoLock'><i class='mui mui-todo_lock'></i></div>");
				domConstruct.place(lock, this.contentNode);
				//tip
				this.makeLockLinkTip(this.contentNode);
			}
			
			//subhead
			//bottom
			var subhead = domConstruct.create("div",{className:"vote_bottom muiFontSizeS muiFontColorMuted"},this.contentNode);

			// 截止时间
			if(this.expireTime){
				domConstruct.create("div",{className:'vote_exp_time_info',innerHTML:voteMsg['mui.kmVoteMain.fdExpireTime']+':<span class="vote_exp_time"> '+this.expireTime+'</span>'},subhead);
			}
			
			domConstruct.place(this.contentNode,this.domNode);
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