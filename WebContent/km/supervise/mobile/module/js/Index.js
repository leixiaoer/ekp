/**
 * 督办管理首页，领导，非领导
 */
define(["mui/createUtils","mui/i18n/i18n!km-supervise:*","mui/device/adapter",	"dojo/_base/lang"], function(createUtils,msg,adapter,lang) {
	var card_item = [];
	if(window.isLeader){
		card_item.push({
			title: {text: msg["kmSuperviseMain.fdStatus"]},
            contents: [{
            	tmpl: createUtils.createTemplate(null, {
            		dojoType: "km/supervise/mobile/module/js/Index/LeaderChart"
                })
            }]
		});
		card_item.push({
            contents: [{
            	tmpl: createUtils.createTemplate(null, {
            		dojoType: "km/supervise/mobile/module/js/Index/SuperviseCategory"
                })
            }]
		});
	}else{
		 
		card_item.push({
			title: {text:msg["lbpm.my"]},
            contents: [{
            	tmpl: '<div class="lui_db_mine"><div class="lui_db_mine_wrap"><div class="lui_db_content"><div class="lui_db_mine_slide"><div id="mySuperviseList" data-dojo-type="mui/list/JsonStoreList" ' 
				    	+'data-dojo-mixins="km/supervise/mobile/resource/js/list/MySuperviseItemListMixin" '
				    	+'data-dojo-props="url:\'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getNormalCount\',lazy:false,tile:true">'
					+'</div></div></div></div></div>'

					+'<div data-dojo-type="dojox/mobile/View" id="myCharge" class="lui_asc_box" style="margin-bottom:10px;background:#fff;">'
						+'<div class="lui_asc_list" style="padding:10px 0px 0px 0px;" data-dojo-type="mui/list/JsonStoreList" '
						+'data-dojo-mixins="km/supervise/mobile/resource/js/list/ManageAndChargeItemListMixin" '
						+'data-dojo-props="url:\'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=data&q.mydoc=duty&orderby=docCreateTime&ordertype=down&isDelay=true&rowsize=3\',lazy:false">'
					+'</div>'
					+ '<div class="muiCardFooter" data-dojo-type="km/supervise/mobile/resource/js/IndexMoreMixin" data-dojo-props="href:\'/km/supervise/mobile/list_charge.jsp?mydoc=duty\'" ></div>'	
					+'</div>'
					+'<div data-dojo-type="dojox/mobile/View" id="myUndertakeAndSup" class="lui_asc_box" style="display:none;margin-bottom:10px;background:#fff;">'
						+'<div class="lui_asc_list" style="padding:10px 0px 0px 0px;" data-dojo-type="mui/list/JsonStoreList" id="undertakeAndSupList" '
							+'data-dojo-mixins="km/supervise/mobile/resource/js/list/UndertakeAndSupItemListMixin" '
							+'data-dojo-props="url:\'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=getUndertakeAndSupDatas&fdType=myUndertake&isDelay=true&rowsize=4\',lazy:false">'
						+'</div>'						
						+ '<div id="undertakeMore" class="muiCardFooter" data-dojo-type="km/supervise/mobile/resource/js/IndexMoreMixin" data-dojo-props="href:\'/km/supervise/mobile/list_undertake.jsp?mydoc=myUndertake\'"></div>'	
						+ '<div id="supMore" class="muiCardFooter" data-dojo-type="km/supervise/mobile/resource/js/IndexMoreMixin" data-dojo-props="href:\'/km/supervise/mobile/list_sup.jsp?mydoc=mySup\'"></div>'						  
					+'</div>'
            }]
		}); 
	}
	card_item.push({
		title: {text:msg["py.DuBanDongTai"]},
        contents: [{
        	tmpl: createUtils.createTemplate(null, {
        		dojoType: "sys/mportal/mobile/Card",
        		dojoProps:{
					//title: '督办动态',
        			tile: true,
					configs:[{
						'operations': {
							'toolbar': true,
							'random': {
								'href': '',
								'name': '换一批',
								'type': 'random'
							}
						},
						'url': '/km/supervise/mobile/dynamic_portal.jsp?rowsize=6'
					}]
        		},
        		style :"padding: 0 1.25rem;"
            })
        }]
	});
	
	var _button = null
	if(window.canCreate){
		_button = {
			icon: "muis-pigeonhole",
			text: msg["mobile.lixiang"],
			click: function(){
				require(["mui/syscategory/SysCategoryUtil"], function(SysCategoryUtil){
					SysCategoryUtil.create({
						createUrl:'/km/supervise/km_supervise_main/kmSuperviseMain.do?method=add&i.docTemplate=!{curIds}',
						mainModelName:'com.landray.kmss.km.supervise.model.KmSuperviseMain',
			   			modelName:'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
			   			key:'10'
		            });
				});
			}
		}
	}
	
	return {
		icon: "muis-supervise-index",
		text: msg["mobile.home.page"],
		createView: function() { 
			return {
				cards: card_item,
		        button: _button
			}
		}
	}
})
