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
		<td width="85%">matchMaterialStock(String jsonData)</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>功能描述</td>
		<td width="85%">匹配物资信息。由于库存和需求共用，通过fdStockFlag区分。stock标识库存，demand标识需求。</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回值</td>
		<td width="85%">匹配到的物资信息返回值（JSONArray）</td>
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
				<td>fdStockId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>对应库存的ID</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>fdCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>物资编码（需和物资台账保持一致）</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td>fdStockFlag</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>标识（stock标识库存，demand标识需求）</td>
			</tr>
		</table></div>
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
				<td>调用接口是否成功，0为程序运行异常，message为失败原因,2为成功</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>data</td>
				<td>字符串（JSONObject）</td>
				<td>无</td>
				<td>返回的物资信息json对象</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td>fdStockId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>返回的库存初始化Id</td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td>init</td>
				<td>整数型（Integer）</td>
				<td>0</td>
				<td>库存初始化数量</td>
			</tr>									
			<tr>
				<td align="center">5</td>
				<td>left</td>
				<td>整数型（Integer）</td>
				<td>0</td>
				<td>剩余库存</td>
			</tr>									
			<tr>
				<td align="center">6</td>
				<td>used</td>
				<td>整数型（Integer）</td>
				<td>0</td>
				<td>已领用库存</td>
			</tr>									
			<tr>
				<td align="center">7</td>
				<td>useing</td>
				<td>整数型（Integer）</td>
				<td>0</td>
				<td>领用中库存</td>
			</tr>									
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>物资匹配参数样例</td>
		<td width="35%">物资匹配参数是采用JSon格式传输，如：{'fdCode':'2006','fdStockFlag':'stock'}。	
		</td>
	</tr>				
	<tr>
		<td class="td_normal_title" width=15%>物资匹配返回参数样例</td>
		<td width="35%">物资匹配返回结果是采用JSon格式传输，如：<br />
			{<br />
				"result": '2',<br />
				"data": [{<br />
					&nbsp;&nbsp;"fdSubject": "2018/总经办/差旅费/",<br />
					&nbsp;&nbsp;"fdBudgetId": "166bf3e8990f96234972b304f9787499",<br />
					&nbsp;&nbsp;"fdRule": "1",<br />
					&nbsp;&nbsp;"fdElasticPercent": 10,<br />
					&nbsp;&nbsp;"fdCanUseAmount": 120000,<br />
					&nbsp;&nbsp;"fdAlreadyUsedAmount": 0,<br />
					&nbsp;&nbsp;"fdOccupyAmount": 0,<br />
					&nbsp;&nbsp;"fdInitAmount": 120000,<br />
					&nbsp;&nbsp;"fdTotalAmount": 120000,<br />
					&nbsp;&nbsp;"fdAdjustAmount": 0,<br />
					&nbsp;&nbsp;"fdCurrenyId": "165458d488fe137a6d818e24a1babb6a",<br />
					&nbsp;&nbsp;"fdSymbol": "CNY"<br />
				}, {<br />
					&nbsp;&nbsp;"fdSubject": "2018/总经办/差旅费/",<br />
					&nbsp;&nbsp;"fdBudgetId": "166bf3e89b5ab234f8243e547d4ad55b",<br />
					&nbsp;&nbsp;"fdRule": "1",<br />
					&nbsp;&nbsp;"fdElasticPercent": 10,<br />
					&nbsp;&nbsp;"fdCanUseAmount": 10000,<br />
					&nbsp;&nbsp;"fdAlreadyUsedAmount": 0,<br />
					&nbsp;&nbsp;"fdOccupyAmount": 0,<br />
					&nbsp;&nbsp;"fdInitAmount": 10000,<br />
					&nbsp;&nbsp;"fdTotalAmount": 10000,<br />
					&nbsp;&nbsp;"fdAdjustAmount": 0,<br />
					&nbsp;&nbsp;"fdCurrenyId": "165458d488fe137a6d818e24a1babb6a",<br />
					&nbsp;&nbsp;"fdSymbol": "CNY"<br />
				}]<br />
			}	<br />
			
			
			错误信息：<br />
			{<br />
				&nbsp;&nbsp;"result": '0',<br />
				&nbsp;&nbsp;"message": "XXXX"<br />
			}<br />
		</td>
	</tr>				
	<tr>
		<td class="td_normal_title" width=15%>服务接口</td>
		<td width="85%">addMaterialStock(String jsonData)</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>功能描述</td>
		<td width="85%">物资执行数据</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回值</td>
		<td width="85%">执行结果（jsonObject）</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>接口入参JSONObject对应参数</td>
		<td width="85%"><img id="viewSrc3"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc3','paramDiv3')" style="cursor: pointer"><br>
		<div id="paramDiv3" style="display:none">
		<table id="List_ViewTable3" class="tb_noborder">
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
				<td>fdStockId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>库存ID</td>
			</tr>
			<tr>
				<td align="center">1</td>
				<td>fdModelId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>单据ID</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>fdModelName</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>单据modelName（用于区分不同的模块）</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td>fdUnit</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>单位</td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td>fdPrice</td>
				<td>数字（Double）</td>
				<td>无</td>
				<td>实际单价</td>
			</tr>
			<tr>
				<td align="center">5</td>
				<td>fdQuantity</td>
				<td>整数（Integer）</td>
				<td>无</td>
				<td>数量</td>
			</tr>
			<tr>
				<td align="center">6</td>
				<td>fdModel</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>型号</td>
			</tr>
			<tr>
				<td align="center">7</td>
				<td>fdType</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>操作类型（1：初始化，2：领用中，3：已领用）</td>
			</tr>
			<tr>
				<td align="center">6</td>
				<td>fdMoney</td>
				<td>数字（Double）</td>
				<td>无</td>
				<td>金额</td>
			</tr>
			<tr>
				<td align="center">6</td>
				<td>fdStockFlag</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>标识（库存：stock，需求：demand）</td>
			</tr>
			<tr>
				<td align="center">9</td>
				<td>fdCode</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>物资编码</td>
			</tr>
			<tr>
				<td align="center">10</td>
				<td>fdDetailId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>明细ID（若是在明细的情况下）</td>
			</tr>
			<tr>
				<td align="center">11</td>
				<td>fdMaterialId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>物资台账ID</td>
			</tr>
		</table></div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回结果JSONObject说明</td>
		<td width="85%"><img id="viewSrc4"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc4','paramDiv4')" style="cursor: pointer"><br>
		<div id="paramDiv4" style="display:none">
		<table id="List_ViewTable4" class="tb_noborder">
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
				<td>调用接口是否成功，2为成功，0为失败，message为失败原因</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>物资执行参数样例</td>
		<td width="35%">物资执行参数是采用JSon格式传输，如：{"fdModelId": "165c7f7aca6e0e0c56a70154d14b7523","fdModelName": "com.kmss.landray.fs.model.expense".....}。	
		</td>
	</tr>				
	<tr>
		<td class="td_normal_title" width=15%>服务接口</td>
		<td width="85%">deleteMaterialStock(String jsonData)</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>功能描述</td>
		<td width="85%">删除预算执行数据</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回值</td>
		<td width="85%">执行结果（jsonObject）</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>接口入参JSONObject对应参数。</td>
		<td width="85%"><img id="viewSrc5"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc5','paramDiv5')" style="cursor: pointer"><br>
		<div id="paramDiv5" style="display:none">
		<table id="List_ViewTable5" class="tb_noborder">
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
				<td>fdStockFlag</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>标识（stock标识库存，demand标识需求）</td>
			</tr>
			<tr>
				<td align="center">2</td>
				<td>fdModelId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>单据ID</td>
			</tr>
			<tr>
				<td align="center">3</td>
				<td>fdModelName</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>单据modelName（用于区分不同的模块）</td>
			</tr>
			<tr>
				<td align="center">4</td>
				<td>fdDetailId</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>明细Id</td>
			</tr>
			<tr>
				<td align="center">5</td>
				<td>fdType</td>
				<td>字符串（String）</td>
				<td>无</td>
				<td>操作类型（1：初始化，2：领用中，3：已领用）</td>
			</tr>
		</table></div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回结果JSONObject说明</td>
		<td width="85%"><img id="viewSrc6"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc6','paramDiv6')" style="cursor: pointer"><br>
		<div id="paramDiv6" style="display:none">
		<table id="List_ViewTable6" class="tb_noborder">
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
				<td>调用接口是否成功，2为成功，0为失败，error为失败原因</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>物资参数样例</td>
		<td width="35%">物资执行删除参数是采用JSon格式传输，如：{"fdModelId": "165c7f7aca6e0e0c56a70154d14b7523","fdModelName": "com.kmss.landray.fs.model.expense".....}。	
		</td>
	</tr>	
	<tr>
		<td class="td_normal_title" width=15%>服务接口</td>
		<td width="85%">updateMaterialStock(String jsonData)</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>功能描述</td>
		<td width="85%">更新物资执行数据</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回值</td>
		<td width="85%">执行结果（jsonObject）</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>接口入参JSONObject对应参数。该接口先执行删除原来占用，重新 插入新的记录</td>
		<td width="85%"><img id="viewSrc7"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc7','paramDiv7')" style="cursor: pointer"><br>
		<div id="paramDiv7" style="display:none">
		<table id="List_ViewTable7" class="tb_noborder">
			<tr>
				<td align="center">同deleteMaterialStock，addMaterialStock</td>
			</tr>
		</table></div>
		</td>
	</tr>
	<tr>
		<td class="td_normal_title" width=15%>返回结果JSONObject说明</td>
		<td width="85%"><img id="viewSrc8"
			src="${KMSS_Parameter_StylePath}icons/expand.gif" border="0"
			onclick="expandMethod('viewSrc8','paramDiv8')" style="cursor: pointer"><br>
		<div id="paramDiv8" style="display:none">
		<table id="List_ViewTable8" class="tb_noborder">
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
				<td>调用接口是否成功，2为成功，0为失败，message为失败原因</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
</center>

<%@ include file="/resource/jsp/view_down.jsp"%>