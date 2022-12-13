define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAsset.mobile.nav"], function(declare,navMsg) {
  return declare("", null, {
	  datas:[
	         [
		          {
				    icon: "fontmuis muis-my-property",
					text: navMsg["kmAsset.mobile.nav.my.asset"],  /*  我的资产   */ 
					href: "/km/asset/mobile/my_asset/index.jsp"	        	  
		          },
		          {
				    icon: "fontmuis muis-property-applyfor",
					text: navMsg["kmAsset.mobile.nav.buy.asset"],  /*  资产申购   */ 
					href: "/km/asset/mobile/buy_asset/index.jsp"
		          },
		          {
				    icon: "fontmuis muis-property-receive",
					text: navMsg["kmAsset.mobile.nav.get.asset"],  /*  资产领用   */ 
					href: "/km/asset/mobile/get_asset/index.jsp"
			      },
		          {
				    icon: "fontmuis muis-property-return",
					text: navMsg["kmAsset.mobile.nav.return.asset"],  /*  资产归还   */
					href: "/km/asset/mobile/return_asset/index.jsp"
			      }
	         ],
	         [
		          {
				    icon: "fontmuis muis-property-purchase",
					text: navMsg["kmAsset.mobile.nav.purchase.asset"],  /*  资产采购   */
					href: "/km/asset/mobile/purchase_asset/index.jsp"	        	  
		          },
		          {
				    icon: "fontmuis muis-property-instorage",
					text: navMsg["kmAsset.mobile.nav.in.asset"],  /*  资产入库   */
					href: "/km/asset/mobile/in_asset/index.jsp"
		          },
		          {
				    icon: "fontmuis muis-property-rent",
					text: navMsg["kmAsset.mobile.nav.rent.asset"],  /*  资产出租   */
					href: "/km/asset/mobile/rent_asset/index.jsp"
			      },
		          {
				    icon: "fontmuis muis-property-allot",
					text: navMsg["kmAsset.mobile.nav.divert.asset"],  /*  资产调拨   */
					href: "/km/asset/mobile/divert_asset/index.jsp"
			      }
             ],
	         [
		          {
				    icon: "fontmuis muis-property-maintain",
					text: navMsg["kmAsset.mobile.nav.repair.asset"],  /*  资产维修   */
					href: "/km/asset/mobile/repair_asset/index.jsp"	        	  
		          },
		          {
				    icon: "fontmuis muis-property-change",
					text: navMsg["kmAsset.mobile.nav.change.asset"],  /*  资产变更   */
					href: "/km/asset/mobile/change_asset/index.jsp"
		          },
		          {
				    icon: "fontmuis muis-property-dispose",
					text: navMsg["kmAsset.mobile.nav.deal.asset"],  /*  资产处置   */
					href: "/km/asset/mobile/deal_asset/index.jsp"
			      },
		          {
				    icon: "fontmuis muis-property-card",
					text: navMsg["kmAsset.mobile.nav.card.asset"],  /*  资产卡片   */
					href: "/km/asset/mobile/card_asset/index.jsp"
			      }
             ],
	         [
		          {
				    icon: "fontmuis muis-take-mission",
					text: navMsg["kmAsset.mobile.nav.task.asset"],  /*  盘点任务   */
					href: "/km/asset/mobile/task_asset/index.jsp"	        	  
		          },
		          {
				    icon: "fontmuis muis-property-check",
					text: navMsg["kmAsset.mobile.nav.inventory.asset"],  /*  资产盘点   */
					href: "/km/asset/mobile/inventory_asset/index.jsp"
		          }
             ]	         
	  ]
  })
})
