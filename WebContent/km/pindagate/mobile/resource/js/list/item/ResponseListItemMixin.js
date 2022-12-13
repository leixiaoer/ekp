define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
    "dojo/date",
   	"mui/util",
   	"mui/list/item/_ListLinkItemMixin",
   	"mui/calendar/CalendarUtil",
   	"mui/i18n/i18n!km-pindagate:mobile"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , dojoDate , util, _ListLinkItemMixin,calendarUtil,msg) {
	
	var item = declare("km.pindagate.list.item.ResponseListItemMixin", [ItemBase, _ListLinkItemMixin], {
		tag:"li",
		
		baseClass:"muiPindagateListItem",
		
		isPindagateClosed : false,  // 调查管理是否已结束

		buildRendering:function(){
			this.domNode = domConstruct.create('li', {className : ''}, this.containerNode);
			this.inherited(arguments);
			this.buildInternalRender();
		},
		
		buildInternalRender : function() {
			var self = this;
			if(!this.img) this.img ='';
			
            // 外层容器DOM（背景图也构建在外层容器DOM中）
			var containerDom = domConstruct.create('div', { 
				className : 'muiPindagateContainer',
				style: { 'background-image':'url(' + this.img +')' }
			}, this.domNode);
			
			// 蒙板DIV(在背景图片上层加一层半透明阴影，避免用户上传纯白色背景图时，内容区白色文字显示不出来)
			var containerMaskDom = domConstruct.create('div', { className : 'muiPindagateContainerMask' }, containerDom);
			
			// 内容DOM
			var contentDom = domConstruct.create('div', { className : 'muiPindagateContent' }, containerDom);
			var contentWarpDom = domConstruct.create('div', { className : 'muiPindagateContentWarp' }, contentDom);
			
			// 参加人数
			var participateInnerHTML = msg['mobile.kmPindagateMain.numberOfParticipate'].replace('%number%','<span class="muiPindagateParticipateNum">'+this.participate+'</span>');
			var participateDom = domConstruct.create('div', { className : 'muiPindagateParticipateInfo', innerHTML: participateInnerHTML }, contentWarpDom);
            
			// 调查标题
			var muiPindagateSubjectDom = domConstruct.create('div', { className : 'muiPindagateSubject', innerHTML:this.label }, contentWarpDom);
			
			// 底部DOM
			var footerDom = domConstruct.create('div', { className : 'muiPindagateContentFooter'}, contentWarpDom);
				
			// 调查结束时间信息
			var endTimeInfoDom = domConstruct.create('div', { className : 'muiPindagateEndTimeInfo'}, footerDom);
			if(!this.finishedTime){
				// 如果没有设置结束时间，则显示 “调查结束时间不限”
				domConstruct.create('span', { innerHTML : msg['mobile.kmPindagateMain.time.not.limit'] }, endTimeInfoDom);
			}else{
				var pindagateClosedTipDom = domConstruct.create('span', { innerHTML : msg['mobile.kmPindagateMain.pindagate.stop.time']+'<span class="muiPindagateEndTimeColons" >:</span><span class="muiPindagateEndTimeTxt">'+self.finishedTime+'</span>' });
				var finishedTime = calendarUtil.parseDate(this.finishedTime);
				var now = self.nowDate || new Date();
				var duration = dojoDate.difference(now,finishedTime,'millisecond');
				if(duration < 1000){
					this.isPindagateClosed = true; 
					// 调查已结束，显示结束时间tip
					domConstruct.place(pindagateClosedTipDom, endTimeInfoDom, 'first');
				}else{
					// 显示调查管理结束时间倒计时
					this._showPindagateCountdown(duration,endTimeInfoDom);
					// 触发调查管理结束时间倒计时定时刷新
					this._triggerPindagateCountdown(finishedTime,now,endTimeInfoDom,pindagateClosedTipDom);
				}
			}

			// 构建底部右侧按钮
			this.pindagateBtn = this._getPindagateBtnDom();
			domConstruct.place(this.pindagateBtn, footerDom, 'last');
			
		},
		
	
		
		/**
		* 触发调查管理结束时间倒计时定时刷新
		* @param finishedTime   调查结束时间（Date对象）
		* @param now            当前时间（Date对象）
		* @param endTimeInfoDom 结束时间展示的父容器DOM对象
		* @param pindagateClosedTipDom 调查倒计时结束后显示提醒DOM对象（显示结束时间tip）
		*/		
		_triggerPindagateCountdown: function(finishedTime, now, endTimeInfoDom, pindagateClosedTipDom){
			var self = this;
			var timer = window.setInterval(function(){
				now = new Date(now.getTime() + 1000);
				var duration = dojoDate.difference(now,finishedTime,'millisecond');
				if(duration >= 1000){
					self._showPindagateCountdown(duration,endTimeInfoDom);
				}else{
					self.isPindagateClosed = true;
					// 调查已结束，显示结束时间tip
					domConstruct.empty(endTimeInfoDom);
					domConstruct.place(pindagateClosedTipDom, endTimeInfoDom, 'first');
					// 操作按钮由“参加调查”替换为“已结束”（不同页签下，替换的按钮内容不同，比如在调查结果页签下，按钮显示为“查看结果”）
					domConstruct.place(self._getPindagateBtnDom(),self.pindagateBtn,'replace');
					// 清除定时器
					clearInterval(timer);
				}
		    },1000);			
		},
		
		
		/**
		* 显示调查管理结束时间倒计时
		* @param duration       当前时间距离结束时间的毫秒数
		* @param endTimeInfoDom 结束时间展示的父容器DOM对象
		*/			
		_showPindagateCountdown: function(duration, endTimeInfoDom){
			domConstruct.empty(endTimeInfoDom);
			var day = parseInt( duration/(24*60*60*1000) ),
			    hour = parseInt( duration % (24*60*60*1000) /(60*60*1000) ),
			    minute = parseInt (duration % (60*60*1000) / (60*1000) ),
			    second = parseInt (duration % (60*1000) / 1000 ),
			    item = null;
			// 天
			if(day > 0){
				item=domConstruct.create('span',{className:'item',innerHTML: msg['mobile.days'] },endTimeInfoDom);
				domConstruct.create('span',{innerHTML:this._formatValue(day),className:'num'},item,'first');
			}
			// 时
			item=domConstruct.create('span',{className:'item',innerHTML: msg['mobile.hours']  },endTimeInfoDom);
			domConstruct.create('span',{innerHTML:this._formatValue(hour),className:'num'},item,'first');
			// 分
			item=domConstruct.create('span',{className:'item',innerHTML: msg['mobile.minute']  },endTimeInfoDom);
			domConstruct.create('span',{innerHTML:this._formatValue(minute),className:'num'},item,'first');
			// 秒
			item=domConstruct.create('span',{className:'item',innerHTML:  msg['mobile.second']  },endTimeInfoDom);
			domConstruct.create('span',{innerHTML:this._formatValue(second),className:'num'},item,'first');				
		},
		
		
		/**
		* 获取调查管理操作按钮DOM对象
		* 不同Tab页签以及调查管理是否已结束状态下返回的DOM对象不同（根据this.treeNode判断当前所处的页签）
		* @return 操作按钮DOM对象
		*/		
		_getPindagateBtnDom: function(){
			var btnDom = null;
			if(this.treeNode == 'participate'){
				if(this.isPindagateClosed){
					// 已结束标签按钮
					btnDom = domConstruct.create('div',{ className:'muiPindagateBtn muiPindagateClosedBtn', innerHTML:msg['mobile.kmPindagateMain.hasend.pindagate'] });
				}else{
					// 参加调查按钮
					btnDom = domConstruct.create('div',{ className:'muiPindagateBtn muiPindagateParticipateBtn', innerHTML:msg['mobile.kmPindagateMain.participate'] });
				}
			}else if(this.treeNode == 'set'){
				// 查看属性按钮
				btnDom = domConstruct.create('div',{ className:'muiPindagateBtn muiPindagateShowSetBtn', innerHTML:msg['mobile.kmPindagateMain.showSet'] });					
			}else if(this.treeNode == 'result'){
				// 查看结果按钮
				btnDom = domConstruct.create('div',{ className:'muiPindagateBtn muiPindagateShowResultBtn', innerHTML:msg['mobile.kmPindagateMain.showResult'] });					
			}
			return btnDom;	
		},
		
		
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		},
		
		_formatValue:function(value){
			if(value < 10){
				value='0'+value;
			}
			return value;
		}
		
	});
	return item;
});