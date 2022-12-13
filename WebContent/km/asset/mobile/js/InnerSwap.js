define([
	'dojo/_base/declare', 
	'dojox/mobile/SwapView',
	'dojox/mobile/View',
	'dojo/topic'
	], function(declare,
		SwapView, View, topic) {
	
	return  declare("km.asset.InnerSwap",[SwapView], {
			onAfterTransitionIn: function() {
				this.inherited(arguments);
				// 提示：滑动切换并不会触发此方法
				topic.publish('/dojox/mobile/viewChanged', this);
				this.resize();
			}
	});
});