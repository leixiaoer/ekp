define([ "dojo/_base/declare","mui/search/SearchBar","mui/util","dojo/topic","dojo/_base/lang","dojo/dom-style"],
		function(declare,SearchBar,util,topic,lang,domStyle){
	
	return declare("sys.xform.mobile.controls.relevance.RelevanceSearchBar",[ SearchBar],{
		
		searchCateUrl : '/sys/xform/controls/relevance.do?method=searchCateList&keyword=!{keyword}',
		
		searchDocUrl : '/sys/xform/controls/relevance.do?method=searchDocList&keyword=!{keyword}',
		
		//搜索结果直接挑转至searchURL界面
		jumpToSearchUrl:false,
				
		//是否需要输入提醒
		needPrompt:false,
		
		postCreate : function() {
			this.inherited(arguments);
			this.subscribe("/mui/category/changed","_cateChange");
		},
		
		_cateChange : function(srcObj,evt){
			if(srcObj.key==this.key && this.searchNode.value){
				this.searchNode.value = "";
				if(this.clearNode) {
					domStyle.set(this.clearNode, {
						display : 'none'
					});
				}
			}
		},
		
		_onClear : function(evt) {
			this.searchNode.value = "";
			if(this.clearNode) {
				domStyle.set(this.clearNode, {
					display : 'none'
				});
			}
			if(this.buttonArea){
				domStyle.set(this.buttonArea, {
			        display: "none"
			      })
			}
			topic.publish("/mui/search/cancel/back",this);
		},
		
		_onSearch : function(evt) {
			this.searchNode.blur(); 
			this._eventStop(evt);
			if (this.searchNode.value != '' || this.emptySearch) {
				var arguObj = lang.clone(this);
				arguObj.keyword = encodeURIComponent(this.searchNode.value);
				
				var cateUrl =  util.formatUrl(util.urlResolver(
						this.searchCateUrl, arguObj));

				var docUrl =  util.formatUrl(util.urlResolver(
						this.searchDocUrl, arguObj));
				
				topic.publish("/sys/xform/relevance/search",this, {keyword: arguObj.keyword , cateUrl:cateUrl, docUrl:docUrl});
			}
			return false;
		},
		
		_onblur:function(srcObj) {
			topic.publish("/mui/search/onblur",this);
			this._searchFocus = false;
			var self = this;
			this.defer(function() {
				domStyle.set(self.buttonArea, {
					display : 'none'
				});
			}, 0);
		}
	});
});