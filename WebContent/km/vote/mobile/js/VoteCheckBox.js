define([ "dojo/_base/declare",'dijit/registry', "dojo/topic",'mui/dialog/Tip',"mui/form/CheckBox","mui/i18n/i18n!km-vote"], function(declare,registry,topic,Tip,CheckBox,voteMsg) {
	var _field = declare("km.vote.VoteCheckBox", [ CheckBox ], {
		maxNum : '',
		_onClick : function(evt) {
			if (!this.fireClick())
				return;

			if(!this.checked){
		   		var num=0;
		   		var obj = document.getElementsByName(this.name);
		   		for (var i=0; i<obj.length; i++) {
		   	   		var checkBoxWidget = registry.byNode(obj[i]);
		   			if (checkBoxWidget.checked) {
		   				num++;
		   			}
		   		}
				if (this.maxNum != 0 && num >= this.maxNum) {
					Tip.fail({
						text:voteMsg["mui.error.select.max"]+this.maxNum+voteMsg["mui.error.option"]
					});
					this.checked = true;
				}
	   		}
			
			this.set('checked', this.checked ? false : true);
			topic.publish(this.ITEMVALUE_CHANGE, this, {
				name : this.name
			});
			if (!this.mul) {
				topic.publish(this.CHECK_CHANGE, this, {
					name : this.name,
					value : this.value
				});
			}
		}
	});
	return _field;
});