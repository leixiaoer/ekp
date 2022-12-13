<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.view" sidebar="no">
	<template:replace name="title">
		<c:out value="${kmOitemsMonthReportForm.docSubject } - ${ lfn:message('km-oitems:kmOitems.tree.modelName') }"></c:out>
	</template:replace>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">
			<ui:button text="${lfn:message('button.export')}" order="1" href="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=exportMonthReport&fdId=${JsParam.fdId}">
			</ui:button>
			<kmss:auth requestURL="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
			    <ui:button text="${lfn:message('button.delete')}"  onclick="Delete();" order="2">
				</ui:button>
			</kmss:auth>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	<template:replace name="path">
		<ui:menu layout="sys.ui.menu.nav"  id="simplecategory"> 
				<ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.tree.modelName') }" href="/km/oitems/" target="_self">
				</ui:menu-item>
				<ui:menu-item text="${ lfn:message('km-oitems:kmOitems.msg.report') }">
				</ui:menu-item>
			</ui:menu>
</template:replace>	
<template:replace name="content"> 
<script>
Com_IncludeFile("jquery.js");
</script>
<script>


seajs.use(['lui/jquery','sys/ui/js/dialog'], function(jQuery,dialog) {
       window.jQuery=jQuery;
       window.dialog=dialog; 
});

//导出
function exportMonthReport(){
	var url  = '<c:url value="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=exportMonthReport"/>';
	var fdId = '${JsParam.fdId}';
  	windows.href.location = "/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=exportMonthReport&fdId="+fdId;
}

	function Delete(){
			dialog.confirm("${lfn:message('page.comfirmDelete')}",function(flag){
		    	if(flag==true){
		    		Com_OpenWindow('kmOitemsMonthReport.do?method=delete&fdId=${JsParam.fdId}','_self');
		    	}else{
		    		return false;
			    }
		    },"warn");
	}
	
	// 两个浮点数求和
	function accAdd(num1,num2){
	   var r1,r2,m;
	   try{
	       r1 = num1.toString().split('.')[1].length;
	   }catch(e){
	       r1 = 0;
	   }
	   try{
	       r2=num2.toString().split(".")[1].length;
	   }catch(e){
	       r2=0;
	   }
	   m=Math.pow(10,Math.max(r1,r2));
	   return Math.round(num1*m+num2*m)/m;
	}
	
	//人员合并
    function mergePerson(id){
        var dept; // 部门
        var person = "";
        var size;
        var money=0.0;
        var subtotal;
    	jQuery("#"+id+" tr:gt(1)").each(function() {
            if(person==""){
               money = accAdd(money,parseFloat((jQuery(this).find("td:eq(8)").text())));  //金额
        	   size = 1;
        	   dept = jQuery(this).find("td:eq(0)"); //部门
               person = jQuery(this).find("td:eq(1)"); //所属人员
               subtotal = jQuery(this).find("td:eq(2)"); //小计
               subtotal.text(money);
           } else{
             var tempMoney = parseFloat((jQuery(this).find("td:eq(8)").text())); //临时金额
             var tempPerson = jQuery(this).find("td:eq(1)"); //临时人员
             var tempsubtotal = jQuery(this).find("td:eq(2)"); //临时小计
             var tempDept = jQuery(this).find("td:eq(0)"); //临时小计
                if(person.text()==tempPerson.text()){
            	   size++;
            	   money = accAdd(money,tempMoney);  //金额
            	   subtotal.text(money);
            	   person.attr('rowSpan', size); //合并
            	   subtotal.attr('rowSpan', size);
            	   dept.attr('rowSpan', size);
            	   tempDept.remove();//去除多余表格
             	   tempPerson.remove(); 
            	   tempsubtotal.remove();
                  }else{
                	   person.attr('rowSpan', size); // //合并
                	   subtotal.attr('rowSpan', size);
                	   dept.attr('rowSpan', size);
                	   size = 1;
                	   money=tempMoney;
                	   subtotal = tempsubtotal;
                	   person = tempPerson;
                	   dept = tempDept;
                	   subtotal.text(money);
                  }
             }
            
          });
       }	
	
	
	function calculateFdAmount(){
	 var fdAmount = 0.0;
      jQuery("#item tr:gt(1)").each(function() {
    	  var subtotal = parseFloat(jQuery(this).find("#subtotal").text());
    	  if(subtotal){
    		  fdAmount = accAdd(fdAmount,subtotal);
    	  }
      });
      jQuery("#fdAmount").html(fdAmount);
	}
    jQuery(document).ready(function() {  
		var j = 0;
		var deptSize = "${listSize}";
		mergePerson("item");
		calculateFdAmount();
	});

</script>
<p class="txttitle"><c:out value="${kmOitemsMonthReportForm.docSubject}"/></p>
<div class='lui_form_title_frame'>
	<table class="tb_normal" width=100%>
	<tr><td colspan="4">
		  <table class="tb_normal" width=100% id="item">
		        <tr>
					<td colspan="9" class="td_normal_title">
					<center><b><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.receiveList"/></b></center>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.receiveDept"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.receivePerson"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.subtotal"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdCategory"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdName"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdUnit"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdReferencePrice"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdCount"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsReportListing.fdAmount"/></td>
				</tr>
				<c:forEach items="${mapItem}" var="item">
				<c:forEach items="${item.value}" var="kmOitemsReportListing"> 	
					<tr>
						<td><c:out value="${kmOitemsReportListing.docDept.deptLevelNames}"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.docCreator.deptLevelNames}"></c:out></td>
						<!-- 小计 -->
						<td id="subtotal">
						</td>
						<td><c:out value="${kmOitemsReportListing.fdCategory }"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.fdName }"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.fdUnit }"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.fdReferencePrice }"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.fdCount }"></c:out></td>
						<td><c:out value="${kmOitemsReportListing.fdAmount}"></c:out></td>
					</tr>
					</c:forEach>
				</c:forEach>
		</table>
	</td>
	</tr>
	<tr><td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.fdAmount"/>
	</td>
	<td colspan="8">
		<div id="fdAmount">
		</div>
	</td>
	</tr>
	<tr>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.docCreator"/></td>
	<td><c:out value="${kmOitemsMonthReportForm.docCreatorName}"></c:out></td>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.docCreateTime"/>
	</td>
	<td>
	<c:out value="${kmOitemsMonthReportForm.docCreateTime}"></c:out>
	</td>
	</tr>
	</table>
</div>
</template:replace>
</template:include>