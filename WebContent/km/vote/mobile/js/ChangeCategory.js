define(["dojo/_base/declare","dojo/_base/lang", "dijit/_WidgetBase","mui/dialog/Tip",
        "dojo/query","mui/form/_CategoryBase","dojo/dom-attr","dojo/dom","dojo/on"],function(declare,lang,WidgetBase,Tip,query,
        		CategoryBase,domAttr,dom,on){
	
		return declare("km.vote.ChangeCategory",[WidgetBase,CategoryBase],{
			key: '_cateSelect',
			
			buildRendering:function(){
				this.inherited(arguments);
				on(query('.muiVoteCate i'),'click',lang.hitch(this,this._onChangeCateClick));
				this.key = '_cateSelect';//由于是双继承，第二个集成会以混入的方式覆盖该类默认值，key的值需要重新赋予。
			},
			_onChangeCateClick : function(){
				this.defer(function(){
					this._selectCate();
				}, 350);
			},
			postCreate : function() {
				this.inherited(arguments);
				this.eventBind();
			},
			startup:function(){
				if(this._started){ return; }
				this.inherited(arguments);
			},
			afterSelectCate:function(evt){
				var process = Tip.processing();
				process.show();
				this.defer(function(){
					domAttr.set(dom.byId('_fdCategoryId'),'value',evt.curIds);
					dom.byId('_fdCategoryName').innerText=evt.curNames;
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