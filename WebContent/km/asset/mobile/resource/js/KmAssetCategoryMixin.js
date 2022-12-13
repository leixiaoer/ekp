define( [ "dojo/_base/declare","dojo/request","dojo/topic","mui/device/adapter","mui/util"],
		function(declare,request,topic,adapter,util) {			
			var sysCategory = declare("km.asset.mobile.resource.js.KmAssetCategoryMixin", null, {
			
			tempKey:"",
			
//			startup:function(){
//				this.inherited(arguments);
//				this.templURL = "/sys/mobile/js/mui/syscategory/syscategory_sgl.jsp?modelName=!{modelName}&mainModelName=!{mainModelName}&authType=!{authType}&showCommonCate=!{showCommonCate}&extendPara=key:!{key}&fdTmepKey="+this.tempKey+"&s_time=" + new Date().getTime();
//			},
			
			afterSelectCate:function(evt){

				var _this = this;
				this.defer(function(){
					
					adapter.open(util.formatUrl(util.urlResolver(this.createUrl, evt)),"_self");
					this.curIds = "";
					this.curNames = "";
					process.hide();

				},300);
			}
				
			});
			return sysCategory;
	});
