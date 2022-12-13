define(
		[ "dojo/_base/declare", "km/carmng/mobile/js/selectdialog/DialogCategory", "km/carmng/mobile/js/selectdialog/DialogMixin" ],
		function(declare, DialogCategory, DialogMixin) {
			var SelectDialog = declare("mui.selectdialog.SelectDialog",
					[ DialogCategory, DialogMixin ], {
						//例外类别id
						exceptValue:''
					});
			return SelectDialog;
		});