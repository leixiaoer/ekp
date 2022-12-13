/**
 * 督办办结
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._ChangeTabBarButtonNewMixin", null, {
				
				changeUrl : '/km/supervise/km_supervise_main/kmSuperviseMain.do?method=changeSupervise',
				
				onClick : function(evt) {
					this.changeUrl = util.setUrlParameter(this.changeUrl, "fdOriginId", this.fdId);
					this.changeUrl = util.setUrlParameter(this.changeUrl, "fdMainId", this.fdId);
					location.href = util.formatUrl(this.changeUrl);
				}
		});
});