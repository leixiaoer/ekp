/**
 * NavBar mixin,覆盖原NavBar的选中样式
 */
define([
        'dojo/_base/declare',
        'mui/tabbar/TabBarButton',
        "mui/dialog/Confirm",
        "mui/util",
        "mui/dialog/Tip",
        ],
		function(declare,TabBarButton,confirm,util,Tip){
		
		return declare('sys.task.mobile.resource.js.CloseTaskTabBarMixins',[TabBarButton],{
			
			fhref:'',
			onClick:function(e){
				var ctx = this;
				
				confirm("此操作后将无法编辑，是否继续？","",function(value,dialog){
					if(value){
						Tip.processing()
						var args = arguments;
						if (ctx.fhref) {
							$.post(ctx.fhref,
									function(data){
										if(data!=null && data.status==true){
											 Tip.success();
											 window.location.reload();
										}else{
											 Tip.fail();
										}
									},'json');
							//location.href = util.formatUrl(ctx.fhref);
						}
					}
				});
				
			}
		});
	
	
	
});