define(["dojo/_base/lang", 
         "dojo/_base/array",
         "dojo/topic",
         "dijit/registry", 
         "dojo/ready", 
         "mui/util",
         "mui/form/Address",
         'dojo/query',
         'dojo/NodeList-dom', 
         'dojo/NodeList-html', 
         "dojo/domReady!"], function(lang, array, topic, registry, ready, util, Address, query) {

	var freeflow={};
	
	freeflow.init=function(){
		var fdIsModify=$("input[name='sysWfBusinessForm.fdIsModify']")[0];
		if(fdIsModify==null || fdIsModify.value!="1"){
			var processXml = lbpm.globals.getProcessXmlString();
			document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0].value = processXml;
		}
		setTimeout(function(){
			lbpm.flow_chart_load_Frame();
			// 记录新添加的节点
			lbpm.myAddedNodes=new Array();
			
			var html = '<div data-dojo-type="sys/lbpmservice/mobile/freeflow/freeflowNodes" data-dojo-props="validate:\'freeflowNodes\'"></div>';
			
			var detailArea = query("#freeFlowNodeDIV");
			detailArea.html(html, {parseContent: true});
		},0);
	};
	
	return freeflow;
});