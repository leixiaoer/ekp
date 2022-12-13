<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.landray.kmss.km.oitems.model.KmOitemsListing"%>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
<script type="text/javascript">
		

</script>
<html:form action="/km/oitems/km_oitems_budger_application/kmOitemsBudgerApplication.do">
	<div id="optBarDiv">
			<input type="button" value="<bean:message  key="button.export"/>"
				onclick="Com_Submit(document.kmOitemsBudgerApplicationForm, 'deptExport');">
	</div>
	<center>
	<div>
		<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.start.time"/> <input class="inputsgl" class="inputsgl" type="text" name="fdStartTime" readonly="readonly" value="${fdStartTime }">
		<a href="#"
						onclick="selectDate('fdStartTime');"><bean:message
						key="dialog.selectOther" /></a> &nbsp;&nbsp;&nbsp;
		<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.end.time"/> <input class="inputsgl" class="inputsgl" type="text" name="fdEndTime" readonly="readonly" value="${fdEndTime }">
		<a href="#"
						onclick="selectDate('fdEndTime');"><bean:message
						key="dialog.selectOther" /></a> &nbsp;&nbsp;&nbsp;
		<bean:message  bundle="km-oitems" key="table.kmOitemsManage"/> <input name="fdCategoryId" type="hidden" value="${fdCategoryId }"><input class="inputsgl" type="text" name="fdCategoryName" readonly="readonly" value="${fdCategoryName }">
		<a href="#"
						onclick="Dialog_Tree(true, 
				 'fdCategoryId', 
				 'fdCategoryName', 
				 ',', 
				 'kmOitemsManageServiceTree&categoryId=!{value}&nodeType=!{nodeType}', 
				 '<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>',
				  null, null,
				   null, null, null,
				   '<bean:message key="table.kmOitemsManage" bundle="km-oitems"/>')"><bean:message
						key="dialog.selectOther" /> </a>
		&nbsp;&nbsp;&nbsp;<bean:message  bundle="km-oitems" key="kmOitemsBudgerApplication.dept"/> <input name="fdDeptId" type="hidden" value="${fdDeptId }"><input class="inputsgl" type="text" name="fdDeptName" readonly="readonly" value="${fdDeptName }">
		 <a href="#"
						onclick="Dialog_Address(true, 'fdDeptId', 'fdDeptName', ';',ORG_TYPE_DEPT);"><bean:message
						key="dialog.selectOther" /></a>
		&nbsp;&nbsp;&nbsp; 
		<input type="button" value="<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.find"/>"
				onclick="Com_Submit(document.kmOitemsBudgerApplicationForm, 'count');">
	</div>
	</br>
	
	<div style="width:96%;height:400px;">
	<table width="100%"  class="tb_normal">
		<tr class="td_normal_title" height="30px" >		
				<td  width="5%"><bean:message key="page.serial"/></td>
				<td  width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
				</td>
				<td width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
				</td>
				<td width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
				</td>
				<td width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
				</td>
				<td width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
				</td>
				<td width="5%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
				</td>
				<td width="5%">
					<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/>
				</td>
				<td width="5%">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerListing.fdApplicationNumber"/>
				</td>
				<td width="10%">
					<bean:message  bundle="km-oitems" key="kmOitemsBudgerListing.total.money"/>
				</td>
		
		</tr>
		<%
			Map kmOitemsListingMap = (Map)request.getAttribute("kmOitemsListingMap"); 
			 Iterator   iterator=kmOitemsListingMap.keySet().iterator();  
			 int number=1 ;
			 while(iterator.hasNext()){ 
				 String      key=(String)iterator.next();   
				 KmOitemsListing   kmOitemsListing=(KmOitemsListing)kmOitemsListingMap.get(key);
		%>
			<tr height="30px">
				<td><%=number %></td>
				<td>
					<%=kmOitemsListing.getFdNo() %>
				</td>
				<td>
					<%=kmOitemsListing.getFdName() %>
				</td>
				<td>
					<%if(kmOitemsListing.getFdCategory()!=null){
					%>
					<%=kmOitemsListing.getFdCategory().getFdName() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(kmOitemsListing.getFdSpecification()!=null){
					%>
					<%=kmOitemsListing.getFdSpecification() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(kmOitemsListing.getFdBrand()!=null){
					%>
					<%=kmOitemsListing.getFdBrand() %>
					<%	
					}
					%>
				</td>
				<td>
					<%if(kmOitemsListing.getFdUnit()!=null){
					%>
					<%=kmOitemsListing.getFdUnit() %>
					<%	
					}
					%>
				</td>
				<td>
					<%=kmOitemsListing.getFdReferencePrice() %>
				</td>
				<td>
					<%=kmOitemsListing.getFdAmount() %>
				</td>
				<td>
					<%=kmOitemsListing.getFdAmount()*kmOitemsListing.getFdReferencePrice() %>
				</td>
			</tr>
		<% number++;} %>
	</table>
	</div>
	</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>