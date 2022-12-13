define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
	"dojo/date/locale" ,
	"dojo/date",
	"mui/i18n/i18n!sys-mobile",
	"mui/i18n/i18n!km-carmng"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util, locale,dateUtil,msg,carmngMsg) {
	
	var item = declare("km.carmng.list.item.CalendarItemMixin", [ItemBase], {
		tag:"li",
		
		baseClass:"muiCarTimeAxisContent",
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			//右侧内容
			var header=domConstruct.create("div",{className:"header"},this.containerNode);
			
			//时间轴
			domConstruct.create("i",{className:"mui mui-date"},header);
			
			var _start=locale.parse(this.start,{selector : 'time',timePattern : dojoConfig.DateTime_format }),
				_end=locale.parse(this.end,{selector : 'time',timePattern : dojoConfig.DateTime_format }),
				_format=dojoConfig.Time_format;
			if(dateUtil.compare(_start,_end,'date') != 0 ){//跨天,显示MM-dd HH:mm ~ {MM-dd HH:mm}
				_format= 'MM-dd HH:mm' ;
			}
			_start=locale.format(_start,{selector : 'time',timePattern :_format }),
			_end=locale.format(_end,{selector : 'time',timePattern : _format });
			
			domConstruct.create("span", { className: "time",innerHTML:_start+' ~ '+_end}, header);//时间
			
			if(this.fdFlag=="0"){
				domConstruct.create("a", { className: "muiCarBtn",innerHTML:carmngMsg["mui.kmCarmngDispatchersInfo.fdFlag1"]}, header);//状态
			}else if(this.fdFlag=="1"){
				domConstruct.create("a", { className: "muiCarBtn returned",innerHTML:carmngMsg["mui.kmCarmngDispatchersInfo.fdFlag2"]}, header);//状态
			}
			
	         var Icon=domConstruct.create("div",{className:"iconItem"},this.containerNode);
	         
	         var box = domConstruct.create("div",{className:"iconBox"},Icon);
	         domConstruct.create("img", { src: this.hostsrc}, box);//用户头像
	         domConstruct.create("h4",{innerHTML:this.fdHost},Icon);
	         
	         var tel = domConstruct.create("div",{className:"detailItem",innerHTML:'<i class="mui mui-tel"></i>'+this.fdApplicationPhone},this.containerNode);
	         var place = domConstruct.create("div",{className:"detailItem",innerHTML:'<i class="mui mui-dot"></i>'+util.formatText(this.fdPlaceName)},this.containerNode);
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		}
	});
	return item;
});