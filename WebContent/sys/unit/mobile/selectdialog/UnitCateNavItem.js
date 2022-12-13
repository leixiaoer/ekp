define( [ "dojo/_base/declare", "mui/nav/NavItem","mui/i18n/i18n!sys-mobile","dojo/topic", "dijit/registry"], 
		function(declare,NavItem,Msg,topic,registry) {
		var header = declare("mui.selectdialog.UnitCateNavItem", [ NavItem], {
				//加载
				startup : function() {
					this.inherited(arguments);
				},
				_onClick: function(e) {
				      if (e) {
				        var target = e.target;
				        this.beingSelected(target);
				      }
				      // 默认click事件，触发列表数据刷新
				      this.defaultClickAction(e);
				     var allHeader = registry.byId('allHeader');//所有单位头部
				     var groupHeader = registry.byId('groupHeader');//机构组头部
				     var cateHeader = registry.byId('cateHeader');//所有分类头部
				     this.showOrHideHeader(allHeader);
				     this.showOrHideHeader(groupHeader);
				     this.showOrHideHeader(cateHeader);
			    },
			    showOrHideHeader:function(header){
			    	if(header && header.channel){
			    		if(header.channel == this.key){
			    			header._showHeader(header);
					     }else{
					    	 header._hideHeader(header);
					     }
			    	}
			    }
			});
			return header;
});