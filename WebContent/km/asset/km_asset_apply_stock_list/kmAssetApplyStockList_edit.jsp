<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.landray.kmss.util.ResourceUtil,com.landray.kmss.util.UserUtil"%>
<!--数字转中文JS  -->
<%@include file="/km/asset/resource/chinaValue.jsp"%>
<script>
	var globalAction="";//全局action
	var globalTarget="";//全局target
	
	//上传excel文件
	function loadExcel(){
		var form=document.getElementsByName("kmAssetApplyStockForm")[0];
		//初始化全局变量
		if(globalAction==""||globalTarget==""){
			globalAction=form.action;
			globalTarget=form.target;
		}
		//修改action的值为excel上传地址
		form.action="${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_stock/kmAssetApplyStock.do?method=loadExcel";
		form.target="file_frame";
		form.submit();
	}
	
	//提交出错
	function loadError(){
		alert("${lfn:message('km-asset:kmAssetCard.tip.upload.error')}");
	}
	
	//excel文件上传完毕添加明细、还原action值
	function callback(result){
		var form=document.getElementsByName("kmAssetApplyStockForm")[0];
		//还原action的值
		form.action=globalAction;
		form.target=globalTarget;
		//获取excel数据,添加明细
		var data = eval(result);
		if(data.length>0){
			for(var i=0;i<data.length;i++){
				var subTotal=data[i].fdStockAmount*data[i].fdPrice;
				var fieldValues = new Object();
				fieldValues["fdItems[!{index}].fdName"]=data[i].fdName!=null?data[i].fdName:"";
				fieldValues["fdItems[!{index}].fdStandard"]=data[i].fdStandard!=null?data[i].fdStandard:"";
				fieldValues["fdItems[!{index}].fdMeasure"]=data[i].fdMeasure!=null?data[i].fdMeasure:"";
		
				fieldValues["fdItems[!{index}].fdStockAmount"]=data[i].fdStockAmount!=null?parseInt(data[i].fdStockAmount).toString():"";
			
				fieldValues["fdItems[!{index}].fdPrice"]=data[i].fdPrice!=null?data[i].fdPrice:"";
				fieldValues["fdItems[!{index}].fdSubTotal"]=new Number(subTotal).toFixed(2);
				if(data[i].fdStockerId!=null){
					fieldValues["fdItems[!{index}].fdStockerId"]=data[i].fdStockerId;
					fieldValues["fdItems[!{index}].fdStockerName"]=data[i].fdStockerName;
				}
				if(data[i].fdProviderId!=null){
					fieldValues["fdItems[!{index}].fdProviderId"]=data[i].fdProviderId;
					fieldValues["fdItems[!{index}].fdProviderName"]=data[i].fdProviderName;
				}
				fieldValues["fdItems[!{index}].fdStockDate"]=data[i].fdStockDate;
				fieldValues["fdItems[!{index}].fdRemark"]=data[i].fdRemark!=null?data[i].fdRemark:"";
				DocList_AddRow("TABLE_DocList",null,fieldValues);
			}
			//更新总计
			var totalMoney=document.getElementsByName("fdTotalMoney")[0];//总计隐藏域
			var totalMoneySpan=document.getElementById("fdTotalMoneySpan");//总计显示域
			if(totalMoney.value=="") totalMoney.value="0";
			totalMoney.value=DocList_GetSum(document.getElementById("TABLE_DocList"),/fdItems\[\d+\]\.fdSubTotal/);
			totalMoneySpan.innerHTML=totalMoney.value.toString();
			//更新中文数字
			var chinaValue=document.getElementById("chinaValue");
			chinaValue.innerHTML=showChinaValue(totalMoney.value);
		}
	}

	//当单价或者数量改变时,自动计算小计和合计
	function calculate(value,obj){
		//取明细项在表格中的索引;如fdItems[1].fdApplyAmount,取1
		var index=obj.name.substring(obj.name.indexOf("[") + 1,obj.name.indexOf("]"));
		var amount=document.getElementsByName("fdItems["+index+"].fdStockAmount")[0];//数量
		var price=document.getElementsByName("fdItems["+index+"].fdPrice")[0];//单价
		var subTotal=document.getElementsByName("fdItems["+index+"].fdSubTotal")[0];//小计隐藏
		if(amount.value!=""&&price.value!=""&&!isNaN(amount.value)&&!isNaN(price.value)){
			//更新小计
			subTotal.value=(parseFloat(amount.value)*parseFloat(price.value)).toFixed(2);
			//更新总计
			var totalMoney=document.getElementsByName("fdTotalMoney")[0];//总计隐藏域
			var totalMoneySpan=document.getElementById("fdTotalMoneySpan");//总计显示域
			if(totalMoney.value=="") totalMoney.value="0";
			totalMoney.value=DocList_GetSum(document.getElementById("TABLE_DocList"),/fdItems\[\d+\]\.fdSubTotal/).toFixed(2);
			totalMoneySpan.innerHTML=totalMoney.value.toString();
			//更新中文数字
			var chinaValue=document.getElementById("chinaValue");
			chinaValue.innerHTML=showChinaValue(totalMoney.value);
		}
	}	

	//删除行,重新计算总值
	function deleteRow(){
		//删除行
		DocList_DeleteRow();
		//更新总计
		var totalMoney=document.getElementsByName("fdTotalMoney")[0];//总结隐藏域
		var totalMoneySpan=document.getElementById("fdTotalMoneySpan");//总计显示域
		if(totalMoney.value==""||!isNaN(totalMoney.value))
			 totalMoney.value="0";
		totalMoney.value=DocList_GetSum(document.getElementById("TABLE_DocList"),/fdItems\[\d+\]\.fdSubTotal/);
		totalMoneySpan.innerHTML=totalMoney.value.toString();
		//更新中文数字
		var chinaValue=document.getElementById("chinaValue");
		chinaValue.innerHTML=showChinaValue(totalMoney.value);
	}

	//增加行,初始化采购人、采购时间
	function addRow(){
		var fieldValues = new Object();
		fieldValues["fdItems[!{index}].fdStockerId"]="<%=UserUtil.getUser().getFdId()%>";
		fieldValues["fdItems[!{index}].fdStockerName"]="<%=UserUtil.getUser().getFdName()%>";
		var date=new Date();
        var month = "";
        var day =  "";
		if(date.getMonth() < 9){
			month = "0"+(date.getMonth()+1);
		}else{
			month = ""+(date.getMonth()+1);
		}
		if(date.getDate() < 10){
			day = "0"+date.getDate();
		}else{
			day = ""+date.getDate();
		}
		if((Com_Parameter['Lang'])=="zh-cn" || (Com_Parameter['Lang'])=="zh-hk"){
		   fieldValues["fdItems[!{index}].fdStockDate"]=date.getFullYear()+"-"+month+"-"+day;
		}else if((Com_Parameter['Lang'])=="en-us"){
			if(Com_Parameter['Date_format']=="dd/MM/yyyy")
				fieldValues["fdItems[!{index}].fdStockDate"]=day+"/"+month+"/"+date.getFullYear();
			else
				fieldValues["fdItems[!{index}].fdStockDate"]=month+"/"+day+"/"+date.getFullYear();
		}
		DocList_AddRow("TABLE_DocList",null,fieldValues);
	}
</script>
<div style="padding-bottom: 10px;">
<bean:message bundle="km-asset" key="kmAssetApplyStock.excelImport"/>
<html:file property="file" style="width:20%" styleClass="lui_form_button" />
&nbsp;&nbsp;
<input type="button" class="lui_form_button"  value="<bean:message bundle='km-asset' key='kmAssetApplyStock.excelSubmit' />" onclick="loadExcel();"  style="min-width: 50px;"/>

<input type="button" class="lui_form_button"  value="<bean:message bundle='km-asset' key='kmAssetApplyStock.excelTemplateDownLoad' />"
	style="min-width: 100px;" onclick="window.open('${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_stock_list/assetspurchase _template.xls');"/>
	 <iframe name="file_frame" style="display:none;"></iframe>
</div>
<table class="tb_normal" width=100% id="TABLE_DocList" align="center" style="table-layout:fixed;">
	<tr align="center">
		<%--序号--%> 
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdOrder"/>
		</td>
		<%--资产名称--%>
		<td class="td_normal_title" width=12%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
		</td>
		<%--规格型号--%>
		<td class="td_normal_title" width=8%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
		</td>
		<%--单位--%>
		<td class="td_normal_title" width=7%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
		</td>
		<%--申购数量--%>
		<td class="td_normal_title" width=9%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
		</td>
		<%--单价--%>
		<td class="td_normal_title" width=7%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
		</td>
		<%--小计--%>
		<td class="td_normal_title" width=5%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdSubTotal"/>
		</td>
		<%--采购人--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStocker"/>
		</td>
		<%--供应商--%>
		<td class="td_normal_title" width=11%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdProvider"/>
		</td>
		<%--采购日期--%>
		<td class="td_normal_title" width=11%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
		</td>
		<%--备注文本--%>
		<td class="td_normal_title" width=10%>
			<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdRemark"/>
		</td>
		<%--添加按钮--%>
		<td class="td_normal_title" width="5%" align="center">
			<a id="add2"  href="#" onclick="addRow();">
				<img src="${KMSS_Parameter_StylePath}/icons/add.gif" border="0" />
			</a>
		</td>
	</tr>
	
	<!-- 基准行 -->
	<tr KMSS_IsReferRow="1" style="display: none">
		<td KMSS_IsRowIndex="1" width="5%"></td>
		<td width="12%" >
			<xform:text	property="fdItems[!{index}].fdName" required="true" style="width:90%" validators="maxLength(200)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdName","km-asset")%>'/>
		</td>
		<td width="8%" >
			<xform:text	property="fdItems[!{index}].fdStandard" required="true" style="width:85%" validators="maxLength(200)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStandard","km-asset")%>'/>
		</td>
		<td width="7%" >
			<xform:text	property="fdItems[!{index}].fdMeasure" required="true" style="width:85%"  validators="maxLength(36)"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdMeasure","km-asset")%>'/>
		</td>
		<td width="9%">
			<xform:text	property="fdItems[!{index}].fdStockAmount" required="true"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStockAmount","km-asset")%>'
				validators="number scaleLength(0) digits maxLength(4)"  style="width:85%" onValueChange="calculate"/>
		</td>
		<td width="7%">
			<xform:text	property="fdItems[!{index}].fdPrice" required="true"
				subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdPrice","km-asset")%>'
				validators="number scaleLength(2) maxLength(36)"  style="width:85%"  onValueChange="calculate"/>
		</td>
		<td width="5%" >
			<xform:text	property="fdItems[!{index}].fdSubTotal" showStatus="readOnly" style="width:85%" />
		</td>
		<td width="10%">
			<xform:address propertyId="fdItems[!{index}].fdStockerId" propertyName="fdItems[!{index}].fdStockerName" orgType="ORG_TYPE_PERSON"  style="width:90%" />
		</td>
		<td width="11%">
			<xform:dialog  propertyId="fdItems[!{index}].fdProviderId" propertyName="fdItems[!{index}].fdProviderName" style="width:90%" showStatus="edit"  dialogJs="Dialog_Provider('fdItems[!{index}].fdProviderId','fdItems[!{index}].fdProviderName');"/>
		</td>
		<td width="11%">
			<xform:datetime property="fdItems[!{index}].fdStockDate"  style="width:100%"
				dateTimeType="date"  validators="datetimevalidators"  subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStockDate","km-asset")%>'/>
		</td>
		<td width="10%">
			<xform:text  property="fdItems[!{index}].fdRemark" style="width:100%" validators="maxLength(36)" />
		</td>
		<!-- 删除、上移、下移按钮 -->
		<td width=5%" align="center">
			<a href="#" onclick="deleteRow();"><img
				src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
		</td>
	</tr>
	
	<c:forEach items="${kmAssetApplyStockForm.fdItems}"  var="item" varStatus="vstatus">
		<tr KMSS_IsContentRow="1">
			<td width="5%">${vstatus.index+1}
				<input type="hidden" name="fdItems[${vstatus.index}].fdId" value="${item.fdId}" /> 
				<input type="hidden" name="fdItems[${vstatus.index}].fdAssetApplyStockId" value="${kmAssetApplyStockForm.fdId}" />
			</td>
			<td width=12%>
				<xform:text property="fdItems[${vstatus.index}].fdName" value="${item.fdName}"  required="true" style="width:90%" validators="maxLength(200)"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdName","km-asset")%>'/>
			</td>
			<td width=8%>
				<xform:text property="fdItems[${vstatus.index}].fdStandard" value="${item.fdStandard}" validators="maxLength(200)"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStandard","km-asset")%>'
					style="width:90%"  required="true"  />
			</td>
			<td width=7%>
				<xform:text property="fdItems[${vstatus.index}].fdMeasure" validators="maxLength(36)"
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdMeasure","km-asset")%>'
					style="width:90%"  required="true" value="${item.fdMeasure}" />
			</td>
			<td width=9%>
				<xform:text property="fdItems[${vstatus.index}].fdStockAmount"
					style="width:90%"  required="true" value="${item.fdStockAmount}" 
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStockAmount","km-asset")%>'
					onValueChange="calculate" validators="number scaleLength(0) digits maxLength(4)"/>
			</td>
			<td width=7%>
				<xform:text property="fdItems[${vstatus.index}].fdPrice"
					style="width:85%"  required="true" value="${item.fdPrice}" 
					subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdPrice","km-asset")%>'
					onValueChange="calculate" validators="number scaleLength(2) maxLength(36)"/>
			</td>
			<td width="5%" >
				<html:hidden property="fdItems[${vstatus.index}].fdSubTotal" value="${item.fdSubTotal}" />
				<span id="fdSubTotal${vstatus.index}">${item.fdSubTotal}</span>
			</td>
			<td width="10%" >
				<xform:address propertyId="fdItems[${vstatus.index}].fdStockerId" propertyName="fdItems[${vstatus.index}].fdStockerName" orgType="ORG_TYPE_PERSON"  style="width:100%" />
			</td>
			<td width="11%" >
				<xform:dialog  propertyId="fdItems[${vstatus.index}].fdProviderId" propertyName="fdItems[${vstatus.index}].fdProviderName" style="width:100%" showStatus="edit"  dialogJs="Dialog_Provider('fdItems[${vstatus.index}].fdProviderId','fdItems[${vstatus.index}].fdProviderName');"/>
			</td>
			<td width="11%" >
					<xform:datetime property="fdItems[${vstatus.index}].fdStockDate" style="width:100%"
						dateTimeType="date"   validators="datetimevalidators"  subject='<%=ResourceUtil.getString(request,"kmAssetApplyStockList.fdStockDate","km-asset")%>'/>
			</td>
			<td width="10%" >
				<xform:text property="fdItems[${vstatus.index}].fdRemark" style="width:100%" validators="maxLength(36)" />
			</td>
			<!-- 删除按钮 -->
			<td width="5%" align="center">
				<a href="#" onclick="deleteRow();"><img
					src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
			</td>
		</tr>
	</c:forEach>
	
</table>

<c:if test="${kmAssetApplyStockForm.method_GET=='edit'}">
	<script type="text/javascript">
		window.onload=function(){
			var totalMoney=document.getElementsByName("fdTotalMoney")[0];
			//更新中文数字
			var chinaValue=document.getElementById("chinaValue");
			chinaValue.innerHTML=showChinaValue(totalMoney.value);
		};
	</script>
</c:if>