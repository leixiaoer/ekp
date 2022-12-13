define([
    "dojo/_base/declare",
    "dojo/_base/lang",
    "dojo/_base/array",
    'dojo/topic',
    "dojo/request",
    "dojo/on",
    "dojo/dom", "dojo/dom-construct", "dojo/dom-style","dojo/dom-class",
    "dijit/_WidgetBase",
    "dijit/_Container",
	"dijit/_Contained",
	"dojox/mobile/_ItemBase",
	"dojo/query"
	], function(declare, lang, array, topic, request, on, dom, domCtr, domStyle, domClass, 
			WidgetBase, Container, Contained, ItemBase,query) {
	
	var simpleItemRenderer = declare('km.oitems.mobile.js.SimpleItemList', [ItemBase], {
		buildRendering:function(){
			
			var ctx = this;
			
			ctx.inherited(arguments);
			
			domClass.add(ctx.domNode, 'muiCateInfoItem');
			
			var itemContainer = domCtr.create('div', {
				className: 'muiCateContainer',
				innerHTML: '\
					<div class="muiCateSelArea"> \
						<div class="muiCateSel" /> \
        			</div>'
			}, ctx.domNode);
			
			//ctx.data['fdName']
			domCtr.create("div",{
				className:"muiCateInfo",
				innerHTML: '<div class="muiCateName">' + ctx.data['fdName'] + '</div>'
			},itemContainer);
			
			if(ctx.url){
				on(ctx.domNode, 'click', function(){
					//修复 #105440 
					query(".muiCateInfoItem").forEach(function(node){
						domClass.remove(node,"muiCateSeled");
					});
					domClass.add(ctx.domNode,"muiCateSeled");
					topic.publish("/mui/category/cancel",{key:'_cateSelect'});
					setTimeout(function(){location.href=ctx.url;},500);
				});
			}
			
		}
	});
	
	return declare("mui.list.SimpleItemList", [WidgetBase, Container, Contained], {

		itemRenderer: simpleItemRenderer,
		
		url: '',
		redirectUrl: '',
		
		method: 'post',
		handleAs: 'json',
		
		postCreate: function(){
			
			domClass.add(this.domNode, 'muiCateLists')
	
			this.loadData();
	
		},
		
		loadData: function(){
			
			var ctx = this;
			
			if(!ctx.url){
				return;
			}

			request(ctx.url, {
				method: ctx.method,
	            handleAs: ctx.handleAs
	        }).then(function(data){
	        	ctx.onComplete(data);
	        },
	        function(err){
	        	ctx.onError(err);
	        });
			
		},
		onComplete: function(data){
			topic.publish('/mui/list/simple/loaded', data);
			this.generateList(data);
		},
		onError: function(err){
			console.error(err);
		},
		generateList: function(items){
			
			var ctx = this;
			
			if(!items || items.length <= 0){

				var muiListNoDataArea = domCtr.create('div', {
					className: 'muiListNoDataArea',
					innerHTML: ' \
						<div class="muiListNoDataInnerArea"> \
							<div class="muiListNoDataContainer muiListNoDataIcon"> \
							<i class="mui mui-message"></i></div> \
							</div> \
						<div class="muiListNoDataTxt"> \
							暂无内容 \
						</div> \
					'
				}, ctx.domNode);

			}else {
				array.forEach(items, function(item, idx){
	
					var muiCateItem = domCtr.create('li', {className: 'muiCateItem'}, ctx.domNode);
	
					new ctx.itemRenderer({data: item, url: lang.replace(ctx.redirectUrl, item)})
						.placeAt(muiCateItem);
					
				});
			}
		}
		
		
	});
});
