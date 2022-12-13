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
	<kmss:auth requestURL="/km/oitems/km_oitems_month_report/kmOitemsMonthReport.do?method=delete&fdId=${param.fdId}" requestMethod="GET">
		<input type="button"
			value="<bean:message key="button.delete"/>"
			onclick="if(!confirmDelete())return;Com_OpenWindow('kmOitemsMonthReport.do?method=delete&fdId=${param.fdId}','_self');">
	</kmss:auth>
	<input type="button"
		value="<bean:message key="button.close"/>"
		onclick="Com_CloseWindow();">
</div>

<p class="txttitle"><c:out value="${kmOitemsMonthReportForm.docSubject}"/></p>

<center>
<table id="Label_Tabel" width=95%>
    <!-- 基本信息 -->
	<tr  LKS_LabelName="<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.base.massage" />">
		<td>
			<table class="tb_normal" width=100%>
	<%-- 
	 <tr>
		<!-- 主题 -->		
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsBudgerApplication.docSubject"/>
		</td><td width="35%">
			<xform:text property="docSubject" style="width:85%" />
		</td>
		<!--部门  -->
		<td class="td_normal_title" width=15%>
			<bean:message bundle="km-oitems" key="kmOitemsMonthReport.docDept"/>
		</td>
		<td width="35%">
			<c:out value="${kmOitemsMonthReportForm.docDeptName}" />
		</td>
	</tr>
	--%>
	<tr><td colspan="4"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.receiveList"/><br>
		  <table class="tb_normal" width=100% id="item">
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
						<td>${kmOitemsReportListing.docDept.fdName}</td>
						<td>${kmOitemsReportListing.docCreator.fdName}</td>
						<!-- 小计 -->
						<td>
						</td>
						<td>${kmOitemsReportListing.fdCategory }</td>
						<td>${kmOitemsReportListing.fdName }</td>
						<td>${kmOitemsReportListing.fdUnit }</td>
						<td>${kmOitemsReportListing.fdReferencePrice }</td>
						<td>${kmOitemsReportListing.fdCount }</td>
						<td>${kmOitemsReportListing.fdAmount}</td>
					</tr>
					</c:forEach>
				</c:forEach>
		</table>
	</td>
	</tr>
	<tr><td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.fdAmount"/>
	</td>
	<td colspan="8">
	${kmOitemsMonthReportForm.fdAmount}
	</td>
	</tr>
	<tr>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.docCreator"/></td>
	<td>${kmOitemsMonthReportForm.docCreatorName}</td>
	<td class="td_normal_title" width="10%" align="center"><bean:message  bundle="km-oitems" key="kmOitemsMonthReport.docCreateTime"/>
	</td>
	<td>
	${kmOitemsMonthReportForm.docCreateTime}
	</td>
	</tr>
	</table>
	</td>
	</tr>
</table>
</center>
<%@ include file="/resource/jsp/view_down.jsp"%>