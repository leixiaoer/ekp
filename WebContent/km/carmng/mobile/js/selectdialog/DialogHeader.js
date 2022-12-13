define( [ "dojo/_base/declare", "mui/category/CategoryHeader","mui/i18n/i18n!sys-mobile"], 
		function(declare,CategoryHeader,Msg) {
		var header = declare("mui.selectdialog.DialogHeader", [ CategoryHeader], {
				//获取详细信息地址
				//detailUrl : '/sys/organization/mobile/address.do?method=detailList&orgIds=!{curId}'
				title: Msg['mui.category.select'],
				detailUrl:null,
				
				buildRendering : function() {
					if (!this.title || this.title==''){ //有可能没有传标题进来
						this.title = Msg['mui.category.select'];
					}					
			        this.inherited(arguments);
				}
			});
			return header;
});