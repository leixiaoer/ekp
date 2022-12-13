<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<meta http-equiv="x-ua-compatible" content="IE=7" >
	<frameset cols="20%,80%" framespacing=1 bordercolor=#003048 frameborder=1>
		<frame id="treeFrame" src="<%=request.getContextPath() %>/km/asset/card_category_tree.jsp?isParentCard=<%=request.getParameter("isParentCard")%>&status=<%=request.getParameter("status") %>" />
		<frameset rows="90%,10%" framespacing=1 bordercolor=#003048 frameborder=0>
			<FRAME noresize scrolling=yes id="optFrame" name='optFrame' frameborder=0 src="<%=request.getContextPath() %>/km/asset/km_asset_card/kmAssetCard.do?method=list&isDialog=0&isParentCard=${HtmlParam.isParentCard}&status=${HtmlParam.status}" />
			<frame noresize scrolling=no id="optFrame2" name=optFrame2 frameborder=0 src="<%=request.getContextPath() %>/km/asset/km_asset_card/kmAssetCard_button_dialog.jsp">
		</frameset>
		
	</frameset>
