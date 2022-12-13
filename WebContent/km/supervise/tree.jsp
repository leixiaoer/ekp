<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="config.tree">
<template:replace name="content">
function generateTree()
{
    window.LKSTree = new TreeView( 
        'LKSTree',
        
        '<bean:message key="module.km.supervise" bundle="km-supervise"/>',//根节点的名称
        document.getElementById('treeDiv')
    );
    var node = LKSTree.treeRoot; 
    
    
    node.isExpanded = true;
   	    /*类别设置*/
    var node_2_0_node_1_0_node = node.AppendURLChild(
        '<bean:message key="py.LeiBieSheZhi" bundle="km-supervise"/>',
        '<c:url value="/sys/category/sys_category_main/sysCategoryMain_tree.jsp?modelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&mainModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain&categoryName=docCategory&templateName=docTemplate&authReaderNoteFlag=2"/>');
    
     <%-- <kmss:authShow roles="ROLE_KMSUPERVISE_CATEGORY_MAINTAINER"> --%>
	    /*模板设置*/
	    var node_2_0_node_1_1_node = node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.project" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=10&fdKey=kmSuperviseMain"/>');
	        node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.change" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=70&fdKey=kmSuperviseMain"/>');
	    	node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.make.plan" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=20&fdKey=kmSuperviseMakePlan"/>');
	        node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.feedback" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=30&fdKey=kmSuperviseFeedback"/>');
	        node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.stage" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=40&fdKey=kmSuperviseStage"/>');
	        node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.termination" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=50&fdKey=kmSuperviseTermination"/>');
	        node.AppendCV2Child(
	        '<bean:message key="table.kmSuperviseTemplet.setup" bundle="km-supervise"/>',
	'com.landray.kmss.km.supervise.model.KmSuperviseTemplet',
	        '<c:url value="/km/supervise/km_supervise_templet/index.jsp?q.docCategory=!{value}&ower=1&fdType=60&fdKey=kmSuperviseSetup"/>');
    <%-- </kmss:authShow> --%>
    
    <kmss:authShow roles="ROLE_KMSUPERVISE_COMMONWORKFLOW">
    /*基础设置*/
    var node_1_2_node = node.AppendURLChild(
        '<bean:message key="py.JiChuSheZhi" bundle="km-supervise"/>');
    node_1_2_node.isExpanded = true;
    
    /*通用编号规则*/
    <kmss:auth requestURL="/sys/number/sys_number_main/sysNumberMain.do?method=list&modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" requestMethod="GET">
    var node_3_0_node_2_1_node_1_2_node = node_1_2_node.AppendURLChild(
        '<bean:message key="py.TongYongBianHaoGui" bundle="km-supervise"/>',
        '<c:url value="/sys/number/sys_number_main/index.jsp?modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"/>');
    </kmss:auth>

    
    /*通用表单模板*/
    <kmss:auth requestURL="/sys/xform/sys_form_common_template/index.jsp?fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseMain&fdMainModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" requestMethod="GET">
    var node_3_0_node_2_2_node_1_2_node = node_1_2_node.AppendURLChild(
        '<bean:message key="py.TongYongBiaoDanMo" bundle="km-supervise"/>',
        '<c:url value="/sys/xform/sys_form_common_template/index.jsp?fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseMain&fdMainModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"/>');
    </kmss:auth>

    
    /*表单数据映射*/
    <kmss:auth requestURL="/sys/xform/base/sys_form_db_table/index.jsp?fdTemplateModel=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseMain&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain" requestMethod="GET">
    var node_3_0_node_2_3_node_1_2_node = node_1_2_node.AppendURLChild(
        '<bean:message key="py.BiaoDanShuJuYing" bundle="km-supervise"/>',
        '<c:url value="/sys/xform/base/sys_form_db_table/index.jsp?fdTemplateModel=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseMain&fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"/>');
    </kmss:auth>

    
    /*搜索设置*/
    <kmss:auth requestURL="/sys/search/sys_search_main/index.jsp?fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseTemplet&fdKey=kmSuperviseTemplet" requestMethod="GET">
    var node_3_0_node_2_4_node_1_2_node = node_1_2_node.AppendURLChild(
        '<bean:message key="py.SouSuoSheZhi" bundle="km-supervise"/>',
        '<c:url value="/sys/search/sys_search_main/index.jsp?fdModelName=com.landray.kmss.km.supervise.model.KmSuperviseMain&fdKey=kmSuperviseMain"/>');
    </kmss:auth>
	
	node_1_2_node.AppendURLChild(
		"<bean:message bundle='km-supervise' key='kmSupervise.listShow'/>",
		"<c:url value="/sys/profile/listShow/sys_listshow_category/index.jsp?modelName=com.landray.kmss.km.supervise.model.KmSuperviseMain"/>"
	);
	
    /*参数配置*/
    var node_1_3_node = node.AppendURLChild(
        '<bean:message key="py.CanShuPeiZhi" bundle="km-supervise"/>');
    node_1_3_node.isExpanded = true;
    
    /*督办紧急程度*/
    <kmss:auth requestURL="/km/supervise/km_supervise_urgency/index.jsp" requestMethod="GET">
    var node_3_0_node_2_0_node_1_3_node = node_1_3_node.AppendURLChild(
        '<bean:message key="kmSuperviseUrgency.tree" bundle="km-supervise"/>',
        '<c:url value="/km/supervise/km_supervise_urgency/index.jsp"/>');
    </kmss:auth> 
    
    /*督办级别*/
    <kmss:auth requestURL="/km/supervise/km_supervise_level/index.jsp" requestMethod="GET">
    var node_3_0_node_2_1_node_1_3_node = node_1_3_node.AppendURLChild(
        '<bean:message key="table.kmSuperviseLevel" bundle="km-supervise"/>',
        '<c:url value="/km/supervise/km_supervise_level/index.jsp"/>');
    </kmss:auth> 
    
    /*督办预警*/
    var node_3_0_node_2_2_node_1_3_node = node_1_3_node.AppendURLChild(
        '<bean:message key="table.kmSuperviseWarn" bundle="km-supervise"/>',
        '<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.supervise.model.KmSuperviseWarnConfig"/>');
    
    /*功能开关*/
    var node_3_0_node_2_2_node_1_4_node = node_1_3_node.AppendURLChild(
        '<bean:message key="kmSuperviseParamConfig.setting" bundle="km-supervise"/>',
        '<c:url value="/sys/appconfig/sys_appconfig/sysAppConfig.do?method=edit&modelName=com.landray.kmss.km.supervise.model.KmSuperviseParamConfig"/>');    
    </kmss:authShow> 
    
    <kmss:ifModuleExist path="/dbcenter/echarts/">
		<kmss:authShow roles="ROLE_DBCENTERECHARTS_DEFAULT">
			<c:import url="/dbcenter/echarts/application/navTree/tree.jsp" charEncoding="UTF-8">
				<c:param name="mainModelName" value="com.landray.kmss.km.supervise.model.KmSuperviseTemplet"></c:param>
				<c:param name="fdKey" value="kmSuperviseMain"></c:param>
			</c:import>
		</kmss:authShow>
	</kmss:ifModuleExist>
    
    /*文档维护*/
	var node_doc = node.AppendURLChild("<bean:message key="tree.sysCategory.maintains" bundle="sys-category" />")
	node_doc.authType="01";
	node_doc.AppendCategoryDataWithAdmin ("com.landray.kmss.km.supervise.model.KmSuperviseTemplet","<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=manageList&categoryId=!{value}"/>","<c:url value="/km/supervise/km_supervise_main/kmSuperviseMain.do?method=listChildren&type=category&categoryId=!{value}" />",null,null,null,null,null,"10");
	//=========回收站========
	<% if(com.landray.kmss.sys.recycle.util.SysRecycleUtil.isEnableSoftDelete("com.landray.kmss.km.supervise.model.KmSuperviseMain")) { %>
	var node_recycle = node.AppendURLChild("<bean:message key="module.sys.recycle" bundle="sys-recycle" />","<c:url value="/km/supervise/km_supervise_main/sysRecycleBox.jsp" />");
	<% } %>
	LKSTree.EnableRightMenu();
    
    LKSTree.Show();
    LKSTree.ClickNode(node_2_0_node_1_0_node);
}
</template:replace>
</template:include>