define(["dojo/_base/declare", "dijit/_WidgetBase", "dijit/_Contained",
	"dijit/_Container", "dojo/dom-construct", "dojo/query", "dojo/dom-attr", "dojo/topic"],

	function(declare, WidgetBase, Contained, Container, domCtr, query, domAttr, topic) {

		return declare("km.oitems.mobile.js.OitemsTable", [WidgetBase, Contained, Container], {

			postCreate: function() {
				this.inherited(arguments);
				this.bindEvents();
			},

			bindEvents: function() {
				var ctx = this;
				ctx.renderElement();

				topic.subscribe('km/oitems/number/change', function() {
					ctx.calculate();
				});

				topic.subscribe('km/oitems/selectedoitem/render', function() {
					ctx.calculate();
				});

			},

			calculate: function() {
				var amount = 0;
				query("tr.selectedOitemRow").forEach(function(node) {
					var number = query(".applicationNumber", node)[0].value;
					var price = query("[name$=fdReferencePrice]", node)[0].value;
					amount += (parseInt(number) * parseFloat(price));
				});
				domAttr.set(this.amountText, "innerHTML", amount);
				domAttr.set(this.totalAmount, "value", amount);
			},

			renderElement: function() {
				var el = domCtr.create('div', {}, this.domNode);

				this.label = domCtr.create('span', {
					'innerHTML': this.params.label + ': '
				}, el);

				this.amountText = domCtr.create('span', {
					'innerHTML': '0'
				}, el);

				this.totalAmount = domCtr.create('input', {
					'type': 'hidden',
					'value': 0,
					'name': 'fdTotalAmount'
				}, el);
			},

		});

	})