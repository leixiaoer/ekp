<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script>
Com_IncludeFile("jquery.js");
</script>
<script>
	function confirmDelete(msg){
	var del = confirm("<bean:message key="page.comfirmDelete"/>");
	return del;
}
   /*** 部门合并方法
    function mergeDept(id,size){
        var j = 0; 
    	jQuery("#"+id+" tr:gt(0)").each(function() {
           j++;
           var dept = jQuery(this).find("td:eq(0)"); //部门
    	   if(j == 1){
    		   dept.attr('rowSpan', size);
        	   }
    	   else{
    		   dept.remove();
        	   }
        	});
        }	
       ***/
	//人员合并
    function mergePerson(id){
        var dept; // 部门
        var person = "";
        var size;
        var money=0.0;
        var subtotal;
    	jQuery("#"+id+" tr:gt(0)").each(function() {

            if(person==""){
        	   money += parseFloat((jQuery(this).find("td:eq(8)").text())); //金额
        	   size = 1;
        	   dept = jQuery(this).find("td:eq(0)"); //部门
               person = jQuery(this).find("td:eq(1)"); //所属人员
               subtotal = jQuery(this).find("td:eq(2)"); //小计
               subtotal.text(money);
           }
           else{
             var tempMoney = parseFloat((jQuery(this).find("td:eq(8)").text())); //临时金额
             var tempPerson = jQuery(this).find("td:eq(1)"); //临时人员
             var tempsubtotal = jQuery(this).find("td:eq(2)"); //临时小计
             var tempDept = jQuery(this).find("td:eq(0)"); //临时小计
                if(person.text()==tempPerson.text()){
            	   size++;
            	   money += tempMoney;
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
                       }
               }
        	});
        }	
    jQuery(document).ready(function() {  
		var j = 0;
		var deptSize = "${listSize}";
		//mergeDept("item",deptSize);
		mergePerson("item");
		});
</script>
<div id="optBarDiv">
	<kmss:auth requestURL="/geesun/oitems/geesun_oitems_month_report/geesunOitemsMonthReport.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('geesunOitemsMonthReport.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><c:out value="${geesunOitemsMonthReportForm.docSubject}"/></p>

<center>
<table id="Label_Tabel" width=95%>
    <!-- 基本信息 -->
	<tr  LKS_LabelName="<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.base.massage" />">
		<td>
			<table class="tb_normal" width=100%>
	<%-- 
	 <tr>
		<!-- 主题 -->		
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsBudgerApplication.docSubject"/>
		</td><td width="35%">
			<xform:text property="docSubject" style="width:85%" />
		</td>
		<!--部门  -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.docDept"/>
		</td>
		<td width="35%">
			<c:out value="${geesunOitemsMonthReportForm.docDeptName}" />
		</td>
	</tr>
	--%>
	<tr><td colspan="4"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveList"/><br>
		  <table class="tb_normal" width=100% id="item">
				<tr>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveDept"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.receivePerson"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.subtotal"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdCategory"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdName"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdUnit"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdReferencePrice"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdCount"/></td>
					<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsReportListing.fdAmount"/></td>
				</tr>
				<c:forEach items="${mapItem}" var="item">
				<c:forEach items="${item.value}" var="geesunOitemsReportListing"> 	
					<tr>
						<td>${geesunOitemsReportListing.docDept.fdName}</td>
						<td>${geesunOitemsReportListing.docCreator.fdName}</td>
						<!-- 小计 -->
						<td>
						</td>
						<td>${geesunOitemsReportListing.fdCategory }</td>
						<td>${geesunOitemsReportListing.fdName }</td>
						<td>${geesunOitemsReportListing.fdUnit }</td>
						<td>${geesunOitemsReportListing.fdReferencePrice }</td>
						<td>${geesunOitemsReportListing.fdCount }</td>
						<td>${geesunOitemsReportListing.fdAmount}</td>
					</tr>
					</c:forEach>
				</c:forEach>
		</table>
	</td>
	</tr>
	<tr><td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.fdAmount"/>
	</td>
	<td colspan="8">
	${geesunOitemsMonthReportForm.fdAmount}
	</td>
	</tr>
	<tr>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.docCreator"/></td>
	<td>${geesunOitemsMonthReportForm.docCreatorName}</td>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="geesun-oitems" key="geesunOitemsMonthReport.docCreateTime"/>
	</td>
	<td>
	${geesunOitemsMonthReportForm.docCreateTime}
	</td>
	</tr>
	</table>
	</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>
