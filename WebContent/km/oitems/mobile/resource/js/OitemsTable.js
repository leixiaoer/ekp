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
			
			topic.subscribe('km/oitems/selectedoitem/get', function(cb) {
				cb && cb(ctx.selectedOitems);
			});
			
			topic.subscribe('km/oitems/selectedoitem/init', function(oitems){
				
				ctx.selectedOitems = oitems;
				ctx.renderSelectedOitems();
			});
			
			topic.subscribe('km/oitems/selectedoitem/res', function(oitems){
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
			
			topic.subscribe('km/oitems/selectedoitem/add', function(newOitem){
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
			
			topic.subscribe('km/oitems/selectedoitem/remove', function(idx,kmOitemsListingId,fdApplicationId){
				ctx.selectedOitems.splice(idx, 1);
				ctx.deleteTrolley(kmOitemsListingId,fdApplicationId).then(function(res){
					ctx.renderSelectedOitems();
				});
			});
			
		},
		
		deleteTrolley: function(kmOitemsListingId,fdApplicationId){
			var delUrl = 'km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=addOitems&fdOitemsId={fdOitemsId}&fdChecked={fdChecked}&fdApplicationId={fdApplicationId}';
			return request.post(config.baseUrl + lang.replace(delUrl, {
				fdOitemsId : kmOitemsListingId,
				fdChecked : false,
				fdApplicationId : fdApplicationId
			}), {
				handleAs: 'json' 
			});
		},
		
		applicationNumberChange: function() {
			topic.publish('km/oitems/number/change');
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
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.kmApplicationId,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].kmApplicationId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdApplicationId,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdListingId,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdListingId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.kmWarehousingRecordJoinListId,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].kmWarehousingRecordJoinListId'
				},fdNoTd);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdNo,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdNo'
				},fdNoTd);
				
				var fdNameTd = domCtr.create('td', {
					innerHTML: oitem.fdName
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdName,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdName'
				},fdNameTd);
				
				var fdAmountTd = domCtr.create('td', {
					innerHTML: oitem.fdAmount
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdAmount,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdAmount'
				},fdAmountTd);
				
				var numTd = domCtr.create('td',{
					
				},oitemRow);
				
				/*domCtr.create('div',{
					'data-dojo-type' : 'mui/form/Input',
					'data-dojo-props' : lang.replace('valueField:"{valueField}",name:"{name}",value:"{value}",validate:"{validate}",required:true',{
						valueField: 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
						name: 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
						value: oitem.fdApplicationNumber,
						validate: 'digits range(1,2147483647)'
					})
				},numTd);*/
				
				var numDiv = domCtr.create('div',{
					'style' : 'position: relative;height: 3rem;'
				},numTd);
				
				domCtr.create('input',{
					'type' : 'text',
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdApplicationNumber',
					'value' : oitem.fdApplicationNumber,
					'validate' : 'required digits min(1)',
					'class' : even?'applicationNumber':'applicationNumber applicationNumberEven',
					'onchange' : ctx.applicationNumberChange,
					'onclick' : 'this.focus();'//修复数量输入框无法获得焦点 #109803
				},numDiv);
				
				var fdReferencePriceTd = domCtr.create('td', {
					innerHTML: oitem.fdReferencePrice
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdReferencePrice,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdReferencePrice'
				},fdReferencePriceTd);
				
				var fdCategoryNameTd = domCtr.create('td', {
					innerHTML: oitem.fdCategoryName
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdCategoryName,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdCategoryName'
				},fdCategoryNameTd);
				
				var fdSpecificationTd = domCtr.create('td', {
					innerHTML: oitem.fdSpecification
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdSpecification,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdSpecification'
				},fdSpecificationTd);
				
				var fdBrandTd = domCtr.create('td', {
					innerHTML: oitem.fdBrand
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdBrand,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdBrand'
				},fdBrandTd);
				
				var fdUnitTd = domCtr.create('td', {
					innerHTML: oitem.fdUnit
				}, oitemRow);
				
				domCtr.create('input',{
					'type' : 'hidden',
					'value' : oitem.fdUnit,
					'name' : 'kmOitemsShoppingTrolleyFormList[' + idx + '].fdUnit'
				},fdUnitTd);
				
				var removeTD = domCtr.create('td', {
				}, oitemRow);
				
				domCtr.create('span', {
					className: 'selectedOitemRowAction_remove',
					innerHTML: '&times;'
				}, removeTD);
				
				on(removeTD, on.selector('.selectedOitemRowAction_remove',touch.press), function(){
					topic.publish('km/oitems/selectedoitem/remove', idx, oitem.fdListingId, oitem.fdApplicationId);
				});
				
			});
			
			parser.parse(ctx.tbody).then(function(e){
				topic.publish("/mui/list/resize");
			});
			
			topic.publish('km/oitems/selectedoitem/render');
		},
		
	});
		
})