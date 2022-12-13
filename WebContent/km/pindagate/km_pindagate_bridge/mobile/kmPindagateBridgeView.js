define([
        "dojo/_base/declare", 
        "dojo/dom-construct",
        "mui/util",
        "dojo/request",
        "mui/i18n/i18n!km-pindagate-bridge:*",
        "dijit/_WidgetBase"
        ],function(declare, domConstruct,
        		util, request, msg,  _WidgetBase){
	
	return declare("km.pindagate.bridge.view", [_WidgetBase], {
		
		url : "",
		
		data : [],
		
		buildRendering : function() {
			this.inherited(arguments);
			this.contentList = domConstruct.create("ul" , {
				className : "muiKmPindagateList" 
			}, this.domNode);
			
			var rurl = util.formatUrl(this.url),
			 	self = this;
			request.get(rurl, {
	             handleAs: 'json'
			}).then(function(result) {
				self.data = result;
				self.buildContent.apply(self);
			});
		},
		
		buildContent : function() {
			if(this.data && this.data.length > 0) {
				for(var i = 0; i < this.data.length; i++) {
					var item = this.data[i];
					var li = domConstruct.create("li", {
						"innerHTML" :  "<h4>" + util.formatText(item.fdPindageteMainSubject) + "</h4>"
					}, this.contentList);
					
					var tnode = domConstruct.create("div", {
						"innerHTML" :  util.urlResolver(msg["kmPindagateMain.bridge.target.title"],
											{"0": item.moduleName}) + " : "
											+ util.formatText(item.fdTModelDisplayName)
					}, li);
						
					
					var btnTxt = "", href = "", clsName = "";
					if(item.isAuthAddResponse) {
						if(item.docStatus == "30") {
							//未开始
							btnTxt = msg["kmPindagateMain.bridge.status.will"];
							clsName = "disabled";
						} else {
							btnTxt = item.addResponseTxt;
							href = item.addResponseUrl;
						}
					}
					
					var btn = domConstruct.create("span", {
						"innerHTML" : util.formatText(btnTxt),
						"className" : "btn " + clsName
					}, li);
					
					if(href) {
						this.connect(btn, 'click', function() {
							var _url = href, _btn = btn;
							return function() {
								if(_btn.btnDisabled) {
									return;
								}
								_btn.btnDisabled = true;
								window.open(util.formatUrl(_url), '_self');
							}
						}());
					}
				}
			}
		}
		
	});
	
});