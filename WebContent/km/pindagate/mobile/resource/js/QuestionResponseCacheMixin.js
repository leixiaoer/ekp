/**
 * 缓存
 */
define(["dojo/_base/declare","dojo/topic","dojo/ready","dojo/query"],function(declare,topic,ready,query){
	return declare("km.pindagate.QuestionResponseCacheMixin",[],{
		
		startup : function(){
			this.inherited(arguments);
			ready(this,this.listenFormElement);
		},
		
		listenFormElement : function(){
			var container = this.containerNode,
				formElements = query('input,select,textarea',container);
			this.connect(container,'click',function(evt){
				var f = formElements;
			});
		},
		
		saveLocalStorage : function(){
			
		}
		
		
	});
});