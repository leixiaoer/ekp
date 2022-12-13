<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div data-dojo-type="mui/table/ScrollableHContainer">
	<div data-dojo-type="mui/table/ScrollableHView">
		<table class="detailTableNormal" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="detailTableNormalTd">
					<table class="muiNormal selectedOitemTable" width="100%" border="0" cellspacing="0" cellpadding="0"
						data-dojo-type="km/oitems/mobile/resource/js/OitemsTable">
						<tr>
                       		<td><bean:message key="page.serial"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsShoppingTrolley.fdApplicationNumber"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/></td>
                       		<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/></td>
	                       	<td><bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/></td>
	                       	<td><bean:message  bundle="km-oitems" key="kmOitems.button.operation"/></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
</div>

<script>

	require(['dojo/topic', 'dojo/ready'], function(topic, ready){
		ready(function(){
			
			var oitems = [
				<c:forEach items="${kmOitemsBudgerApplicationForm.kmOitemsShoppingTrolleyFormList}" var="kmOitemsShoppingTrolleyForm" varStatus="vstatus">
					{
						fdId: '${kmOitemsShoppingTrolleyForm.fdId }',
						kmApplicationId: '${kmOitemsBudgerApplicationForm.fdId}',
						fdApplicationId: '${kmOitemsBudgerApplicationForm.fdId}',
						fdListingId: '${kmOitemsShoppingTrolleyForm.fdListingId}',
						kmWarehousingRecordJoinListId: '${kmOitemsShoppingTrolleyForm.kmWarehousingRecordJoinListId}',
						fdNo: '${kmOitemsShoppingTrolleyForm.fdNo}',
						fdName: '${kmOitemsShoppingTrolleyForm.fdName}',
						fdAmount: '${kmOitemsShoppingTrolleyForm.fdCurNum}',
						fdApplicationNumber: '${kmOitemsShoppingTrolleyForm.fdApplicationNumber}',
						fdReferencePrice: '${kmOitemsShoppingTrolleyForm.fdReferencePrice}',
						fdCategoryName: '${kmOitemsShoppingTrolleyForm.fdCategoryName}',
						fdSpecification: '${kmOitemsShoppingTrolleyForm.fdSpecification}',
						fdBrand: '${kmOitemsShoppingTrolleyForm.fdBrand}',
						fdUnit: '${kmOitemsShoppingTrolleyForm.fdUnit}'
					},
				</c:forEach>
             ];
			
			topic.publish('km/oitems/selectedoitem/init', oitems);
			
		});
	});

</script>
