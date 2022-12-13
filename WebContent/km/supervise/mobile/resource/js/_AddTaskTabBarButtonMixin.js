/**
 * 督办反馈
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._AddTaskTabBarButtonNewMixin", null, {
				
				addUrl : '/km/supervise/km_supervise_main_plan/kmSuperviseMainPlan.do?method=add&fdIsNew=true',
				
				onClick : function(evt) {
					this.addUrl = util.setUrlParameter(this.addUrl, "fdMainId", this.fdId);
					this.addUrl = util.setUrlParameter(this.addUrl, "isAdd", this.isAdd);
					location.href = util.formatUrl(this.addUrl);
				}
		});
});