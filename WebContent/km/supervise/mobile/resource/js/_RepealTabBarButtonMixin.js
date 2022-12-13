/**
 * 督办撤销
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!sys-task:mui.sysTaskMain"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._RepealTabBarButtonMixin", null, {

				repealUrl : '/km/supervise/km_supervise_main/kmSuperviseMain.do?method=updateAddRepeal',
				
				onClick : function(evt) {
					location.href = util.formatUrl(util.setUrlParameter(this.repealUrl, "fdId", this.fdId));
				}
		});
});