<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<div id="showtip" style="display:none;position:absolute; top:100px; right:80px;z-index: 999"></div>
		<br/>
		<table class="tb_normal" width=90%>
			<tr>
				<td>
					<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.formfilled"/></b>
					<%-- <a href="#" onmousemove="showFigure(event,'images/caseDiagram.gif',10);" onmouseout="hideFigure(this);">
						(<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font>)
					</a> --%>
				</td>
			</tr>
			<tr>
				<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td><xform:rtf property="subject" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf></td>
			</tr>
			<tr>
				<td colspan="2"	width=100%>
					<iframe id="attFrame"  src="" width=100% height=0 frameborder=0 scrolling=no></iframe>
				</td>
			</tr>
			<tr>
				<td  bgcolor="#ECF0F6"><input type="checkbox" name="willProblem" id="willProblem" onclick="checkValueShow()" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/></td>
			</tr>
			<tr id="willValue" style="display:none">
				<td><xform:rtf property="tip" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf></td>
			</tr>
			<tr>
				<td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.titleForRow"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td>
					<table id="questionitemlist" class="tb_normal" width=100%>
						<tr>
							<td width="30" ><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addQuestionItem();" style="cursor:pointer;"></td>
							<td width="30" ><bean:message key="page.serial"/></td>
							<td width="425" align="center">
								<bean:message bundle="km-pindagate" key="kmPindagateQuestion.titleForRow"/>
								<!-- <span class="txtstrong">*</span> -->
								<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.columnHeadings"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td>
					<table id="selectitemlist" class="tb_normal" width=100%>
						<tr>
							<td width="30"><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addSelectItem();" style="cursor:pointer;"></td>
							<td width="30"><bean:message key="page.serial"/></td>
							<td width="425"  align="center">
								<bean:message bundle="km-pindagate" key="kmPindagateQuestion.columnHeadings"/>
								<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="willAnswer" id="willAnswer" value="true" >
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
				</td>
			</tr>
			<tr>
				<td align="center">
					<ui:button text="${lfn:message('button.save') }" onclick="save();" ></ui:button>&nbsp;
					<ui:button text="${lfn:message('button.close') }" onclick="_close();"  styleClass="lui_toolbar_btn_gray"></ui:button>
				</td>
			</tr>
		</table>
		<DIV id="dHTMLToolTip"  style="Z-INDEX: 1000; LEFT: 0px; VISIBILITY: hidden; WIDTH: 10px; POSITION: absolute; TOP: 0px; HEIGHT: 10px"></DIV>
		<%--防止IE下出现水平滚动条--%>
		<style type="text/css">body {overflow-x:hidden;}</style>
		<%--JS --%>
	</template:replace>
</template:include>
<%@include file="/km/pindagate/question_type_ui/formfilled/formfilled_edit_script.jsp"%>