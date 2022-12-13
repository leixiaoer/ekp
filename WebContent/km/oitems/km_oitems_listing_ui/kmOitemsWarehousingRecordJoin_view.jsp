<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ include file="/resource/jsp/view_top.jsp" %>

<center>
	<table class="tb_normal" id="Label_Tabel" width="95%">
		<tr LKS_LabelName="入库明细" >
			<td>
				<c:import url="/km/oitems/km_oitems_warehousing_record/kmOitemsWarehousingRecord.do?method=list&fdListingId=${JsParam.fdListing}&fdPrice=${JsParam.fdPrice}" charEncoding="UTF-8">
				</c:import>
			</td>
		</tr>
		
		<tr LKS_LabelName="领用明细">
			<td>
				<c:import url="/km/oitems/km_oitems_shopping_trolley/kmOitemsShoppingTrolley.do?method=data&warehouseId=${JsParam.warehouseId}" charEncoding="UTF-8">
				</c:import>
			</td>
		</tr>
	</table>
</center>
