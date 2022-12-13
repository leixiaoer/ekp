define([
        "dojo/_base/declare",
        'dojo/_base/lang',
        "dojo/_base/array",
        'dojo/parser',
        'dojo/request',
        'dojo/dom-construct',
        'dojo/query',
        "dojox/mobile/TransitionEvent",
        "dojo/text!../tmpl/view.jsp",
        'mui/util',
        'mui/qrcode/QRcode',
        'mhui/dialog/Dialog',
        './KmVoteResultViewMixin'
	], function(declare, lang, array, parser, request, domConstruct, query, TransitionEvent, viewTemplate, util,  qrcode , Dialog,KmVoteResultViewMixin) {
	
	return declare('km.vote.maxhub.KmVoteViewMixin', [KmVoteResultViewMixin] ,{
		
		_onClick : function(){
			if(this.fdVoteStatus != 2){
				//投票未结束,打开扫一扫投票页面
				this._openView();
			}else if(this.canVoteResult == 'true'){
				//投票已结束且有查看投票权限，打开投票结果页面
				this._openResultView();
			}
		},
		
		_openView : function(){
			var self = this;
			//未初始化,先创建一个view
			if(!this.voteView){
				this.viewTemplateString = lang.replace(viewTemplate,{
					title : this.docSubject,
					creator : this.creator,
					expireTime : this.expireTime,
					count : this.voteNum,
					fdId : this.fdId
				});
				parser.parse(domConstruct.create('div',{ innerHTML : this.viewTemplateString },query('#content')[0] ,'last'))
					.then(function(widgetList) {
						array.forEach(widgetList, function(widget, index) {
							if(index == 0){
								self._initView(widget);
								self.voteView = widget;
							}
						});
						var opts = {
							transition : 'slide',
							moveTo : self.voteView.id
						};
						self.voteView.show();
						new TransitionEvent(document.body ,  opts ).dispatch();
				});
			}else{
				var opts = {
					transition : 'slide',
					moveTo : this.voteView.id
				};
				self.voteView.show();
				new TransitionEvent(document.body ,  opts ).dispatch();
			}
		},
		
		_initView : function(view){
			//二维码生成
			var qRNode = query('.qRNode',view.domNode)[0];
			var url = location.origin + dojoConfig.baseUrl + 'km/vote/km_vote_main/kmVoteMain.do?method=view&fdId=' + this.fdId;
			var obj = qrcode.make({
				url : url,
				width : 430,
				height : 430
			});
			domConstruct.place(obj.domNode, qRNode,'first'); 
			this._initViewEvent(view);
		},
		
		_initViewEvent : function(view){
			//返回
			var backNode = query('.mhBackNode',view.domNode)[0];
			backNode && this.connect(backNode,'click',lang.hitch(this,function(){
				this.voteView && this.voteView.hide();
			}));
			//查看投票结果
			var resultNode = query('.mhResultNode',view.domNode)[0];
			if(resultNode && this.canVoteResult == 'false'){
				domConstruct.destroy(resultNode);
			}
			//结束投票
			var finishNode = query('.mhFinishNode',view.domNode)[0];
			if(finishNode){
				this.finishNode = finishNode;
				if(this.fdVoteStatus == 0 && this.docStatus != '10'){
					this.connect(finishNode,'click','_handleFinish');
				}else{
					domConstruct.destroy(finishNode);
				}
			}
			this.inherited(arguments);
		},
		
		//结束投票
		_handleFinish : function(){
			var self = this;
			var dialog = Dialog.show({
				content : domConstruct.create('div',{innerHTML:'是否结束投票?'}),
				baseClass : 'mhuiVoteAlertDialog',
				showClose : false,
				buttons: [{
					text: '取消',
					onClick: function(d) {
						dialog.hide();
					}
				},{
					text: '确定',
					className: 'mhuiDialogPrimaryBtn',
					onClick : function(){
						dialog.hide();
						self._____handleFinish();
					}
				}]
			});
		},
		
		_____handleFinish : function(){
			var self = this;
			var url = util.formatUrl('/km/vote/km_vote_main/kmVoteMain.do?method=terminateVote&fdId=' + this.fdId);
			var promise = request.post(url, {
                headers: {'Accept': 'application/json'},
                handleAs: 'json'
            }).then(function(result) {
            	if (result['status'] === false) {
            		return;
            	}
            	self.fdVoteStatus = 2;
            	self.finishNode && domConstruct.destroy(self.finishNode);
            	//绘制结束状态Node
            	self._buildStatusNode();
            	//关闭当前页面
            	self.voteView && self.voteView.hide();
            	if(self.canVoteResult == 'true'){
            		//如果有查看结果权限直接打开查看页面
            		self._openResultView();
            	}
            });
		}
		
		
	});
	
});