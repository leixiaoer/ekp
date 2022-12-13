define(function(require, exports, module) {
	
	var $ = require('lui/jquery');
	var base = require('lui/base');
	var topic = require('lui/topic');
	
	var VSpace = base.Component.extend({
		
		startup : function(){
			var config = this.config,
				element = config.element;
			var self = this;
			if(window.LUI.luihasReady){
				self.vspaceRender();
			}else{
				LUI.ready(function(){
					self.vspaceRender();
				});
			}
		},
		
		vspaceRender : function(){
			var self = this;
			var preNode = this.element.prev();
			var nextNode = this.element.next();
			if(preNode && preNode.length>0 && nextNode && nextNode.length>0){
				setTimeout(function(){
					if($(preNode).height()>0 && $(nextNode).height()>0){//#93120 隐藏的高度应该排除，会导致无权限时高度不对齐
						if($(preNode).height() == 10 ){
							self.element.hide();
							$(preNode).hide();
						}
					}else{
						self.element.hide();
					}
				},1);
			}else{
				self.element.hide();
			}
		}
		
	});
	exports.VSpace = VSpace;
});