define(['dojo/_base/declare','dojo/topic','dojo/dom-construct'],
		function(declare,topic,domConstruct){
	
	return declare('km.vote.mobile.js.SwitchMixin',null,{
		
		property:'',
		
		buildRendering:function(){
			this.inherited(arguments);
			if(this.propDom){
				this.propDom.value = (this.value=='on')?false:true;
			}
		},

		onStateChanged:function(newState){
			this.inherited(arguments);
			var _value=newState=='on'?false:true;
			this.propDom.value=_value;
			
			topic.publish("/kmVote/isMul/change",this, {value:_value});
		}
	});
});