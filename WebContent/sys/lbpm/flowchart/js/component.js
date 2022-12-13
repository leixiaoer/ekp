/**********************************************************
功能：流程图节组件对象（节点、连线、拐点）定义
使用：
	作为流程图组件的一部分，由panel.js自动引入
必须需要扩展的功能：
	FlowChartObject.Nodes.InitializeTypes（节点类型的声明）
作者：叶中奇
创建时间：2008-05-05
修改记录：
**********************************************************/

//====================节点全局对象====================
FlowChartObject.Nodes.all = new Array();				//节点索引
FlowChartObject.Nodes.Index = 0;						//节点流水号
FlowChartObject.Nodes.Types = new Object();				//所有节点类型
FlowChartObject.Nodes.InfoBox = new Object();			//详细信息框
FlowChartObject.Nodes.InfoBox.Current = null;			//当前显示的对象
FlowChartObject.Nodes.InfoBox.Main = null;				//详细信息框主体DOM模型
FlowChartObject.Nodes.InfoBox.Text = null;				//详细信息框文本DOM模型
FlowChartObject.Nodes.InfoBox.TimeoutId = 0;			//详细信息延时加载的timeoutid

//====================连线全局对象====================
FlowChartObject.Lines.all = new Array();				//连线索引
FlowChartObject.Lines.Index = 0;						//节点流水号
FlowChartObject.Lines.OptLine = null;					//操作连线

//====================操作点全局对象====================
FlowChartObject.Points.LinePoint = new Array();			//连线的操作点
FlowChartObject.Points.NodePoint = null;				//节点的操作点

//====================泳道图全局操作对象================
FlowChartObject.Lane.Roles.all = new Array();			//角色索引
FlowChartObject.Lane.Roles.Index=0;                     //角色流水号
FlowChartObject.Lane.Roles.RoleAddButton= new Object(); //角色添加按钮

FlowChartObject.Lane.Stages.all = new Array();			//阶段索引
FlowChartObject.Lane.Stages.Index=0;
FlowChartObject.Lane.Stages.StageAddButton= new Object(); //角色添加按钮

/**
 * 检查节点是否覆盖到了角色泳道线，并返回修正后的X坐标
 */
FlowChartObject.Lane.Roles.CheckNodeX=function(nodeX,nodeWidth){
	var result=nodeX;
	if (nodeX < 0) {
		return result;
	}
	//没有泳道阻止节点 出X轴操出左边边线
	if((GRID_SIZE-(nodeX-nodeWidth/2))>=0){
		result=GRID_SIZE+nodeWidth/2;
	}
	if(FlowChartObject.Lane.Roles.all.length>0){
		for(i=0;i<FlowChartObject.Lane.Roles.all.length;i++){
			var tempNum=FlowChartObject.Lane.Roles.all[i].Data.x-nodeX;
			if(tempNum<nodeWidth / 2&&tempNum>=0){
				result=nodeX-(nodeWidth / 2-tempNum);
			}
			if(tempNum>-(nodeWidth / 2)&&tempNum<0){
				result=nodeX+(nodeWidth / 2+tempNum)
			}
			//计算超出第一条角色泳道的节点
			if(i==0){
				if(tempNum>=0){
					result=FlowChartObject.Lane.Roles.all[i].Data.x+nodeWidth/2;
				}
			}
			//计算超出最后一条角色泳道的节点
			if(i==(FlowChartObject.Lane.Roles.all.length-1)){
				tempNum=FlowChartObject.Lane.Roles.all[i].Data.x+FlowChartObject.Lane.Roles.all[i].Data.width-nodeX;
				if(tempNum<nodeWidth / 2&&tempNum>=0){
					result=nodeX-(nodeWidth / 2-tempNum);
				}
				if(tempNum>-(nodeWidth / 2)&&tempNum<0){
					result=nodeX+(nodeWidth / 2+tempNum)
				}
			}
			
		}
	}
	return result;
}
/**
 * 检查节点是否覆盖到了阶段泳道线，并返回修正后的Y坐标
 */
FlowChartObject.Lane.Stages.CheckNodeY=function(nodeY,nodeHeight){
	var result=nodeY;
	if (nodeY < 0) {
		return result;
	}
	//没有泳道时阻止节点 出y轴操出上边边线
	if((GRID_SIZE-(nodeY-nodeHeight/2))>=0){
		result=GRID_SIZE+nodeHeight/2;
	}
	if(FlowChartObject.Lane.Stages.all.length>0){
		for(i=0;i<FlowChartObject.Lane.Stages.all.length;i++){
			var tempNum=FlowChartObject.Lane.Stages.all[i].Data.y-nodeY;
			if(tempNum>=0&&tempNum<(nodeHeight / 2)){
				result=nodeY-(nodeHeight / 2-tempNum);
			}
			if(tempNum<0&&tempNum>-(nodeHeight / 2)){
				result=nodeY+(nodeHeight / 2+tempNum);
			}
			//计算超出第一条阶段泳道的节点
			if(i==0){
				if(tempNum>=0){
					result=FlowChartObject.Lane.Stages.all[i].Data.y+nodeHeight/2;
				}
			}
			//计算超出最后一条阶段泳道的节点
			if(i==(FlowChartObject.Lane.Stages.all.length-1)){
				tempNum=FlowChartObject.Lane.Stages.all[i].Data.y+FlowChartObject.Lane.Stages.all[i].Data.height-nodeY;
				if(tempNum<nodeHeight / 2&&tempNum>=0){
					result=nodeY-(nodeHeight / 2-tempNum);
				}
				if(tempNum>-(nodeHeight / 2)&&tempNum<0){
					result=nodeY+(nodeHeight / 2+tempNum)
				}
			}
		}
	}
	return result;
}
/**
 * 创建泳道图的角色泳道
 */
FlowChartObject.Lane.Roles.Create=function (data){	
	var role = new FlowChartObject_Lane_Role(data);	
	FlowChartObject.Lane.Roles.Refresh(role);
	return role;	
}
/**
 * 将对象中的指定属性从字符串转换为int类型
 * @param data data对象
 * @returns 返回data
 */
function FlowChartObject_Lane_Format_Data(data){
	data.order=parseInt(data.order);
	data.width=parseInt(data.width);
	data.height=parseInt(data.height);
	data.x=parseInt(data.x);
	data.y=parseInt(data.y);
	return data;
}
function FlowChartObject_Lane_Role(data){	
	this.Name="Role";//元素类型
	this.DOMElement=null;//泳道图形的Dom对象
	this.DOMText=null;//泳道图内文字对象
	this.DOMLine=null;//操作线
	if(data==null){
		var Roles_Length=FlowChartObject.Lane.Roles.all.length;
		this.Data=new Object();
		this.Data.id="R"+(++FlowChartObject.Lane.Roles.Index);//泳道ID
		this.Data.XMLNODENAME="laneRole";
		this.Data.text=this.Data.id+FlowChartObject.Lang.Role;//泳道名字
		this.Data.order=Roles_Length;//泳道的排序号
		this.Data.width=GRID_SIZE*15;//泳道宽度
		this.Data.height=0;//泳道高度
		this.Data.x=GRID_SIZE;//泳道X坐标的设置
		this.Data.y=0;//泳道的Y坐标
		if(Roles_Length!=0){
			for(var i=0;i<Roles_Length;i++){
				this.Data.x+=FlowChartObject.Lane.Roles.all[i].Data.width;
			}
		}
	}
	else{
		//由于XML转换的对象属性都是字符串的，需要将属性还原成原来的类型
		this.Data=FlowChartObject_Lane_Format_Data(data);		
	}
	this.Del=FlowChart_Lane_Role_Del;//删除泳道
	this.GetXMLString=FlowChart_Lane_GetXMLString;//将泳道转化为XML字符串
	this.SetText=FlowChart_Lane_SetText;//设置泳道的标题文本
	this.Move=FlowChart_Lane_Move;//泳道移动
	this.SetWidth=FlowChart_Lane_Role_SetWidth;
	
	FlowChartObject.Lane.Roles.CreateRoleDOM(this);
	FlowChartObject.Lane.Roles.all.push(this);
	
}
function FlowChart_Lane_Role_SetWidth(newWidth){
	this.Data.width=newWidth;
	FlowChartObject.SetLaneRoleWidth(this);
	FlowChartObject.SetPosition(this.DOMLine,(this.Data.x+this.Data.width),this.Data.y);
}
/**
 * 移动泳道
 * @param x
 * @param y
 * @returns
 */
function FlowChart_Lane_Move(x,y){
	this.Data.x=x;
	this.Data.y=y;
	FlowChartObject.SetPosition(this.DOMElement,this.Data.x,this.Data.y);
	if(this.Name=="Role"){
		FlowChartObject.SetPosition(this.DOMLine,(this.Data.x+this.Data.width),this.Data.y);
	}
	if(this.Name=="Stage"){
		FlowChartObject.SetPosition(this.DOMLine,this.Data.x,(this.Data.y+this.Data.height));
	}
	
}
/**
 * 设置泳道标题
 * @param text
 * @returns
 */
function FlowChart_Lane_SetText(text){
	this.Data.text=text;
	this.DOMText.text(this.Data.text);
}
/**
 * 删除角色泳道
 * @param obj
 * @returns
 */
function FlowChart_Lane_Role_Del(obj){
	//更新泳道位置和坐标
	var rolesAll=FlowChartObject.Lane.Roles.all;
	for(var i=0;i<rolesAll.length;i++){
		if((this.Data.order+1)==rolesAll[i].Data.order){
			var new_x=rolesAll[i].Data.x-this.Data.width;
			rolesAll[i].Move(new_x,rolesAll[i].Data.y);
			rolesAll[i].SetWidth((this.Data.width+rolesAll[i].Data.width));
		}					
	}
	if((this.Data.order+1)==rolesAll.length){
		//更新新增按钮位置，保持自己始终在最后一个泳道后面
		var roleAddButton=FlowChartObject.Lane.Roles.RoleAddButton;
		roleAddButton.X=roleAddButton.X-this.Data.width;
		FlowChartObject.SetPosition(roleAddButton.DOMElement,roleAddButton.X,roleAddButton.Y);
	}
	
	//从队列和流程图中删除泳道
	FlowChartObject.RemoveElement(this.DOMElement);
	FlowChartObject.RemoveElement(this.DOMLine);
	FlowChartObject.Lane.Roles.all = Com_ArrayRemoveElem(FlowChartObject.Lane.Roles.all, this);
	
	//删除成功后重置队列中的排序标记
	for(var i=0;i<FlowChartObject.Lane.Roles.all.length;i++){
		FlowChartObject.Lane.Roles.all[i].Data.order=i;
	}
	
	//刷新泳道角色高度和阶段高度
	FlowChartObject.RefreshAllLaneRoleHeight();
	FlowChartObject.RefreshAllLaneStageHeight();
			
}
//生成泳道的xml信息
function FlowChart_Lane_GetXMLString(){
	return WorkFlow_BuildXMLString(this.Data,this.Data.XMLNODENAME);
}
/**
 * 创建泳道图的阶段泳道
 */
FlowChartObject.Lane.Stages.Create=function (data){
	
	var stage = new FlowChartObject_Lane_Stage(data);//泳道图对象				
	FlowChartObject.Lane.Stages.Refresh(stage);
	return stage;
	
}
function FlowChartObject_Lane_Stage(data){	
	this.Name="Stage";//元素类型
	this.DOMElement=null;//泳道的dom对象
	this.DOMText=null;//泳道的文字对象
	this.DOMLine=null;//操作线
	if(data==null){
		var Stage_Length=FlowChartObject.Lane.Stages.all.length;
		this.Data=new Object();
		this.Data.id="S"+(++FlowChartObject.Lane.Stages.Index);//泳道ID
		this.Data.XMLNODENAME="laneStage";
		this.Data.text=this.Data.id+FlowChartObject.Lang.Step;//泳道名称
		this.Data.order=Stage_Length;//泳道排序编号
		this.Data.width=0;//泳道宽度
		this.Data.height=GRID_SIZE*15;//泳道高度	
		this.Data.x=0;//泳道X坐标
		this.Data.y=GRID_SIZE;//泳道Y坐标
		if(Stage_Length!=0){
			for(var i=0;i<Stage_Length;i++){
				this.Data.y+=FlowChartObject.Lane.Stages.all[i].Data.height;
			}	
		}
	}
	else{
		//由于XML转换的对象属性都是字符串的，需要将属性还原成原来的类型
		this.Data=FlowChartObject_Lane_Format_Data(data);		
	}
	this.Del=FlowChart_Lane_Stage_Del;//泳道的删除方法
	this.GetXMLString=FlowChart_Lane_GetXMLString;//将泳道转化为XML字符串
	this.SetText=FlowChart_Lane_SetText;//设置文本
	this.Move=FlowChart_Lane_Move;//泳道移动
	this.SetHeight=FlowChart_Lane_Stage_SetHeight;
	
	FlowChartObject.Lane.Stages.CreateStageDOM(this);
	FlowChartObject.Lane.Stages.all.push(this);

	
}
/**
 * 设置阶段泳道高度
 * @param newHeight
 * @returns
 */
function FlowChart_Lane_Stage_SetHeight(newHeight){
	this.Data.height=newHeight;
	FlowChartObject.SetLaneStageHeight(this);
	FlowChartObject.SetPosition(this.DOMLine,this.Data.x,(this.Data.y+this.Data.height));	
}
//删除阶段泳道
function FlowChart_Lane_Stage_Del(obj){
	var stagesAll=FlowChartObject.Lane.Stages.all;
	//更新泳道位置和坐标
	for(var i=0;i<stagesAll.length;i++){
		if(this.Data.order<stagesAll[i].Data.order){
			if((this.Data.order+1)==stagesAll[i].Data.order){
				var new_y=stagesAll[i].Data.y-obj.Data.height;
				stagesAll[i].Move(stagesAll[i].Data.x,new_y);
				stagesAll[i].SetHeight(this.Data.height+stagesAll[i].Data.height);
			}
			
		}					
	}
	if((this.Data.order+1)==stagesAll.length){
		//更新新增按钮位置，保持自己始终在最后一个泳道后面
		var stageAddButton=FlowChartObject.Lane.Stages.StageAddButton;
		stageAddButton.Y=stageAddButton.Y-obj.Data.height;
		FlowChartObject.SetPosition(stageAddButton.DOMElement,stageAddButton.X,stageAddButton.Y);
	}
	
	//从画布中删除泳道
	FlowChartObject.RemoveElement(obj.DOMElement);
	//删除操作线
	FlowChartObject.RemoveElement(obj.DOMLine);
	//从队列和流程图中删除泳道
	FlowChartObject.Lane.Stages.all = Com_ArrayRemoveElem(FlowChartObject.Lane.Stages.all, obj);
	
	//删除成功后重置队列中的排序标记
	for(var i=0;i<FlowChartObject.Lane.Stages.all.length;i++){
		FlowChartObject.Lane.Stages.all[i].Data.order=i;
	}
	//刷新泳道角色高度和阶段高度
	FlowChartObject.RefreshAllLaneRoleHeight();
	FlowChartObject.RefreshAllLaneStageHeight();
			
}

//====================节点全局操作====================
//功能：节点初始化操作，创建详细显示框的HTML对象
FlowChartObject.Nodes.InitializeTypes = []; // 节点初始化注册队列
FlowChartObject.Nodes.Initialize = function(){
	//初始化节点类型
	for (var i = 0; i < FlowChartObject.Nodes.InitializeTypes.length; i ++) {
		FlowChartObject.Nodes.InitializeTypes[i]();
	}

	//初始化详细信息框
	var newElem = document.createElement("table");
	newElem.className = "nodeinfo_tb reset_width_height";
	newElem.style.position = "absolute";
	newElem.style.display = "none";
	newElem.insertRow(-1).insertCell(-1);
	document.body.appendChild(newElem);
	FlowChartObject.Nodes.InfoBox.Main = newElem;
	FlowChartObject.Nodes.InfoBox.Text = newElem.rows[0].cells[0];
	
	if (Com_IsFreeFlow()) {
		//初始化右侧节点面板
		var nodePanel = document.createElement("div");
		nodePanel.id = "nodePanel";
		nodePanel.style.position = "fixed";
		nodePanel.style.right = "0px";
		nodePanel.style.top = "0px";
		nodePanel.style.height = "100%";
		nodePanel.style.zIndex = "6";
		nodePanel.style.width = "420px";
		nodePanel.style.border = "1px solid #C0C0C0";
		nodePanel.style.backgroundColor = "#f6f6f6";
		nodePanel.style.display = "none";
		document.body.appendChild(nodePanel);
		$('<iframe id="iframe_node" width="100%" height="100%" frameborder="0"></iframe>').prependTo(nodePanel);
	}
};

//功能：根据ID查找对象
FlowChartObject.Nodes.GetNodeById = function(id){
	for(var i=0; i<FlowChartObject.Nodes.all.length; i++) {
		if(id==FlowChartObject.Nodes.all[i].Data.id){
			return FlowChartObject.Nodes.all[i];
		}
	}
	return null;
};

//功能：隐藏详细信息
FlowChartObject.Nodes.InfoBox.Hide = function(){
	if(FlowChartObject.Nodes.InfoBox.TimeoutId!=0){
		clearTimeout(FlowChartObject.Nodes.InfoBox.TimeoutId);
		FlowChartObject.Nodes.InfoBox.TimeoutId = 0;
	}
	if (FlowChartObject.Nodes.InfoBox.Current != null 
			&& FlowChartObject.Nodes.InfoBox.Current.ShowDetailAfter != null) {
		FlowChartObject.Nodes.InfoBox.Current.ShowDetailAfter(false);
	}
	FlowChartObject.Nodes.InfoBox.Main.style.display = "none";
	FlowChartObject.Nodes.InfoBox.Current = null;
};

FlowChartObject.Nodes.Color = {
	c:[0xFF, 0xFF, 0xFF],
	d:[10, 25, 40],
	Get:function(){
		var color = "#";
		var c = FlowChartObject.Nodes.Color.c;
		var d = FlowChartObject.Nodes.Color.d;
		var n = 0xB2;
		for(var i=0; i<3; i++){
			c[i]-=d[i];
			if(c[i]<n)
				c[i]+=0xFF-n;
			color += c[i].toString(16);
		}
		return color;
	}
};

FlowChartObject.Nodes.RelateNodes = function(nodes){
	var color = FlowChartObject.Nodes.Color.Get();
	for(var i=0; i < nodes.length; i++){
		nodes[i].RelatedNodes = new Array();
		var ids = "";
		for(var j=0; j < nodes.length; j++){
			if(i==j)
				continue;
			ids += ";" + nodes[j].Data.id;
			nodes[i].RelatedNodes[nodes[i].RelatedNodes.length] = nodes[j];
		}
		nodes[i].Data.relatedNodeIds = ids.substring(1);
		FlowChartObject.SetFillcolor(nodes[i].DOMElement, color);
	}
}

FlowChartObject.Nodes.RefreshAllRelatedNodes = function(){
	for(var i=0; i<FlowChartObject.Nodes.all.length; i++){
		var node = FlowChartObject.Nodes.all[i];
		if(node.Data.relatedNodeIds==null){
			if(node.RelatedNodes.length>0){
				node.RelatedNodes = new Array();
			}
		}else{
			if(node.RelatedNodes.length==0){
				var nodes = new Array();
				var idArr = node.Data.relatedNodeIds.split(";");
				nodes[0] = node;
				for(var i=0; i<idArr.length; i++){
					var rNode = FlowChartObject.Nodes.GetNodeById(idArr[i]);
					if(rNode==null)
						continue;
					nodes[nodes.length] = rNode;
				}
				if(nodes.length==1)
					node.Data.relatedNodeIds = null;
				else
					FlowChartObject.Nodes.RelateNodes(nodes);
			}
		}
	}
}

//====================节点类型对象类====================
function FlowChart_NodeType(type){
	this.Type = type;
	this.Name = FlowChartObject.Lang.Operation.Text.ChangeMode[type];
	this.Hotkey = null;										//热键
	this.ShowInOperation = true;							//是否显示在菜单中
	this.Initialize = null;									//初始化方法，必须定义
	this.CreateNode = FlowChart_NodeType_CreateNode;		//创建该类型的节点
	this.ImgIndex = -1;  // 工具栏图标索引
	this.ImgUrl = null;  // 工具栏图标地址 和索引只能用其一
	this.ButtonIndex = 100;
	this.BackgroundImage = null; // 节点图标
	this.Cursor = null; // 鼠标手势图片地址
	this.Desc = FlowChartObject.NodeTypeDescs[FlowChartObject.NodeDescMap[type]];   //节点描述信息
	FlowChartObject.Nodes.Types[type] = this;
}
FlowChartObject.Nodes.NodeType = FlowChart_NodeType;

//通用的创建节点方法
function FlowChart_NodeType_CreateNode(){
	var node = new FlowChart_Node(this.Type);
	node.MoveTo(EVENT_X, EVENT_Y, true);
	FlowChart_NodeType_AutoLink(node);
}

function FlowChart_NodeType_AutoLink(sNode, eNode) {
	eNode = eNode || sNode;
	var line = FlowChart_Mode_Node_GetEventLineObject();
	if(line==null)
		return;
	//寻找合适的插入点
	var points = line.Points;
	var ps0 = new Array(points[0]);		//前面连线的坐标点
	for(var i=1; i<points.length-1; i++){
		//注意这里循环到points.length-1，是因为若节点不落在前面的线段上，肯定落在最后一条线段上
		var p0 = points[i-1];
		var p1 = points[i];
		if(FlowChart_Mode_IsThreePointsInOneLine(p0.x, p0.y, EVENT_X, EVENT_Y, p1.x, p1.y))
			break;
		ps0[i] = p1;
	}
	ps0[ps0.length] = {x:0, y:0};		//往前面的连线添加一个结束点
	p0 = ps0[ps0.length-2];				//记录最后一个中间点，方便计算连接结束位置
	var ps1 = new Array({x:0, y:0});	//后面连线的坐标点
	for(;i<points.length; i++)
		ps1[ps1.length] = points[i];
	p1 = ps1[1];						//记录第一个中间点，方便计算连接开始位置
	
	var endNode = line.EndNode;
	var endPositioin = line.Data.endPosition;
	//将当前的连线连到新建的节点
	line.LinkNode(null, sNode, null, sNode.GetClosestPoint(p0.x, p0.y).position, ps0);
	line.Refresh();
	//创建一条新的连线，当前节点和原结束节点
	line = new FlowChart_Line();
	line.LinkNode(eNode, endNode, eNode.GetClosestPoint(p1.x, p1.y).position, endPositioin, ps1);
	line.Refresh(FlowChartObject.LINE_REFRESH_TYPE_DOM);
}

FlowChartObject.Nodes.AutoLinkQuickBuild=FlowChart_NodeType_AutoLink_QuickBuild;
/**
 * 创建人：王祥
 * 创建时间：2017-10-25
 * 用于快捷操作新建节点链接线创建
 * @param sNode
 * @param eNode
 * @param sline
 * @returns
 */
function FlowChart_NodeType_AutoLink_QuickBuild(sNode, eNode,sline) {
	eNode = eNode || sNode;
	var line = sline;
	if(line==null)
		return;
	//寻找合适的插入点
	var points = line.Points;
	var ps0 = new Array(points[0]);		//前面连线的坐标点
	for(var i=1; i<points.length-1; i++){
		//注意这里循环到points.length-1，是因为若节点不落在前面的线段上，肯定落在最后一条线段上
		var p0 = points[i-1];
		var p1 = points[i];
		if(FlowChart_Mode_IsThreePointsInOneLine(p0.x, p0.y, EVENT_X, EVENT_Y, p1.x, p1.y))
			break;
		ps0[i] = p1;
	}
	ps0[ps0.length] = {x:0, y:0};		//往前面的连线添加一个结束点
	p0 = ps0[ps0.length-2];				//记录最后一个中间点，方便计算连接结束位置
	var ps1 = new Array({x:0, y:0});	//后面连线的坐标点
	for(;i<points.length; i++)
		ps1[ps1.length] = points[i];
	p1 = ps1[1];						//记录第一个中间点，方便计算连接开始位置
	
	var endNode = line.EndNode;
	var endPositioin = line.Data.endPosition;
	//将当前的连线连到新建的节点
	line.LinkNode(null, sNode, null, "1", ps0);
	line.Refresh();
	//创建一条新的连线，当前节点和原结束节点
	line = new FlowChart_Line();
	line.LinkNode(eNode, endNode, "3", endPositioin, ps1);
	line.Refresh(FlowChartObject.LINE_REFRESH_TYPE_DOM);
}

FlowChartObject.Nodes.AutoLink = FlowChart_NodeType_AutoLink;

//====================节点对象类====================
function FlowChart_Node(type, data){
	var _setLangs=function(d){
		if(_isLangSuportEnabled){
			var nameLangs = [];
			var langs =d.langs;
			if(typeof langs=="undefined"){
				var l = {};//如果没有第一次新建没有配置时，初始化
				if(typeof _allNodeName!="undefined"){
					nameLangs = _allNodeName[type]||[];
					l["nodeName"]=nameLangs;
					d.langs=JSON.stringify(l);
				}
			}
		}
	}

	var typeObj = FlowChartObject.Nodes.Types[type];
	//节点数据
	if(data==null){
		this.Data = new Object();
		this.Data.id = (FlowChartObject.IsEmbedded?"EN":"N")+(++FlowChartObject.Nodes.Index);
		this.Data.name = typeObj.Name;
		this.Data.x = 0;
		this.Data.y = 0;
		_setLangs(this.Data);//新建没有配置时，初始化
	}else{
		this.Data = data;
		FlowChart_Node_FormatData(data);
	}
	
	//==========属性==========
	this.Name = "Node";												//对象名称
	this.Type = type;												//类型
	this.TypeCode = FlowChartObject.NODETYPE_NORMAL;				//普通节点
	this.Text = "";													//节点文本
	this.Info = "";													//节点详细信息
	this.IsSelected = false;										//是否被选中
	this.CanDelete = true;											//是否可以被删除
	this.CanCopy = true;											//是否可以拷贝
	this.CanLinkOutCount = 1;										//是否可被接出的连线数
	this.CanLinkInCount = 2;										//是否可以接入的连线数
	this.CanChangeIn = true;										//是否可以修改流入
	this.CanChangeOut = true;										//是否可以修改流出
	this.Width = 0;													//节点宽度
	this.Height = 0;												//节点高度
	this.Status = FlowChartObject.STATUS_NORMAL;					//节点状态
	this.AttributePage = "/sys/lbpm/flowchart/page/node_attribute.jsp";				//节点属性配置页面
	this.AttributePanelPage = "/sys/lbpm/flowchart/page/node_attribute_panel.jsp";	//节点属性面板
	this.Desc = typeObj.Desc;   //节点描述信息
	this.Small_WidthRank=0;                                         //缩小宽度差值 0 为不缩小
	this.Small_HeightRank=0;
	this.Small_ImgageURL=null;
	this.IsCreateInThisTime = false;										//是否本次编辑添加的（自由流判断用）
	
	//==========子对象==========
	this.LineOut = new Array();										//起点为当前节点的连线
	this.LineIn = new Array();										//终点为当前节点的连线
	this.DOMElement = null;											//节点DOM模型
	this.DOMText = null;											//节点文本的DOM模型
	this.RelatedNodes = new Array();								//相关节点
	
	//==========方法==========
	this.MoveTo = FlowChart_Node_MoveTo;							//移动节点
	this.MoveBy = FlowChart_Node_MoveBy;							//移动节点
	this.Select = FlowChart_Node_Select;							//选中节点
	this.Show=FlowChart_Node_Show;                                  //设置节点的可见性（true：可见，false：隐藏）
	this.SetStatus = FlowChart_Node_SetStatus;						//设置状态
	this.ShowAttribute = FlowChart_Node_ShowAttribute;				//显示属性
	this.ShowAttributePanel = FlowChart_Node_ShowAttributePanel;	//显示属性面板
	this.ShowDetail = FlowChart_Node_ShowDetail;					//显示详细信息
	this.Delete = FlowChart_Node_Delete;							//删除节点
	this.AddLineOut = FlowChart_Node_AddLineOut;					//添加流出连线
	this.AddLineIn = FlowChart_Node_AddLineIn;						//添加流入连线
	this.DelLineOut = FlowChart_Node_DelLineOut;					//删除流出连线
	this.DelLineIn = FlowChart_Node_DelLineIn;						//删除流入连线
	this.GetPointByPosition = FlowChart_Node_GetPointByPosition;	//根据位置获取连接点
	this.GetClosestPoint = FlowChart_Node_GetClosestPoint;			//获取最靠近的连接点
	this.FormatXMLData = FlowChart_Node_FormatXMLData;				//格式化用于生成XML的数据
	this.GetXMLString = FlowChart_Node_GetXMLString;				//转换为XML信息
	this.Initialize = typeObj.Initialize;							//初始化
	this.Refresh = FlowChart_Node_Refresh;							//刷新显示信息，同时刷新详细信息
	this.RefreshInfo = Com_EmptyFunction;							//刷新详细信息
	this.ChangeIconType = null;										//切换大小图标
	this.Check = FlowChart_Node_Check;								//检查节点配置是否正确
	this.RefreshRefId = null;										//更新引用链接
	this.AddObjectData = FlowChart_Node_AddObjectData;				//供子窗口往节点属性传递对象
	this.AfterShow = null;
	
	//==========初始化==========
	FlowChartObject.Nodes.all[FlowChartObject.Nodes.all.length] = this;
	this.Initialize();
	this.Refresh();
	if(data!=null){
		this.MoveTo(this.Data.x, this.Data.y);
	}
}

//====================节点对象类使用函数====================
//功能：将节点移动到(x, y)点，同时更新节点的连线
//参数：toGrid：是否吸附到网格
function FlowChart_Node_MoveTo(x, y, toGrid){
	var i;
	if(toGrid){
		x = Math.round(x/GRID_SIZE)*GRID_SIZE;
		y = Math.round(y/GRID_SIZE)*GRID_SIZE;
		for(i=0; i<FlowChartObject.Nodes.all.length; i++){
			var otherNode = FlowChartObject.Nodes.all[i];
			if(otherNode!=this && otherNode.Data.x == x && otherNode.Data.y == y){
				x += 20;
				y += 20;
				i = -1;
			}
		}
	}
	//泳道：检查节点坐标是否覆盖到了泳道，并修正节点坐标
	x=FlowChartObject.Lane.Roles.CheckNodeX(x,this.Width);
	y=FlowChartObject.Lane.Stages.CheckNodeY(y,this.Height);
	
	this.Data.x = x;
	this.Data.y = y;
	FlowChartObject.SetPosition(this.DOMElement, x - this.Width / 2, y - this.Height / 2);
	var refreshType = toGrid?FlowChartObject.LINE_REFRESH_TYPE_ALL:FlowChartObject.LINE_REFRESH_TYPE_DOM;
	for(i=0; i<this.LineOut.length; i++)
		this.LineOut[i].Refresh(refreshType);
	for(i=0; i<this.LineIn.length; i++)
		this.LineIn[i].Refresh(refreshType);
}

//功能：将节点移动(dx, dy)个像素，同时更新节点的连线
//参数：toGrid：是否吸附到网格
function FlowChart_Node_MoveBy(dx, dy, toGrid){
	this.MoveTo(this.Data.x + dx, this.Data.y + dy, toGrid);
}


//功能：选中节点
//参数：selType：true=选中 false=不选中 null=反向选中
function FlowChart_Node_Select(selType){
	this.IsSelected = (selType==null)?!this.IsSelected:selType;
	FlowChartObject.SetStrokeColor(this.DOMElement, this.IsSelected?"#FF4444":"#000000");
}
function FlowChart_Node_Show(show){
	FlowChartObject.ShowElement(this.DOMElement, show);
}
//功能：设置节点状态，参数见状态常量
function FlowChart_Node_SetStatus(status){
	if(this.Status==status)
		return;
	this.Status = status;
	FlowChartObject.SetFillcolor(this.DOMElement, FlowChartObject.NODESTYLE_STATUSCOLOR[status]);
}

//功能：显示属性
function FlowChart_Node_ShowAttribute(){
	function _getLangLabel(defLabel,langsArr,lang){
		if(langsArr==null){
			return defLabel;
		}
		for(var i=0;i<langsArr.length;i++){
			if(lang==langsArr[i]["lang"]){
				return langsArr[i]["value"]||defLabel;
			}
		}
		return defLabel;
	}

	function _replaceLangs(data){
		if(_isLangSuportEnabled){
			var langs =data.langs;
			if(typeof langs!="undefined"){
				var langsJson = $.parseJSON(langs);
				var nameLangs = langsJson.nodeName;
				if(typeof nameLangs!="undefined"){
					data.name = _getLangLabel(data.name,nameLangs,_userLang);
				}
				var descLangs = langsJson.nodeDesc;
				if(typeof descLangs!="undefined"){
					data.description = _getLangLabel(data.description,descLangs,_userLang);
				}
			}
		}
		return data;
	}

	if(this.AttributePage!=null){
		var page = this.AttributePage;
		if (page.indexOf("page/node_attribute.jsp") > 0) {
			page = page + "?nodeType=" + this.Type + "&modelName=" + FlowChartObject.ModelName;
		}
		if (page.charAt(0) == '/') {
			page = page.substring(1);
		}
		
		var dialogObject = [];
		dialogObject.Node = this;
		dialogObject.Window = window;
		dialogObject.AfterShow = function(rtnData) {
			if(rtnData){
				if(this.Node.Status==FlowChartObject.STATUS_UNINIT)
					this.Node.SetStatus(FlowChartObject.STATUS_NORMAL);
				this.Node.Data = _replaceLangs(this.Node.Data);
				this.Node.Refresh();
			}
			if(this.Node.AfterShow){
				this.Node.AfterShow(this.Node);
			}
		}
		var url = Com_Parameter.ContextPath+page+"&s_css="+Com_Parameter.Style;
		Com_PopupWindow(url,680,580,dialogObject);
	}
}

//功能：显示节点属性面板（自由流）
function FlowChart_Node_ShowAttributePanel(callback){
	function _getLangLabel(defLabel,langsArr,lang){
		if(langsArr==null){
			return defLabel;
		}
		for(var i=0;i<langsArr.length;i++){
			if(lang==langsArr[i]["lang"]){
				return langsArr[i]["value"]||defLabel;
			}
		}
		return defLabel;
	}

	function _replaceLangs(data){
		if(_isLangSuportEnabled){
			var langs =data.langs;
			if(typeof langs!="undefined"){
				var langsJson = $.parseJSON(langs);
				var nameLangs = langsJson.nodeName;
				if(typeof nameLangs!="undefined"){
					data.name = _getLangLabel(data.name,nameLangs,_userLang);
				}
				var descLangs = langsJson.nodeDesc;
				if(typeof descLangs!="undefined"){
					data.description = _getLangLabel(data.description,descLangs,_userLang);
				}
			}
		}
		return data;
	}

	if(this.AttributePanelPage!=null){
		var page = this.AttributePanelPage;
		if (page.indexOf("page/node_attribute_panel.jsp") > 0) {
			page = page + "?nodeType=" + this.Type + "&modelName=" + FlowChartObject.ModelName;
		}
		if (page.charAt(0) == '/') {
			page = page.substring(1);
		}
		
		var dialogObject = [];
		dialogObject.Node = this;
		dialogObject.Window = window;
		dialogObject.AfterShow = function(rtnData) {
			if(rtnData){
				if(this.Node.Status==FlowChartObject.STATUS_UNINIT)
					this.Node.SetStatus(FlowChartObject.STATUS_NORMAL);
				this.Node.Data = _replaceLangs(this.Node.Data);
				this.Node.Refresh();
				if(callback){
					callback(this.Node);
				}
			}
		}
		//有回调则认为弹框展示节点属性
		var url = Com_Parameter.ContextPath+page+"&s_css="+Com_Parameter.Style;
		if(callback){
			url+="&isOpenNewWin=true";
			var width = 460;var height = 500;
			if((this.Data && this.Data.isFixedNode=='true') || this.Type=="draftNode" || this.Type=="startNode" || this.Type=="endNode"){
				url+="&isFixedNode=true";
				width = 680;height = 580;
			}
			Com_PopupWindow(url,width,height,dialogObject);
		}else{
			Com_Parameter.Dialog = dialogObject;
			$("#iframe_node").attr("src", url);
			$("#nodePanel").show();
		}
	}
}

//功能：删除节点，同时删除相关的连线
function FlowChart_Node_Delete(){
	for(;this.LineOut.length>0;)
		this.LineOut[0].Delete();
	for(; this.LineIn.length>0;)
		this.LineIn[0].Delete();
	FlowChartObject.Nodes.all = Com_ArrayRemoveElem(FlowChartObject.Nodes.all, this);
	FlowChartObject.RemoveElement(this.DOMElement);
}

//功能：显示详细信息
//参数：show：是否显示，noLazy：是否不延时
function FlowChart_Node_ShowDetail(show, noLazy){
	if(!show || this.Info==null || this.Info==""){
		FlowChartObject.Nodes.InfoBox.Hide();
		return;
	}
	if(!noLazy){
		if(this!=FlowChartObject.Nodes.InfoBox.Current){
			FlowChartObject.Nodes.InfoBox.Hide();
			//延时显示
			FlowChartObject.Nodes.InfoBox.TimeoutId = setTimeout("FlowChartObject.Nodes.InfoBox.Current.ShowDetail(true, true);", 800);
		}
	}else{
		FlowChartObject.Nodes.InfoBox.Text.innerHTML = this.Info;
		var obj = FlowChartObject.Nodes.InfoBox.Main;
		obj.style.display = "";
		
		//调整位置，将信息框显示在当前节点的旁边，并不让显示框超出边界
		var w = this.Width / 2;
		var h = this.Height / 2;
		if(this.Data.x + w + obj.clientWidth <= document.body.clientWidth) {
			obj.style.left = (this.Data.x + w + 4) + "px";
		} else if(this.Data.x - w - obj.clientWidth >= 0){
			obj.style.left = (this.Data.x - w - obj.clientWidth - 4) + "px";
		} else {
			obj.style.left = 0 + "px";
		}
		if(this.Data.y - h + obj.clientHeight <= document.body.clientHeight) {
			obj.style.top = (this.Data.y - h) + "px";
		} else if(this.Data.y + h - obj.clientHeight >= 0){
			obj.style.top = (this.Data.y + h - obj.clientHeight) + "px";
		} else {
			obj.style.top = 0 + "px";
		}
		if (this.ShowDetailAfter != null) {
			this.ShowDetailAfter(true);
		}
	}
	FlowChartObject.Nodes.InfoBox.Current = this;
}

//功能：添加流出连线
function FlowChart_Node_AddLineOut(line){
	if(Com_ArrayGetIndex(this.LineOut, line)==-1)
		this.LineOut[this.LineOut.length] = line;
}

//功能：添加流入连线
function FlowChart_Node_AddLineIn(line){
	if(Com_ArrayGetIndex(this.LineIn, line)==-1)
		this.LineIn[this.LineIn.length] = line;
}

//功能：删除流入连线
function FlowChart_Node_DelLineOut(line){
	this.LineOut = Com_ArrayRemoveElem(this.LineOut, line);
}

//功能：删除流出连线
function FlowChart_Node_DelLineIn(line){
	this.LineIn = Com_ArrayRemoveElem(this.LineIn, line);
}

//功能：根据位置，获取节点连接坐标和位置
//参数：见常量表 NODEPOINT_POSITION_*
function FlowChart_Node_GetPointByPosition(position){
	switch(position){
		case FlowChartObject.NODEPOINT_POSITION_TOP:
			return {x:this.Data.x, y:this.Data.y-this.Height/2, position:FlowChartObject.NODEPOINT_POSITION_TOP};
		case FlowChartObject.NODEPOINT_POSITION_RIGHT:
			return {x:this.Data.x+this.Width/2, y:this.Data.y, position:FlowChartObject.NODEPOINT_POSITION_RIGHT};
		case FlowChartObject.NODEPOINT_POSITION_BOTTOM:
			return {x:this.Data.x, y:this.Data.y+this.Height/2, position:FlowChartObject.NODEPOINT_POSITION_BOTTOM};
		case FlowChartObject.NODEPOINT_POSITION_LEFT:
			return {x:this.Data.x-this.Width/2, y:this.Data.y, position:FlowChartObject.NODEPOINT_POSITION_LEFT};
	}
}

//功能：根据参考点，获取最靠近的连接点和位置
//参数：xx,yy：参考点，默认取当前事件的位置
function FlowChart_Node_GetClosestPoint(xx, yy){
	if(xx==null)
		xx = EVENT_X;
	if(yy==null)
		yy = EVENT_Y;
	var minD = 10000;
	var minP = null;
	for(var i=0; i<FlowChartObject.NODEPOINT_POSITION_ALL.length; i++){
		var p = this.GetPointByPosition(FlowChartObject.NODEPOINT_POSITION_ALL[i]);
		var d = Com_GetDistance(xx, yy, p.x, p.y);
		if(d<minD){
			minD = d;
			minP = p;
		}
	}
	return minP;
}

//功能：刷新节点显示信息（小图标）
function FlowChart_Node_Refresh(){
	this.Text = Com_FormatTextNormal(this.Data.name, 7, 14);
	if(this.DOMText!=null){
		FlowChartObject.SetText(this.DOMText, this.Text);
	}
	this.RefreshInfo();
}

//功能：刷新节点显示信息（大图标）
function FlowChart_Node_BigIconRefresh(){
	var array = new Array();
	this.Text = " " + Com_FormatTextNormal(this.Data.name, 12, 24);
	array.push(this.Text);
	var handlerNames = Com_FormatTextNormal((this.Data.handlerNames || FlowChartObject.Lang.Node.HandlerIsEmpty), 15, 30);
	array.push(handlerNames);
	FlowChartObject.SetText(this.DOMText, array);
	this.RefreshInfo();
}

//功能：格式化用于生成XML的数据
function FlowChart_Node_FormatXMLData(){
	this.Data.XMLNODENAME = this.Type;
}

//功能：将Data信息转换为XML字符串并返回
function FlowChart_Node_GetXMLString(){
	this.FormatXMLData();
	return WorkFlow_BuildXMLString(this.Data, this.Type);
}

//功能：检查节点配置是否正确
function FlowChart_Node_Check(){
	return FlowChartObject.CheckFlowNode(this);
}

//====================节点常用函数====================
//功能：切换大小图标
function FlowChart_Node_ChangeIconType(){
	FlowChartObject.Nodes.CreateBigRectDOM(this);
	FlowChartObject.SetFillcolor(this.DOMElement, FlowChartObject.NODESTYLE_STATUSCOLOR[this.Status]);
	this.Refresh();
	this.MoveTo(this.Data.x, this.Data.y);
}

//功能：格式化data数据
function FlowChart_Node_FormatData(data){
	if(typeof(data.x)=="string"){
		data.x = parseInt(data.x, 10);
		data.y = parseInt(data.y, 10);
	}
}

//为了解决edge浏览器子窗口中创建的对象无法正常保存到父窗口而特别加的克隆对象到节点属性的方法
function FlowChart_Node_AddObjectData(attr, obj){
	if (typeof obj == "object" && obj != null) {
		this.Data[attr] = objClone(obj);
	} else {
		this.Data[attr] = obj;
	}
}

function objClone(obj) {
	// edge浏览器下优先通过length属性来判断obj是否为数组
	var o = obj.length ? [] : {};
	for (var k in obj) {
		 o[k] = typeof obj[k] == "object" ? objClone(obj[k]) : obj[k];
	}
	return o;
}

//====================连线全局操作====================
//功能：连线初始化操作，创建操作线
FlowChartObject.Lines.Initialize = function(){
	var optLine = new FlowChart_Line(null, "opt");
	optLine.Show(false);
	FlowChartObject.Lines.OptLine = optLine;
};

//功能：根据ID查找对象
FlowChartObject.Lines.GetLineById = function(id){
	for(var i=0; i<FlowChartObject.Lines.all.length; i++){
		if(id==FlowChartObject.Lines.all[i].Data.id) {
			return FlowChartObject.Lines.all[i];
		}
	}
	return null;
};		

//====================连线对象类====================
function FlowChart_Line(data, type, weight){
	//连线数据
	if(data==null){
		this.Data = new Object();
		this.Data.id = (FlowChartObject.IsEmbedded?"EL":"L") + (++FlowChartObject.Lines.Index);
		this.Data.name = "";
	}else{
		this.Data = data;
	}
	//==========属性==========
	this.Name = "Line";										//对象名称
	this.IsSelected = false;								//是否被选中
	this.CanDelete = true;									//是否可以被删除
	this.Type = type==null?"normal":type;					//类型：normal或opt、play
	this.Text = "";										    //连线文本
	this.Status = FlowChartObject.STATUS_NORMAL;			//连线状态
	this.Weight = weight==null?FlowChartObject.LINESTYLE_WEIGHT:weight;		//连线的粗细
	
	//==========子对象==========
	this.StartNode = null;									//开始节点
	this.EndNode = null;									//结束节点
	this.Points = new Array();								//所有拐点坐标，若连接到了开始和结束节点，RefreshDOM动作会重新更新起始点和终止点的值
	this.DOMElement = null;									//连线DOM模型
	this.DOMText = null;									//显示文本的HTML对象
	
	//==========方法==========
	this.Select = FlowChart_Line_Select;					//选中连线
	this.SetStatus = FlowChart_Line_SetStatus;				//设置状态
	this.Refresh = FlowChart_Line_Refresh;					//刷新显示
	this.Show = FlowChart_Line_Show;						//显示或隐藏
	this.ShowAttribute = FlowChart_Line_ShowAttribute;		//显示属性
	this.Delete = FlowChart_Line_Delete;					//删除连线
	this.FormatXMLData = FlowChart_Line_FormatXMLData;		//格式化用于生成XML的数据
	this.GetXMLString = FlowChart_Line_GetXMLString;		//转换为XML文本
	this.RefreshText = FlowChart_Line_RefreshText;			//刷新文本
	this.RefreshDOM = FlowChart_Line_RefreshDOM;			//刷新DOM模型显示
	this.LinkNode = FlowChart_Line_LinkNode;				//连接节点
	this.MoveBy = FlowChart_Line_MoveBy;					//移动中间连线
	this.RefreshRefId = null;								//更新引用链接
	this.Initialize = function() {
		FlowChartObject.Lines.CreateLineDOM(this);
	};
	this.Initialize();
	
	if(this.Type=="normal"){
		FlowChartObject.Lines.all[FlowChartObject.Lines.all.length] = this;
		if(data!=null){
			this.Points = FlowChart_Line_GetPointsByString(data.points);
			this.LinkNode(FlowChartObject.Nodes.GetNodeById(this.Data.startNodeId),	FlowChartObject.Nodes.GetNodeById(this.Data.endNodeId));
			this.Refresh();
		}
	}
}

//====================连线对象类使用函数====================
//功能：选中连线
//参数：selType：true=选中 false=不选中 null=反向选中
function FlowChart_Line_Select(selType){
	this.IsSelected = (selType==null)?!this.IsSelected:selType;
	var color = this.IsSelected?FlowChartObject.LINESTYLE_SELECTEDCOLOR:FlowChartObject.LINESTYLE_STATUSCOLOR[this.Status];
	FlowChartObject.SetStrokeColor(this.DOMElement, color);
}

//功能：设置连线状态，参数见状态常量
function FlowChart_Line_SetStatus(status){
	if(this.Status==status)
		return;
	this.Status = status;
	this.Select(this.IsSelected);
}

//功能：刷新显示
//参数：见常量表 LINE_REFRESH_TYPE_*
function FlowChart_Line_Refresh(type){
	//初始化参数
	if(type==null)
		type = FlowChartObject.LINE_REFRESH_TYPE_ALL;

	//更新DOM模型显示
	if((type & FlowChartObject.LINE_REFRESH_TYPE_DOM)>0)
		this.RefreshDOM();
	//更新文本内容
	if((type & FlowChartObject.LINE_REFRESH_TYPE_TEXT)>0)
		this.RefreshText();
}

//功能：显示属性
function FlowChart_Line_ShowAttribute(){
	function _getLangLabel(defLabel,langsArr,lang){
		if(langsArr==null){
			return defLabel;
		}
		for(var i=0;i<langsArr.length;i++){
			if(lang==langsArr[i]["lang"]){
				return langsArr[i]["value"]||defLabel;
			}
		}
		return defLabel;
	}

	function _replaceLangs(data){
		if(_isLangSuportEnabled){
			var langs = data.langs;
			if(typeof langs!="undefined"){
				var langsJson = $.parseJSON(langs);
				data.name = _getLangLabel(data.name,langsJson,_userLang);
			}
		}
		return data;
	}

	var dialogObject = [];
	dialogObject.Line = this;
	dialogObject.Window = window;
	dialogObject.AfterShow = function(rtnData) {
		if(rtnData){
			this.Line.Data = _replaceLangs(this.Line.Data);
			this.Line.Refresh();
		}
	}
	Com_PopupWindow("line_attribute.jsp",640,480,dialogObject);
}

//功能：刷新文本信息
function FlowChart_Line_RefreshText(){
	this.Text = Com_FormatTextNormal(this.Data.name, 10);
	if(this.Text==null || this.Text==""){
		FlowChartObject.ShowElement(this.DOMText, false);
	}else{
		FlowChartObject.ShowElement(this.DOMText, true);
		FlowChartObject.SetText(this.DOMText, this.Text);
		//更新文本位置：连线中间点
		var points = Com_CalculateMiddlePoints(this.Points, 0.5);
		var size = FlowChartObject.GetElementSize(this.DOMText);
		//#52910 处理拖拽节点时，连接线描述文字位置不正确的问题（svg下获取width的值不稳定）
		FlowChartObject.SetPosition(this.DOMText, (points[points.length-1].x), (points[points.length-1].y));
	}
}

//功能：刷新节点DOM模型显示
function FlowChart_Line_RefreshDOM(){
	if(this.Points.length==0){
		this.Points[0] = {x:0, y:0};
		this.Points[1] = {x:0, y:0};
	}
	//更新开始、结束点
	if(this.StartNode!=null)
		this.Points[0] = this.StartNode.GetPointByPosition(this.Data.startPosition);
	if(this.EndNode!=null)
		this.Points[this.Points.length - 1] = this.EndNode.GetPointByPosition(this.Data.endPosition);
	//处理线段位置
	var pointPath = "";
	for(var i=0; i<this.Points.length; i++){
		pointPath += " "  + this.Points[i].x + "," + this.Points[i].y;
	}
	FlowChartObject.SetLinePoints(this.DOMElement, pointPath.substring(1));
}

//功能：连接节点
//参数：参数为空表示不更新
//	startNode：开始节点
//	endNode：结束节点
//	startPosition：开始位置
//	endPosition：结束位置
//	points：连线信息
function FlowChart_Line_LinkNode(startNode, endNode, startPosition, endPosition, points){
	if(startNode!=null && this.StartNode!=startNode){
		if(this.StartNode!=null)
			this.StartNode.DelLineOut(this);
		this.StartNode = startNode;
		this.StartNode.AddLineOut(this);
		if(!startNode.CanChangeOut)
			this.CanDelete = false;
	}
	if(startPosition!=null)
		this.Data.startPosition = startPosition;
	if(endNode!=null && this.EndNode!=endNode){
		if(this.EndNode!=null)
			this.EndNode.DelLineIn(this);
		this.EndNode = endNode;
		this.EndNode.AddLineIn(this);
		if(!endNode.CanChangeIn)
			this.CanDelete = false;
	}
	if(endPosition!=null)
		this.Data.endPosition = endPosition;
	if(points!=null)
		this.Points = points;
}

//功能：格式化用于生成XML的数据
function FlowChart_Line_FormatXMLData(){
	this.Data.startNodeId = this.StartNode.Data.id;
	this.Data.endNodeId = this.EndNode.Data.id;
	this.Data.points = FLowChart_Line_GetPointsString(this.Points);
	this.Data.XMLNODENAME = "line";
}

//功能：将Data信息转换为XML字符串并返回
function FlowChart_Line_GetXMLString(){
	this.FormatXMLData();
	return WorkFlow_BuildXMLString(this.Data, "line");
}

//功能：删除连线
function FlowChart_Line_Delete(){
	//解除相关的链接
	this.StartNode.DelLineOut(this);
	this.EndNode.DelLineIn(this);
	if (this.StartNode.Type == "manualBranchNode" && this.StartNode.Data.defaultBranch == this.Data.id) {
		this.StartNode.Data.defaultBranch = "";
	}
	FlowChartObject.Lines.all = Com_ArrayRemoveElem(FlowChartObject.Lines.all, this);
	if(this.DOMText) {
		FlowChartObject.RemoveElement(this.DOMText);
	}
	FlowChartObject.RemoveElement(this.DOMElement);
}

//功能：显示/隐藏连线，仅用于操作连线
function FlowChart_Line_Show(show){
	if(this.DOMText) {
		FlowChartObject.ShowElement(this.DOMText, show);
	}
	FlowChartObject.ShowElement(this.DOMElement, show);
}

//功能：移动连线的中间点
//参数：
//	dx,dy：位置的增量
//	type：移动后的刷新类型，见常量表 LINE_REFRESH_TYPE_*
function FlowChart_Line_MoveBy(dx, dy, type){
	var points = this.Points;
	if(points.length<3)
		return;
	for(var i=0; i<points.length-1; i++){
		points[i].x += dx;
		points[i].y += dy;
	}
	this.Refresh(type);
}

//====================连线常用函数====================
//功能：将点字符串描述转换成对象
function FlowChart_Line_GetPointsByString(points){
	var rtnVal = new Array();
	if(points!=null && points!=""){
		points = points.split(";");
		for(var i=0; i<points.length; i++){
			var point = points[i].split(",");
			rtnVal[rtnVal.length] = {x:parseInt(point[0],10), y:parseInt(point[1], 10)};
		}
	}
	return rtnVal;
}

//功能：将点对象转换成字符串
function FLowChart_Line_GetPointsString(points){
	var rtnVal = "";
	for(var i=0; i<points.length; i++)
		rtnVal += ";" + points[i].x + "," + points[i].y;
	return rtnVal.substring(1);
}

//====================操作点全局操作====================
//功能：初始化操作点
FlowChartObject.Points.Initialize = function(){
	FlowChartObject.Points.NodePoint = new FlowChart_Point("node");
};

//====================操作点对象类====================
function FlowChart_Point(type){
	//==========属性==========
	this.Name = "Point";								//对象名称
	this.Type = type;									//操作点类型：node和line
	this.x = 0;											//圆心位置横坐标
	this.y = 0;											//圆心位置纵坐标
	
	//==========子对象==========
	this.DOMElement = null;								//操作点DOM模型
	
	//==========方法==========
	this.MoveTo = FlowChart_Point_MoveTo;				//移动操作点
	this.Show = FlowChart_Point_Show;					//显示/隐藏操作点
	
	//==========初始化==========
	this.Initialize = function() {
		FlowChartObject.Points.CreatePointDOM(this);
	};
	this.Initialize();
	
	if(this.Type=="line"){
		this.index = FlowChartObject.Points.LinePoint.length;	//节点对应于FlowChartObject.Points.LinePoint的索引号
		FlowChartObject.Points.LinePoint[this.index] = this;
	}
	
}

//====================操作点对象类使用函数====================
//功能：移动操作点，参数x,y为坐标点
function FlowChart_Point_MoveTo(x, y){
	this.x = x;
	this.y = y;
	//注意x和y为圆心位置，圆的直径为8
	FlowChartObject.SetPosition(this.DOMElement, this.x - 4, this.y - 4);
}

//功能：显示/隐藏操作点
function FlowChart_Point_Show(show){
	FlowChartObject.ShowElement(this.DOMElement, show);
}
