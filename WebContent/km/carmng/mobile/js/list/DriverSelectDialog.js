define(["dojo/_base/declare", "km/carmng/mobile/js/DialogCategory", "km/carmng/mobile/js/selectdialog/DialogMixin" ],
		function(declare, DialogCategory, DialogMixin) {
			var CarSelectDialog = declare("km.carmng.CarSelectDialog", [DialogCategory, DialogMixin ], {
				
				icon1: "mui mui-create",
				//加载
				startup : function() {
					this.inherited(arguments);
					this.key = "fdDriverId";
				}
			});
			return CarSelectDialog;
		});