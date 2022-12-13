/**
 * 督办办结
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._FinishTabBarButtonNewMixin", null, {
				
				finishUrl : '/km/supervise/km_supervise_main_finish/kmSuperviseMainFinish.do?method=add',
				
				onClick : function(evt) {
					location.href = util.formatUrl(util.setUrlParameter(this.finishUrl, "fdMainId", this.fdId));
				}
		});
});