define(['dojo/_base/declare','dojo/topic','dojo/dom-construct'],
		function(declare,topic,domConstruct){
	
	return declare('km.vote.mobile.js.VoteSwitchMixin',null,{
		
		property:'',
		
		buildRendering:function(){
			this.inherited(arguments);
			//#103413 有两个input导致移动端新建投票时不允许评论不生效
			//this.propDom=domConstruct.create('input',{type:'hidden',name:this.property,value:this.value=='on'?true:false},this.domNode);
		},

		onStateChanged:function(newState){
			this.inherited(arguments);
			var _value=newState=='on'?true:false;
			this.propDom.value=_value;
			topic.publish("/kmVote/isAllowSay/change",this, {value:_value});
		}
	});
});