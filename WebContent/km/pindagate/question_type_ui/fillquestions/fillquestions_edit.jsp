<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<template:include ref="default.dialog">
	<template:replace name="content" >
		<div id="showtip" style="display:none;position:absolute; top:100px; right:80px;z-index: 999"></div>
		<br/>
		<table class="tb_normal" width=90% >
			<tr>
				<td>
					<%--图例--%>
					<b><bean:message bundle="km-pindagate" key="kmPindagateQuestion.type.fillquestions"/></b>
				</td>
			</tr>
			<%--问题题目--%>
			<tr>
				<td bgcolor="#ECF0F6">
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.subject"/><span class="txtstrong">*</span>
				</td>
			</tr>
			<tr>
				<td>
					<xform:rtf property="subject" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf>
				</td>
			</tr>
			<%--附件--%>
			<tr>
				<td colspan="2"	width=100% >
					<iframe id="attFrame" src="" width=100%  height="0px;" frameborder=0 scrolling=no ></iframe>
				</td>
			</tr>
			<%--问题提示--%>
			<tr>
				<td bgcolor="#ECF0F6"><input type="checkbox" name="willProblem" id="willProblem" onclick="checkValueShow()" ><bean:message bundle="km-pindagate" key="kmPindagateQuestion.tip"/></td>
			</tr>
			<tr id="willValue" style="display:none">
				<td>
					<xform:rtf property="tip" showStatus="edit"   toolbarCanCollapse="all" height="150" width="100%"></xform:rtf>
				</td>
			</tr>
			<%--问题设置--%>
			<tr><td  bgcolor="#ECF0F6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.questionSeting"/></td></tr>
			<tr>
				<td>
					<input type="checkbox" name="willAnswer" id="willAnswer" value="true" >
					<bean:message bundle="km-pindagate" key="kmPindagateQuestion.willAnswer"/><br>
					<input type="checkbox" name="fillQues" id="fillQues">
					<%-- <bean:message bundle="km-pindagate" key="kmPindagateQuestion.hlist"/> --%>
					 <bean:message bundle="km-pindagate" key="kmPindagateQuestion.conValidation"/>
					 <span id="allcheck" style="display: none;">
					 
					<select type="text" id="questionsSel" onchange="questionsSel(this);" style="width: 160px;" class="inputsgl">
						<option value="1"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.integer"/></option>
						<option value="2"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.decimal"/></option>
						<option value="3"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.date"/></option>
						<option value="4"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.phone"/></option>
						<option value="5"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.email"/></option>
						<option value="6"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.provicity"/></option>
						<option value="7"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.idnumber"/></option>
						<option value="8"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.chinese"/></option>
						<option value="9"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.english"/></option>
					</select>
					<br/>
					<br/>
					<span id="integerVal">
					<input type="checkbox" id="range"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.scolimite"/> 
							<span style="display: none;">
								<bean:message bundle="km-pindagate" key="kmPindagateQuestion.min"/>：<input type="number" name="min" id="min" >
								<bean:message bundle="km-pindagate" key="kmPindagateQuestion.max"/>：<input type="number" name="max" id="max" >
							</span>
						<br/>
						<input type="checkbox" id="defVal"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.defaultValue"/>
						<span style="display: none;">
						    <input type="input" name="integerDef" id="integerDef" >
						</span>
						
					</span>
					<span id="dataVal" style="display: none;">
						<select type="text" id="dataSel" style="width: 160px;" name="dataSel" value="" class="inputsgl">
						<option value="1"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.date"/></option>
						<option value="2"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.time"/></option>
						<option value="3"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.date"/>/<bean:message bundle="km-pindagate" key="kmPindagateQuestion.time"/></option>
					</select>
					</span>
					
					<span id="stringVal" style="display: none;">
						<input type="checkbox" id="strDefVal"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.defaultValue"/>
						<span style="display: none;">
							<input type="input" name="strValDef" id="strValDef" >
						</span>
					</span>
						<span id="cutyVal" style="display: none;">
						<input type="checkbox" name="cityVal" id="cityVal"><bean:message bundle="km-pindagate" key="kmPindagateQuestion.defaultValue"/>
				            <span style="display: none;">
				            	<!--省份选择-->
					            <select id="prov" onchange="showCity(this)">
					                <option value="-1">=<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selProvince"/>=</option>
					 
					            </select>
					 
					            <!--城市选择-->
					            <select id="city" onchange="showCountry(this)">
					                <option value="-1">=<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selCity"/>=</option>
					            </select>
					 
					            <!--县区选择-->
					            <select id="country">
					                <option value="-1">=<bean:message bundle="km-pindagate" key="kmPindagateQuestion.selCounty"/>=</option>
					            </select>
				            </span>
						</span>
					</span>
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
		<%--JS--%>
		<script src="city.js"></script>
		<script src="method.js"></script>
	</template:replace>
</template:include>
<%@include file="/km/pindagate/question_type_ui/fillquestions/fillquestions_edit_script.jsp"%>