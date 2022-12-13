define(["dojo/_base/declare",
        "dojo/topic",
        "dojo/dom-class",
        "mui/tabbar/TabBarButton"],
		function(declare,topic,domClass,TabBarButton){
	
	return declare("km.asset.list.CriteriaBarButton", [TabBarButton], {
		
		criteriaType:'',
		fdAssignUser:'',
		personnelIds:'',
		taskCreator:'',
		
		buildRendering :function(){
			this.inherited(arguments);
			this.criteriaText=this.label;
			domClass.add(this.domNode,'muiMeetingFeedbackCriteriaItem muiNavBarGroupItem');//添加样式
			domClass.add(this.labelNode,'muiNavBarGroupItemInner');//添加样式
			this.subscribe('/km/imeeting/feedbackCriteriaSelect','feedbackCriteriaSelect');
			
		},
		
		onClick : function() {
			if (this.href) {
				location.href = util.formatUrl(this.href);
				return false;
			}
			topic.publish('/km/imeeting/onFeedbackCriteria',this,{criteriaType :this.criteriaType, fdAssignUser :this.fdAssignUser, personnelIds :this.personnelIds, taskCreator :this.taskCreator, criteriaText :this.criteriaText});
			this.inherited(arguments);
		},
		
		feedbackCriteriaSelect:function(criteriaType){
			domClass.remove(this.domNode,'selected');
			if(this.criteriaType == criteriaType){
				domClass.add(this.domNode,'selected');
			}
		}
		
		
		
	});
	
	
	
});