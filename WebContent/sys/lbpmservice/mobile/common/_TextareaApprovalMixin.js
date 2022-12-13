define([
  "dojo/_base/declare",
  "mui/form/_InputBase",
  "dojo/dom-construct",
  "dojo/dom-style",
  "dojo/topic",
  "dojo/touch"
  ], function (
  declare,
  _InputBase,
  domConstruct,
  domStyle,
  topic,
  touch
  ) {
	var mixin = declare("sys/lbpmservice/mobile/common/_TextareaApprovalMixin",null, {
	    
	    // 针对审批意见框，重写此方法
	    resizeHeight: function (obj) {
	        var th = 38;
	        domStyle.set(obj, {height: "auto",});
	      /* if (this.textareaPre) {
	          th = this.textareaPre.offsetHeight;
	        }*/
	        if (th <= 0 && obj.value != "") {
	          th = obj.scrollHeight;
	        }
	        if (th <= 38) {
	          th = 38;
	        }
	        domStyle.set(obj, {
	          height: th + "px",
	        });
	      }

	});

	  return mixin;
	});