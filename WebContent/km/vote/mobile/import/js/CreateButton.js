define([
    "mui/tabbar/TabBarButton",
	"dojo/_base/declare",
	"mui/form/_CategoryBase",
	"dojo/dom-construct",
	"mui/util",
	"mui/dialog/Tip",
	"dojo/dom-attr",
	"mui/device/adapter",
	"dojox/mobile/sniff"
	], function(TabBarButton, declare, CategoryBase, domConstruct, util, Tip, domAttr,adapter,has) {

	return declare("mui.tabbar.CreateButton", [TabBarButton, CategoryBase], {
		icon1 : '',
		
		key : '_cateSelect',
		
		createUrl : '',
		fdVoteCategoryId : '',
		
		buildRendering:function(){
			this.inherited(arguments);
			this.domNode.dojoClick = !has('ios');
		},
		
		postCreate : function() {
			this.inherited(arguments);
			this.eventBind();
		},
		
		_onClick : function(evt) {
			this.defer(function(){
				if(this.fdVoteCategoryId){
					adapter.open(util.formatUrl(util.urlResolver(this.createUrl, {
						curIds : this.fdVoteCategoryId
					})),"_self");
				}else{
					this._selectCate();
				}
			}, 350);
		},
		
		afterSelectCate:function(evt){
			var process = Tip.processing();
			process.show();
			this.defer(function(){
				adapter.open(util.formatUrl(util.urlResolver(this.createUrl, evt)),"_self");
				this.curIds = "";
				this.curNames = "";
				process.hide();
			},300);
		},
		
		returnDialog:function(srcObj , evt){
			this.inherited(arguments);
			if(srcObj.key == this.key){
				this.afterSelectCate(evt);
			}
		}
	});
});