/**
 * 督办反馈
 */
define(	[
       	 "dojo/_base/declare", "dojo/_base/lang", "dojo/request", "mui/util",
		"dojo/dom-class", "mui/dialog/Tip","mui/i18n/i18n!km-supervise:mobile"
		], function(declare, lang,req, util, domClass, Tip,Msg) {

			return declare("km.supervise.mixin._BackTabBarButtonNewMixin", null, {
				
				backUrl : '/km/supervise/km_supervise_back/kmSuperviseBack.do?method=add&fdIsNew=true',
				
				onClick : function(evt) {
					this.backUrl = util.setUrlParameter(this.backUrl, "fdMainId", this.fdId);
					this.backUrl = util.setUrlParameter(this.backUrl, "fdType", this.fdType);
					if(this.fdTaskId){
						this.backUrl = util.setUrlParameter(this.backUrl, "fdTaskId", this.fdTaskId);
					}
					location.href = util.formatUrl(this.backUrl);
				}
		});
});