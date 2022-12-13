define(
		[ "dojo/_base/declare","dojo/text!../tmpl/editor_layout.html" ,
		  "mui/util","mui/i18n/i18n!sys-task:sysTaskMain.docSubject"],
		function(declare,layout,util,Msg) {
		    
			var params = {};
			params["title"]= Msg["sysTaskMain.docSubject"];
			layout = util.urlResolver(layout,params);

		return declare("sys.task.mobile.resource.js.EditorMixin",null,{
			layout : layout
		});
			
});