<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.dialog">
	<template:replace name="content" >
		<div id="showtip" style="display:none;position:absolute; top:100px; right:80px;z-index: 999"></div>
		<br/>
		<table class="tb_normal" width=90%>
			<tr>
				<td>
					<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scorematrix"/></b>&nbsp;&nbsp;&nbsp;
					<a href="#" onmousemove="showFigure(event,'images/caseDiagram.gif',10);" onmouseout="hideFigure(this);"><font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.legend"/></font></a>
				</td>
			</tr>
			<tr>
				<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td>
					<xform:rtf property="subject" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf>
				</td>
			</tr>
			<tr>
				<td colspan="2"	width=100%>
					<iframe id="attFrame"  src="" width=100% height=0 frameborder=0 scrolling=no></iframe>
				</td>
			</tr>
			<tr>
				<td bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/></td>
			</tr>
			<tr>
				<td><xform:rtf property="tip" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf></td>
			</tr>
			<tr>
				<td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.question"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td>
					<table id="questionitemlist" class="tb_normal" width=100%>
						<tr>
							<td width="30" ><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addQuestionItem();" style="cursor:pointer;"></td>
							<td width="30" ><bean:message key="page.serial"/></td>
							<td width="245" align="center"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/>&nbsp;&nbsp;&nbsp;&nbsp;<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font></td>
							<td width="180" align="center"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.image.title"/></td>
						</tr>
					</table>
				</td>
			</tr>
				<tr>
				<td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.option"/><span class="txtstrong">*</span></td>
			</tr>
			<tr>
				<td>
					<table id="selectitemlist" class="tb_normal" width=100%>
						<tr>
							<td width="30"><img src="${KMSS_Parameter_StylePath}icons/add.gif" onclick="addSelectItem();" style="cursor:hand"></td>
							<td width="30"><bean:message key="page.serial"/></td>
							<td width="245" align="center"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.quetItem"/>&nbsp;&nbsp;&nbsp;&nbsp;<font color=red><bean:message bundle="km-pindagate" key="kmPindagateQuestion.IncreasedMulti"/></font></td>
							<td width="180" align="center"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.scoreValue"/></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
			<tr>
				<td>
					<input type="checkbox" name="willAnswer" id="willAnswer" value="true" >
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
					<input type="checkbox" name="hlist" id="hlist" value="true">
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.matrix.hlist"/>
					<br/>
					<input type="checkbox" name="autoAddSelectReason" id="autoAddSelectReason" value="true" >
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.autoAddSelectReason"/>
					<span id="div_selectReasonText" style="display: none;">
						,<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selectReasonText"/>
						<input type="text" id="selectReasonText" name="selectReasonText" value="" class="inputsgl">
					</span><br>
					<input type="checkbox" name="showAverage" id="showAverage" value="true" checked="checked">
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.showAverage"/>
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
<%@include file="/km/pindagate/question_type_ui/scorematrix/scorematrix_edit_script.jsp"%>