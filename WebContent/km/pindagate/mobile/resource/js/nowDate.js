define(["dojo/_base/declare", "dojo/request", "mui/util"], function(declare, request, util) {
			var claz = declare("km.pindagate.nowDate", [], {
				
		            url : "/km/pindagate/mobile/resource/js/nowDate.jsp",
		            
		    		/**
		    		* 获取服务器当前时间
		    		* @return 返回服务器的当前时间（Date对象）
		    		*/	
					getDate : function() {
						var nowDate = null;
						var requestUrl = util.formatUrl(this.url);
						request.get(requestUrl ,{handleAs : 'json' , sync : 'false'}).then(function(time){
							nowDate = new Date(time);
						});
						return nowDate;
					}
			
			});
			return new claz();
});