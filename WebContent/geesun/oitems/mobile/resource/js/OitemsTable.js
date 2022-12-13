define([ "dojo/_base/declare", "dojo/_base/lang", "dojo/parser", "dijit/_WidgetBase", "dijit/_Contained",
	"dijit/_Container", "dojo/window", "dojo/dom", "dojo/_base/array", "dojo/_base/config",
	"dojo/dom-style", "dojo/dom-class", "dojo/dom-construct", "dojo/query", 
	"dojo/topic", "dojo/on", "dojo/request", "dojo/touch", 'mui/dialog/Tip', 'dojo/mouse', 'dojo/dom-attr'], 
	
	function(declare, lang, parser, WidgetBase, Contained, Container, win, 
			dom, array, config, domStyle, domClass, domCtr, query, topic, on, request, 
			touch, Tip, mouse, domAttr) {
	
	return declare("km.oitems.mobile.js.OitemsTable", [ WidgetBase, Contained, Container ], {

		selectedOitems: [],
	    
		postCreate: function(){
			this.inherited(arguments);
			
			this.tbody = this.domNode.getElementsByTagName('tbody')[0];
			
			this.bindEvents();
		},

		bindEvents: function(){
			
			var ctx = this;
			
			topic.subscribe('geesun/oitems/selectedoitem/get', function(cb) {
				cb && cb(ctx.selectedOitems);
			});
			
			topic.subscribe('geesun/oitems/selectedoitem/init', function(oitems){
				
				ctx.selectedOitems = oitems;
				ctx.renderSelectedOitems();
			});
			
			topic.subscribe('geesun/oitems/selectedoitem/res', function(oitems){
				var res = [];
				for(var i = 0; i < oitems.length; i++){
					var oitem = oitems[i];
					res.push({
						fdId: oitem.trolleyId,
						kmApplicationId: oitem.fdApplicationId,
						fdApplicationId: oitem.fdApplicationId,
						fdListingId: oitem.fdListingId,
						kmWarehousingRecordJoinListId: oitem.kmWarehousingRecordJoinListId,
						fdNo: oitem.fdNo,
						fdName: oitem.fdName,
						fdAmount: oitem.fdAmount,
						fdApplicationNumber: oitem.fdApplicationNumber,
						fdReferencePrice: oitem.fdReferencePrice,
						fdCategoryName: oitem.fdCategoryName,
						fdSpecification: oitem.fdSpecification,
						fdBrand: oitem.fdBrand,
						fdUnit: oitem.fdUnit
					});
				}
				ctx.selectedOitems = res;
				ctx.renderSelectedOitems();
				
			});
			
			topic.subscribe('geesun/oitems/selectedoitem/add', function(newOitem){
				var i, l = ctx.selectedOitems.length;
				
				for(i = 0; i < l; i++){
					
					if(ctx.selectedOitems[i].fdId == newOitem.fdId){
						Tip.fail({
							text: '已选取物品'
						});
						return;
					}
					
				}
				
				ctx.selectedOitems.push({
					
				});
				
				ctx.renderSelectedOitems();
				
			});
			
			topic.subscribe('geesun/oitems/selectedoitem/remove', function(idx,geesunOitemsListingId,fdApplicationId){
				ctx.selectedOitems.splice(idx, 1);
				ctx.deleteTrolley(geesunOitemsListingId,fdApplicationId).then(function(res){
					ctx.renderSelectedOitems();
				});
			});
			
		},
		
		deleteTrolley: function(geesunOitemsListingId,fdApplicationId){
			var delUrl = 'geesun/oitems/geesun_oitems_shopping_trolley/geesunOitemsShoppingTrolley.do?method=addOitems&fdOitemsId={fdOitemsId}&fdChecked={fdChecked}&fdApplicationId={fdApplicationId}';
			return request.post(config.baseUrl + lang.replace(delUrl, {
				fdOitemsId : geesunOitemsListingId,
				fdChecked : false,
				fdApplicationId : fdApplicationId
			}), {
				handleAs: 'json' 
			});
		},
		
		renderSelectedOitems: function(){
			
			var ctx = this;

			array.forEach(query('.selectedOitemRow'), function(row, idx){
				row.remove();
			});
			
			array.forEach(ctx.selectedOitems, function(oitem, idx){
				var even =false;
				if(idx%2 ==0){
					even =true;
				}
				var oitemRow = domCtr.create('tr', {
					className: 'selectedOitemRow'
				}, ctx.tbody);
				
				domCtr.create('td', {
					innerHTML: idx + 1
				}, oitemRow);
				
				var fdNoTd = domCtr.create('td', {
					innerHTML: oitem.fdNo
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdId,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.kmApplicationId,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].kmApplicationId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdApplicationId,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdListingId,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdListingId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.kmWarehousingRecordJoinListId,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].kmWarehousingRecordJoinListId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdNo,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdNo'
				},fdNoTd);
				
				var fdNameTd = domCtr.create('td', {
					innerHTML: oitem.fdName
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdName,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdName'
				},fdNameTd);
				
				var fdAmountTd = domCtr.create('td', {
					innerHTML: oitem.fdAmount
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdAmount,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdAmount'
				},fdAmountTd);
				
				var numTd = domCtr.create('td',{
					
				},oitemRow);
				
				/*domCtr.create('div',{
					'data-dojo-type' : 'mui/form/Input',
					'data-dojo-props' : lang.replace('valueField:"{valueField}",name:"{name}",value:"{value}",validate:"{validate}",required:true',{
						valueField: 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
						name: 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
						value: oitem.fdApplicationNumber,
						validate: 'digits range(1,2147483647)'
					})
				},numTd);*/
				
				var numDiv = domCtr.create('div',{
					'style' : 'position: relative;height: 3rem;'
				},numTd);
				
				domCtr.create('input',{
					'type' : 'text',
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
					'value' : oitem.fdApplicationNumber,
					'validate' : 'digits range(1,2147483647)',
					'class' : even?'applicationNumber':'applicationNumber applicationNumberEven',
					'onclick' :'this.focus();'//修复数量输入框无法获得焦点 #109803
				},numDiv);
				
				var fdReferencePriceTd = domCtr.create('td', {
					innerHTML: oitem.fdReferencePrice
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdReferencePrice,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdReferencePrice'
				},fdReferencePriceTd);
				
				var fdCategoryNameTd = domCtr.create('td', {
					innerHTML: oitem.fdCategoryName
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdCategoryName,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdCategoryName'
				},fdCategoryNameTd);
				
				var fdSpecificationTd = domCtr.create('td', {
					innerHTML: oitem.fdSpecification
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdSpecification,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdSpecification'
				},fdSpecificationTd);
				
				var fdBrandTd = domCtr.create('td', {
					innerHTML: oitem.fdBrand
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdBrand,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdBrand'
				},fdBrandTd);
				
				var fdUnitTd = domCtr.create('td', {
					innerHTML: oitem.fdUnit
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdUnit,
					'name' : 'geesunOitemsShoppingTrolleyFormList[' + idx + '].fdUnit'
				},fdUnitTd);
				
				var removeTD = domCtr.create('td', {
				}, oitemRow);
				
				domCtr.create('span', {
					className: 'selectedOitemRowAction_remove',
					innerHTML: '&times;'
				}, removeTD);
				
				on(removeTD, on.selector('.selectedOitemRowAction_remove',touch.press), function(){
					topic.publish('geesun/oitems/selectedoitem/remove', idx, oitem.fdListingId, oitem.fdApplicationId);
				});
				
			});
			
			parser.parse(ctx.tbody).then(function(e){
				topic.publish("/mui/list/resize");
			});
			
			
		},
		
	});
		
})
