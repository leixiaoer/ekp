<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div data-dojo-type="mui/table/ScrollableHContainer">
	<div data-dojo-type="mui/table/ScrollableHView">
		<table class="detailTableNormal" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="detailTableNormalTd">
					<table class="muiNormal selectedOitemTable" width="100%" border="0" cellspacing="0" cellpadding="0"
						data-dojo-type="geesun/oitems/mobile/resource/js/OitemsTable">
						<tr>
                       		<td><bean:message key="page.serial"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdNo"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdName"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdAmount"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsShoppingTrolley.fdApplicationNumber"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdReferencePrice"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdCategoryId"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdSpecification"/></td>
                       		<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdBrand"/></td>
	                       	<td><bean:message  bundle="geesun-oitems" key="geesunOitemsListing.fdUnit"/></td>
	                       	<td><bean:message  bundle="geesun-oitems" key="geesunOitems.button.operation"/></td>
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
				<c:forEach items="${geesunOitemsBudgerApplicationForm.geesunOitemsShoppingTrolleyFormList}" var="geesunOitemsShoppingTrolleyForm" varStatus="vstatus">
					{
						fdId: '${geesunOitemsShoppingTrolleyForm.fdId }',
						kmApplicationId: '${geesunOitemsBudgerApplicationForm.fdId}',
						fdApplicationId: '${geesunOitemsBudgerApplicationForm.fdId}',
						fdListingId: '${geesunOitemsShoppingTrolleyForm.fdListingId}',
						kmWarehousingRecordJoinListId: '${geesunOitemsShoppingTrolleyForm.kmWarehousingRecordJoinListId}',
						fdNo: '${geesunOitemsShoppingTrolleyForm.fdNo}',
						fdName: '${geesunOitemsShoppingTrolleyForm.fdName}',
						fdAmount: '${geesunOitemsShoppingTrolleyForm.fdCurNum}',
						fdApplicationNumber: '${geesunOitemsShoppingTrolleyForm.fdApplicationNumber}',
						fdReferencePrice: '${geesunOitemsShoppingTrolleyForm.fdReferencePrice}',
						fdCategoryName: '${geesunOitemsShoppingTrolleyForm.fdCategoryName}',
						fdSpecification: '${geesunOitemsShoppingTrolleyForm.fdSpecification}',
						fdBrand: '${geesunOitemsShoppingTrolleyForm.fdBrand}',
						fdUnit: '${geesunOitemsShoppingTrolleyForm.fdUnit}'
					},
				</c:forEach>
             ];
			
			topic.publish('geesun/oitems/selectedoitem/init', oitems);
			
		});
	});

</script>
