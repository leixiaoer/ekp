define(["dojo/_base/declare", "dojo/ready", "dijit/_WidgetBase", "dojo/dom-construct", 
"lib/echart/echarts", "dojo/dom-style", "dojo/request", "mui/createUtils", "dojo/parser", "dijit/registry", "dojo/on","mui/i18n/i18n!km-supervise:*"],
	function (declare, ready, _WidgetBase, domConstruct, echarts, domStyle, request, createUtils, parser, registry, on,msg) {
		return declare("km.supervise.mobile.chart", [_WidgetBase], {

			url: "",

			baseClass: "lui_sm_mc_card lui_sm_mc_statistics",

			tile: true,

			buildRendering: function () {
				this.inherited(arguments);
				var titleNode = domConstruct.create('div', { className: 'lui_sm_mcs_title' }, this.domNode);
				domConstruct.create('div', { className: 'lui_font_family_bold', innerHTML: msg['py.DuBanLeiBie'] }, titleNode);
				var istatusNode = domConstruct.create('div', { className: 'lui_sm_mcst_nav' }, titleNode);
				var istatusNodeItem1 = domConstruct.create('span', { innerHTML: msg['enums.status.delay'] }, istatusNode);
				var istatusNodeItem2 = domConstruct.create('span', { innerHTML: msg['enums.status.soon.delay'] }, istatusNode);
				var istatusNodeItem3 = domConstruct.create('span', { className: 'lui_sm_mcst_nav-active', innerHTML: msg['enums.status.normal'] }, istatusNode);
				on(istatusNodeItem1, 'click', this.navSelect);
				on(istatusNodeItem2, 'click', this.navSelect);
				on(istatusNodeItem3, 'click', this.navSelect);
				
				var html = '<div class="lui_sm_mcs_itemList" id="templateList" data-dojo-type="mui/list/JsonStoreList" '
						       +'data-dojo-mixins="km/supervise/mobile/resource/js/list/TemplateItemListMixin"'
						       +'data-dojo-props="url:\'/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getCount&status=10\',lazy:false">'
						  +'</div>'
				
		        this.listNode = domConstruct.create("div", {className: "muiSearchPromptList", innerHTML: html}, this.domNode);
	            parser.parse({rootNode: this.listNode, noStart: false});
				
			},
			
		    navSelect: function (e) {
		    	e.target.parentNode.childNodes.forEach(function(item,index){
		    		item.setAttribute('class','')
		    	})
		    	var status = "";
		    	switch(e.target.innerHTML) {
		    	case msg['enums.status.delay']:
		    		status = "30";
		    		break;
		    	case msg['enums.status.soon.delay']:
		    		status = "20";
		    		break;
		    	case msg['enums.status.normal']:
		    		status = "10";
		    		break;
		    	}
		    	
	    		e.target.setAttribute('class','lui_sm_mcst_nav-active')
	    		
		    	if(status != ""){
					var href="/km/supervise/km_supervise_templet/kmSuperviseTemplet.do?method=getCount&status=" + status;
					registry.byId("templateList").set('url',href);
					registry.byId("templateList").reload();
		    	}
		    }
			
		})
	}
)