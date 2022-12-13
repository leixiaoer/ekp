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
	"mui/util","mui/i18n/i18n!sys-task:sysTaskMain.fdPlanCompleteTime.descript",
	"mui/openProxyMixin"
	], function(declare, domConstruct,domClass , domStyle , domAttr , ItemBase , util,i18n,locale,util,Msg,OpenProxyMixin) {
	
	var item = declare("km.supervise.list.item.SupervisePlanItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"muiTaskListItem",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode= this.srcNodeRef
				|| domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.href){
				this.proxyClick(this.domNode, this.href, '_blank');
			}
			
			//右侧内容
			var rightContainer=domConstruct.create("div", { className: "rightContainer"}, this.containerNode),
				contentContainer=domConstruct.create("div", { className: "contentContainer"}, rightContainer),
				progressContainer=domConstruct.create("div", { className: "progress"}, rightContainer);
			
			
			this.labelNode = domConstruct.create("div",{className:"muiSubject"},contentContainer);
			
			var labelText = "";
			//状态
			if(this.fdStatus){
				var _statusInfo=this._getStatusInfo(this.fdStatus);
				labelText += '<span class="muiTaskStatusTag '+_statusInfo.className+'" >'+this.fdStatusText+'</span>'
			}
			//超期
			if(this.overDay){
				labelText += '<span class="overday" >'+Msg['sysTaskMain.fdPlanCompleteTime.descript.over']+ this.overDay+Msg['sysTaskMain.fdPlanCompleteTime.descript.day']+'</span>'
			}
			
			if(this.title){
				labelText += this.title;
			}
			
			this.subject = domConstruct.create("h4",{className:"muiSubject",innerHTML:labelText },this.labelNode);
			
			
			var taskIcoList=domConstruct.create("ul", { className: "taskIcoList"}, contentContainer);
			var li;
			//负责人
			li=domConstruct.create("li", {className:'muiTaskPersons' }, taskIcoList);
//			domConstruct.create("i", { className: "mui mui-person"}, li);
			domConstruct.create("span", { innerHTML: "负责人: "+this.performs }, li);
			
			//进度
			this._buildProgress(this.progress,progressContainer);
			
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
		
		_getStatusInfo:function(value){
			var statusInfo={
				'1':{
					className:'muiTaskInactive'
				},
				'2':{
					className:'muiTaskProgress'
				},
				'3':{
					className:'muiTaskComplete'
				},
				'4':{
					className:'muiTaskTerminate'
				},
				'5':{
					className:'muiTaskOverrule'
				},
				'6':{
					className:'muiTaskClose'
				}
			}
			return statusInfo[value];
		},
		
		userClickAction : function(){
			return false;
		}
		
		
	});
	return item;
});