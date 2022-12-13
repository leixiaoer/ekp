define([ "dojo/_base/declare", "dijit/_WidgetBase",], function(declare,_WidgetBase) {
	var claz = declare("mui.form.TextLabel", [ _WidgetBase ], {

		buildRendering : function() {
			this.inherited(arguments);
			this.buildXFormStyle(this.domNode);
		},
		//设置表单自定义样式,现在只对字体类型,颜色生效
		buildXFormStyle: function (node) {
			var xformStyle = this.get("xformStyle");
			if (xformStyle) {
				var showMobileStyle;
				if (typeof KMSSData != 'undefined') {
					var data = new KMSSData();
					data.AddBeanData("sysFormDefaultSettingService");
					data = data.GetHashMapArray();
					if (data.length > 0) {
						showMobileStyle = data[0].showMobileStyle;
					}
				}
				if (showMobileStyle === "true") {
					node.setAttribute("style", xformStyle);
				}
			}
		},
	});

	return claz;
})
