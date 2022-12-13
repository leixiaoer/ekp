define([ "dojo/_base/declare", "dojo/dom-construct","dojo/topic"], 
		function(declare, domConstruct, topic) {
	var item = declare("sys.introduce.IntrSwitchMixin", null, {
		
		_onSwitchClick: function(){
			this.inherited(arguments);
			//发表按钮校验
			topic.publish('/mui/introduce/validate');
		},
		
		postCreate:function(){
			this.inherited(arguments);
			topic.publish('/mui/introduce/validate');
		},
		
	});
	return item;
});