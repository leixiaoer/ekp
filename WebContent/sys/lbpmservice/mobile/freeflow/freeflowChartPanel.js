define(
		["dojo/_base/declare","dijit/_WidgetBase","dojo/query","dojo/dom-construct","dojo/dom-style","dojo/_base/lang","dojo/topic",
		"mui/dialog/Dialog","mui/i18n/i18n!sys-lbpmservice","dojo/parser",'dojo/dom-attr',"sys/lbpmservice/mobile/freeflow/freeflowNodeAttribute","dojo/_base/window","dojox/mobile/sniff"],
		function(declare,WidgetBase,query,domConstruct,domStyle,lang,topic,Dialog,Msg,parser,domAttr,freeflowNodeAttribute,win,has) {
			var freeflowChartPanel = declare("sys.lbpmservice.mobile.freeflow.freeflowChartPanel",
					[WidgetBase], {
						template : false,
				
						optTmpl : '<div id="freeflowNodeTypeSelect" data-dojo-type="mui/form/RadioGroup" data-dojo-props="showStatus:\'edit\',name:\'_lbpm_address_button_radio\',mul:\'false\',store:{store},orient:\'vertical\'" style="padding-right:0;"></div>',
						
						nodeTmpl : "<div data-dojo-type=\"sys/lbpmservice/mobile/freeflow/freeflowNode\" data-dojo-props=\"nodeId:'!{nodeId}',template:!{template}\"></div>",
						
						addAreaTmpl : "<div data-dojo-type=\"sys/lbpmservice/mobile/freeflow/freeflowSplitArea\" data-dojo-props=\"nodeId:'!{nodeId}',template:!{template}\" class=\"free_flow_addArea\"></div>",
						
						buildRendering : function() {
							this.inherited(arguments);
							this.cateFieldShow = domConstruct.create("div" ,{className:'free_flow_show'},this.domNode);
							if(this.template){
								this.defer(function(){
									lbpm.flow_chart_load_Frame();
								},0);
							}
							//初始化流程图
							this._init();
						},
						
						_init:function(){
							var self = this;
							var FlowChartObject = this.getFlowChartObject();
							if(FlowChartObject && FlowChartObject.Nodes && FlowChartObject.Nodes.GetNodeById && FlowChartObject.Nodes.GetNodeById("N2")){
								self.updateFreeFlowNodes(self.cateFieldShow,FlowChartObject);
							}else{
								this.defer(function(){
									this._init();
								},100);
							}
						},
						
						postCreate : function() {
							this.inherited(arguments);
							this.subscribe("/sys/lbpmservice/freeflow/addNode","_addNode");
							this.subscribe("/sys/lbpmservice/freeflow/___addNode","___addNode");
							this.subscribe("/sys/lbpmservice/freeflow/deleteNode","_deleteNode");
							this.subscribe("/sys/lbpmservice/freeflow/moveNode","_moveNode");
							this.subscribe("/sys/lbpmservice/freeflow/updateNode","_updateNode");
						},
						
						//修改节点
						_updateNode : function(srcObj){
							var FlowChartObject = this.getFlowChartObject();
							this.updateFlowXml(FlowChartObject);
						},
						
						//添加节点
						_addNode : function(srcObj){
							this._selectNodeType(srcObj);
						},
						
						//添加节点
						___addNode : function(srcObj,evt){
							if(evt && evt.newNode){
								var self = this;
								var newItem = this.buildNodeInfo(this.cateFieldShow, evt.newNode);
								parser.parse(newItem).then(function () {
				                    win.doc.dojoClick = !has("ios") || has("ios") > 13;
				                });
								this.defer(function(){
									topic.publish("/sys/lbpmservice/freeflow/moveNodeEnd",self);
								},100);
							}
						},
						
						//删除节点
						_deleteNode : function(srcObj){
							this.deleteFreeFlowNode(srcObj.nodeId);
						},
						
						//移动节点
						_moveNode : function(srcObj){
							var FlowChartObject = this.getFlowChartObject();
							//更新前节点连线信息（开始节点为key，连线及结束节点的对象）
							var oldInfo = {};
							for(var i=0; i<FlowChartObject.Lines.all.length; i++){
								var line = FlowChartObject.Lines.all[i].Data;
								if(!oldInfo[line.startNodeId]){
									oldInfo[line.startNodeId]={};
								}
								oldInfo[line.startNodeId]["lineId"] = line.id;
								oldInfo[line.startNodeId]["endNodeId"] = line.endNodeId;
							}
							//当前按顺序排列的节点
							var newInfo = [];
							newInfo.push("N1");
							query(".free_flow_show").children("div.free_flow_item").forEach(function(node){
								newInfo.push(domAttr.get(node,"data-node-id"));
							});
							newInfo.push("N3");
							//按新顺序，若当前节点和下一节点与旧信息中不一致，则认为发生改变，获得旧信息中的连线重新连接当前节点及下一节点
							for(var i=0;i<newInfo.length-1;i++){
								var beginNode = FlowChartObject.Nodes.GetNodeById(newInfo[i]);
								var endNode = FlowChartObject.Nodes.GetNodeById(newInfo[i+1]);
								if(oldInfo[newInfo[i]] && oldInfo[newInfo[i]]["endNodeId"] && oldInfo[newInfo[i]]["endNodeId"]!=newInfo[i+1]){
									var line = FlowChartObject.Lines.GetLineById(oldInfo[newInfo[i]]["lineId"]);
									if(line){
										line.LinkNode(beginNode, endNode, '3', '1');
										line.Refresh(FlowChartObject.LINE_REFRESH_TYPE_DOM);
									}
								}
								//刷新结束节点坐标为开始节点想x,y+80
								endNode.MoveTo(beginNode.Data.x, beginNode.DOMElement.trans.y + 20*4);
							}
							//更新流程图
							this.updateFlowXml(FlowChartObject);
							topic.publish("/sys/lbpmservice/freeflow/moveNodeEnd",this);
						},
						
						// 选择节点类型
						_selectNodeType : function(srcObj){
							var self = this;
							if (this.nodeTypeDialog != null){
								return;
							}
							var store = [ {
								text : Msg["mui.freeFlow.lbpm.nodeType.reviewNode"],
								value : "reviewNode"
							}, {
								text : Msg["mui.freeFlow.lbpm.nodeType.signNode"],
								value : "signNode"
							}, {
								text : Msg["mui.freeFlow.lbpm.nodeType.sendNode"],
								value : "sendNode"
							}];
							this.dialogNode = domConstruct.toDom(lang.replace(this.optTmpl,{store: JSON.stringify(store).replace(/\"/g,"\'") }));
							this.nodeTypeDialog = Dialog.element({
								canClose : false,
								showClass : 'muiDialogElementShow muiFormSelect free_flow_selectNodeType',
								element : this.dialogNode,
								position:'bottom',
								'scrollable' : false,
								'parseable' : true,
								onDrawed:function(){
									self.defer(function(){
										self._nodeTypeClick(srcObj);
									},100);
								},
								callback : lang.hitch(this, function() {
									this.nodeTypeDialog = null;
								})
							});
							var splitDom = domConstruct.toDom("<div class='muiDialogElementButton_bottom_split'></div>");
							domConstruct.place(splitDom, query("#freeflowNodeTypeSelect",this.nodeTypeDialog.contentNode)[0],'after');
							var title = domConstruct.toDom("<div class='muiDialogElementButton_bottom'>"+Msg["mui.freeFlow.cancel"]+"</div>");
							domConstruct.place(title, splitDom,'after');
							query(title).on("touchend",function(evt){
								self.nodeTypeDialog.hide();
								self.nodeTypeDialog = null;
							});
						},
						
						//节点类型点击事件
						_nodeTypeClick : function(srcObj){
							var self = this;
							query(".muiRadioItem",this.dialogNode).on("touchend",function(evt){
								var nowTime = new Date().getTime();
							    var clickTime = this.ctime;
							    if(clickTime != 'undefined' && (nowTime - clickTime < 500)){
							       return false;
							    }
							    this.ctime = nowTime;
								var dom = evt.target;
								var nodeSelectType = query("input",dom).val();
								if(!nodeSelectType){
									var labelDom = query(dom).closest(".muiRadioItem")[0];
									nodeSelectType = query("input",labelDom).val();
								}
								// 弹出属性设置
								self.defer(function(){
									var newNode= this.addNodeInFreeFlow("","",nodeSelectType,srcObj.nodeId);
									if(this.freeflowNodeAttributeDialog==null){
										this.freeflowNodeAttributeDialog = new freeflowNodeAttribute();
									}
									this.freeflowNodeAttributeDialog._selectCate({nodeId:newNode.Data["id"],state:"add",template:this.template});
									var newItem = this.buildNodeInfo(null, newNode, query(srcObj.domNode).closest(".free_flow_item"));
									parser.parse(newItem).then(function () {
					                    win.doc.dojoClick = !has("ios") || has("ios") > 13;
					                });;
									self.defer(function(){
										topic.publish("/sys/lbpmservice/freeflow/moveNodeEnd",self);
									},100);
								},350);
								// 关闭弹出窗口
								self.nodeTypeDialog.hide();
								self.nodeTypeDialog = null;
							});
						},
						
						// 构建起草节点
						buildDraftorNode : function (domContainer) {
							var itemDom = domConstruct.create("div", {
								className : 'free_flow_item',
								'data-node-id' : "N2"
							}, domContainer);
							var tmpOrgDom = domConstruct.create("div",{
								className:"free_flow_node"
							},itemDom);
							domConstruct.create("div", {
								className : 'free_flow_left'
							}, tmpOrgDom);
							var centerDom = domConstruct.create("div", {
								className : 'free_flow_center'
							}, tmpOrgDom);
							var spanCenterDom = domConstruct.create("span", {
								className : 'free_flow_center_icon'
							}, centerDom);
							domConstruct.create("i", {
								className : 'fontmuis muis-org-draft'
							}, spanCenterDom);
							domConstruct.create("span", {
								className : 'free_flow_sortName',
								innerHTML : Msg["mui.freeFlow.draftorNode"]
							}, centerDom);
							var rightDom = domConstruct.create("div", {
								className : 'free_flow_right'
							}, tmpOrgDom);
							domConstruct.create("span", {
								className : 'free_flow_drafterTip',
								innerHTML : Msg["mui.freeFlow.draftorNode.default"]
							}, rightDom);
							this.buildAddArea(itemDom,"N2");
						},
						
						//构建节点信息
						buildNodeInfo : function(domContainer, node, afterNode){
							var itemDom = domConstruct.create("div", {
								className : 'free_flow_item',
								'data-node-id' : node.Data["id"]
							});
							if(domContainer){
								domConstruct.place(itemDom, domContainer, "last");
							}else if(afterNode){
								query(itemDom).insertAfter(query(afterNode));
							}
							var tmpl = this.nodeTmpl.replace("!{nodeId}", node.Data["id"]).replace("!{template}", this.template);
							var nodeDom = domConstruct.toDom(tmpl);
					        domConstruct.place(nodeDom, itemDom, "last");
					        this.buildAddArea(itemDom,node.Data["id"]);
					        return itemDom;
						},

						//构建按钮及分割符区域
						buildAddArea : function(domContainer,nodeId){
							var tmpl = this.addAreaTmpl.replace("!{nodeId}", nodeId).replace("!{template}", this.template);
							var addAreaDom = domConstruct.toDom(tmpl);
					        domConstruct.place(addAreaDom, domContainer, "last");
						},
						
						//添加流程节点
						addNodeInFreeFlow : function(handlerIds,handlerNames,nodeType,beginId) {
							var FlowChartObject = this.getFlowChartObject();
							if (FlowChartObject) {
								var newNodeObj,beginNode;
								if (beginId) {
									beginNode = FlowChartObject.Nodes.GetNodeById(beginId);
								} else {
									beginNode = FlowChartObject.Nodes.GetNodeById("N3").LineIn[0].StartNode;
								}
								if (lbpm.freeFlow.defOperRefIds.length == 0 || !lbpm.freeFlow.defFlowPopedom) {
									var data = new KMSSData();
									data.AddBeanData("getOperTypesByNodeService&nodeType=freeFlowReviewNode");
									data = data.GetHashMapArray();
									for(var i=0,len=data.length;i<len;i++){
										if(data[i].isDefault=="true"){
											lbpm.freeFlow.defOperRefIds["reviewNode"] = data[i].value;
											break;
										}
									}
									data = new KMSSData().AddBeanData("getOperTypesByNodeService&nodeType=freeFlowSignNode");
									data = data.GetHashMapArray();
									for(var i=0,len=data.length;i<len;i++){
										if(data[i].isDefault=="true"){
											lbpm.freeFlow.defOperRefIds["signNode"] = data[i].value;
											break;
										}
									}
									lbpm.freeFlow.defFlowPopedom = Lbpm_SettingInfo["defaultFlowPopedom"];
								}
								if(!this.notifyDfaultValue){
									var data = new KMSSData();
									data.AddBeanData("getNotifyTypeService");
									data = data.GetHashMapArray();
									this.notifyDfaultValue = data[0]["defaultValue"];
								}
								nodeType = nodeType||"reviewNode";
								newNodeObj = FlowChartObject.Nodes.createNodeInFreeFlow(beginNode,nodeType,true);
								FlowChartObject.Nodes.initNodeDataInFreeFlow(newNodeObj);
								if(handlerIds){
									newNodeObj.Data["handlerIds"]=handlerIds;
								}
								if(handlerNames){
									newNodeObj.Data["handlerNames"]=handlerNames;
								}
								newNodeObj.Data["notifyType"]=this.notifyDfaultValue;
								if (newNodeObj.Data["processType"]) {
									newNodeObj.Data["operations"]["refId"]=lbpm.freeFlow.defOperRefIds[nodeType];
									newNodeObj.Data["flowPopedom"]=lbpm.freeFlow.defFlowPopedom;
								}
								newNodeObj.Data["canAddAuditNoteAtt"]=Lbpm_SettingInfo["isCanAddAuditNoteAtt"];
								newNodeObj.Data["canModifyMainDoc"]=Lbpm_SettingInfo["isEditMainDocument"];
								lbpm.myAddedNodes.push(newNodeObj.Data.id);
								beginNode = newNodeObj;
								this.updateFlowXml(FlowChartObject);
								return newNodeObj;
							}
						},
						
						//开始构建流程图信息
						updateFreeFlowNodes : function(domContainer,FlowChartObject) {
							domConstruct.empty(domContainer);
							this.buildDraftorNode(domContainer);
							this.appendFreeFlowNode(domContainer,FlowChartObject);
							parser.parse(domContainer).then(function () {
			                    win.doc.dojoClick = !has("ios") || has("ios") > 13;
			                });;
						},
						
						//循环添加节点
						appendFreeFlowNode : function(domContainer,FlowChartObject,nodeObj){
							if(!nodeObj){
								nodeObj = FlowChartObject.Nodes.GetNodeById("N2");
							}
							var node = nodeObj.LineOut[0].EndNode;
							if (node.Data["id"] == "N3") {
								return;
							}
							this.buildNodeInfo(domContainer, node);
							this.appendFreeFlowNode(domContainer,FlowChartObject, node);
						},
						
						//删除节点
						deleteFreeFlowNode : function (id){
							if(!this.template){
								var node = lbpm.nodes[id];
								if (!node) {
									return;
								}
							}
							this.delNodeInFreeFlow(id);
						},
						
						//删除节点
						delNodeInFreeFlow : function(nodeId) {
							var FlowChartObject = this.getFlowChartObject();
							var delNodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
							FlowChartObject.Nodes.deleteNodeInFreeFlow(delNodeObj,true);
							this.updateFlowXml(FlowChartObject);
						},
						
						//获得流程图对象
						getFlowChartObject : function(){
							var iframe = document.getElementById('WF_IFrame');
							return iframe.contentWindow.FlowChartObject;
						},
						
						//更新流程图
						updateFlowXml : function(FlowChartObject) {
							var flowXml = FlowChartObject.BuildFlowXML();
							if (!flowXml || this.template){
								return;
							}
							var processXMLObj = document.getElementsByName("sysWfBusinessForm.fdFlowContent")[0];
							processXMLObj.value = flowXml;
							lbpm.globals.parseXMLObj();
							lbpm.modifys = {};
							$("input[name='sysWfBusinessForm.fdIsModify']")[0].value = "1";
							lbpm.events.mainFrameSynch();
						}
					});
			return freeflowChartPanel;
		});