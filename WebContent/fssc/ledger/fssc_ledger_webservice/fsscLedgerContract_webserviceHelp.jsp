<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("optbar.js|list.js");
</script>
<script>
 function expandMethod(imgSrc,divSrc) {
	var imgSrcObj = document.getElementById(imgSrc);
	var divSrcObj = document.getElementById(divSrc);
	if(divSrcObj.style.display!=null && divSrcObj.style.display!="") {
		divSrcObj.style.display = "";
		imgSrcObj.src = "${KMSS_Parameter_StylePath}icons/collapse.gif";
	}else{
		divSrcObj.style.display = "none";
		imgSrcObj.src = "${KMSS_Parameter_StylePath}icons/expand.gif";		
	}
 }

 List_TBInfo = new Array(
			{TBID:"List_ViewTable1"},{TBID:"List_ViewTable2"},{TBID:"List_ViewTable3"},{TBID:"List_ViewTable4"},{TBID:"List_ViewTable5"},{TBID:"List_ViewTable6"}
		);
</script>


<div id="optBarDiv"><input type="button"
	value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${HtmlParam.name}服务接口说明</p>

<center>
<table class="tb_normal" width=95%>
	<tr>
		<td class="td_normal_title" width=15%>服务接口</td>
		<td width="85%">outsideLedgerContract(String jsonData)</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>功能描述</td>
		<td width="85%">导入合同台账</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回值</td>
		<td width="85%">添加结果（jsonObject）</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>接口入参JSONObject对应参数</td>
		<td width="85%"><img id="viewSrc1"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc1','paramDiv1')" style="cursor: pointer"><br>
		<div id="paramDiv1" style="display:none">
		<table id="List_ViewTable1" class="tb_noborder">
			<tr>
				<sunbor:columnHead htmlTag="td">
					<td width="40pt">序号</td>
				    <td width="20%">属性名</td>
				    <td width="20%">类 型</td>
				    <td width="10%">缺省值</td>
				    <td width="50%">描 述</td>
				</sunbor:columnHead>
			</tr>
			<tr>
				<td align="center">1</td>
				<td>fdContractName</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同名称</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>fdContractCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同编号</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td>fdErpNo</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>ERP核算编号</td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td>fdParentContractNo</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>上游合同号</td>
			</tr>
			<tr>
				<td align="center">5</td>
				<td>fdSupplierCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>签约公司编号（需和基础数据保持一致）</td>
			</tr>
			<tr>
				<td align="center">6</td>
				<td>fdSignDate</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>签约日期（格式2019-07-01）</td>
			</tr>
			<tr>
				<td align="center">7</td>
				<td>fdEffectDate</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同生效日期（格式2019-07-01）</td>
			</tr>
			<tr>
				<td align="center">8</td>
				<td>fdContractType</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同类别（1-定额合同；2-框架合同）</td>
			</tr>
			<tr>
				<td align="center">9</td>
				<td>fdContractStatus</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同状态（1-执行,2-暂停,3-终止,4-关闭）</td>
			</tr>
			<tr>
				<td align="center">10</td>
				<td>fdLedgerType</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同类型（1-收入；2-支出）</td>
			</tr>
			<tr>
				<td align="center">11</td>
				<td>fdAgentCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>经办人编码（需和基础数据保持一致）</td>
			</tr>
			<tr>
				<td align="center">12</td>
				<td>fdContractDeptCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>承办部门编码（需和基础数据保持一致）</td>
			</tr>
			<tr>
				<td align="center">13</td>
				<td>fdExecuteDeptDode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>执行部门编码（需和基础数据保持一致）</td>
			</tr>
			<tr>
				<td align="center">14</td>
				<td>fdCurrencySymbol</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>币种符号（需和基础数据保持一致）</td>
			</tr>
			<tr>
				<td align="center">15</td>
				<td>fdContractAmount</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>合同金额</td>
			</tr>
			<tr>
				<td align="center">16</td>
				<td>fdPerforBond</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>履约保证金</td>
			</tr>
			<tr>
				<td align="center">17</td>
				<td>fdPayedAmount</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>合同已付款</td>
			</tr>
			<tr>
				<td align="center">18</td>
				<td>fdUnpayAmount</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>合同未付款</td>
			</tr>
			<tr>
				<td align="center">19</td>
				<td>fdPayingAmount</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>合同付款中</td>
			</tr>
			<tr>
				<td align="center">20</td>
				<td>fdPrice</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>单价</td>
			</tr>
			<tr>
				<td align="center">21</td>
				<td>fdContractSubject</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>合同标的</td>
			</tr>
			<tr>
				<td align="center">22</td>
				<td>fdReason</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>变更原因</td>
			</tr>
			
			<tr>
				<td colspan="2">paymentCondition—付款条件</td>
			</tr>
			<tr>
				<td align="center">23</td>
				<td>fdPaymentPeriod</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>付款期</td>
			</tr>
			<tr>
				<td align="center">24</td>
				<td>fdClause</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>付款条件</td>
			</tr>
			<tr>
				<td align="center">25</td>
				<td>fdPaymentDate</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>约定付款日期（格式2019-07-01）</td>
			</tr>
			<tr>
				<td align="center">26</td>
				<td>fdPaymentRatio</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>付款比例</td>
			</tr>
			<tr>
				<td align="center">27</td>
				<td>fdPaymentAmount</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>付款金额</td>
			</tr>
			<tr>
				<td align="center">28</td>
				<td>fdLeftMoney</td>
				<td>数字类型（Double）</td>
				<td>无</td>
				<td>本期剩余应付金额</td>
			</tr>
			<tr>
				<td align="center">29</td>
				<td>fdPaymentMethod</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>标的</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回结果JSONObject说明</td>
		<td width="85%"><img id="viewSrc2"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc2','paramDiv2')" style="cursor: pointer"><br>
		<div id="paramDiv2" style="display:none">
		<table id="List_ViewTable2" class="tb_noborder">
			<tr>
				<sunbor:columnHead htmlTag="td">
					<td width="40pt">序号</td>
				    <td width="30%">属性名</td>
				    <td width="20%">类 型</td>
				    <td width="20%">缺省值</td>
				    <td width="30%">描 述</td>
				</sunbor:columnHead>
			</tr>
			<tr>
				<td align="center">1</td>
				<td>result</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>调用接口是否成功，0为成功，1为失败</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>errormsg</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>失败原因</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>参数样例</td>
		<td width="35%">参数是采用JSon格式传输，如：{"fdContractCode": "1","fdEffectDate": "2019-07-01","fdContractAmount": "1000000","paymentCondition":[{"fdPaymentPeriod":"第一期","fdClause":"完成50%","fdPaymentDate":"2019-07-01","fdPaymentRatio":"50%","fdPaymentAmount":"500000","fdPaymentMethod":"转账"},{"fdPaymentPeriod":"第二期","fdClause":"完成100%","fdPaymentDate":"2019-12-01","fdPaymentRatio":"50%","fdPaymentAmount":"500000","fdPaymentMethod":"转账"}]}。
		</td>
	</tr>				
	<tr>
		<td class="td_normal_title" width=15%>返回参数样例</td>
		<td width="35%">返回结果是采用JSon格式传输，如：<br />
			成功：<br />
			{<br />
				&nbsp;&nbsp;"result": "0",<br />
				&nbsp;&nbsp;"errormsg": ""
			}<br />

			失败：<br />
			{<br />
				&nbsp;&nbsp;"result": "1",<br />
				&nbsp;&nbsp;"errormsg": "合同编号为空或输入错误！"<br />
			}<br />
		</td>
	</tr>				
</table>
</center>

<%@ include file="/resource/jsp/view_down.jsp"%>