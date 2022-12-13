define([ "dojo/_base/declare", "dojo/dom-construct", "dojo/query", "mui/form/_FormBase", "dojo/dom-class"], 
		function(declare, domConstruct, query, _FormBase, domClass) {
	var claz = declare("sys.xform.mobile.controls.AuditShow", [ _FormBase], {
		
		buildRendering :function(){
			this.auditShow = query(".muiFormEleAuditShowWrap",this.domNode);
			this.inherited(arguments);
			if (this.newMui) {
				domConstruct.place(this.tipNode,this.domNode,'first');
			}
			domConstruct.destroy(this.rightIcon);
		},
		
		startup: function () {
			this.inherited(arguments);
			domClass.remove(this.domNode, "muiFormRight");
		}
		
	});
	return claz;
});