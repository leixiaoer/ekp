define([
    "dojo/_base/declare",
	"sys/task/mobile/resource/js/list/CalendarItemListMixin",
	'mui/util'
	], function(declare, CalendarItemListMixin,util) {
	
	return declare("sys.task.mportal.TaskListMixin", [CalendarItemListMixin], {
		
		type : 'all',
		
		postMixInProperties : function(){
			//util.loadCSS('/sys/task/mobile/mportal/css/list.css');
			this.inherited(arguments);
		},
		
		buildRendering: function(){
			this.inherited(arguments);
			switch(this.type){
				case 'all' :
					break;
				case 'appoint' :
					this.url = util.setUrlParameter(this.url,'q.flag','1');
					break;
				case 'complete' :
					this.url = util.setUrlParameter(this.url,'q.taskStatus','3');
					break;
				case 'attention' :
					this.url = util.setUrlParameter(this.url,'q.flag','0');
					break;
				default :
					break;
			}
		}
		
	});
});