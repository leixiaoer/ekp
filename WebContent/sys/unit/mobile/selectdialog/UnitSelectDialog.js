﻿define(["dojo/_base/declare", "sys/unit/mobile/selectdialog/DialogCategory", "sys/unit/mobile/selectdialog/DialogMixin" ],
		function(declare, DialogCategory, DialogMixin) {
			var CarSelectDialog = declare("km.carmng.CarSelectDialog", [DialogCategory, DialogMixin ], {
				
				key:null,
				
				//加载
				startup : function() {
					this.inherited(arguments);
					//this.key = "fdCarInfoId";
				}
			});
			return CarSelectDialog;
		});