<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/tree_top.jsp" %>
//Com_Parameter.XMLDebug = true;
function generateTree()
{
	LKSTree = new TreeView(
		"LKSTree",
		"<bean:message key="kmCarmng.tree.title" bundle="km-carmng"/>",
		document.getElementById("treeDiv")
	);
	var n1, n2, n3, n4, n5;
	n1 = LKSTree.treeRoot;
	//========== 我的文档 ==========
	//个人申请
	n2=n1.AppendURLChild("<bean:message key="kmCarmng.tree.my.submit" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&myDoc=true" />"	);
	<!-- 草稿 -->
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.draft" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=10&myDoc=true" />"	
	);
	<!-- 待审 -->
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.wait" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=20&myDoc=true" />"			
	);
	<!-- 发布 -->
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&myDoc=true&isDispatcher=1" />"	
	);
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish2" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&myDoc=true&isDispatcher=2" />"	
	);
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish3" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&myDoc=true&isDispatcher=3" />"	
	);
	<!-- 驳回 -->
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.refuse" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=11&myDoc=true" />"	
	);
	<!-- 废弃 -->
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.discard" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=00&myDoc=true" />"	
	);
	
	//我的审批
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.my.examine" bundle="km-carmng"/>");
	//待审
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.wait" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&flowType=unExecuted" />"	
	);
	//已审
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.already" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&flowType=executed" />"	
	);
	//用车申请
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.application" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list" />");
	//按审批状态
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.application.status" bundle="km-carmng"/>");
	//待审
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.wait" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=20" />"	
	);
	//审批通过
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&isDispatcher=1" />"	
	);
	//驳回
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.refuse" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=11" />"	
	);
	//废弃
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.discard" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=00" />"	
	);
	//按用车状态
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.use.status" bundle="km-carmng"/>");
	//出车
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish2" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&isDispatcher=2" />"	
	);
	//完成
	n3.AppendURLChild(
		"<bean:message key="kmCarmng.tree.publish3" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=list&docStatus=30&isDispatcher=3" />"	
	);

	<kmss:authShow roles="ROLE_KMCARMNG_CARMANAGE">
	//车辆信息
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.car.information" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=" />");
	//按车队
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information6" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=" />");
	
	n3.AppendBeanData('kmCarmngMotorcadeSetTreeService&categoryId=!{value}',
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&motorcadeId=!{value}" />");
	//按类别
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information1" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=" />");
	n3.AppendBeanData('kmCarmngCategoryTreeService&categoryId=!{value}',"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&categoryId=!{value}" />");
	//按状态
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information2" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=" />");
	//在役
	n3.AppendURLChild("<bean:message key="kmCarmng.tree.car.information21" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=1" />");
	//送修
	n3.AppendURLChild("<bean:message key="kmCarmng.tree.car.information22" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=2" />");
	//报废
	n3.AppendURLChild("<bean:message key="kmCarmng.tree.car.information23" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infomation/kmCarmngInfomation.do?method=list&docStatus=3" />");
	//违章信息
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information3" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=list"/>");
	//保险信息
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information4" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_insurance_info/kmCarmngInsuranceInfo.do?method=list"/>");
	//保养信息
	n3 = n2.AppendURLChild("<bean:message key="kmCarmng.tree.car.information5" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=list"/>");
	//搜索车辆信息
	n3 = n2.AppendURLChild("<bean:message bundle="km-carmng" key="kmCarmngInfomation.search"/>",
	"<c:url value="/sys/search/search.do?method=condition&fdModelName=com.landray.kmss.km.carmng.model.KmCarmngInfomation"/>");
	
	</kmss:authShow>
	<kmss:authShow roles="ROLE_KMCARMNG_MOTORCADE_ATTEMPER">
	//调度信息
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.dispatcher" bundle="km-carmng"/>");
	//用车调度
	
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.dispatcher1" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_application/kmCarmngApplication.do?method=listByDispatchers&docStatus=30&fdIsDispatcher=1" />");
	
	//调度信息	
   
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.dispatcher2" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=list" />");
 </kmss:authShow>
	<kmss:authShow roles="ROLE_KMCARMNG_USECARQUERY">
	//用车查询
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.dispatcher3" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_dispatchers_info/kmCarmngDispatchersInfo.do?method=search" />");
	</kmss:authShow>
	
	<kmss:authShow roles="ROLE_KMCARMNG_CHARGESTAT">
	//统计报表
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.fee.count" bundle="km-carmng"/>");
	//出车统计
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.fee.count1" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_user_fee_info/kmCarmngUserFeeInfo.do?method=count"/>");
	//保养统计
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.fee.count2" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_maintenance_info/kmCarmngMaintenanceInfo.do?method=count" />");
	//违章统计
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.fee.count3" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_infringe_info/kmCarmngInfringeInfo.do?method=count"/>");
	</kmss:authShow>
	
	<kmss:authShow roles="ROLE_KMCARMNG_SETTING">
	//基础设置
	n2 = n1.AppendURLChild("<bean:message key="kmCarmng.tree.base.set" bundle="km-carmng"/>");
	
	//车队设置
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.base.set1" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_motorcade_set/kmCarmngMotorcadeSet.do?method=list" />");
	//驾驶员信息
	n2.AppendURLChild(
		"<bean:message key="kmCarmng.tree.base.set2" bundle="km-carmng"/>",
		"<c:url value="/km/carmng/km_carmng_drivers_info/kmCarmngDriversInfo.do?method=list" />"
	);
	//车辆类别
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.base.set3" bundle="km-carmng"/>",
	"<c:url value="/km/carmng/km_carmng_category/kmCarmngCategory.do?method=list" />"
	);
	//通用流程模板
	n2.AppendURLChild("<bean:message key="kmCarmng.tree.base.set4" bundle="km-carmng"/>",
	"<c:url value="/sys/workflow/sys_wf_common_template/sysWfCommonTemplate.do?method=list&fdModelName=com.landray.kmss.km.carmng.model.KmCarmngMotorcadeSet&fdKey=kmCarmngMotorcadeSet" />"
	); 
	</kmss:authShow>
	LKSTree.EnableRightMenu();
	LKSTree.Show();
}
<%@ include file="/resource/jsp/tree_down.jsp" %>