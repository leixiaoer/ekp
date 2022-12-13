define(
		[ "dojo/_base/declare", "mui/form/Category", "mui/address/AddressMixin",
			"dijit/registry","dojo/query","dojo/dom-construct","dojo/dom-style","dojo/dom-class", "dojo/on", "mui/util", "dojo/dom-attr","dojo/_base/lang", "dojo/_base/array", "dojo/topic", "mui/dialog/Dialog","mui/dialog/Tip", "mui/i18n/i18n!sys-mobile","mui/i18n/i18n!sys-lbpmservice"],
		function(declare, Category, AddressMixin,registry,query, domConstruct, domStyle ,domClass, on, util,domAttr, lang, array, topic, Dialog, Tip, msg, Msg) {
			var freeflowNodes = declare("sys.lbpmservice.mobile.freeflow.freeflowNodes",
					[ Category, AddressMixin ], {
						
						subject : '选人添加节点',
						
						isMul : true,
						
						type : ORG_TYPE_POSTORPERSON,
						
						idField : "_freeflowNodes_",
						
						id : "freeflowNodes",
						
						//是否显示头像
						showHeadImg : true,
						
						_cateDialogPrefix: "__freeflowNodes__",
						
						//新地址本
						isNew : true,
						
						//部门限制
						deptLimit : '',
						
						//例外类别id
						exceptValue:'',
						
						maxPageSize:300,
						
						dataUrl : '/sys/organization/mobile/address.do?method=addressList&parentId=!{parentId}&orgType=!{selType}&deptLimit=!{deptLimit}&maxPageSize=!{maxPageSize}',
						
						iconUrl : '/sys/lbpmservice/mobile/freeflow/image.jsp?orgId=!{orgId}',
						
						searchUrl:"/sys/organization/mobile/address.do?method=searchList&keyword=!{keyword}&orgType=!{orgType}&deptLimit=!{deptLimit}",
						
						buildRendering : function() {
							this.inherited(arguments);
							domClass.add(this.domNode,'muiAddressForm')
							if(this.showHeadImg){
								domClass.add(this.domNode,'freeFlowShowHeadImg');
							}
						},
						
						postCreate : function() {
							this.inherited(arguments);
							this.subscribe("mui/form/select/callback", lang.hitch(this,function(evt) {
								// 起草人切换提交身份时对应的起草人图标和起草人名称要跟随变化
								if (evt.id == "rolesSelectObj" && evt.key == "handlerId") {
									this.curDraftorId = evt.value;
									this.curDraftorName = evt.text;
									var nodes = query(this.draftOrgDom).closest(".freeFlowOrg");
									nodes.forEach(function(orgDom) {
										var id = orgDom.getAttribute("data-id");
										if (id == "N2"){
											var orgIconDom = query(orgDom).children(".freeFlowOrgIcon")[0];
											var icon = util.formatUrl(util.urlResolver(this.iconUrl , {
												orgId : this.curDraftorId
											}));
											domStyle.set(orgIconDom, 'background', 'url('+icon+') center center / cover no-repeat');
											var nameDom = query(orgDom).children(".name")[0];
											nameDom.innerText = this.curDraftorName;
										}
									}, this);
								}
							}));
							/*this.subscribe("mui/view/currentView",lang.hitch(this,function(view) {
								// 从freeflowChartView离开时刷新当前的freeflowNodes
								if (view.movedFrom == "freeflowChartView") {
									this.buildValue(this.contentNode);
								}
							}));*/
							this.subscribe("/sys/lbpmservice/freeflow/viewTransitionOut",lang.hitch(this,function(view) {
								// 从freeflowChartView离开时刷新当前的freeflowNodes
								if (view.id == "freeflowChartView") {
									this.buildValue(this.contentNode);
								}
							}));
						},
						
						startup:function(){
							this.inherited(arguments);
						},
						
						domNodeClick : function(){
							if(query(".nodeAddIcon").indexOf(arguments[0].target) >= 0){
								return;//中间添加按钮事件不走这边
							}
							this.currentStartNodeId = null;
							if(this.showHeadImg){
								var evtNode = query(arguments[0].target).closest(".muiCategoryAdd");
								if(evtNode.length <= 0){
									return;
								}
							}
							var evtNode = query(arguments[0].target).closest(".freeFlowOrg");
							if(evtNode.length > 0){
								return;
							}
							this.defer(function(){
								this._selectCate();
							},350);
						},
						
						buildValue : function(domContainer){
							domConstruct.empty(domContainer);
							domClass.replace(domContainer,"freeFlowFiledShow",domContainer.className);
							if(this.curIds!=null && this.curIds!=''){
								var ids = this.curIds.split(this.splitStr);
								var names = this.curNames.split(this.splitStr);
								if (ids.length > 0){
									this.addNodeInFreeFlow();
								}
							}

							this.updateFreeFlowNodes(domContainer);
							
							// 具有可编辑权限时才出现添加节点按钮图标
							if(lbpm.nowNodeFlowPopedom == "1" || lbpm.nowNodeFlowPopedom == "2"){
								var className = 'muiCategoryAdd mui mui-plus';
								this.muiCategoryAddNode = domConstruct.create("div",{className: className },domContainer);
								domStyle.set(this.muiCategoryAddNode,'display','inline-block');
								domStyle.set(this.muiCategoryAddNode,'margin-left','0.3rem');
							}
							// 切断父类设置的事件绑定
							this.disconnect(this.orgIconClickHandle);
							// 重新绑定
							this.connect(this.cateFieldShow, on.selector(".freeFlowOrgIcon", "click"), function(evt) {
								if (evt.stopPropagation)
									evt.stopPropagation();
								if (evt.cancelBubble)
									evt.cancelBubble = true;
								if (evt.preventDefault)
									evt.preventDefault();
								if (evt.returnValue)
									evt.returnValue = false;
								var nodes = query(evt.target).closest(".freeFlowOrg");
								nodes.forEach(function(orgDom) {
									var id = orgDom.getAttribute("data-id");
									var node = lbpm.nodes[id];
									if (id == "N2" || !node.handlerIds || node.handlerIds.split(";").length <= 1) {
										return;
									}
									// 当前操作的节点对象
									this.operatingNode = node;
									// 当前操作节点的Dom对象
									this.operatingNodeDom = orgDom;
									var store = array.map(node.handlerIds.split(";"), function(handlerId, i) {
										return {
											text : util.formatText(node.handlerNames.split(";")[i]) , 
											value : handlerId
										};
									});
									var canEdit = false;
									if (node.Status == "1" && node.isFixedNode != 'true') {
										if (lbpm.nowNodeFlowPopedom=="2") {
											canEdit = true;
										} else if (lbpm.nowNodeFlowPopedom=="1") {
											if (lbpm.myAddedNodes.contains(node.id)) {
												canEdit = true;
											}
										}
									}
									var itemHtmls = array.map(store, function(item) {
										var temp = '<div data-dojo-type="sys/lbpmservice/mobile/freeflow/NodeHandlersListItem" class="_nodeHandlerListItem" name="_listItem_nodeHandlers" value="!{value}"'
											+' data-dojo-props="mul:false,text:\'!{text}\',nodeId:\''+node.id+'\',canEdit:'+canEdit+'"></div>';
										return temp.replace(
												'!{text}', item.text).replace(
												'!{value}', item.value);
									});
									var html =  "<div class='muiFormSelectElement'>" + itemHtmls.join("") + "</div>";
									
									// 针对多个审批人的节点弹出对应的节点处理人列表
									this.defer(function() {
										if (this.dialog != null){
											return;
										}
										
										var buttons = [];
										if (canEdit) {
											buttons = [ {
												title : msg['mui.button.cancel'],
												fn : function(dialog) {
													dialog.hide();
												}
											},{
												title : msg['mui.button.ok'],
												fn : lang.hitch(this, this._modifyNodeHandlers)
												
											}];
										} else {
											buttons = [{title:"",fn:null},{title:"",fn:null}];
										}
										this.dialog = Dialog.element({
											showClass : 'muiDialogElementShow muiFormSelect',
											element : html,
											position : 'bottom',
											scrollable : false,
											parseable : true,
											buttons : buttons,
											onDrawed:function(){
												// 调整样式使删除item后弹出框的高度能自动跟随变化
												domStyle.set(this.containerNode,'min-height','7%');
												domStyle.set(this.contentNode,'height','auto');
											},
											callback : lang.hitch(this, function() {
												this.dialog = null;
											})
										});
										// 设置节点处理人列表顶部的标题
										var nameDom = query(orgDom).children(".name")[0];
										var title = domConstruct.toDom("<div class='muiDialogElementButton_bottom' style='width:100%'>"+nameDom.innerText+"</div>");
										domConstruct.place(title, this.dialog.buttonsDom[0],'after');
										if (canEdit) {
											domStyle.set(this.dialog.buttonsDom[0],'width','15%');
											domStyle.set(this.dialog.buttonsDom[1],'width','15%');
											domStyle.set(title,'width','70%');
											domStyle.set(title,'float','left');
											domStyle.set(title,'color'," #2A304A");
											domStyle.set(title,'font-size',"1.5rem");
										}
									}, 300);
								}, this);
							});
						},
						
						_buildOneOrg : function(domContainer, node){
							var isMulHandlers = false;
							if (node.handlerNames) {
								if (node.handlerNames.split(";").length > 1) {
									isMulHandlers = true;
								}
							}
							
							if (isMulHandlers) {
								var icon = util.formatUrl(util.urlResolver(this.iconUrl , {
									orgId : ""
								}));
								this.buildOrgNode(domContainer, node, icon);
							} else {
								var icon = util.formatUrl(util.urlResolver(this.iconUrl , {
									orgId : node.handlerSelectType=="org" ? node.handlerIds : ""
								}));
								this.buildOrgNode(domContainer, node, icon);
							}
						},
						
						buildOrgNode : function(domContainer, node, icon){
							// 构建节点图标(头像)
							var tmpOrgDom = this.buildNodeIcon(domContainer, node, icon);
							// 构建节点类型图标
							this.buildNodeTypeIcon(tmpOrgDom, node);
							// 构建删除按钮图标
							this.buildDeleteIcon(tmpOrgDom, node);
							// 构建箭头
							this.buildArrowIcon(tmpOrgDom, node);
						},
						
						// 构建起草节点
						buildDraftorNode : function (domContainer) {
							var draftorId = $("[name='sysWfBusinessForm.fdDraftorId']")[0].value;
							if (this.curDraftorId) {
								draftorId = this.curDraftorId;
							}
							var draftorName = $("[name='sysWfBusinessForm.fdDraftorName']")[0].value;
							if (this.curDraftorName) {
								draftorName = this.curDraftorName;
							}
							var icon = util.formatUrl(util.urlResolver(this.iconUrl , {
								orgId : draftorId
							}));
							var tmpOrgDom = domConstruct.create("div",{className:"freeFlowOrg", "data-id":"N2"},domContainer);
							domConstruct.create("div", {
								style:{
									background:'url(' + icon +') center center no-repeat',
									backgroundSize:'cover',
									display:'inline-block'
								},
								className : 'freeFlowOrgIcon'
							}, tmpOrgDom);
							domConstruct.create('div',{
								className:'name',
								innerHTML: draftorName 
							},tmpOrgDom);
							//添加节点类型图标
							var iconUrl = util.formatUrl('/sys/lbpmservice/mobile/resource/image/draftNode.png');
							domConstruct.create("div", {
								style:{
									background:'url('+iconUrl+') center center no-repeat',
									backgroundSize:'cover',
									display:'block'
								},
								className : "nodeTypeIcon"
							}, tmpOrgDom);
							if (lbpm.nowNodeId == "N2") {
								this.isPassedRoute = false;
							}
							this.buildArrowIcon(tmpOrgDom, lbpm.nodes["N2"]);
							this.draftOrgDom = tmpOrgDom;
						},
						
						_delOneOrg : function(orgDom, id){
							this.inherited(arguments);
							this.deleteFreeFlowNode(id);
							topic.publish("/sys/lbpmservice/freeflow/___deleteNode",this,{nodeId:id});
						},
						
						//构建节点图标（头像）
						buildNodeIcon : function(domContainer, node, icon){
							var tmpOrgDom = domConstruct.create("div",{className:"freeFlowOrg", "data-id":node.id},domContainer);
							domConstruct.create("div", {
								style:{
									background:'url(' + icon +') center center no-repeat',
									backgroundSize:'cover',
									display:'inline-block'
								},
								className : 'freeFlowOrgIcon'
							}, tmpOrgDom);
							var nodeTitle = this._getNodeTitle(node);
							
							domConstruct.create('div',{
								className:'name',
								innerHTML: nodeTitle 
							},tmpOrgDom);
							return tmpOrgDom;
						},
						
						//构建节点类型图标
						buildNodeTypeIcon : function(domContainer, node){
							var iconUrl = util.formatUrl('/sys/lbpmservice/mobile/resource/image/'+node.XMLNODENAME+'.png');
							domConstruct.create("div", {
								style:{
									background:'url(' + iconUrl + ') center center no-repeat',
									backgroundSize:'cover',
									display:'block'
								},
								className : "nodeTypeIcon"
							}, domContainer);
						},
						
						//构建删除图标
						buildDeleteIcon : function(domContainer, node){
							var canDelete = false;
							if (node.Status == "1" && node.isFixedNode != 'true') {
								if (lbpm.nowNodeFlowPopedom=="2") {
									canDelete = true;
								} else if (lbpm.nowNodeFlowPopedom=="1") {
									if (lbpm.myAddedNodes.contains(node.id)) {
										canDelete = true;
									}
								}
							}
							//添加删除按钮
							if(canDelete){
								var delOrgDom = domConstruct.create('div',{ className : 'del mui mui-close' },domContainer);
								this.connect(delOrgDom,'touchend',function(evt) {
									if (evt.stopPropagation)
										evt.stopPropagation();
									if (evt.cancelBubble)
										evt.cancelBubble = true;
									if (evt.preventDefault)
										evt.preventDefault();
									if (evt.returnValue)
										evt.returnValue = false;
									var nodes = query(evt.target).closest(".freeFlowOrg");
									nodes.forEach(function(orgDom) {
										var id = orgDom.getAttribute("data-id");
										this.defer(function() { // 同时关注时，必须要异步处理
											this._delOneOrg(orgDom, id);
										}, 300);
									}, this);
								});
							}
						},
						
						// 构建箭头图标
						buildArrowIcon : function(domContainer, node) {
							var nextNodeId = node.endLines[0].endNode.id;
							if (nextNodeId == "N3") {
								if(!(lbpm.nowNodeFlowPopedom == "1" || lbpm.nowNodeFlowPopedom == "2")){
									return;
								}
							}
							var arrowUrl = util.formatUrl('/sys/lbpmservice/mobile/resource/image/arrowGoto.png');
							
							if (this.isPassedRoute){
								arrowUrl = util.formatUrl('/sys/lbpmservice/mobile/resource/image/arrowGone.png');
							}
							
							/*domConstruct.create("div", {
								style:{
									background:'url(' + arrowUrl +') center center no-repeat',
									backgroundSize:'cover',
									display:'block'
								},
								className : 'arrowGoIcon'
							}, domContainer);*/
							this.lastLineIcon = domConstruct.create("div", {
								style:{
									display:'block'
								},
								className : 'nodeAddLine'
							}, domContainer);
							if(lbpm.nowNodeFlowPopedom == "1" || lbpm.nowNodeFlowPopedom == "2"){
								var className = 'nodeAddIcon mui mui-plus';
								this.lastNodeAddIcon = domConstruct.create("div",{style:{
									display:'block'
								},className: className },domContainer);
								this.connect(this.lastNodeAddIcon,'click',lang.hitch(this,function(evt){
									var freeFlowOrgElem = query(evt.target).closest(".freeFlowOrg")[0];
									this.currentStartNodeId = domAttr.get(freeFlowOrgElem,"data-id");
									this.defer(function(){
										this._selectCate();
									},350);
								}))
								if(nextNodeId == 'N3'){
									domStyle.set(this.lastNodeAddIcon,{
										"display":"none"
									})
									domStyle.set(this.lastLineIcon,{
										"display":"none"
									})
								}
							}
							if (nextNodeId == lbpm.nowNodeId) {
								this.isPassedRoute = false;
								//设置当前页面的添加按钮为none
								query(".nodeAddIcon",query(".freeFlowFiledShow")[0]).style({
									"display":'none'
								})
							}
						},
						
						buildOptIcon:function(optContainer){
							if(!this.showHeadImg)
								this.inherited(arguments);
							this.muiCategoryAddNode = optContainer;
						},
						
						// 构建节点标题（底部的名称）
						_getNodeTitle : function (node) {
							var handlerName = node.handlerNames;
							var dataNextNodeHandler;
							var nextNodeHandlerNames4View="";
							if(node.handlerSelectType=="formula"){
								dataNextNodeHandler = lbpm.globals.formulaNextNodeHandler(node.handlerIds,true,false);
							}else if (node.handlerSelectType=="matrix") {
								dataNextNodeHandler = lbpm.globals.matrixNextNodeHandler(node.handlerIds,true,false);
							}else if (node.handlerSelectType=="rule") {
								dataNextNodeHandler = lbpm.globals.ruleNextNodeHandler(node.id,node.handlerIds,true,false);
							} else {
								dataNextNodeHandler = lbpm.globals.parseNextNodeHandler(node.handlerIds,true,false);
							}
							for(var j=0;j<dataNextNodeHandler.length;j++){
								if(nextNodeHandlerNames4View==""){
									nextNodeHandlerNames4View=dataNextNodeHandler[j].name;
								}else{
									nextNodeHandlerNames4View+=";"+dataNextNodeHandler[j].name;
								}
							}
							if(nextNodeHandlerNames4View == "" && node.handlerIds != null) {
								nextNodeHandlerNames4View = lbpm.constant.COMMONNODEHANDLERORGNULL;
							}
							if(nextNodeHandlerNames4View){
								handlerName = nextNodeHandlerNames4View;
							}
							var handlerSize = handlerName.split(";").length;
							var nodeTitle = handlerName;
							if (handlerSize > 1) {
								if (node.XMLNODENAME == "reviewNode") {
									if (node.processType == '0') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.reviewNode.processType_0.nodeTitle'],[handlerSize]);
									} else if (node.processType == '1') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.reviewNode.processType_1.nodeTitle'],[handlerSize]);
									} else if (node.processType == '2') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.reviewNode.processType_2.nodeTitle'],[handlerSize]);
									} 
								} else if (node.XMLNODENAME == "signNode") {
									if (node.processType == '0') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.signNode.processType_0.nodeTitle'],[handlerSize]);
									} else if (node.processType == '1') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.signNode.processType_1.nodeTitle'],[handlerSize]);
									} else if (node.processType == '2') {
										nodeTitle = lang.replace(Msg['mui.freeFlow.signNode.processType_2.nodeTitle'],[handlerSize]);
									} 
								} else if (node.XMLNODENAME == "sendNode") {
									nodeTitle = Msg['mui.freeFlow.sendNode.nodeTitle'];
								}
							}
							return nodeTitle;
						},
						
						_modifyNodeHandlers : function(dialog) {
							var _handlerIds = '';
							var _handlerNames = '';
							var isChange = false;
							array.forEach(dialog.htmlWdgts,function(wdt){
								if (wdt && wdt.name == '_listItem_nodeHandlers') {
									if (wdt._destroyed) {
										isChange = true;
									} else {
										_handlerIds += ';' + wdt.value;
										_handlerNames += ';' + wdt.text;
									}
								}
							});
							if (!isChange) {
								dialog.hide();
								return;
							}
							_handlerIds = _handlerIds.slice(1);
							_handlerNames = _handlerNames.slice(1);
							
							this.modifyNodeHandlersInFreeFlow(this.operatingNode.id, _handlerIds, _handlerNames);
							
							var orgIconDom = query(this.operatingNodeDom).children(".freeFlowOrgIcon")[0];
							if (_handlerIds.split(';').length == 1) {
								var icon = util.formatUrl(util.urlResolver(this.iconUrl , {
									orgId : _handlerIds
								}));
								domStyle.set(orgIconDom, 'background', 'url('+icon+') center center / cover no-repeat');
							}
							
							var nameDom = query(this.operatingNodeDom).children(".name")[0];
							nameDom.innerText = this._getNodeTitle(lbpm.nodes[this.operatingNode.id]);
							dialog.hide();
						},
						
						returnDialog:function(srcObj , evt){
							if(srcObj.key == this.idField){
								this.inherited(arguments);
								this.curIds = "";
								this.curNames = "";
							}
						},
						
						
						// 以下是自由流流程图相关操作js
						
						addNodeInFreeFlow : function() {
							var FlowChartObject = this.getFlowChartObject();
							if (FlowChartObject) {
								var endNodeObj = FlowChartObject.Nodes.GetNodeById("N3");
								var newNodeObj,beginNode;
								beginNode = endNodeObj.LineIn[0].StartNode;
								if(this.currentStartNodeId){
									beginNode = FlowChartObject.Nodes.GetNodeById(this.currentStartNodeId);
								}
								var ids = this.curIds.split(this.splitStr);
								var names = this.curNames.split(this.splitStr);
								if (ids.length>0) {
									if (lbpm.freeFlow.defOperRefIds.length == 0 || !lbpm.freeFlow.defFlowPopedom) {
										var data = new KMSSData();
										data.AddBeanData("getOperTypesByNodeService&nodeType=freeFlowReviewNode");
										data = data.GetHashMapArray();
										for(var j=0;j<data.length;j++){
											if(data[j].isDefault=="true"){
												lbpm.freeFlow.defOperRefIds["reviewNode"] = data[j].value;
												break;
											}
										}
										data = new KMSSData().AddBeanData("getOperTypesByNodeService&nodeType=freeFlowSignNode");
										data = data.GetHashMapArray();
										for(var j=0;j<data.length;j++){
											if(data[j].isDefault=="true"){
												lbpm.freeFlow.defOperRefIds["signNode"] = data[j].value;
												break;
											}
										}
										lbpm.freeFlow.defFlowPopedom = (Lbpm_SettingInfo["defaultFlowPopedom"] > lbpm.nodes[lbpm.nowNodeId].flowPopedom)?lbpm.nodes[lbpm.nowNodeId].flowPopedom:Lbpm_SettingInfo["defaultFlowPopedom"];
									}
									newNodeObj = FlowChartObject.Nodes.createNodeInFreeFlow(beginNode,"reviewNode",true);
									FlowChartObject.Nodes.initNodeDataInFreeFlow(newNodeObj);
									for ( var i = 0; i < ids.length; i++) {
										if (i > 0) {
											newNodeObj.Data["handlerNames"]+=";";
											newNodeObj.Data["handlerIds"]+=";";
										}
										newNodeObj.Data["handlerNames"]+=names[i];
										newNodeObj.Data["handlerIds"]+=ids[i];
									}
									newNodeObj.Data["operations"]["refId"]=lbpm.freeFlow.defOperRefIds["reviewNode"];
									newNodeObj.Data["flowPopedom"]=lbpm.freeFlow.defFlowPopedom;
									newNodeObj.Data["processType"]="2";
									newNodeObj.Data["canAddAuditNoteAtt"]=Lbpm_SettingInfo["isCanAddAuditNoteAtt"];
									newNodeObj.Data["canModifyMainDoc"]=Lbpm_SettingInfo["isEditMainDocument"];
									newNodeObj.Data["notifyType"]=Lbpm_SettingInfo["defaultNotifyType"];
									lbpm.myAddedNodes.push(newNodeObj.Data.id);
									beginNode = newNodeObj;
								}
								this.updateFlowXml(FlowChartObject);
								topic.publish("/sys/lbpmservice/freeflow/___addNode",this,{newNode:newNodeObj});
							}
						},
						
						updateFreeFlowNodes : function(domContainer) {
							domConstruct.empty(domContainer);
							this.isPassedRoute = true;
							this.buildDraftorNode(domContainer);
							this.appendFreeFlowNode(domContainer,lbpm.nodes["N2"]);
							
							this.validation.validateElement(this);
						},
						
						appendFreeFlowNode : function(domContainer,nodeObj){
							var nodeId = nodeObj.endLines[0].endNode.id;
							if (nodeId == "N3") {
								return;
							}
							var node = lbpm.nodes[nodeId];
							this._buildOneOrg(domContainer, node);
							if(!this.edit){
								domConstruct.create("span",{innerHTML:this.splitStr},domContainer);
							}
							this.appendFreeFlowNode(domContainer, node);
						},
						
						deleteFreeFlowNode : function (id){
							var node = lbpm.nodes[id];
							if (!node) {
								return;
							}
							this.delNodeInFreeFlow(id);
							this.validation.validateElement(this);
						},
						
						delNodeInFreeFlow : function(nodeId) {
							var FlowChartObject = this.getFlowChartObject();
							var delNodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
							FlowChartObject.Nodes.deleteNodeInFreeFlow(delNodeObj,true);
							this.updateFlowXml(FlowChartObject);
						},
						
						modifyNodeHandlersInFreeFlow : function(nodeId,ids,names){
							var FlowChartObject = this.getFlowChartObject();
							var nodeObj = FlowChartObject.Nodes.GetNodeById(nodeId);
							nodeObj.Data["handlerNames"]=names;
							nodeObj.Data["handlerIds"]=ids;
							this.updateFlowXml(FlowChartObject);
							topic.publish("/sys/lbpmservice/freeflow/___updateNode",this,{nodeId:nodeObj.Data["id"]});
						},
						
						getFlowChartObject : function(){
							var iframe = document.getElementById('WF_IFrame');
							return iframe.contentWindow.FlowChartObject;
						},
						
						updateFlowXml : function(FlowChartObject) {
							var flowXml = FlowChartObject.BuildFlowXML();
							if (!flowXml){
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
			return freeflowNodes;
		});