define(["dojo/_base/declare","dijit/_WidgetBase","./QuestionScrollableMixin","dijit/_Contained","dojo/_base/array","dojo/dom-construct","dojo/dom-class","dojo/query"],
		function(declare,WidgetBase,QuestionScrollableMixin,Contained,array,domConstruct,domClass,query){
	
	return declare("km.pindagate.QuestionStatistic",[WidgetBase,QuestionScrollableMixin,Contained],{
		
		id:null,//id
		
		data : null,
		
		basePath:'km/pindagate/mobile/question_type/',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			domClass.add(this.domNode,'muiResponse');
			this.containerNode  = domConstruct.create("div",{className:'questionStatistic'}, this.domNode);
			
			this.initProperties();
			if(url = this.getWidgetUrl()){
				var self = this;
				require([url],function(){
					array.forEach(arguments, function(StatisticWidget) {
						var _statisticWidget = new StatisticWidget({
							context : this
						});
						_statisticWidget.startup();
						self.widget=_statisticWidget;//循环引用...待改进
						
					},self);
				});
			}
		},
		
		//属性初始化
		initProperties:function(){
			this.renderNode = this.containerNode;
			this.type = this.data.fdType;
		},
		
		getValueBySelector:function(selector,ctx){
			var domArray=query(selector,ctx);
			if(domArray.length > 0){
				return domArray[0].value;
			}
			return null;
		},
		
		//根据类型获取对应的题型组件url
		getWidgetUrl:function(){
			var url=null;
			if(this.type){
				var url=this.type;
				if (url.indexOf('/') < 0)
					// example:ekp/km/pindagate/mobile/question_type/singleselect/SingleselectResponse
					url = this.basePath + this.type +'/' +this.capitalize(this.type) + 'Statistic';
			}
			return url;
		},
		
		//首字母转为大写
		capitalize : function(str) {
			if (str == null || str.length == 0)
				return "";
			return str.substr(0,1).toUpperCase()+str.substr(1);
		},
		
		show:function(){
			this.widget.show();
		},
		
		hide:function(){
			this.widget.hide();
		}
		
		
	});
});