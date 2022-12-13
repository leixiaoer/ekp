/**
 * 关注按钮组件
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._AttentionTabBarButtonMixin", null, {
				// 关注
				attentionUrl : '/km/supervise/km_supervise_main/kmSuperviseMain.do?method=addConcern&hasAttention=false&forward=lui-source',
				// 取消关注
				disAttentionUrl : '/km/supervise/km_supervise_main/kmSuperviseMain.do?method=deleteConcern&hasAttention=true&forward=lui-source',

				hasAttention : false,

				fdId : null,

				scaleClass : 'muiAttentionMaskScale',

				attentionClass : 'mui-focus-on',

				disAttentionClass : 'mui-focus-off',

				buildRendering : function() {
					this.inherited(arguments);
				},

				startup : function() {
					if (this._started)
						return;
					this.inherited(arguments);
					this.toggleAttention(this.hasAttention);
				},

				replaceClass : function(flag) {
					var i1 = this["iconNode" + 1], i2 = this["iconNode" + 2];
					var class1 = flag ? this.attentionClass : this.disAttentionClass, class2 = flag
							? this.disAttentionClass 
							: this.attentionClass;
					domClass.replace(i1, class1 + ' ' + this.scaleClass, class2
									+ ' ' + this.scaleClass);
					domClass.replace(i2, class1 + ' ' + this.scaleClass, class2
									+ ' ' + this.scaleClass);
				}, 

				removeScaleClass : function() {
					var i1 = this["iconNode" + 1], i2 = this["iconNode" + 2];
					this.defer(lang.hitch(this, function() {
										domClass.remove(i1, this.scaleClass);
										domClass.remove(i2, this.scaleClass);
									}), 300);
				},
				
				replaceLabel : function(flag) {
					if(flag)
						this.labelNode.innerHTML=Msg['mobile.cancelGuanZhu'];
					else
						this.labelNode.innerHTML=Msg['mobile.GuanZhu'];				
				},

				toggleAttention : function(hasAttention) {
					if(this.icon1){
					  this.replaceClass(hasAttention);
					  this.removeScaleClass();
					}
					if(this.label)
						 this.replaceLabel(hasAttention);
					this.set('hasAttention', hasAttention);
				},

				rq : function(url, data, handleAs, callback) {
					req(util.formatUrl(url), {
								handleAs : handleAs,
								method : 'post',
								data : data
							}).then(lang.hitch(this, callback));
				},

				// 切换关注
				onClick : function(evt) {
					if (!this.hasAttention){
						this.rq(this.attentionUrl, {
								fdId : this.fdId
								}, 'json', function(data) {
									this.toggleAttention(true);
									Tip.tip({
												icon : 'mui '
														+ this.attentionClass,
												text : Msg['mobile.concern.sucess']
											});

								});
					}else{
						this.rq(this.disAttentionUrl, {
								fdId : this.fdId
								}, 'json', function(data) {
									this.toggleAttention(false);
									Tip.tip({
												icon : 'mui '
														+ this.disAttentionClass,
												text : Msg['mobile.source.failure']
											});
								});
					}
					return false;
				}
		});
});