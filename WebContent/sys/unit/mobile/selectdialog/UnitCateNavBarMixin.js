define(["dojo/_base/declare", "mui/i18n/i18n!sys-mobile","./UnitCateNavItem"], function(declare,  Msg,UnitCateNavItem) {
	
  return declare("sys.unit.mobile.selectdialog.UnitCateNavBarMixin", null, {
	itemRenderer:UnitCateNavItem,
	memory:  [
		{
			moveTo: 'allUnitView', 
			text: '所有单位',
			channelName : "dialogNav",
			key: 'all',
			selected : true
		},
		{
			moveTo: 'unitGroupView',
			text: '机构组',
			channelName : "dialogNav",
			key: 'group'
		},
	      {
	  	  	moveTo: "unitCateView", 
	  	  	text: "所有分类",
	  	  	channelName : "dialogNav",
	  	  	key:"cate",
		      }
		]
	  })
})
