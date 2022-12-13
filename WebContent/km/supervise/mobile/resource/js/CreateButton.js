define([
    "mui/tabbar/TabBarButton",
	"dojo/_base/declare",
	"mui/form/_CategoryBase",
	"dojo/dom-construct",
	"mui/util",
	"mui/dialog/Tip",
	"dojo/dom-attr",
	"dojo/dom-style","mui/device/adapter", "dojo/dom-class", "dojo/touch","dojo/on", "dojo/query"
	], function(TabBarButton, declare, CategoryBase, domConstruct, util, Tip, domAttr, domStyle, adapter, domClass, touch, on, query) {

	return declare("km.supervise.mobile.resource.js.CreateButton", [TabBarButton, CategoryBase], {
		icon: "",
		
		createUrl:'',
		
		key:'',
		
		iconclass:'',
		
		// 按钮样式
		baseClass : "muiHeaderItem mui mui-plus muiFolder",
		
		buildRendering:function(){
			console.log(this.iconclass);
			if(this.iconclass)
				this.baseClass = this.iconclass;
			this.inherited(arguments);
			if(!this.key)
				this.key = '_cateSelect';
			domAttr.set(this.domNode, 'title', '新建');
			console.log(this.domNode);
		},
		
		postCreate : function() {
			this.inherited(arguments);
			this.eventBind();
		},
		
		_onClick : function(evt) {
			this.defer(function(){
				this._selectCate();
			}, 350);
		},
		
		afterSelectCate:function(evt){
			var process = Tip.processing();
			process.show();
			this.defer(function(){
				adapter.open(util.formatUrl(util.urlResolver(this.createUrl, evt)),"_self");
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