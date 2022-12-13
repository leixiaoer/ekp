define([ "dojo/_base/declare", "dojox/mobile/_ItemBase", "dojo/_base/lang", 
         "dojo/_base/array", "dojo/_base/config", "dojo/window", "dojo/dom", "dojo/_base/array",
         "dojo/dom-style", "dojo/dom-attr", "dojo/dom-class", "dojo/dom-construct", "dojo/query", "dojo/topic", 
         "dojo/on", "dojo/request", "dojo/touch", "./OitemSelectorListItem","mui/i18n/i18n!km-oitems:kmOitemsShoppingTrolley","mui/i18n/i18n!sys-mobile:mui.category"], 
	
	function(declare, ItemBase, lang, array, config, win, dom, array, 
			domStyle, domAttr, domClass, domCtr,  query, topic, on, request, touch, 
			OitemSelectorListItem,Msg,Msg1) {
	
	return declare("km.oitems.mobile.js.OitemSelector", [ ItemBase ], {

		key: '',
		keywords: '',
		lockd : false,
		
		fdApplicationId : '',
		
		itemRenderer: OitemSelectorListItem,
		
		TYPE_RECORD: -1,
		TYPE_OITEM: 0,
		TYPE_CAT: 1,
		
		isMul: false,
		
		catList: [],
		oitemList: [],
		recordList: [],
		
		selectedOitems: {},
		
		catDataUrl: 'km/oitems/km_oitems_manage/kmOitemsManage.do?method=cateList&categoryId={categoryId}&getTemplate=0&modelName=com.landray.kmss.km.oitems.model.KmOitemsManage&authType=00',
		oitemDataUrl: 'km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&deptBudger=true&categoryId={categoryId}&fdApplicationId={fdApplicationId}',
		checkUrl: "km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=checkNum&kmOitemsListingId={kmOitemsListingId}",
		addUrl: "km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=addOitems&fdOitemsId={fdOitemsId}&fdChecked={fdChecked}&fdApplicationId={fdApplicationId}&warehousingRecordId={warehousingRecordId}&fdPrice={fdPrice}&fdCurNum={fdCurNum}&fdIsCancle={fdIsCancle}",
		listRecordUrl : 'km/oitems/km_oitems_warehousing_record_joinlist/kmOitemsWarehousingRecordJoinList.do?method=listRecord&fdListingId={fdListingId}&fdApplicationId={fdApplicationId}',
		getContentUrl : "km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=loadTrolley&orderby=fdNo&fdApplicationId={fdApplicationId}",
		
		searchDataUrl: 'km/oitems/km_oitems_listing/kmOitemsListing.do?method=checkOitemsList&deptBudger=true&fdApplicationId={fdApplicationId}&keywords={keywords}',
		
		listCon: new domCtr.create("ul"),
		
		postCreate: function(){
			var ctx = this;
			ctx.inherited(arguments);
			ctx.initialize();
			ctx.fdApplicationId = query('[name="fdId"]')[0].value;
		},
		
		initialize: function(){
			var ctx = this;
			
			ctx.catList = [];
			
			ctx.selectedOitems = {};
			topic.publish('km/oitems/selectedoitem/get', function(selectedOitems) {
				array.forEach(selectedOitems, function(oitem) {
					ctx.selectedOitems[oitem.fdId] = true;
				});
			});
			
			ctx.title = dom.byId('oitemSelectorTitle');
			ctx.preBtn = dom.byId('oitemSelectorPreBtn');
			ctx.cancelBtn = dom.byId('oitemSelectorCalBtn');
			ctx.scrollableViewContainer = query('#oitemSelectorView__oitemSelect .mblScrollableViewContainer')[0];
			
			domCtr.place(ctx.listCon,ctx.domNode,"last");
			
			ctx.bindEvents();
			
			ctx.loadSearchCon();
			
			ctx.loadData();
			
		},
		
		bindEvents: function(){
			
			var ctx = this;
			var lock = false;
			on(ctx.cancelBtn, touch.press, function(e){
				topic.publish('/mui/category/cancel', {
					key: '_oitemSelect'
				});
			});
			
			on(ctx.preBtn, touch.press, function(e){
				ctx.catList.pop();
				
				if(ctx.catList.length < 1){
					domStyle.set(ctx.preBtn, 'display', 'none');	
					ctx.title.innerHTML = Msg1['mui.category.pselect'];
					ctx.loadData();
				}else{
					var t = ctx.catList[ctx.catList.length - 1];
					ctx.title.innerHTML = t.text;
					ctx.loadData(t.id);
				}
				
				
			});
			
			on(ctx.listCon, on.selector('.muiCateClick', "click"), function(e){
				
				//解决问题单 #109747：在500毫秒内请求多次，只取第一次,解决问题单#143751：延迟500毫秒取消，走完方法释放锁。
				if(lock) return;
				lock = true;
		        //setTimeout(function(){ lock = false; },500);
		          
				e.stopPropagation();
				e.cancelBubble = true;
				e.preventDefault();
				e.returnValue = false;
				
				var node = query(e.target).closest(".muiCateItem")[0];
				
				if(node) {
					var type = domAttr.get(node, 'data-type');
					var id = domAttr.get(node, 'data-id');
					var text = domAttr.get(node, 'data-text');
					
					if(type == ctx.TYPE_CAT) {
						
						ctx.catList.push({
							id: id,
							text: text
						});
						ctx.title.innerHTML = text;
						domStyle.set(ctx.preBtn, 'display', 'block');
						ctx.loadData(id);
						
					} else if(type == ctx.TYPE_OITEM) {
						
						array.forEach(ctx.oitemList, function(d){
							
							if(d.fdId == id){
								
								request.post(config.baseUrl + lang.replace(ctx.checkUrl, {
									kmOitemsListingId : d.fdId
								}), {
									handleAs: 'json'
								}).then(function(res){
									if(res['moreThanOne'] == "false"){
										var recordJoinListId = res['kmOitemsWarehousingRecordJoinListId'];
										var fdPrice = res['fdPrice'];
										var curNum = res['curNum']; 
										var kmOitemsListingId = res['kmOitemsListingId'];
										var promise = ctx.addTrolley(true,recordJoinListId, fdPrice, curNum, kmOitemsListingId);
										promise.then(function(res){
											if(ctx.isMul) {
												
												if(domClass.contains(node, 'muiCateSeled')) {
													domClass.remove(node,'muiCateSeled');
													ctx.selectedOitems[d.oitem.fdId] = false;
													topic.publish('/km/oitems/cancelSelected', kmOitemsListingId);
													topic.publish('/mui/category/unselected', ctx, lang.mixin(d.oitem, {
														label: d.oitem.title
													}));
												} else {
													domClass.add(node,'muiCateSeled');
													ctx.selectedOitems[d.oitem.fdId] = true;
													topic.publish('/mui/category/selected', ctx, lang.mixin(d.oitem, {
														label: d.oitem.title
													}));		
												}
												
												
											} else {
												
												if(ctx.selectedOitems[d.oitem.fdId]) {
													return;
												}
												
												domClass.add(node,'muiCateSeled');
												topic.publish('/mui/category/cancel', {
													key: '_oitemSelect'
												});
											}
										});
									}else{
										ctx.oitemList.push({
											id: id,
											text: text
										});
										ctx.title.innerHTML = text;
										domStyle.set(ctx.preBtn, 'display', 'block');
										ctx.loadRecord(id);
									}
								});
								
							}
							
						});
						
					}else if(type == ctx.TYPE_RECORD){
						array.forEach(ctx.recordList, function(d){
							if(d.fdId == id){
								ctx.addTrolley(true,d.fdId, d.fdPrice, d.curNum, d.oitemId).then(function(res){
									if(ctx.isMul) {
										
										if(domClass.contains(node, 'muiCateSeled')) {
											domClass.remove(node,'muiCateSeled');
											ctx.selectedOitems[d.record.fdId] = false;
											topic.publish('/km/oitems/cancelSelected', d.oitemId);
											topic.publish('/mui/category/unselected', ctx, lang.mixin(d.record, {
												label: d.record.title
											}));
										} else {
											domClass.add(node,'muiCateSeled');
											ctx.selectedOitems[d.record.fdId] = true;
											topic.publish('/mui/category/selected', ctx, lang.mixin(d.record, {
												label: d.record.title
											}));		
										}
										
										
									} else {
										
										if(ctx.selectedOitems[d.record.fdId]) {
											return;
										}
										
										domClass.add(node,'muiCateSeled');
										topic.publish('/mui/category/cancel', {
											key: '_oitemSelect'
										});
									}
								});
							}
						});
					}
					
				}
				lock = false;
			});
			
			topic.subscribe('/km/oitems/cancelSelected', function(oitemId) {
				ctx.addTrolley(false,'','','',oitemId);
			});
			
			topic.subscribe('/mui/category/cancelSelected', function(_ctx, item) {
				
				if(ctx.key != _ctx.key) {
					return;
				}
				
				var node = query('.muiCateItem[data-id="' + item.fdId + '"]');
				ctx.selectedOitems[item.fdId] = false;
				if(node[0]) {
					domClass.remove(node[0], 'muiCateSeled');
				}
				
			});
			
			topic.subscribe('/mui/category/submit', function(_ctx, items) {
				items = [];
				if(ctx.key != _ctx.key) {
					return;
				}
				request.post(config.baseUrl + lang.replace(ctx.getContentUrl, {
					fdApplicationId : ctx.fdApplicationId
				}), {
					handleAs: 'json'
				}).then(function(res){
					items = res;
					topic.publish('km/oitems/oitemselector/result', items);
				});
			});
			
		},
		
		addTrolley: function(fdChecked,recordJoinListId,fdPrice,curNum,kmOitemsListingId){
			var ctx = this;
			return request.post(config.baseUrl + lang.replace(ctx.addUrl, {
				fdOitemsId : kmOitemsListingId,
				fdChecked : fdChecked,
				fdApplicationId : ctx.fdApplicationId,
				warehousingRecordId : recordJoinListId,
				fdPrice : fdPrice,
				fdCurNum : curNum,
				fdIsCancle : ''
			}), {
				handleAs: 'json' 
			});
		},
		
		loadRecord: function(oitemId) {
			if(this.lockd) return;
			var ctx = this;
			ctx.lockd = true;
	        setTimeout(function(){ ctx.lockd = false; },500);
	        
			domCtr.empty(ctx.listCon);
			request.post(config.baseUrl + lang.replace(ctx.listRecordUrl, {
				fdListingId : oitemId,
				fdApplicationId : ctx.fdApplicationId
			}), {
				handleAs: 'json',
				data: {
					rowsize: 999999
				}
			}).then(function(res){
				var t = [];
				array.forEach(res.datas, function(d){
					
					var _t = {};
					array.forEach(d, function(_d){
						_t[_d.col] = _d.value;
					});
					t.push({
						type: ctx.TYPE_RECORD,
						fdId: _t.fdId,
						oitemId: _t.oitemId,
						fdPrice: _t.fdPrice,
						curNum: _t.fdCurNumber,
						text: _t.title+" ("+Msg['kmOitemsShoppingTrolley.fdAmount']+":"+_t.fdCurNumber+", "+Msg['kmOitemsShoppingTrolley.fdReferencePrice']+":"+_t.fdPrice+")",
						record: _t
					});
					
				});
				ctx.scrollableViewContainer.style.transform="translate3d(0,0,0)";
				
				ctx.recordList = t;
				ctx.renderData(t);
			});
		},
		
		loadData: function(catId) {
			
			var ctx = this;
			
			domCtr.empty(ctx.listCon);
			
			request.post(config.baseUrl + lang.replace(ctx.catDataUrl, {
				categoryId: catId || ''
			}), {
				handleAs: 'json'
			}).then(function(res){
				
				var t = [];
				
				array.forEach(res, function(d){
					
					t.push({
						type: ctx.TYPE_CAT,
						fdId: d.value,
						text: d.text
					});
				});
				
				ctx.renderData(t);
			});
			
			if(catId){
				
				request.post(config.baseUrl + lang.replace(ctx.oitemDataUrl, {
					categoryId: catId || '',
					fdApplicationId: ctx.fdApplicationId
				}), {
					handleAs: 'json',
					data: {
						rowsize: 999999
					}
				}).then(function(res){
					
					var t = [];
					
					array.forEach(res.datas, function(d){
						var _t = {};
						array.forEach(d, function(_d){
							_t[_d.col] = _d.value;
						});
						t.push({
							type: ctx.TYPE_OITEM,
							fdId: _t.fdId,
							text: _t.title+" ("+Msg['kmOitemsShoppingTrolley.fdAmount']+":"+_t.fdAmount+", "+Msg['kmOitemsShoppingTrolley.fdReferencePrice']+":"+_t.fdReferencePrice+")",
							oitem: _t
						});
						ctx.scrollableViewContainer.style.transform="translate3d(0,0,0)";
					});
					
					ctx.oitemList = t;
					ctx.renderData(t);
				});
			}
			
		},
		
		renderData: function(data) {
			
			var ctx = this;
			
			array.forEach(data, function(item, idx){
				
				var oitemItem = new ctx.itemRenderer(lang.mixin(item, {
					isMul: ctx.isMul
				}));
				
				if(ctx.selectedOitems[item.fdId]) {
					domClass.add(oitemItem.domNode, 'muiCateSeled');
				}
				
				oitemItem.placeAt(ctx.listCon);
				
			});
			
		},
		loadSearchCon:function(){
			var ctx = this;
			var searchCon = domCtr.create('div', {
				className: 'muiOitemSelSearch'
			});


			var searchBox = domCtr.create('div', {
				className: 'muiOitemSearchContainer'
			}, searchCon);
			
			var inputBox = domCtr.create('div', {
				className: 'muiOitemSearchTextContainer'
			}, searchBox);
			
			domCtr.create('input', {
				id: 'muiOitemSearchText',
				className: 'muiOitemSearch inText',
				placeholder: '搜索用品'
			}, inputBox);
			
			var buttonCon = domCtr.create('div', {
				id: 'muiOitemSearchBtn',
				className: 'muiOitemSearch button search',
				innerHTML:'搜索'
			}, searchBox);
			
			domCtr.place(searchCon,ctx.domNode,"first");
			this.connect(buttonCon, 'click', 'getSearchData');
		},
		
		
		getSearchData : function(){
			if(this.lockd) return;
			var ctx = this;
			ctx.lockd = true;
	        setTimeout(function(){ ctx.lockd = false; },500);
			ctx.keywords = $('#muiOitemSearchText').val();
			request.post(config.baseUrl + lang.replace(ctx.searchDataUrl, {
				fdApplicationId : ctx.fdApplicationId,
				keywords : ctx.keywords
			}), {
				handleAs: 'json',
				data: {
					rowsize: 999999
				}
			}).then(function(res){
				var t = [];
				array.forEach(res.datas, function(d){
					
					var _t = {};
					array.forEach(d, function(_d){
						_t[_d.col] = _d.value;
					});
					t.push({
						type: 0,
						fdId: _t.fdId,
						text: _t.title+" ("+Msg['kmOitemsShoppingTrolley.fdAmount']+":"+_t.fdAmount+", "+Msg['kmOitemsShoppingTrolley.fdReferencePrice']+":"+_t.fdReferencePrice+")",
						oitem: _t
					});
					
				});
				ctx.scrollableViewContainer.style.transform="translate3d(0,0,0)";
				
				ctx.recordList = t;
				ctx.loadListData(t);
			});
		},
		
		loadListData: function(data) {

			var ctx = this;
			
			ctx.oitemList = data;
			domCtr.empty(ctx.listCon);
			
			if(data.length == 0){
				domCtr.create('div', {
					innerHTML:'暂无记录'
				}, ctx.listCon);
			}else{
				array.forEach(data, function(item, idx){
					
					var oitemItem = new ctx.itemRenderer(lang.mixin(item, {
						isMul: ctx.isMul
					}));
					
					if(ctx.selectedOitems[item.fdId]) {
						domClass.add(oitemItem.domNode, 'muiCateSeled');
					}
					
					oitemItem.placeAt(ctx.listCon);
					
				});
			
			}
			
		}
		
	});
		
})