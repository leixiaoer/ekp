/**
 * 督办办结
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._StopTabBarButtonNewMixin", null, {
				
				stopUrl : '/km/supervise/km_supervise_main_stop/kmSuperviseMainStop.do?method=add',
				
				onClick : function(evt) {
					location.href = util.formatUrl(util.setUrlParameter(this.stopUrl, "fdMainId", this.fdId));
				}
		});
});