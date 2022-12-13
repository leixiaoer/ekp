<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%-- 查询栏--%>
	<center>
		<div style="width: 98%">
			<table width="90%" class="tb_normal"  >
				<tr>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.docSubject"/>
					</td>
					<td>
						<input class="inputsgl" type="text" size="20" name="docSubject" value="${docSubject}">
					</td>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
					</td>
					<td>
						<input class="inputsgl" type="text" size="20" name="fdNo" value="${fdNo}">
					</td>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.docStatus"/>
					</td>
					<td>
						
					</td>
					<td>
						<input type="button" class="btnopt" id="ok_id" 
							value="<bean:message  bundle="km-provider" key="kmProviderMain.btn.search"/>" onclick="findApply();"/>
							&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="btnopt" 
							value="<bean:message  bundle="km-provider" key="kmProviderMain.btn.clear"/>" onclick="clear_value();"/>
					</td>
				</tr>
				<tr>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.fdCreator"/>
					</td>
					<td>
						<input name="creatorId" type="hidden" value="${creatorId}">
						<input class="inputsgl" type="text" name="creatorName" value="${creatorName}" readonly="readonly">
						<a href="#"
							  onclick="Dialog_Address(true, 'creatorId', 'creatorName', ';', 'ORG_TYPE_PERSON')">
						   <bean:message key="dialog.selectOther" />
						 </a>
					</td>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.fdCreateDate"/>
					</td>
					<td>
						<input class="inputsgl"  type="text" name="createDate" value="${createDate}" readonly="readonly">
						 <a href="#" onclick="selectDateTime('createDate');"> <bean:message key="dialog.selectTime" /></a> 
					</td>
					<td class="td_normal_title">
						<bean:message  bundle="km-asset" key="kmAssetApplyBase.fdApplyTemplate"/>
					</td>
					<td  colspan="2">
						
					</td>
				</tr>
			
			</table>
		</div>
	</center>