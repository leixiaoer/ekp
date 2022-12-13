define(["dojo/_base/declare","dijit/_WidgetBase","./QuestionStatistic","dijit/_Container","./CardPageMixin","dojo/dom-construct"],
		function(declare,WidgetBase,QuestionStatistic,Container,CardPageMixin,domConstruct){
	
	return declare("km.pindagate.QuestionStatisticList",[WidgetBase,Container,CardPageMixin],{
		
		
		datas : [],
		
		lazy : true,
		
		startup : function(){
			this.inherited(arguments);
			if(!this.lazy){
				this.init();
			}
		},
		
		init : function(datas){
			this.datas = datas || this.datas ||  [];
			for(var i = 0; i < datas.length; i++){
				if(datas[i].fdSplit == 'false' ){
					var refNode = domConstruct.create('div',{},this.domNode);
					var q = new QuestionStatistic({
						data : datas[i]
					},refNode);
					q.startup();
					this.addChild(q);
				}
			}			
		}
		
	});
});