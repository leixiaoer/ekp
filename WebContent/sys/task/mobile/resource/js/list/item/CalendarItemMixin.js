define([
    "dojo/_base/declare",
    "dojo/dom-construct",
    "dojo/dom-class",
	"dojo/dom-style",
	"dojo/dom-attr",
    "dojox/mobile/_ItemBase",
   	"mui/util",
   	"mui/i18n/i18n!sys-task:sysTaskMain",
	"dojo/date/locale",
	"mui/util","mui/i18n/i18n!sys-task:sysTaskMain.fdPlanCompleteTime.descript",
	"mui/openProxyMixin"
	], function(declare, domConstruct, domClass, domStyle, domAttr, ItemBase, util, i18n, locale, util, Msg, OpenProxyMixin) {
	
	var item = declare("sys.task.list.item.CalendarItemMixin", [ItemBase,OpenProxyMixin], {
		tag:"li",
		
		baseClass:"muiTaskListItem calendarLi",
		
		href : 'javascript:void(0);',
		
		buildRendering:function(){
			this.inherited(arguments);
			
			this.domNode = this.containerNode = this.srcNodeRef || domConstruct.create(this.tag,{className:this.baseClass});
			
			this.domNode.dojoClick = true;
			if(this.href){
				this.proxyClick(this.domNode, this.href, '_blank');
			}
			
			// 单个任务内容载体DOM
			var itemContentContainer = domConstruct.create("div", { className: "itemContentContainer" }, this.containerNode);
			
			
			// 构建头部信息（标题、任务状态、进度）
			this._buildHeaderContent(itemContentContainer);
			
			// 构建底部信息（负责人）
			this._buildFooterContent(itemContentContainer);
			
			//进度
			//this._buildProgress(this.progress,progressContainer);
			
		},
		
		_buildHeaderContent:function(itemContentContainer){
			// 头部信息DOM
			var headerDom = domConstruct.create("div", { className: "headerContainer" }, itemContentContainer);
			
			// 左侧载体DOM（标题、任务状态、负责人）
			var leftContainer = domConstruct.create("div", { className: "leftContainer" }, headerDom);
			
			// 左侧第一行
			var leftFirstRow = domConstruct.create("div", { className: "firstRow" }, leftContainer);
			
			// 标题
			var subjectDom = domConstruct.create("span", { className: "muiTaskSubject muiFontSizeM muiFontColorInfo", innerHTML: this.title }, leftFirstRow);
			
			// 左侧第二行
			var leftSecondRow = domConstruct.create("div", { className: "secondRow" }, leftContainer);
			
			//状态
			if(this.fdStatus){
				var statusDom = domConstruct.create("span", { className: "muiTaskStatusTag muiTaskStatusDefault muiFontSizeS" }, leftSecondRow);
				statusDom.innerText = this.fdStatusText;
			}
			// 超期
			if(this.overDay){
				var overDayDom = domConstruct.create("span", { className: "overday muiFontSizeS"}, leftSecondRow);
				overDayDom.innerHTML = "<span>"+Msg['sysTaskMain.fdPlanCompleteTime.descript.over']+"</span><span>"+this.overDay+"</span><span>"+Msg['sysTaskMain.fdPlanCompleteTime.descript.day']+"</span>";
			}
			
			// 右侧载体DOM（进度）
			var rightContainer = domConstruct.create("div", { className: "rightContainer"}, headerDom);
			
			// 进度
			var progressDom = domConstruct.create("div", { className: "progress muiFontColor"}, rightContainer);
			
			// 进度数值
			var progressNumDom = domConstruct.create("span", {}, progressDom);
			progressNumDom.innerText = this.progress;
			// 进度单位（百分比）
			var progressUnitDom = domConstruct.create("span", {}, progressDom);
			progressUnitDom.innerText = "%";	
			
		},
		
		_buildFooterContent:function(itemContentContainer){
			// 底部信息DOM
			var footerDom = domConstruct.create("div", { className: "footerContainer" }, itemContentContainer);		
			// 负责人
			if(this.performs){
				
				// 负责人信息载体Dom
				var taskPersonsInfoDom = domConstruct.create("div", { className: "muiTaskPersonsInfo"}, footerDom);
				
				// 负责人图标
				var taskPersonsIconDom = domConstruct.create("i", { className: "fontmuis muis-user muiTaskPersonsIcon"}, taskPersonsInfoDom);
				// 负责人标题
				var taskPersonsTitleDom = domConstruct.create("div", { className: "muiTaskPersonsTitle muiFontSizeS muiFontColorMuted"}, taskPersonsInfoDom);
				var responsible = i18n['sysTaskMain.responsible'];
				taskPersonsTitleDom.innerText = i18n['sysTaskMain.responsible'] + ":";
				// 负责人姓名
				var taskPersonsDom = domConstruct.create("div", { className: "muiTaskPersons muiFontSizeS muiFontColorMuted"}, taskPersonsInfoDom);
				if(responsible.length > 8)
				{
					taskPersonsDom.innerText =  "\xa0\xa0\xa0\xa0\xa0\xa0" + this.performs;
				}
				else
				{
					taskPersonsDom.innerText =  this.performs;
				}
				
				
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