<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/htmlhead.jsp" %>
<script type="text/javascript">
	Com_IncludeFile("document.js", "style/" + Com_Parameter.Style + "/doc/");
	Com_IncludeFile("jquery.js");
	Com_IncludeFile('json2.js');
	Com_IncludeFile('dialog.js');
	Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
</head>
<body>
	<form>
		<table class="tb_normal"  width=95%>
			<%@ include file="/km/supervise/fieldlayout/common/param_top.jsp"%>
			<c:import url="/km/supervise/fieldlayout/common/param_required.jsp" charEncoding="UTF-8">
				     <c:param name="defaultChecked" value="false" />
			</c:import>
			<c:import url="/km/supervise/fieldlayout/common/param_width.jsp" charEncoding="UTF-8">
				  <c:param name="defaultWidth" value="45%" />
		    </c:import>
		    <tr>
				<td colspan="2">
					<c:import url="/sys/xform/designer/fieldlayout/default_layout/param_style.jsp" charEncoding="UTF-8">
					</c:import>
				</td>
			</tr>
			<%@ include file="/km/supervise/fieldlayout/common/param_bottom.jsp"%>
		</table>
	</form>
</body>
</html>