/**
 * 督办办结
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._UrgeTabBarButtonMixin", null, {
				
				urgeUrl : '/km/supervise/km_supervise_urge/kmSuperviseUrge.do?method=showUrgeSupervise',
				
				onClick : function(evt) {
					location.href = util.formatUrl(util.setUrlParameter(this.urgeUrl, "fdMainIds", this.fdId));
				}
		});
});