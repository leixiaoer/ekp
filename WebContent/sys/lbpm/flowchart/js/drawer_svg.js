Com_IncludeJsFile("svg.js");
( function(FlowChartObject) {
	
	FlowChartObject.SVG = new Object();
	FlowChartObject.SVG.Drawer = null;
	FlowChartObject.SVG.Initialize = function() {
		SVG.eid = function(name) { // Id生成规则
			return 'lbpm' + name.charAt(0).toUpperCase() + name.slice(1)
					+ (SVG.did++);
		};
		FlowChartObject.SVG.Drawer = window.SVG('lbpmSvg');
		var g = FlowChartObject.SVG.Group = FlowChartObject.SVG.Drawer.group();
		
		//添加泳道
		FlowChartObject.SVG.Lane=g.group();
		FlowChartObject.SVG.Lane.Roles=FlowChartObject.SVG.Lane.group();
		FlowChartObject.SVG.Lane.Stages=FlowChartObject.SVG.Lane.group();
		FlowChartObject.SVG.Lane.Lines=FlowChartObject.SVG.Lane.group();
		//创建泳道工具按钮
		FlowChartObject.CreateLaneToolbar(FlowChartObject.SVG.Lane);
		FlowChartObject.SVG.Nodes = g.group();
		FlowChartObject.SVG.Lines = g.group();
		FlowChartObject.SVG.Points = g.group();
	};
	FlowChartObject.InitializeArray.unshift(FlowChartObject.SVG); // 优先初始化
	
	FlowChartObject.CreateLaneToolbar=function(g){
		var startLane=g.rect(GRID_SIZE,GRID_SIZE).attr("fill", "#f5f5f5").attr("x", 0).attr("y", 0).attr("stroke", "#D4D4DC").attr("stroke-width", "1");
		FlowChartObject.Lane.StartLaneDOM=startLane;//泳道初始位置的占位符避免有空白格
		//自由流时不显示
		if(Com_IsFreeFlow()){
			startLane.hide();		
		}
		//创建角色添加功能按钮
		var roleButton=createRoleAddButton(g);	
		//创建阶段添加功能按钮
		var stageButton=createStageAddButton(g);
		//查看状态下和自由流状态下不显示
		if(!FlowChartObject.IsEdit||Com_IsFreeFlow()){
			roleButton.hide();
			stageButton.hide();
		}
		
	}
	
	/**
	 * 创建阶段添加功能按钮
	 * @param g
	 * @returns
	 */
	function createStageAddButton(g){
		var stageAddButton=g.group();
		FlowChartObject.Lane.Stages.StageAddButton.DOMElement=stageAddButton;
		FlowChartObject.Lane.Stages.StageAddButton.X=0;
		FlowChartObject.Lane.Stages.StageAddButton.Y=GRID_SIZE; 
		//阶段添加功能按钮
		stageAddButton.image('../images/laneAdd.png',20,20).style('cursor', 'pointer').click(function() {		   
			 var stage=FlowChartObject.Lane.Stages.Create();
			//有节点在泳道的范围外时，扩大泳道，将所所有在泳道外的节点覆盖
			   var max_Y=0;
				for(var i=0;i<FlowChartObject.Nodes.all.length;i++){
					var nodeTail_Y=FlowChartObject.Nodes.all[i].Data.y+FlowChartObject.Nodes.all[i].Height/2;
					if(max_Y<nodeTail_Y){
						max_Y=nodeTail_Y;
					}
				}
				if((stage.Data.y+stage.Data.height)<max_Y){		
					var newHeight=max_Y-stage.Data.y+GRID_SIZE;
					stage.SetHeight(newHeight);
					var stageAddButton=FlowChartObject.Lane.Stages.StageAddButton;
					stageAddButton.Y=stage.Data.y+stage.Data.height;
					//角色添加完成后移动增加按钮按钮，始终将自己保持在最后一个泳道的后面
					FlowChartObject.SetPosition(stageAddButton.DOMElement,stageAddButton.X,stageAddButton.Y);
				}
		});
		FlowChartObject.SetPosition(FlowChartObject.Lane.Stages.StageAddButton.DOMElement,FlowChartObject.Lane.Stages.StageAddButton.X,FlowChartObject.Lane.Stages.StageAddButton.Y);	
		stageAddButton.node.LKSObject=FlowChartObject.Lane.Stages.StageAddButton;
		
		
		return stageAddButton;
	}
	
	/**
	 * 创建角色添加功能按钮
	 * @param g
	 * @returns
	 */
	function createRoleAddButton(g){
		var roleAddButton=g.group();
		FlowChartObject.Lane.Roles.RoleAddButton.DOMElement=roleAddButton;
		FlowChartObject.Lane.Roles.RoleAddButton.X=GRID_SIZE;
		FlowChartObject.Lane.Roles.RoleAddButton.Y=0;
		
		//角色添加功能按钮
		roleAddButton.image('../images/laneAdd.png',20,20).style('cursor', 'pointer').click(function() {
		   var role=FlowChartObject.Lane.Roles.Create();
		   
		   //有节点在泳道的范围外时，扩大泳道，将所所有在泳道外的节点覆盖
		   var max_X=0;
			for(var i=0;i<FlowChartObject.Nodes.all.length;i++){
				var nodeTail_X=FlowChartObject.Nodes.all[i].Data.x+FlowChartObject.Nodes.all[i].Width/2;
				if(max_X<nodeTail_X){
					max_X=nodeTail_X;
				}
			}
			if((role.Data.x+role.Data.width)<max_X){		
				var newWidth=max_X-role.Data.x+GRID_SIZE;
				role.SetWidth(newWidth);
				var roleAddButton=FlowChartObject.Lane.Roles.RoleAddButton;
				roleAddButton.X=role.Data.x+role.Data.width;
				//角色添加完成后移动增加按钮按钮，始终将自己保持在最后一个泳道的后面
				FlowChartObject.SetPosition(roleAddButton.DOMElement,roleAddButton.X,roleAddButton.Y);
			}		
			
		});
		
		FlowChartObject.SetPosition(FlowChartObject.Lane.Roles.RoleAddButton.DOMElement,FlowChartObject.Lane.Roles.RoleAddButton.X,FlowChartObject.Lane.Roles.RoleAddButton.Y);	
		roleAddButton.node.LKSObject=FlowChartObject.Lane.Roles.RoleAddButton;
		return roleAddButton;
	}
	
	// 调整画布宽度、高度
	FlowChartObject.Resize = function(isEdit) {
		var bbox;
		var drawer = FlowChartObject.SVG.Drawer;
		try {
			bbox = drawer.node.getBBox();
		} catch(e) {
			bbox = {
				x: drawer.node.clientLeft,
				y: drawer.node.clientTop,
				width: drawer.node.clientWidth,
				height: drawer.node.clientHeight
			};
		}
		if(bbox.height + bbox.y > 0) {
			document.body.style.height = (bbox.height + bbox.y + 50) + "px";
		}
		if(bbox.width + bbox.x > 0) {
			document.body.style.width = (bbox.width + bbox.x + 50) + "px";
			//画布宽度小于界面宽度时，让画布铺满界面
			_spreadDrawer(bbox.width + bbox.x + 50);
		}
		if(bbox.width==0&&bbox.height==0){
			document.body.style.height = (FlowChartObject.maxY + bbox.y + 200) + "px";
			document.body.style.width = (FlowChartObject.maxX + bbox.x + 200) + "px";	
			//画布宽度小于界面宽度时，让画布铺满界面
			_spreadDrawer(FlowChartObject.maxX + bbox.x + 200);
		}
		FlowChartObject.SVG.BoxWidth=bbox.width + bbox.x;
		FlowChartObject.SVG.BoxHeight=bbox.height + bbox.y ;
		//刷新泳道的角色高度和阶段宽度
		FlowChartObject.RefreshAllLaneRoleHeight();
		FlowChartObject.RefreshAllLaneStageHeight();
	};
	/**
	 * 画布宽度小于界面宽度时，让画布铺满界面
	 * @param 画布当前宽度
	 */
	function _spreadDrawer(currentWidth){
		//让画布初始化的时候铺满界面
		var minWidth=window.screen.availWidth*0.90;
		if(currentWidth<minWidth){
			document.body.style.width = minWidth+"px";
		}
	}
	
	
	// 显示隐藏
	FlowChartObject.ShowElement = function(element, show) {
		if (!element) {
			return;
		}
		if (element.node) { // svg
			if (show) {
				element.show();
			} else {
				element.hide();
			}
		} else {
			element.style.display = show ? "" : "none";
		}
	};
	// 删除元素
	FlowChartObject.RemoveElement = function(element) {
		if (element.node) { // svg
			element.remove();
		} else {
			element.parentNode.removeChild(element);
		}
	};
	// 获取元素大小
	FlowChartObject.GetElementSize = function(element) {
		return {
			width : element.node.offsetWidth || element.node.scrollWidth || element.attr('width') || 0,
			height : element.node.offsetHeight || element.node.scrollHeight || element.attr('height') || 0
		};
	};
	// 设置位置
	FlowChartObject.SetPosition = function(obj, left, top) {
		obj.move(left, top);
		FlowChartObject.maxX=left>FlowChartObject.maxX?left:FlowChartObject.maxX;
		FlowChartObject.maxY=top>FlowChartObject.maxY?top:FlowChartObject.maxY;
		FlowChartObject.Resize();
	};
	// 设置填充颜色
	FlowChartObject.SetFillcolor = function(obj, color) {
		var child = obj.children()[0];
		child.attr("fill", color);
		if (child.type == "polyline") {
			createLineArrow(child, color); // 创建颜色箭头
		}
	};
	// 获取填充颜色
	FlowChartObject.GetFillcolor = function(obj) {
		var child = obj.children()[0];
		return child.attr("fill");
	};
	// 设置边框颜色
	FlowChartObject.SetStrokeColor = function(obj, color) {
		var child = obj.children()[0];
		child.attr("stroke", color);
		if (child.type == "polyline") {
			createLineArrow(child, color); // 创建颜色箭头
		}
	};
	// 设置连线拐点
	FlowChartObject.SetLinePoints = function(obj, points) {
		obj.children()[0].plot(points);
		
		//#58210 辅助操作线,避免连接线过窄点击困难
		if(obj.children()[1]&&obj.children()[1].type=="polyline"){		
			obj.children()[1].plot(points);
		}
		
		//该部分代码是为了解决Win7操作系统下IE使用SVG时，线段位置不更新的问题
		/**
		 * 根据原颜色进行少量的切换，再还原，避免显示过于夸张
		 */
		if(obj.node.LKSObject){
			if(obj.node.LKSObject.Status==STATUS_PASSED){
				FlowChartObject.SetStrokeColor(obj,"#009901" );
			}
			else{
				FlowChartObject.SetStrokeColor(obj,"#999998" );
			}	
			setTimeout(function(){
				FlowChartObject.SetStrokeColor(obj,LINESTYLE_STATUSCOLOR[obj.node.LKSObject.Status]);
			},1);
		}		
		
	};
	// 设置文本
	FlowChartObject.SetText = function(obj, text) {
		if (obj) {
			if(text && text.constructor == Array) {
				var label = "";
				for (var i = 0; i < text.length; i++) {
					if(i > 0) {
						label += "\r\n-----------------------------------------------\r\n";
					}
					label += text[i];
				}
				text = label;
			}
			obj.text(text);
			if(obj.parent.node.LKSObject.Height) {
				// FIXME 调整垂直定位，IE10、firefox下obj.bbox().height高度有时候读取不到
				obj.y((obj.parent.node.LKSObject.Height - (obj.bbox().height && obj.bbox().height<obj.parent.node.LKSObject.Height ? obj.bbox().height : 13)) / 2);
			}
		}
	};

	function getRectDOMImageUrl(obj) {
		var nodeType = FlowChartObject.Nodes.Types[obj.Type];
		return nodeType.BackgroundImage
				|| ("../images/" + obj.Type.toLowerCase() + ".png");
	}

	function createLineArrow(line, color) {
		var isIE11 = false;
		if (navigator.userAgent.toLowerCase().indexOf("trident") > -1 && navigator.userAgent.indexOf("rv:11.0") > -1) {
			isIE11 = true;
		}
		var arrow = FlowChartObject.SVG.Drawer.node.getElementById("lbpmArrow"
				+ color);
		if (arrow) {
			if (isIE11) {
				// 针对win7下最新版本(11.0.9600.19356以上)的IE11浏览器查看流程图时浏览器崩溃的问题 #73560
				if (line.attr("marker-end") == null) {
					line.attr("marker-end", "url(#lbpmArrow" + color + ")");
				}
			} else {
				line.attr("marker-end", "url(#lbpmArrow" + color + ")");
			}
			return;
		}
		var defs = FlowChartObject.SVG.Drawer.defs();
		var marker = SVG.create("marker");
		marker.setAttributeNS(null, 'id', "lbpmArrow" + color);
		marker.setAttributeNS(null, 'viewBox', '0 0 20 20');
		marker.setAttributeNS(null, 'refX', "17px");
		marker.setAttributeNS(null, 'refY', "10px");
		marker.setAttributeNS(null, 'markerUnits', 'strokeWidth');
		marker.setAttributeNS(null, 'markerWidth', "4px");
		marker.setAttributeNS(null, 'markerHeight', "4px");
		marker.setAttributeNS(null, 'orient', "auto");
		defs.node.appendChild(marker);
		var path = SVG.create("path");
		path.setAttributeNS(null, 'd', "M 0 0 L 20 10 L 0 20 z");
		path.setAttributeNS(null, 'fill', color);
		path.setAttributeNS(null, 'stroke', color);
		path.setAttributeNS(null, 'stroke-width', "1px");
		marker.appendChild(path);
		if (isIE11) {
			marker.setAttributeNS(null, 'end', "url(#lbpmArrow" + color + ")");
		} else {
			line.attr("marker-end", "url(#lbpmArrow" + color + ")");
		}
	}
	
	function createNodeGroup() {
		var group = FlowChartObject.SVG.Nodes.group();
		//group.attr("filter", "url(#filter)");
		return group;
	}

	// 线
	FlowChartObject.Lines.CreateLineDOM = function(obj) {
		var group = FlowChartObject.SVG.Lines.group();
		var polyline = group.polyline("0, 0", true).attr("class",
				"line_" + obj.Type).attr("fill", "none").attr("stroke",
				FlowChartObject.LINESTYLE_STATUSCOLOR[obj.Status]).attr(
				"stroke-width", obj.Weight);
		polyline.attr("stroke-linecap", "round").attr("stroke-linejoin",
				"round");
		createLineArrow(polyline,
				FlowChartObject.LINESTYLE_STATUSCOLOR[obj.Status]);
		//#58210 辅助操作线,避免连接线过窄点击困难 rgba(0,0,0,0)
		var polylineAssist = group.polyline("0, 0", true).attr("class",
				"line_" + obj.Type).attr("fill", "none").attr("stroke",
				"rgba(0,0,0,0)").attr(
				"stroke-width", 20);
		obj.DOMElement = group;
		if (obj.Type == "opt") {
			polyline.attr("stroke-dasharray", "20, 10"); // 虚线
		} else {
			group.node.LKSObject = obj;
			// 文本
			var text = group.text(obj.Text).attr("class", "line_text text").fill(
					"#000000");
			text.font( {
				size : 12
			});
			text.node.LKSObject = obj;
			obj.DOMText = text;
		}
	};

	// 点
	FlowChartObject.Points.CreatePointDOM = function(obj) {
		var group = FlowChartObject.SVG.Points.group().hide(); // 隐藏
		var circle = group.circle(8).attr("class", "point_main").attr("stroke",
				"#0000FF");
		obj.DOMElement = group;
		if (obj.Type == "line") {
			circle.attr("fill", "#00FF00");
			circle.attr("title", FlowChartObject.Lang.PointHelp);
			group.node.LKSObject = obj;
			circle.on("mouseover", function(e) {
				this.instance.attr("fill", "#FF0000");
			});
			circle.on("mouseout", function(e) {
				this.instance.attr("fill", "#00FF00");
			});
		} else {
			circle.attr("fill", "#9999FF");
		}
	};
	FlowChartObject.Nodes.QuickBuildTop=null;//节点快捷操作上部分区域
	
	FlowChartObject.Nodes.QuickBuildBottom=null;//节点快捷操作下部分区域
	
	FlowChartObject.Nodes.MenuTop=null;//节点快捷操作上部分区域的操作菜单
	
	FlowChartObject.Nodes.MenuBottom=null;//节点快捷操作下部分区域的操作菜单
	
	FlowChartObject.Nodes.QuickBuildRight=null;//节点快捷操作右侧区域
	
	FlowChartObject.Nodes.MenuRight=null;//节点快捷操作右侧区域的操作菜单
	
	/**
	 * 新增 王祥 2017-10-27
	 * 清除快捷菜单的缓存
	 */
	FlowChartObject.Nodes.removeQuickBuild=function(){
		var svg = FlowChartObject.SVG.Drawer;
		if(FlowChartObject.Nodes.QuickBuildTop!=null&&FlowChartObject.Nodes.QuickBuildBottom!=null){
			FlowChartObject.Nodes.QuickBuildTop.remove();
			FlowChartObject.Nodes.QuickBuildTop=null;
			
			FlowChartObject.Nodes.QuickBuildBottom.remove();
			FlowChartObject.Nodes.QuickBuildBottom=null;
			
			FlowChartObject.Nodes.MenuTop.remove();
			FlowChartObject.Nodes.MenuTop=null;
			
			FlowChartObject.Nodes.MenuBottom.remove();
			FlowChartObject.Nodes.MenuBottom=null;
		}
		if(FlowChartObject.Nodes.QuickBuildRight!=null){
			FlowChartObject.Nodes.QuickBuildRight.remove();
			FlowChartObject.Nodes.QuickBuildRight=null;
			
			FlowChartObject.Nodes.MenuRight.remove();
			FlowChartObject.Nodes.MenuRight=null;
		}
	}
	/**
	 * 新增 王祥 2017-10-27
	 * 创建快捷菜单的上部分
	 * @param obj 创建菜单的节点对象
	 * @returns 返回上部分菜单对象
	 */
	function createQuickBuildTop(obj){
		var QuickBuildTop=new Object();
		QuickBuildTop.orientation="Top";
		QuickBuildTop.Name="QuickBuild";
		var groupTop = FlowChartObject.SVG.Drawer.group();
		groupTop.rect(obj.Width,obj.Height).attr("fill", "blue").attr("x", obj.DOMElement.trans.x).attr("y", obj.DOMElement.trans.y-obj.Height+2).attr("opacity",0);	
		var points = new Array();
		points.push("8,0");
		points.push("0,10");
		points.push("16,10");
		groupTop.polygon(points.join(" "), true).attr("stroke", "#58c0ee")
				.fill("#58c0ee").move(obj.DOMElement.trans.x+obj.Width/2-8,obj.DOMElement.trans.y-15).mousemove(function() {
					FlowChartObject.Nodes.MenuBottom.hide();
					FlowChartObject.Nodes.MenuTop.show();
				});		
		var menuTop=groupTop.group();
		menuTop.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x).attr("y", obj.DOMElement.trans.y-35).mousedown(function(){
			var node = new FlowChart_Node("signNode");//创建签字节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y-70, true);
			var oldLine=obj.LineIn[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});
		menuTop.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x+obj.Width/2-8).attr("y", obj.DOMElement.trans.y-35).mousedown(function(){
			var node = new FlowChart_Node("reviewNode");//创建审批节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y-70, true);
			var oldLine=obj.LineIn[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});	
		menuTop.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x+obj.Width-20).attr("y", obj.DOMElement.trans.y-35).mousedown(function(){
			var node = new FlowChart_Node("sendNode");//创建抄送节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y-70, true);
			var oldLine=obj.LineIn[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});
		menuTop.hide();
		
		QuickBuildTop.DOMElement=groupTop;
		groupTop.node.LKSObject=QuickBuildTop;
		
		FlowChartObject.Nodes.QuickBuildTop=groupTop;
		FlowChartObject.Nodes.MenuTop=menuTop;
		return groupTop;
	}
	/**
	 * 新增 王祥 2017-10-27
	 * 创建快捷菜单的下部分
	 * @param obj 创建菜单的节点对象
	 * @returns 返回下部分菜单对象
	 */
	function createQuickBuildBottom(obj){
		var QuickBuildBottom=new Object();
		QuickBuildBottom.orientation="Bottom";
		QuickBuildBottom.Name="QuickBuild";
		var groupBottom = FlowChartObject.SVG.Drawer.group();
		groupBottom.rect(obj.Width,obj.Height).attr("fill", "blue").attr("x", obj.DOMElement.trans.x).attr("y", obj.DOMElement.trans.y+obj.Height-2).attr("opacity",0);	
		var points = new Array();
		points.push("0,0");
		points.push("16,0");
		points.push("8,10");
		groupBottom.polygon(points.join(" "), true).attr("stroke", "#58c0ee")
				.fill("#58c0ee").move(obj.DOMElement.trans.x+obj.Width/2-8,obj.DOMElement.trans.y+obj.Height+5).mousemove(function() {
					FlowChartObject.Nodes.MenuTop.hide();
					FlowChartObject.Nodes.MenuBottom.show();
				});
		var menuBottom=groupBottom.group();
		menuBottom.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x).attr("y", obj.DOMElement.trans.y+obj.Height+20).mousedown(function(){
			var node = new FlowChart_Node("signNode");//创建签字节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y+100, true);
			var oldLine=obj.LineOut[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});
		menuBottom.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x+obj.Width/2-8).attr("y", obj.DOMElement.trans.y+obj.Height+20).mousedown(function(){
			var node = new FlowChart_Node("reviewNode");//创建审批节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y+100, true);
			var oldLine=obj.LineOut[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});
		menuBottom.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x+obj.Width-20).attr("y", obj.DOMElement.trans.y+obj.Height+20).mousedown(function(){
			var node = new FlowChart_Node("sendNode");//创建抄送节点
			node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y+100, true);
			var oldLine=obj.LineOut[0];
			FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		});
		menuBottom.hide();
		
		QuickBuildBottom.DOMElement=groupBottom;
		groupBottom.node.LKSObject=QuickBuildBottom;
		
		FlowChartObject.Nodes.QuickBuildBottom=groupBottom;
		FlowChartObject.Nodes.MenuBottom=menuBottom;
		
		return groupBottom;
	}
	/**
	 * 新增 王祥 2017-10-27
	 * 创建节点快捷操作菜单
	 */
	FlowChartObject.Nodes.quickBuild=function(obj){	
		//王祥
		if(FlowChartObject.Nodes.QuickBuildTop==null&&FlowChartObject.Nodes.QuickBuildBottom==null){
			var vExcludeNodes =new Array();
			//vExcludeNodes.push("draftNode");//起草节点
			//vExcludeNodes.push("endNode");//结束节点
			vExcludeNodes.push("splitJoinNode");//并行分支
			vExcludeNodes.push("startNode");//开始节点
			vExcludeNodes.push("splitNode");//启动并行分支
			vExcludeNodes.push("manualBranchNode");//人工决策
			vExcludeNodes.push("joinNode");//结束并行分支
			vExcludeNodes.push("autoBranchNode");//条件分支
			var vVisual=true;
			for(n in vExcludeNodes){
				if(obj.Type==vExcludeNodes[n]){
					vVisual=false;
				}
			}
			//排除不需要显示该功能的节点
			if(vVisual==true){
				var top=createQuickBuildTop(obj);
				var bottom=createQuickBuildBottom(obj);
				if(obj.Type=="draftNode"){
					top.hide();
				}
				if(obj.Type=="endNode"){
					bottom.hide();
				}
			}		
		}
	}
	
	// 功能：创建圆角节点
	FlowChartObject.Nodes.CreateRoundRectDOM = function(obj) {
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);
		obj.Width = 120;
		obj.Height = 40;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate) {
			obj.Width = obj.Width - obj.Small_WidthRank;
			obj.Height = obj.Height - obj.Small_HeightRank;
		}

		var group = createNodeGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate && obj.Small_ImgageURL) {
			group.image(obj.Small_ImgageURL, obj.Width, obj.Height);
		} else {
			group.rect(obj.Width, obj.Height).attr("class", "node_main").attr(
					"rx", 20).attr("ry", 20).attr("stroke", "#000000").fill("#ffffff");
			group.image(getRectDOMImageUrl(obj), 25, 25).move(15,
					(obj.Height - 25) / 2);
			// create text
			var text = group.text(obj.Text).attr("class", "round_nodetb text").fill(
					'#000000').move((obj.Width + 25) / 2, (obj.Height - 12) / 2);
			text.font( {
				size : 12,
				anchor: 'middle'
			});
			obj.DOMText = text;
		}
	};

	// 功能：创建方角节点
	FlowChartObject.Nodes.CreateRectDOM = function(obj) {
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);
		obj.Width = 120;
		obj.Height = 40;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate) {
			obj.Width = obj.Width - obj.Small_WidthRank;
			obj.Height = obj.Height - obj.Small_HeightRank;
		}

		var group = createNodeGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate && obj.Small_ImgageURL) {
			group.image(obj.Small_ImgageURL, obj.Width, obj.Height);
		} else {
			var rect = group.rect(obj.Width, obj.Height).attr("class",
					"node_main").attr("rx", 5).attr("ry", 5).attr("stroke",
					"#000000").fill("#ffffff");

			group.image(getRectDOMImageUrl(obj), 25, 25).move(5,
					(obj.Height - 28) / 2);
			// create text
			var text = group.text(obj.Text).attr("class", "round_nodetb").fill(
					'#000000').move((obj.Width + 25) / 2, (obj.Height - 12) / 2);
			text.font( {
				size : 12,
				anchor: 'middle'
			});

			obj.DOMText = text;
			obj.Refresh = FlowChart_Node_Refresh;
		}
	};

	// 功能：创建大图标节点
	FlowChartObject.Nodes.CreateBigRectDOM = function(obj) {
		if (FlowChartObject.IconType == ICONTYPE_BIG) {
			if (obj.DOMElement != null)
				FlowChartObject.RemoveElement(obj.DOMElement);
			obj.Width = 200;
			obj.Height = 80;

			var group = createNodeGroup();
			group.node.LKSObject = obj;
			obj.DOMElement = group;

			var rect = group.rect(obj.Width, obj.Height).attr("class",
					"node_main").attr("rx", 5).attr("ry", 5).attr("stroke",
					"#000000").fill("#ffffff");

			group.image(getRectDOMImageUrl(obj), 25, 25).move(10,
					6);
			// create text
			var text = group.text(obj.Text).attr("class", "round_nodetb").fill(
					'#000000').move(obj.Width / 2, (obj.Height - 12) / 2);
			text.font( {
				size : 12,
				anchor: 'middle'
			});

			obj.DOMText = text;
			obj.Refresh = FlowChart_Node_BigIconRefresh;
		} else {
			FlowChartObject.Nodes.CreateRectDOM(obj);
		}
		obj.ChangeIconType = FlowChart_Node_ChangeIconType;
	};

	// 功能：创建菱形节点
	FlowChartObject.Nodes.CreateDiamondDOM = function(obj) {
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);
		obj.Width = 120;
		obj.Height = 80;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate) {
			obj.Width = obj.Width - obj.Small_WidthRank;
			obj.Height = obj.Height - obj.Small_HeightRank;
		}

		var group = createNodeGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;

		if (FlowChartObject.isNeedSmall && !FlowChartObject.IsEdit
				&& !FlowChartObject.IsTemplate && obj.Small_ImgageURL) {
			group.image(obj.Small_ImgageURL, obj.Width, obj.Height);
		} else {
			var points = new Array();
			points.push((obj.Width / 2) + ", 0");
			points.push(obj.Width + ", " + (obj.Height / 2));
			points.push((obj.Width / 2) + ", " + obj.Height);
			points.push("0, " + (obj.Height / 2));
			group.polygon(points.join(" "), true).attr("stroke", "#000000")
					.fill("#ffffff");

			group.image(getRectDOMImageUrl(obj), 25, 25).move(
					(obj.Width - 25) / 2, (obj.Height - 25) / 2);

			var text = group.text(obj.Text).attr("class", "round_nodetb")
					.fill('#000000').move(obj.Width / 2,
							(obj.Height - 12) / 2);
			text.font( {
				size : 12,
				anchor: 'middle'
			});

			obj.DOMText = text;

		}
	};

	function createConcurrentDOM(obj) {
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);
		obj.Width = 40;
		obj.Height = 40;

		var group = createNodeGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;

		var points = new Array();
		points.push((obj.Width / 2) + ", 0");
		points.push(obj.Width + ", " + (obj.Height / 2));
		points.push((obj.Width / 2) + ", " + obj.Height);
		points.push("0, " + (obj.Height / 2));

		group.polygon(points.join(" "), true).attr("class", "node_main").attr(
				"stroke", "#000000").fill("#ffffff");

		group.line((obj.Width / 4), (obj.Height / 2), (obj.Width / 4 * 3),
				(obj.Height / 2)).attr("stroke", "#000000").fill("#000000")
				.attr("stroke-width", 5);
		group.line((obj.Width / 2), (obj.Height / 4), (obj.Width / 2),
				(obj.Height / 4 * 3)).attr("stroke", "#000000").fill("#000000")
				.attr("stroke-width", 5);

	}

	// 功能：创建并行分支节点
	FlowChartObject.Nodes.CreateSplitDOM = function(obj) {
		createConcurrentDOM(obj);
	};

	// 功能：创建合并分支节点
	FlowChartObject.Nodes.CreateJoinDOM = function(obj) {
		createConcurrentDOM(obj);
	};
	
	// 创建节点快捷操作菜单(自由流)
	FlowChartObject.Nodes.quickBuildOfFreeFlow=function(obj){
		if(FlowChartObject.IsMainFlow || obj.Status==FlowChartObject.STATUS_PASSED){
			return;
		}
		if(FlowChartObject.Nodes.QuickBuildRight == null){
			var vExcludeNodes =new Array();
			vExcludeNodes.push("startNode");//开始节点
			var vVisual=true;
			for(n in vExcludeNodes){
				if(obj.Type==vExcludeNodes[n]){
					vVisual=false;
				}
			}
			//排除不需要显示该功能的节点
			if(vVisual==true){
				var right =createQuickBuildRight(obj);
				if(obj.Type=="endNode"){
					right.hide();
				}
			}		
		}
	}
	
	// 创建快捷菜单的右侧部分（自由流）
	function createQuickBuildRight(obj){
		var QuickBuildRight=new Object();
		QuickBuildRight.orientation="Right";
		QuickBuildRight.Name="QuickBuild";
		var groupRight = FlowChartObject.SVG.Drawer.group();
		groupRight.rect(obj.Height,obj.Width - GRID_SIZE * 2).attr("fill", "blue").attr("x", obj.DOMElement.trans.x + obj.Width).attr("y", obj.DOMElement.trans.y - obj.Height/2).attr("opacity",0);	
		var points = new Array();
		points.push("0,0");
		points.push("8,8");
		points.push("0,16");
		groupRight.polygon(points.join(" "), true).attr("stroke", "#58c0ee")
				.fill("#58c0ee").move(obj.DOMElement.trans.x+obj.Width + GRID_SIZE/2 - 4, obj.DOMElement.trans.y + obj.Height/2 - 8).mousemove(function() {
					FlowChartObject.Nodes.MenuRight.show();
				});
		var menuRight=groupRight.group();
		if(FlowChartObject.IsTemplate){
			if (obj.Type=="draftNode" || obj.Status==FlowChartObject.STATUS_RUNNING || (FLOWTYPE_POPEDOM == FLOWTYPE_POPEDOM_ADD && parent.Data_MyAddedNodes && !parent.Data_MyAddedNodes.contains(obj.Data.id))) {
				menuRight.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y-20).mousedown(function(){
					createNodeInFreeFlow(obj,"reviewNode");//Create Review Node
				});
				menuRight.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y - GRID_SIZE/4 + 6).mousedown(function(){
					createNodeInFreeFlow(obj,"signNode");//Create Sign Node
				});	
				menuRight.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y + GRID_SIZE/2 + 12).mousedown(function(){
					createNodeInFreeFlow(obj,"sendNode");//Create Send Node
				});
				menuRight.image("../images/buttonbar-1_02-04.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y + 40).mousedown(function(){
					createNodeInFreeFlow(obj,"robotNode");//Create Robot Node
				});
			} else {
				menuRight.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y-30).mousedown(function(){
					createNodeInFreeFlow(obj,"reviewNode");//Create Review Node
				});
				menuRight.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y - GRID_SIZE/4 - 4).mousedown(function(){
					createNodeInFreeFlow(obj,"signNode");//Create Sign Node
				});	
				menuRight.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y + GRID_SIZE/2 + 2).mousedown(function(){
					createNodeInFreeFlow(obj,"sendNode");//Create Send Node
				});
				menuRight.image("../images/buttonbar-1_02-04.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y + GRID_SIZE + 14).mousedown(function(){
					createNodeInFreeFlow(obj,"robotNode");//Create Robot Node
				});
				menuRight.image("../images/buttonbar_delete.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y + 50).mousedown(function(){
					deleteNodeInFreeFlow(obj);// delete node
					FlowChartObject.Nodes.removeQuickBuild();
				});
			}
		}else{
			if (obj.Type=="draftNode" || obj.Data.isFixedNode=="true" || obj.Status==FlowChartObject.STATUS_RUNNING || (FLOWTYPE_POPEDOM == FLOWTYPE_POPEDOM_ADD && parent.Data_MyAddedNodes && !parent.Data_MyAddedNodes.contains(obj.Data.id))) {
				menuRight.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE).attr("y", obj.DOMElement.trans.y-GRID_SIZE/2).mousedown(function(){
					createNodeInFreeFlow(obj,"reviewNode");//Create Review Node
				});
				menuRight.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE).attr("y", obj.DOMElement.trans.y + GRID_SIZE/2).mousedown(function(){
					createNodeInFreeFlow(obj,"signNode");//Create Sign Node
				});	
				menuRight.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE).attr("y", obj.DOMElement.trans.y+GRID_SIZE*3/2).mousedown(function(){
					createNodeInFreeFlow(obj,"sendNode");//Create Send Node
				});
			} else {
				menuRight.image("../images/buttonbar-1_02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y-20).mousedown(function(){
					createNodeInFreeFlow(obj,"reviewNode");//Create Review Node
				});
				menuRight.image("../images/buttonbar-1_02-02.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y - GRID_SIZE/4 + 6).mousedown(function(){
					createNodeInFreeFlow(obj,"signNode");//Create Sign Node
				});	
				menuRight.image("../images/buttonbar-1_02-03.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + GRID_SIZE + 4).attr("y", obj.DOMElement.trans.y + GRID_SIZE/2 + 12).mousedown(function(){
					createNodeInFreeFlow(obj,"sendNode");//Create Send Node
				});
				menuRight.image("../images/buttonbar_delete.png",16,16).attr("x", obj.DOMElement.trans.x + obj.Width + 10).attr("y", obj.DOMElement.trans.y + 40).mousedown(function(){
					deleteNodeInFreeFlow(obj);// delete node
					FlowChartObject.Nodes.removeQuickBuild();
				});
			}
		}
		
		menuRight.hide();
		
		QuickBuildRight.DOMElement=groupRight;
		groupRight.node.LKSObject=QuickBuildRight;
		
		FlowChartObject.Nodes.QuickBuildRight=groupRight;
		FlowChartObject.Nodes.MenuRight=menuRight;
		FlowChartObject.Resize();
		return groupRight;
	}
	
	// 创建子节点
	FlowChartObject.Nodes.createSubNode = function(nodeType,groupNodeId,groupNodeType){
		var node = new FlowChart_Node(nodeType);
		var gNode = FlowChartObject.Nodes.GetNodeById(groupNodeId);
		var eNode = FlowChartObject.Nodes.GetNodeById(gNode.Data.endNodeId);
		var sNode = eNode.LineIn[0].StartNode;
		node.MoveTo(sNode.Data.x, sNode.Data.y,true);
		eNode.LineIn[0].LinkNode(sNode, node, FlowChartObject.NODEPOINT_POSITION_BOTTOM, FlowChartObject.NODEPOINT_POSITION_TOP);
		var line = new FlowChart_Line();
		line.LinkNode(node, eNode, FlowChartObject.NODEPOINT_POSITION_BOTTOM, FlowChartObject.NODEPOINT_POSITION_TOP);
		initCommonNodeData(node);
		initCommonManualNodeData(node);
		initReviewNodeData(node);
		node.Data["handlerSelectType"]="org";
		node.Data["ignoreOnHandlerSame"]="false";
		node.Data["onAdjoinHandlerSame"]="false";
		node.Data["operations"]["refId"]="13c5ae137925b6f5b55b6cf4051ac33a";
		node.Data["groupNodeId"]=groupNodeId;
		node.Data["groupNodeType"]=groupNodeType;
		node.Data["processType"] = "2"; // 节点流转方式默认会审
		return node;
	}
	
	// 删除子节点
	FlowChartObject.Nodes.deleteSubNode = function(subNodeId){
		var subNodeObj = FlowChartObject.Nodes.GetNodeById(subNodeId);
		if (subNodeObj != null) {
			if(subNodeObj.LineOut.length==1){
				var endNode = subNodeObj.LineOut[0].EndNode;
				for(var j=subNodeObj.LineIn.length-1; j>=0; j--){
					var line = subNodeObj.LineIn[j];
					line.LinkNode(null, endNode, null, subNodeObj.LineOut[0].Data.endPosition);
				}
			}
			subNodeObj.Delete();
		}
	}
	
	// 初始化人工类节点数据
	FlowChartObject.Nodes.initNodeData = function initNodeData(node,data){
		if(node.Type == "reviewNode"){
			initReviewNodeData(node,data);
		} else if (node.Type == "signNode") {
			initSignNodeData(node,data);
		} else if (node.Type == "sendNode") {
			initSendNodeData(node,data);
		}
		if(node.Status==FlowChartObject.STATUS_UNINIT){
			node.SetStatus(FlowChartObject.STATUS_NORMAL);
		}
		node.Refresh();
	}
	
	// 自由流里快捷创建节点
	function createNodeInFreeFlow(obj,nodeType,isMobile){
		var node = new FlowChart_Node(nodeType);
		var oldLine=obj.LineOut[0];
		var lineLength = Math.abs(oldLine.Points[1].y - oldLine.Points[0].y);
		if (lineLength < GRID_SIZE*4) {
			// 后面的节点都往下挪
			moveAllNextNodeDown(oldLine);
		}
		node.MoveTo(obj.DOMElement.trans.x+obj.Width/2, obj.DOMElement.trans.y + GRID_SIZE*4, true);
		FlowChartObject.Nodes.AutoLinkQuickBuild(node,null,oldLine);
		if (!isMobile) {
			FlowChartObject.SelectElement(node,true,true);
		}
		if (parent.Data_MyAddedNodes) {
			parent.Data_MyAddedNodes.push(node.Data.id);
		}
		//node.ShowAttributePanel();
		return node;
	}
	
	function initNodeDataInFreeFlow(node,data){
		FlowChartObject.Nodes.initNodeData(node,data);
		node.Data["canModifyFlow"]="true";
		node.Data["flowPopedom"]="1";
		node.Refresh();
	}
	
	function initReviewNodeData(node,data){
		initCommonNodeData(node,data);
		initCommonManualNodeData(node,data);
		var kmssData = parent.KMSSData;
		if (typeof parent.KMSSData == "undefined" && parent.parent) {
            kmssData = parent.parent.KMSSData;
        }
		var data = new kmssData().AddBeanData("lbpmSettingInfoService").GetHashMapArray()[0];
		var operationScope = new Array();
		operationScope.handler_commission = data.handlerCommissionDefaultScope;
		operationScope.handler_communicate = data.handlerCommunicateDefaultScope;
		operationScope.handler_additionSign = data.handlerAdditionSignDefaultScope;
		operationScope.handler_assign = data.handlerAssignDefaultScope;
		node.Data["operationScope"]=operationScope;
	
    }
	
	function initSignNodeData(node,data){
		initCommonNodeData(node,data);
		initCommonManualNodeData(node,data);
	}
	
	function initSendNodeData(node,data){
		initCommonNodeData(node,data);
		node.Data["canAddOpinion"]="false";
	}
	function initCommonManualNodeData(node,data){
		node.Data["processType"]="0";
		var operations = new Array();
		var refId =null;
		operations.refId = refId;
		node.Data["operations"]=operations;
		node.Data["ignoreOnHandlerSame"]="true";
		node.Data["onAdjoinHandlerSame"]="true";
		node.Data["canAddAuditNoteAtt"]="true";
		node.Data["canModifyFlow"]="false";
		node.Data["canModifyMainDoc"]="false";
		node.Data["canModifyNotionPopedom"]="false";
		node.Data["optHandlerCalType"]="2";
		node.Data["optHandlerIds"]="";
		node.Data["optHandlerNames"]="";
		node.Data["optHandlerSelectType"]="org";
		node.Data["orgAttributes"]="handlerIds:handlerNames;optHandlerIds:optHandlerNames;otherCanViewCurNodeIds:otherCanViewCurNodeNames";
		node.Data["recalculateHandler"]="false";
		node.Data["useOptHandlerOnly"]="false";
		node.Data["dayOfNotify"]="0";
		node.Data["dayOfPass"]="0";
		node.Data["hourOfNotify"]="0";
		node.Data["hourOfPass"]="0";
		node.Data["hourOfTranNotifyDraft"]="0";
		node.Data["hourOfTranNotifyPrivate"]="0";
		node.Data["minuteOfNotify"]="0";
		node.Data["minuteOfPass"]="0";
		node.Data["minuteOfTranNotifyDraft"]="0";
		node.Data["minuteOfTranNotifyPrivate"]="0";
		node.Data["tranNotifyDraft"]="0";
		node.Data["tranNotifyPrivate"]="0";
	}
	
	function initCommonNodeData(node,data){
		node.Data["handlerSelectType"]="org";
		node.Data["handlerNames"]="";
		node.Data["handlerIds"]="";
		node.Data["ignoreOnHandlerEmpty"]="false";
		var langsValue = _getNodeNameLang(node.Type);
		var nodeLangs={};
		nodeLangs["nodeName"]=langsValue;
		nodeLangsStr=JSON.stringify(nodeLangs);
		if(nodeLangsStr){
			node.Data["langs"]=nodeLangsStr;
		}
		node.Data["orgAttributes"]="handlerIds:handlerNames;optHandlerIds:optHandlerNames;otherCanViewCurNodeIds:otherCanViewCurNodeNames";
	}
	
	function _getNodeNameLang(nodeType){
		//[{lang:"zh-CN","value":""},{lang:"en-US","value":""}]
		var elLang=[];
		if(!_isLangSuportEnabled){
			return elLang;
		}
		if(!(typeof _allNodeName == "undefined" || _allNodeName==null)){
			elLang = _allNodeName[nodeType];
		}
		return elLang;
	}
	
	FlowChartObject.Nodes.createNodeInFreeFlow = createNodeInFreeFlow;
	FlowChartObject.Nodes.initNodeDataInFreeFlow = initNodeDataInFreeFlow;
	
	// 自由流快捷删除节点
	function deleteNodeInFreeFlow(obj,isMobile){
		if(FlowChartObject.Mode.Current.Type!="normal"){
			return;
		}
		var preNode = obj.LineIn[0].StartNode;
		//整理连线和关联信息
		if(obj.Name=="Node"){
			if(obj.LineOut.length==1){
				var endNode = obj.LineOut[0].EndNode;
				for(var j=obj.LineIn.length-1; j>=0; j--){
					var line = obj.LineIn[j];
					if(FlowChartObject.Rule.CheckLinkBetween(line.StartNode, endNode, line)){
						line.LinkNode(null, endNode, null, obj.LineOut[0].Data.endPosition);
						line.Refresh();
					}
				}
			}
		}
		//删除
		obj.Delete();
		FlowChartObject.Mode.RefreshOptPoint();
		//往上挪动节点
		moveAllNextNodeUp(preNode.LineOut[0]);
		//删除节点后自动选中被删除节点的上一节点
		if (!isMobile) {
			FlowChartObject.SelectElement(preNode,true,true);
		}
		//preNode.ShowAttributePanel();
	}
	
	FlowChartObject.Nodes.deleteNodeInFreeFlow = deleteNodeInFreeFlow;
	
	// 向上挪节点（自由流）
	function moveAllNextNodeUp(lineObj){
		if(!lineObj){
			return;
		}
		var lineEndNode = lineObj.EndNode;
		if (lineEndNode.Type != "endNode") {
			lineEndNode.MoveTo(lineEndNode.Data.x, lineEndNode.DOMElement.trans.y - GRID_SIZE*2, true);
			moveAllNextNodeUp(lineObj.EndNode.LineOut[0]);
		} else {
			lineEndNode.MoveTo(lineEndNode.Data.x, lineEndNode.DOMElement.trans.y - GRID_SIZE*2, true);
		}
	}

	// 向下挪节点（自由流）
	function moveAllNextNodeDown(lineObj){
		if(!lineObj){
			return;
		}
		var lineEndNode = lineObj.EndNode;
		if (lineEndNode.Type != "endNode") {
			if ((lineEndNode.LineOut.length > 0) && (Math.abs(lineEndNode.LineOut[0].Points[1].y - lineEndNode.LineOut[0].Points[0].y) < GRID_SIZE*4)) {
				moveAllNextNodeDown(lineObj.EndNode.LineOut[0]);
			}
			lineEndNode.MoveTo(lineEndNode.Data.x, lineEndNode.DOMElement.trans.y + GRID_SIZE*4, true);
		} else {
			lineEndNode.MoveTo(lineEndNode.Data.x, lineEndNode.DOMElement.trans.y + GRID_SIZE*4, true);
		}
	}

	
	/**
	 * 创建一个角色组
	 * @returns
	 */
	function createRoleGroup(){
		var group=FlowChartObject.SVG.Lane.Roles.group();
		return group;
	}
	/**
	 * 创建一个阶段组
	 * @returns
	 */
	function createStageGroup(){
		var group=FlowChartObject.SVG.Lane.Stages.group();
		return group;
	}
	/**
	 * 创建一个操作线组
	 * @returns
	 */
	function createLaneLineGroup(){
		var group=FlowChartObject.SVG.Lane.Lines.group();
		return group;
	}
	/**
	 * 在画布上绘画一条角色泳道
	 */
	FlowChartObject.Lane.Roles.CreateRoleDOM=function(obj){
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);

		var group = createRoleGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;
		group.rect(obj.Data.width,GRID_SIZE).attr("fill", "#f5f5f5").attr("stroke", "#D4D4DC").attr("stroke-width", "1");
		group.rect(obj.Data.width,obj.Data.height).attr("fill", "rgba(0,0,0,0)").attr("y",GRID_SIZE).attr("stroke-width", "1").attr("stroke", "#D4D4DC");
				
		// create text
		var text = group.text(obj.Data.text).attr("class", "round_nodetb text").fill(
					'#000000').cx(obj.Data.width/2+GRID_SIZE).y(5).click(function(e){
						if(FlowChartObject.IsEdit){
							dblclickText(e,this);
						}
						
					});
		text.font( {
			size : 12,
			anchor: 'middle'
		});
		//编辑状态下才生成删除按钮
		if(FlowChartObject.IsEdit){
			group.image('../images/laneDelete.png',20,20).style('cursor', 'pointer').attr("x", 6).attr("y", obj.Data.y).click(function(){
				obj.Del();
			});
			text.style('cursor', 'pointer');
		}
		obj.DOMText = text;
		
		var WResize=new Object();
		WResize.Name="w-resize";
		WResize.Role=obj;
		WResize.Point={x1:0,y1:0,x2:0,y2:obj.Data.height};
		var w_resize=createLaneLineGroup();
		//拖拽操作线
		WResize.DOMLine=w_resize.line(WResize.Point.x1,WResize.Point.y1,WResize.Point.x2,WResize.Point.y2).attr({
		    stroke: "rgba(0,0,0,0)",//red,rgba(0,0,0,0)
		    "stroke-width": 10,	
		});
		if(FlowChartObject.IsEdit){
			w_resize.style({
				cursor:"w-resize",
			});
		}
		
		
		WResize.DOMElement=w_resize;
		w_resize.node.LKSObject=WResize;
		
		obj.DOMLine=w_resize;
		
			
	}
	//在画布上绘制一条阶段泳道
	FlowChartObject.Lane.Stages.CreateStageDOM=function(obj){
		if (obj.DOMElement != null)
			FlowChartObject.RemoveElement(obj.DOMElement);

		var group = createStageGroup();
		group.node.LKSObject = obj;
		obj.DOMElement = group;
		group.rect(GRID_SIZE,obj.Data.height).attr("fill", "#f5f5f5").attr("stroke", "#D4D4DC").attr("stroke-width", "1");//泳道头部
		group.rect(obj.Data.width,obj.Data.height).attr("fill", "rgba(0,0,0,0)").attr("x", obj.Data.x+GRID_SIZE).attr("stroke", "#D4D4DC").attr("stroke-width", "1");//泳道身体
			
		// create text
		var text = group.text(obj.Data.text).attr("class", "round_nodetb text").x(7).y(obj.Data.height/2).fill(
					'#000000').click(function(e){
						if(FlowChartObject.IsEdit){
							dblclickText(e,this);
						}
						
					});//.attr("transform","rotate(90 ,"+10+","+obj.Data.height/2+")")
		text.style({
			"writing-mode":"tb-rl",
		});
		text.font( {
			size : 12,
			anchor: 'middle'
		});
		//编辑状态
		if(FlowChartObject.IsEdit){
			//泳道删除按钮
			group.image('../images/laneDelete.png',20,20).style('cursor', 'pointer').attr("y", 6).attr("x", obj.Data.x).click(function(){
				obj.Del(obj);
			});
			text.style('cursor', 'pointer');
		}
		obj.DOMText = text;	
		
		var SResize=new Object();
		SResize.Name="s-resize";
		SResize.Stage=obj;
		SResize.Point={x1:0,y1:0,x2:obj.Data.width,y2:0};
		//拖拽操作线
		var s_resize=createLaneLineGroup();
		SResize.DOMLine=s_resize.line(SResize.Point.x1,SResize.Point.y1,SResize.Point.x2,SResize.Point.y2).attr({
		    stroke: "rgba(0,0,0,0)",//blue,rgba(0,0,0,0)
		    "stroke-width": 10,	
		});
		if(FlowChartObject.IsEdit){
			s_resize.style({
				cursor:"s-resize",
			});
		}
		
		SResize.DOMElement=s_resize;
		s_resize.node.LKSObject=SResize;
		
		obj.DOMLine=s_resize;
	}
	//缓存选中的标题
	FlowChartObject.Lane.SelectedText=null;
	/**
	 * 泳道标题双击事件函数
	 * @param e 事件对象
	 * @param obj 调用事件的对象
	 * @returns
	 */
	function dblclickText(e,obj){
		//将选中的泳道名称放到缓存中
		FlowChartObject.Lane.SelectedText=obj;
		//console.log(e.pageX+"+"+e.pageY);
		var vRName=$("#rName");
		var vWidth=vRName.width();
		var vHeight=vRName.height();
		var x=e.pageX-vWidth/2;
		if(FlowChartObject.Lane.SelectedText.parent.node.LKSObject.Name=="Stage"){
			//当调用对象为阶段泳道时让编辑框显示在最左边
			x=0;
		}
		var y=e.pageY-vHeight/2;
		vRName.show();
		vRName.offset({left:x,top:y});//将编辑框移动到泳道标题附近		
		vRName.val(obj.text());
		vRName.focus();
		vRName.blur(function(event) {
			if(FlowChartObject.Lane.SelectedText){
				setText(this);
			}
			
        });
		vRName.keydown(function(event) {    
            if (event.keyCode == 13) {
            	if(FlowChartObject.Lane.SelectedText){
            		setText(this);
            	}
            }    
        }); 				
	}
	/**
	 * 设置泳道标题文本
	 * @param obj 编辑标题的文本框
	 * @returns
	 */
	function setText(obj){
		if($(obj).val()!=""){
			FlowChartObject.Lane.SelectedText.parent.node.LKSObject.SetText($(obj).val());
		}
		//完成泳道赋值后清除缓存
    	FlowChartObject.Lane.SelectedText=null;
    	$(obj).val("");
    	$(obj).hide();
	}
	
	/**
	 * 根据坐标变更线的位置
	 */
	FlowChartObject.MoveLineByPoint=function(lineDom,point){
		lineDom.plot(point.x1,point.y1,point.x2,point.y2);
	}
	//变更角色泳道宽度
	FlowChartObject.SetLaneRoleWidth=function(obj){

		obj.DOMElement.children()[0].attr("width",obj.Data.width);
		obj.DOMElement.children()[1].attr("width",obj.Data.width);
		obj.DOMText.cx(obj.Data.width/2);
		
	}
	//刷新所有角色泳道高度
	FlowChartObject.RefreshAllLaneRoleHeight=function(){
		var newHeight=0;
		var i=0;
		//有阶段泳道时角色泳道按阶段泳道的总高度计算
		if(FlowChartObject.Lane.Stages.all.length>0){
			for(i=0;i<FlowChartObject.Lane.Stages.all.length;i++){
				newHeight+=FlowChartObject.Lane.Stages.all[i].Data.height;
			}	
		}
		else if(FlowChartObject.Nodes.all.length>0){
			//无阶段泳道时高度用节点中Y坐标最大的数值做为高度
			var max_y=0;
			for(i=0;i<FlowChartObject.Nodes.all.length;i++){
				if(max_y<FlowChartObject.Nodes.all[i].Data.y){
					max_y=FlowChartObject.Nodes.all[i].Data.y;
				}
			}
			newHeight=max_y+GRID_SIZE*2;
		}
		else{
			//没有节点和阶段泳道时，使用画布的高度作为角色泳道的高度
			newHeight=FlowChartObject.SVG.BoxHeight;
		}
		//更新所有角色泳道的高度
		for(i=0;i<FlowChartObject.Lane.Roles.all.length;i++){
			var obj=FlowChartObject.Lane.Roles.all[i];
			obj.Data.height=newHeight;
			obj.DOMElement.children()[1].attr("height",obj.Data.height);
			//更新操作线长度
			obj.DOMLine.node.LKSObject.Point.y2=obj.Data.height+GRID_SIZE;
			FlowChartObject.MoveLineByPoint(obj.DOMLine.node.LKSObject.DOMLine,obj.DOMLine.node.LKSObject.Point);
		}			
	}
	//变更阶段泳道高度
	FlowChartObject.SetLaneStageHeight=function(obj){
		obj.DOMElement.children()[0].attr("height",obj.Data.height);
		obj.DOMElement.children()[1].attr("height",obj.Data.height);
		obj.DOMText.cy(obj.Data.height/2+20);//.move(2, obj.Data.height/2);
	}
	FlowChartObject.RefreshAllLaneStageHeight=function(){
		var newWidth=0;
		var i=0;
		//当存在角色泳道时，阶段泳道的宽度设置为所有角色泳道宽度的总和
		if(FlowChartObject.Lane.Roles.all.length>0){
			for(i=0;i<FlowChartObject.Lane.Roles.all.length;i++){
				newWidth+=FlowChartObject.Lane.Roles.all[i].Data.width;
			}
		}
		else if(FlowChartObject.Nodes.all.length>0){
			//获取x坐标最大的节点的坐标作为阶段泳道的宽度
			var max_x=0;
			for(i=0;i<FlowChartObject.Nodes.all.length;i++){
				if(max_x<FlowChartObject.Nodes.all[i].Data.x){
					max_x=FlowChartObject.Nodes.all[i].Data.x;
				}
			}
			newWidth=max_x+GRID_SIZE*3;
		}
		else{
			//没有节点和角色泳道时，使用画布的宽度作为阶段泳道的高度
			newWidth=FlowChartObject.SVG.BoxWidth;
		}
		for(i=0;i<FlowChartObject.Lane.Stages.all.length;i++){
			var obj=FlowChartObject.Lane.Stages.all[i];
			obj.Data.width=newWidth;
			obj.DOMElement.children()[1].attr("width",obj.Data.width);
			//更新操作线长度
			obj.DOMLine.node.LKSObject.Point.x2=obj.Data.width+GRID_SIZE;
			FlowChartObject.MoveLineByPoint(obj.DOMLine.node.LKSObject.DOMLine,obj.DOMLine.node.LKSObject.Point);
		}
		
	}
	/**
	 * 泳道：根据泳道的坐标刷新角色泳道的位置
	 */
	FlowChartObject.Lane.Roles.Refresh=function(role){
		//移动泳道至指定坐标位置
		FlowChartObject.SetPosition(role.DOMElement,role.Data.x,role.Data.y);
		//移动操作线的位置
		FlowChartObject.SetPosition(role.DOMLine,(role.Data.x+role.Data.width),role.Data.y);
		var roleAddButton=FlowChartObject.Lane.Roles.RoleAddButton;
		roleAddButton.X+=role.Data.width;
		//角色添加完成后移动增加按钮按钮，始终将自己保持在最后一个泳道的后面
		FlowChartObject.SetPosition(roleAddButton.DOMElement,roleAddButton.X,roleAddButton.Y);
	}
	/**
	 * 泳道：根据泳道的坐标刷新阶段泳道的位置
	 */
	FlowChartObject.Lane.Stages.Refresh=function(stage){
		//将泳道添加至队列的最后
		FlowChartObject.SetPosition(stage.DOMElement,stage.Data.x,stage.Data.y); 
		//移动操作线的位置
		FlowChartObject.SetPosition(stage.DOMLine,stage.Data.x,(stage.Data.y+stage.Data.height));
		//角色添加完成后移动按钮，始终将自己保持在最后一个泳道的后面
		var stageAddButton=FlowChartObject.Lane.Stages.StageAddButton;
		stageAddButton.Y+=stage.Data.height; 
		FlowChartObject.SetPosition(stageAddButton.DOMElement,stageAddButton.X,stageAddButton.Y);
	}
})(FlowChartObject);