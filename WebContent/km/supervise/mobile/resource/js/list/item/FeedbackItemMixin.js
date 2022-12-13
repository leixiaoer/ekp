define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/i18n/i18n",
	"dojo/date/locale",
	"mui/util",
  	"km/supervise/mobile/resource/js/_AttachmentItemMixin",
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,_AttachmentItemMixin,OpenProxyMixin) {
	
	var item = declare("km.supervise.list.item.FeedbackItemMixin", [ItemBase,_AttachmentItemMixin,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"taskCommonListItem muiFeedbackListItem",
		
		href : 'javascript:void(0);',
		
		fdModelName:'com.landray.kmss.km.supervise.model.KmSuperviseBack',
		
		formBeanName:'kmSuperviseBackForm',
		
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			//上方信息
			var feedbackInfo=domConstruct.create("div",{className:"info"},this.containerNode);
			//反馈人头像
			domConstruct.create("span", {className: "infoImg",style:{background:'url(' + util.formatUrl(this.icon) +') center center no-repeat',backgroundSize:'cover',display:'inline-block'}}, feedbackInfo);
			domConstruct.create("h4", { innerHTML:this.fdPersonName}, feedbackInfo);//反馈人名字
		
			var date=domConstruct.create("p", { className:"infoDate mui mui-time"}, feedbackInfo);
			domConstruct.create("span", { innerHTML:this.fdFeedbackTime }, date);//反馈日期
			
			var progressContainer=domConstruct.create("div", { className: "progress"}, feedbackInfo);//进度
			this._buildProgress(this.fdProgress,progressContainer);
			
			//下方反馈内容
			if(this.fdResult){
				var feedbackContent=domConstruct.create("div",{className:"content"},feedbackInfo);
				domConstruct.create("p",{innerHTML:this.fdResult},feedbackContent);
			}
			//附件
			if(this.fdId){
				var attContainer=domConstruct.create("div",{className:""},feedbackInfo);
				this.createAtt(attContainer,{
					fdModelId:this.fdId
				});
			}
		},
		
		startup:function(){
			if(this._started){ return; }
			this.inherited(arguments);
		},
	
		_setLabelAttr: function(text){
			if(text)
				this._set("label", text);
		},
		
		_buildProgress:function(progress,containerNode){
			progress=progress.replace('%','');
			//角度=360度*progress/100
			var deg=(18*parseInt(progress)/5);
			var pie_left=domConstruct.create("div",{className:"pie_left"},containerNode);
			var left=domConstruct.create("div",{className:"left"},pie_left);
			if(deg > 180){
				var _deg=deg-180;
				domStyle.set(left,'transform','rotate('+_deg+'deg)');
				domStyle.set(left,'-webkit-transform','rotate('+_deg+'deg)');
			}
			var pie_right=domConstruct.create("div",{className:"pie_right"},containerNode);
			var right=domConstruct.create("div",{className:"right"},pie_right);
			if(deg < 180){
				domStyle.set(right,'transform','rotate('+deg+'deg)');
				domStyle.set(right,'-webkit-transform','rotate('+deg+'deg)');
			}else{
				domStyle.set(right,'transform','rotate(180deg)');
				domStyle.set(right,'-webkit-transform','rotate(180deg)');
			}
			if(this.fdStatus=='3'){
				var mask=domConstruct.create("div",{className:"mask"},containerNode);
				var span=domConstruct.create("i",{className:'mui mui-taskComplete'});
			}else if(this.fdStatus=='6'){
				var mask=domConstruct.create("div",{className:"mask"},containerNode);
				var span=domConstruct.create("i",{className:'mui mui-taskClose'});
			}else{
				var mask=domConstruct.create("div",{className:"mask",innerHTML:'%'},containerNode);
				var span=domConstruct.create("span",{innerHTML:progress});
			}
			
			domConstruct.place(span,mask,'first');
			
		},
		
		userClickAction : function(){
			return false;
		}
		
		
	});
	return item;
});