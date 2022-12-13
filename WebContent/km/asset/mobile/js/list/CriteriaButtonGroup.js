define(["dojo/_base/declare",
        "dojo/dom-style",
        "dojo/dom-class",
        "dojo/dom-construct",
        "dojo/topic",
        "mui/tabbar/TabBarButtonGroup",
        "mui/i18n/i18n!km-asset:mobile"],
		function(declare,domStyle,domClass,domConstruct,topic,TabBarButtonGroup,msg){
	
	return declare("km.imeeting.mobile.resource.js._TabBarButtonGroupMixin", [TabBarButtonGroup], {
		
		criteriaType:'',//当前选中节点
		fdAssignUser:'',
		personnelIds:'',
		taskCreator:'',
		criteriaText: msg['mobile.kmAssetApplyTask.criteria.all'],
		
		buildRendering:function(){
			this.inherited(arguments);
			//当前选中节点设置
			this.subscribe('/km/imeeting/onFeedbackCriteria',function(widget){
				this.criteriaType=widget.criteriaType;
				this.fdAssignUser=widget.fdAssignUser;
				this.personnelIds=widget.personnelIds;
				this.taskCreator=widget.taskCreator;
				this.criteriaText=widget.criteriaText;
			});
			//数据请求结束后显示label
			this.subscribe('/mui/list/loaded', function(widget){
				if(!this.countLabel){
					this.countLabel=domConstruct.create('span',{className:'' },this.domNode,'before');
				}
				if(widget.url.indexOf("kmAssetApplyTaskDetail.do?method=manageList")>-1&&widget.url.indexOf("inventoryType=todoInventory")>-1){
					this.countLabel.innerHTML=this.criteriaText+'（'+ widget.totalSize +'）';
					topic.publish('/km/imeeting/feedbackCriteriaSelect',this.criteriaType);
				}
				
			});
		},
		
		startup :function(){
			this.inherited(arguments);
			domClass.add(this.domNode,'muiMeetingFeedbackCriteria');//筛选按钮
			domClass.add(this.openerContainer.domNode,'muiMeetingFeedbackOpener');//弹出框
		},
		
		//重写打开opener
		_onClick:function(evt){
			var opener = this.openerContainer;
			if (opener.resize) {
				domClass.add(opener.domNode, 'muiTooltipHidden');
				this.defer(function(){
					this.hideOpener(this);
					domClass.remove(opener.domNode, 'muiTooltipHidden');
				},300);
			}
			else {
				opener.show(this.iconDivNode?this.iconDivNode:this.domNode, ['below']);
			}
			this.defaultClickAction(evt);
			this.handle = this.connect(document.body, 'touchend', 'unClick');
		}
		
	});
	
	
	
});