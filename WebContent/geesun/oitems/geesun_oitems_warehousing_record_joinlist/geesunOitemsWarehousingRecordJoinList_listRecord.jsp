<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript" src="../js/geesunOitemsWarehousingRecord_checkedSelected.js">
</script>
<script type="text/javascript">
Com_IncludeFile("document.css", "style/"+Com_Parameter.Style+"/doc/");
</script>
<html:form action="/geesun/oitems/geesun_oitems_warehousing_record/geesunOitemsWarehousingRecord.do">
<c:if test="${queryPage.totalrows==0}">
	<%@ include file="/resource/jsp/list_norecord.jsp"%>
</c:if>
<c:if test="${queryPage.totalrows>0}">
	<%@ include file="/resource/jsp/list_pagenav_top.jsp"%>
	<table id="List_ViewTable">
		<tr>
			<sunbor:columnHead htmlTag="td">
			    <td></td>
				<td width="40pt"><bean:message key="page.serial"/></td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdNumber"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdCurNumber"/>
				</td>
				<td>
					<bean:message  bundle="geesun-oitems" key="geesunOitemsWarehousingRecord.fdPrice"/>
				</td>				
			</sunbor:columnHead>
		</tr>
		<c:forEach items="${queryPage.list}" var="geesunOitemsWarehousingRecordJoinList" varStatus="vstatus">
		<c:set var="geesunOitemsListingId" value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId}"/>
			<tr onclick="requestxml(null,'${vstatus.index+1}','${geesunOitemsListingId}','${JsParam.fdApplicationId}','${geesunOitemsWarehousingRecordJoinList.fdId}','${geesunOitemsWarehousingRecordJoinList.fdPrice}','${geesunOitemsWarehousingRecordJoinList.fdCurNumber}','');">
			    <td>
					<input type="checkbox" name="List_Selected" id="id${vstatus.index+1}" value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdId}" onclick="requestxml(this,'${vstatus.index+1}','${geesunOitemsListingId}','${JsParam.fdApplicationId}','${geesunOitemsWarehousingRecordJoinList.fdId}','${geesunOitemsWarehousingRecordJoinList.fdPrice}','${geesunOitemsWarehousingRecordJoinList.fdCurNumber}','');">
				</td>
				<td>${vstatus.index+1}</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdCategory.fdName}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdSpecification}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdBrand}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.geesunOitemsListing.fdUnit}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.fdNumber}" />
				</td>
				<td>
					<c:out value="${geesunOitemsWarehousingRecordJoinList.fdCurNumber}" />
				</td>
				<td>
				  <kmss:showNumber value="${geesunOitemsWarehousingRecordJoinList.fdPrice}" pattern="#,##0.00#"></kmss:showNumber>
				</td>					
			</tr>
		</c:forEach>
	</table>
	<br/>
	<center><input type=button class="btnopt" value="<bean:message key="button.ok"/>"
			onclick="submitOk();">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button class="btnopt" value="<bean:message key="button.cancelSelect"/>"
			onclick="CloseW();">&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button class="btnopt" value="<bean:message key="button.close"/>"
			onclick="CloseW();">
			</center>
	<%@ include file="/resource/jsp/list_pagenav_down.jsp" %>
</c:if>
</html:form>
 <script type="text/javascript" src="${KMSS_Parameter_ContextPath}resource/js/jquery.js"></script>
<script type="text/javascript">

	function CloseW() {
		requestxml('','','${geesunOitemsListingId}','${JsParam.fdApplicationId}','','','','1','');
		$dialog.hide("1");
	}
	function submitOk(){
		var flag = true;
		$("input[type='checkbox']").each(function(){    
           if($(this).is(":checked")){    
        	   flag = false;   
            }
        });
		if(flag){
			alert("请选择物品!");
			return;
		}
		$dialog.hide();
	}
</script>
<%@ include file="/resource/jsp/list_down.jsp"%>
