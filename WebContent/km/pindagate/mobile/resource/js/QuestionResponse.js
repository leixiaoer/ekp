define(["dojo/_base/declare","dijit/_WidgetBase","./QuestionScrollableMixin","dijit/_Contained","dojo/_base/array","dojo/dom-construct","dojo/query"],
		function(declare,WidgetBase,QuestionScrollableMixin,Contained,array,domConstruct,query){
	
	return declare("km.pindagate.QuestionResponse",[WidgetBase,QuestionScrollableMixin,Contained],{
			
		id:null,//id
		index:null,
		type:null,
		typeName:null,
		questionDef:null,
		relationDef:null,
		serialNum:null,
		title:null,
		
		basePath:'km/pindagate/mobile/question_type/',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.containerNode = domConstruct.create("div",{}, this.domNode);
			
			this.initProperties();
			if(url = this.getWidgetUrl()){
				var self = this;
				require([url],function(){
					array.forEach(arguments, function(ResponseWidget) {
						var _ResponseWidget = new ResponseWidget({
							context : this
						});
						_ResponseWidget.startup();
						self.widget=_ResponseWidget;//循环引用...待改进
						
					},self);
				});
			}
		},
		
		//属性初始化
		initProperties:function(){
			this.type= this.type || this.getValueBySelector('.type',this.domNode);//问题类型
			this.typeName= this.typeName || this.getValueBySelector('.typeName',this.domNode);//问题类型名字
			this.questionDef= this.questionDef || this.getValueBySelector('.questionDef',this.domNode);//问题信息
			this.relationDef= this.relationDef || this.getValueBySelector('.relationDef',this.domNode);//题目关联信息
			this.serialNum= this.serialNum || this.getValueBySelector('.serialNum',this.domNode);//问题序号
			this.pageno= this.pageno || this.getValueBySelector('.pageno',this.domNode);//问题所在页
			this.title=this.title || this.getValueBySelector('.title',this.domNode);//问题名字
			
			if(typeof this.questionDef == 'string'){
				this.questionDef=JSON.parse(this.questionDef);
			}
			
			if(typeof this.relationDef == 'string'){
				if (this.relationDef) {
					this.relationDef=JSON.parse(this.relationDef);
				}
			}
			
			//如果是评分提后面加上分数
			if(this.type == "scorematrix"){
				var items = this.questionDef.options;
				for(var i=0;i<items.length;i++){
					items[i][0] = items[i][0] + " (" + items[i][1] + "分）"; 
				}
				this.questionDef.options = items;
			}
			
			this.renderNode = this.containerNode;
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
					url = this.basePath + this.type +'/' +this.capitalize(this.type) + 'Response';
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