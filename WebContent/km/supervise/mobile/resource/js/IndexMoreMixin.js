define([ "dojo/_base/declare", "dojo/_base/lang", "dojo/dom-construct",
		"mui/form/_FormBase", "mui/i18n/i18n!km-supervise:*" , 	"mui/device/adapter",	"mui/util"], function(
		declare, lang, domConstruct, _FormBase, msg,adapter,util) {
	var claz = declare("km.supervise.IndexMoreMixin", [ _FormBase ],
			{
				tag : "div",
				baseClass : "muiCardFooter",
				value : null,
				href: null,
				buildRendering : function() {
					this.inherited(arguments);
					var more_button = domConstruct.create("button", {
						className : "muiCardFooterMore"
					}, this.domNode);
					var more_button_span = domConstruct.create("span", {
						className : "muiNotifyTitleLabel",
						innerHTML : msg['mobile.view.more']
					}, more_button);
					var more_button_i = domConstruct.create("i", {
						className : "mui mui-forward"
					}, more_button);
					if(this.href !=null){						
						this._bindMoreClick(more_button);
					}
				},
				/**
				 * 绑定点击事件
				 * 
				 * @param element
				 *            DOM对象
				 */
				_bindMoreClick : function(element) { 
					var url = util.formatUrl(this.href); 
					// 直接跳转至明细页面
					this.connect(element, 'click', lang.hitch(this, function() {
						adapter.open(url, '_self');
					}));
				},
			});

	return claz;
})
