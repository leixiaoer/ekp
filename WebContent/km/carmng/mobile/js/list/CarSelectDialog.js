define(["dojo/_base/declare", "km/carmng/mobile/js/list/DialogCategory", "km/carmng/mobile/js/selectdialog/DialogMixin" ],
		function(declare, DialogCategory, DialogMixin) {
			var CarSelectDialog = declare("km.carmng.CarSelectDialog", [DialogCategory, DialogMixin ], {
				
				icon1: "mui mui-addIco",
				
				key:null,
				
				//加载
				startup : function() {
					this.inherited(arguments);
					//this.key = "fdCarInfoId";
				}
			});
			return CarSelectDialog;
		});