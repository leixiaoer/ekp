<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.geesun.oitems.model.GeesunOitemsListing"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script type="text/javascript">
		

</script>
<html:form action="/geesun/oitems/geesun_oitems_budger_application/geesunOitemsBudgerApplication.do">
	<div id="optBarDiv">
			<input type="button" value="<bean:message  key="button.export"/>"
				onclick="Com_Submit(document.geesunOitemsBudgerApplicationForm, 'deptExport');">
	</div>
	<center>
	<div>
		<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.start.time"/> <input class="inputsgl" class="inputsgl" type="text" name="fdStartTime" readonly="readonly" value="${fdStartTime }">
		<a href="#"
						onclick="selectDate('fdStartTime');"><bean:message
						key="dialog.selectOther" /></a> &nbsp;&nbsp;&nbsp;
		<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.end.time"/> <input class="inputsgl" class="inputsgl" type="text" name="fdEndTime" readonly="readonly" value="${fdEndTime }">
		<a href="#"
						onclick="selectDate('fdEndTime');"><bean:message
						key="dialog.selectOther" /></a> &nbsp;&nbsp;&nbsp;
		<bean:message  bundle="geesun-oitems" key="table.geesunOitemsManage"/> <input name="fdCategoryId" type="hidden" value="${fdCategoryId }"><input class="inputsgl" type="text" name="fdCategoryName" readonly="readonly" value="${fdCategoryName }">
		<a href="#"
						onclick="Dialog_Tree(true, 
				 'fdCategoryId', 
				 'fdCategoryName', 
				 ',', 
				 'geesunOitemsManageServiceTree&categoryId=!{value}&nodeType=!{nodeType}', 
				 '<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>',
				  null, null,
				   null, null, null,
				   '<bean:message key="table.geesunOitemsManage" bundle="geesun-oitems"/>')"><bean:message
						key="dialog.selectOther" /> </a>
		&nbsp;&nbsp;&nbsp;<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerApplication.dept"/> <input name="fdDeptId" type="hidden" value="${fdDeptId }"><input class="inputsgl" type="text" name="fdDeptName" readonly="readonly" value="${fdDeptName }">
		 <a href="#"
						onclick="Dialog_Address(true, 'fdDeptId', 'fdDeptName', ';',ORG_TYPE_DEPT);"><bean:message
						key="dialog.selectOther" /></a>
		&nbsp;&nbsp;&nbsp; 
		<input type="button" value="<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.find"/>"
				onclick="Com_Submit(document.geesunOitemsBudgerApplicationForm, 'count');">
	</div>
	</br>
	
	<div style="width:96%;height:400px;">
	<table width="100%"  class="tb_normal">
		<tr class="td_normal_title" height="30px" >		
				<td  width="5%"><bean:message key="page.serial"/></td>
				<td  width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/>
				</td>
				<td width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</td>
				<td width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</td>
				<td width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</td>
				<td width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</td>
				<td width="5%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</td>
				<td width="5%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/>
				</td>
				<td width="5%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerListing.fdApplicationNumber"/>
				</td>
				<td width="10%">
					<bean:message  bundle="geesun-oitems" key="geesunOitemsBudgerListing.total.money"/>
				</td>
		
		</tr>
		<%
			Map geesunOitemsListingMap = (Map)request.getAttribute("geesunOitemsListingMap"); 
			 Iterator   iterator=geesunOitemsListingMap.keySet().iterator();  
			 int number=1 ;
			 while(iterator.hasNext()){ 
				 String      key=(String)iterator.next();   
				 GeesunOitemsListing   geesunOitemsListing=(GeesunOitemsListing)geesunOitemsListingMap.get(key);
		%>
			<tr height="30px">
				<td><%=number %></td>
				<td>
					<%=geesunOitemsListing.getFdNo() %>
				</td>
				<td>
					<%=geesunOitemsListing.getFdName() %>
				</td>
				<td>
					<%if(geesunOitemsListing.getFdCategory()!=null){
					%>
					<%=geesunOitemsListing.getFdCategory().getFdName() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(geesunOitemsListing.getFdSpecification()!=null){
					%>
					<%=geesunOitemsListing.getFdSpecification() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(geesunOitemsListing.getFdBrand()!=null){
					%>
					<%=geesunOitemsListing.getFdBrand() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(geesunOitemsListing.getFdUnit()!=null){
					%>
					<%=geesunOitemsListing.getFdUnit() %>
					<%	
					}
					%>
				</td>
				<td>
					<%=geesunOitemsListing.getFdReferencePrice() %>
				</td>
				<td>
					<%=geesunOitemsListing.getFdAmount() %>
				</td>
				<td>
					<%=geesunOitemsListing.getFdAmount()*geesunOitemsListing.getFdReferencePrice() %>
				</td>
			</tr>
		<% number++;} %>
	</table>
	</div>
	</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>
