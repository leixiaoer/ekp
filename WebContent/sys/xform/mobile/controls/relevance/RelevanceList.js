define( [ "dojo/_base/declare","mui/category/CategoryList","dojo/_base/lang",
          "dojo/_base/json","mui/util","dojo/topic"], function(declare,
		CategoryList, lang,json,util,topic) {
	return declare("sys.xform.mobile.controls.relevance.RelevanceList", [ CategoryList ], {
		
		modelName:null,
		
		isTemp : false,
		
		isMul : true,
		
		selType : 1,
		
		rowsize : 15,
		
		pageno: 1,
		
		//数据请求URL
		dataUrl : '/sys/xform/controls/relevance.do?method=getAllList&parentId=!{parentId}&modelPath=!{modelPath}&fdControlId=!{fdControlId}&extendXmlPath=!{extendXmlPath}&fdKey=!{fdKey}&pAdmin=!{pAdmin}',
		
		tempUrl : '/sys/xform/controls/relevance.do?method=getDocByCategory&modelName=!{modelName}&fdControlId=!{fdControlId}&extendXmlPath=!{extendXmlPath}&fdKey=!{fdKey}&fdTemplateId=!{fdTemplateId}&categoryId=!{categoryId}&isChild=!{isChild}&modelPath=!{modelPath}&notSearch=!{notSearch}&pageno=!{pageno}&rowsize=!{rowsize}&orderby=fdId&ordertype=down&inputParams=!{inputParams}',
		
		postCreate : function() {
			this.inherited(arguments);
			this.dataUrl = util.formatUrl(this.dataUrl);
			this.tempUrl = util.formatUrl(this.tempUrl);
			this.subscribe("/sys/xform/relevance/category/changed","_RcateChange");
			this.subscribe("/sys/xform/relevance/search","_searchByUrl");
		},
		
		_searchByUrl : function(srcObj,evt){
			if(srcObj.key==this.key){
				if(this.isTemp){
					evt.url = evt.docUrl;
					this._RcateChange(srcObj,evt);
				}else{
					evt.url = evt.cateUrl;
					this._cateChange(srcObj,evt);
				}
			}
		},
		
		_RcateChange : function(srcObj,evt){
			if(srcObj.key==this.key){
				this.isTemp = true;
				this.pageno = 1;
				if(evt && evt.url){
					if(!this._addressUrl){
						this._addressUrl = this.url;
					}
					this.showMore=false;
					this.url = evt.url+"&fdControlId=!{fdControlId}&extendXmlPath=!{extendXmlPath}&pageno=!{pageno}&rowsize=!{rowsize}&modelName=!{modelName}&fdKey=!{fdKey}&fdTemplateId=!{fdTemplateId}&categoryId=!{categoryId}&isChild=!{isChild}&notSearch=!{notSearch}&orderby=fdId&ordertype=down&inputParams=!{inputParams}";
					this.url = util.urlResolver(this.url,this);
				}else{
					this.fdTemplateId = evt.fdTemplateId;
					this.categoryId = evt.categoryId;
					this.modelPath = evt.modelPath;
					this.fdKey = evt.fdKey;
					this.notSearch = evt.notSearch;
					this.isChild = evt.isChild;
					this.url = util.urlResolver(this.tempUrl,this);
				}
				this.buildLoading();
				this.reload();
				var self = this;
				this.defer(function(){
					topic.publish('/sys/xform/relevance/toTop',self);
				}, 200);
			}
		},
		
		loadMore: function(handle) {
			if(this.isTemp){
				this.url = util.urlResolver(this.tempUrl,this);
			}else{
				this.url = util.urlResolver(this.dataUrl,this);
			}
			return this.doLoad(handle, true);
		},
		
		formatDatas : function(datas) {
			return datas;
		},
		
		//往下查看数据
		_cateChange:function(srcObj,evt){
			if(srcObj.key==this.key){
				this.isTemp = false;
				if(evt && evt.url){
					if(!this._addressUrl){
						this._addressUrl = this.url;
					}
					this.showMore=false;
					this.url = evt.url+"&modelName=!{modelName}&fdKey=!{fdKey}&fdControlId=!{fdControlId}&extendXmlPath=!{extendXmlPath}";
					this.url = util.urlResolver(this.url,this);
				}else{
					this.showMore=true;
					this.parentId = evt.fdId;
					this.modelPath = evt.modelPath;
					this.fdKey = evt.fdKey;
					this.pAdmin = evt.pAdmin;
					this.url = util.urlResolver(this.dataUrl,this);
				}
				this.buildLoading();
				this.reload();
				var self = this;
				this.defer(function(){
					topic.publish('/sys/xform/relevance/toTop',self);
				}, 200);
			}
		},
		
		//搜索后返回
		_cateReback:function(srcObj,evt){
			if(srcObj.key==this.key){
				this.showMore=true;
				if(this.isTemp){
					this.pageno = 1;
					this.url = util.urlResolver(this.tempUrl,this);
				}else{
					this.url = util.urlResolver(this.dataUrl,this);
				}
				this.buildLoading();
				this.reload();
			}
		}
	});
});