<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<br/>
		<%--提示信息--%>
		<div id="showtip" style="display:none;position:absolute; top:100px; right:60px;z-index: 999;width: 80%;"></div>
		<table class="tb_normal" width=90%>
			<tr>
				<td>
					<%--图例--%>
					<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.essayquestion"/></b>&nbsp;&nbsp;&nbsp;
					<a href="#" onmousemove="showFigure(event,'images/caseDiagram.gif',10);" onmouseout="hideFigure(this);"><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font></a>
				</td>
			</tr>
			<%--题目文字--%>
			<tr>
				<td bgcolor="#ECF0F6">
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span>
				</td>
			</tr>
			<tr>
				<td><xform:rtf property="subject" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf></td>
			</tr>
			<%--附件--%>
			<tr>
				<td colspan="2"	width=100%>
					<iframe id="attFrame"  src="" width=100% height=0  frameborder=0 scrolling=no></iframe>
				</td>
			</tr>
			<%--问题提示--%>
			<tr>
				<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/></td>
			</tr>
			<tr>
				<td><xform:rtf property="tip" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf></td>
			</tr>
			<%--问题设置--%>
			<tr>
				<td>
					<input type="checkbox" name="willAnswer" id="willAnswer" value="true" >
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
	        		<bean:message bundle="km-pindagate" key="kmPindagateQuestion.textarea.height"/>
	        		<input id="textHeight" name="textHeight" type="text" value="5" class="inputsgl"  style="width: 30px;" />
	        		<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.unit.line"/></font>
				</td>
			</tr>
			<tr>
				<td align="center">
					<ui:button text="${lfn:message('button.save') }" onclick="save();"></ui:button>&nbsp;
					<ui:button text="${lfn:message('button.close') }" onclick="_close();" styleClass="lui_toolbar_btn_gray"></ui:button>
				</td>
			</tr>
		</table>
		<%--防止IE下出现水平滚动条--%>
		<style type="text/css">body {overflow-x:hidden;}</style>
		<%--JS--%>
  </template:replace>
</template:include>
<%@include file="/km/pindagate/question_type_ui/essayquestion/essayquestion_edit_script.jsp"%>