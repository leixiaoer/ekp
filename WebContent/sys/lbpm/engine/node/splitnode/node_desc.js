	/*******************************************************************************
	 * 功能：启动并行分支节点的节点描述（节点扩展点的nodeJsType项配置此文件的路径）
	 ******************************************************************************/
( function(nodedescs) {
	nodedescs['splitNodeDesc'].getLines = getLines;
	//获取即将流向的连线(nodeObj为当前节点对象，nextNodeObj为下一节点对象,disFilter是否禁用计算流出连线)
	function getLines(nodeObj,nextNodeObj,disFilter){
		return nextNodeObj.endLines;
	};
})(lbpm.nodedescs);