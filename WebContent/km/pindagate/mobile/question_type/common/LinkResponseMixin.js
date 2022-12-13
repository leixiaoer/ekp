/**
 * RTF中链接处理
 */
define(["dojo/_base/declare","dojo/_base/lang","dojo/_base/array","dojo/query","dojo/parser","dojo/Deferred","dojo/dom-style",
        "dojo/dom-construct","dojo/dom-geometry","mui/util","dojox/mobile/TransitionEvent","dojox/mobile/viewRegistry","mui/dialog/Tip",
        "dojo/text!./LinkIframeView.jsp"],
		function(declare,lang,array,query,parser,Deferred,domStyle,domConstruct,domGeometry,util,TransitionEvent,viewRegistry,Tip,viewTemplate){
	return declare("km.pindagate.common.LinkResponseMixin",null,{
		
		backview : null,
		
		formatLink : function(domNode){
			this.inherited(arguments);
			var self = this,
				links = [];
			if (typeof (domNode) == "object") {
				links = query('a', domNode);
			} else {
				links = query(domNode + ' a');
			}
			array.forEach(links,lang.hitch(this,function(link){
				var href = link.getAttribute('href');
				link.setAttribute('href','javascript:void(0);');
				this.connect(link,'touchstart',(function(_href){
					return function(evt){
						evt.preventDefault();
						self.handleLink(_href);
					};
				})(href));
			}));
		},
		
		handleLink : function(href){
			this.returnview = viewRegistry.getEnclosingView(this.context.renderNode);
			this.gotoLoading = Tip.tip( {
				icon: "mui mui-loading mui-spin",
				time: 2500, 
				cover : true,
				text: "加载中...",
			});
			var defer = new Deferred();
			if(!window.__reponse__iframe__view){
				this.createIframeView(defer);
			}else{
				defer.resolve(window.__reponse__iframe__view);
			}
			var self = this;
			defer.then(function(widget){
				var iframedom = widget.iframedom;
				iframedom.setAttribute('src',href);
				var opts = {
					transition : 'slide',
					moveTo:widget.id
				};
				new TransitionEvent(document.body ,  opts ).dispatch();
				self.gotoLoading.show();
			});
		},
		
		createIframeView : function(defer){
			var self = this;
			parser.parse(domConstruct.create('div',{ innerHTML:viewTemplate }))
				.then(function(widgetList) {
					array.forEach(widgetList, function(widget, index) {
						if(index == 0){
							var viewdom = widget.domNode,
								returndom = query('[dojo-data-mask="muiReturn"]',viewdom)[0],
								iframedom = query('[dojo-data-mask="muiLinkIframe"]',viewdom)[0]
							widget.iframedom = iframedom;
							util.addTopView(widget);
							window.__reponse__iframe__view = widget;
							self.connect(returndom,'touchstart',function(){
								var opts = {
									transition : 'slide',
									transitionDir : -1,
									moveTo:self.returnview.id
								};
								new TransitionEvent(document.body ,  opts ).dispatch();
							});
							self.connect(iframedom,'load',function(){
								self.gotoLoading.hide();
							});
							var iframeHeight = domGeometry.getMarginBox(document.body).h - domGeometry.getMarginBox(returndom).h + 'px';
							domStyle.set(iframedom,'width','100%');
							domStyle.set(iframedom,'height',iframeHeight);
							domStyle.set(iframedom,'border','0');
							if(defer){
								defer.resolve(window.__reponse__iframe__view);
							}
						}
					});
			});
		}
		
		
	});
});