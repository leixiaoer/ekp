<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script type="text/javascript">
	Com_IncludeFile("selectstockListdialog.js",'${KMSS_Parameter_ContextPath}km/asset/resource/',null,true);
</script>
<script type="text/javascript">
	var stockListIds="";
	//填写的到货数量有校验，1.到货数量<=（采购数量-已到数量），即不能超出
	function calculate(value,obj){
		var fdStockAmount=	DocList_GetPreField(obj.parentNode,"fdStockAmount");//采购数量
		var fdReceiveAmount=DocList_GetPreField(obj.parentNode,"fdReceiveAmount");//已到数量
		if(fdStockAmount.value-fdReceiveAmount.value<value){
			alert("<bean:message bundle='km-asset' key='kmAssetApplyInList.largeNumber'/>");
			obj.value="";
		}
	}
	
	function checkCode(value,obj){
		var url="${KMSS_Parameter_ContextPath}km/asset/km_asset_card/kmAssetCard.do?method=checkUniqueCode"; 
		 $.ajax({     
		     type:"post",   
		     url:url,     
		     data:{fdCode:value,fdCardId:null},
		     async:false,    //用同步方式 
		     success:function(data){
		    	 var results =  eval("("+data+")");
		    	 if(results['isExist'] =='true'){
		    		 alert("<bean:message bundle='km-asset' key='kmAssetCard.import.fdCode.isExists'/>");
		    		 obj.value="";
		    	 }else{
		    		 //跟当前列表中的值进行比较
		    		 var fdCodeArr =$( "input[name*='fdCode']");
		    		 if(fdCodeArr && fdCodeArr.length > 0){
		    			 //所有行的内容是否有重复 
		    			 var hash = {};
		    			 for(var i=0;i<fdCodeArr.length;i++){
		    				 var rowVal =$(fdCodeArr[i]).val();
		    				 if(rowVal){
		    					 if(hash[rowVal]){	
		    						 alert("<bean:message bundle='km-asset' key='kmAssetCard.import.fdCode.isExists'/>");
		    			    		 obj.value="";
		    						 return true;
		    					 } 
		    					  hash[rowVal] = true;
		    				 } 
		    			 }
		    			 
		    		 }
		    	 }
			}    
	    });	
   }
	
	
	function refreshTbIndex(tbId,index){
		var optTB = document.getElementById(tbId);
		 var tb_index = parseInt(index)+1;
		 for(var j = tb_index; j<optTB.rows.length; j++){
			optTB.rows[j].cells[0].innerHTML = j;
		}	
	}
	
	
	
	function DocList_DeleteRow_Asset(tbId,rowIndex){
		var optTB = document.getElementById(tbId);
		var tbInfo = DocList_TableInfo[tbId];
		optTB.deleteRow(rowIndex);
		
		tbInfo.lastIndex--;
		for(var i = rowIndex; i<tbInfo.lastIndex; i++)
			DocListFunc_RefreshIndex(tbInfo, i);
	}
	
	//同时删除入库明细、采购明细
	function deleteRow(index){
		
		optTR = DocListFunc_GetParentByTagName("TR");
		var optTB = DocListFunc_GetParentByTagName("TABLE", optTR);
		var rowIndex = Com_ArrayGetIndex(optTB.rows, optTR);
		var tb_index = parseInt(rowIndex)-1;
		
		//从全局变量中删除指定明细ID
		var stockListId=document.getElementsByName("kmAssetApplyInListForms["+tb_index+"].fdStockListId");
		if(stockListId!=null&&stockListId.length>0){
			stockListIds=stockListIds.replace(stockListId[0].value,"");
		}
		
		DocList_DeleteRow_Asset('TABLE_DocList_Stock',rowIndex);
		DocList_DeleteRow_Asset('TABLE_DocList_In',rowIndex);
		refreshTbIndex('TABLE_DocList_Stock',index);
		refreshTbIndex('TABLE_DocList_In',index);
	}
	seajs.use(['lui/dialog'], function(dialog){
		window.dialog=dialog;
	});

	function showStockList(){	
		var url=Com_GetCurDnsHost()+Com_Parameter.ContextPath + 'km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=list&isDialog=0';
	 	dialog.iframe(url,"${lfn:message('km-asset:kmAssetApplyBase.selectAsset') }",function(ids){
	 		if (ids!=""&&ids!=null){
				var data = new KMSSData();
			    var url = "${KMSS_Parameter_ContextPath}km/asset/km_asset_apply_stock_list/kmAssetApplyStockList.do?method=loadStockList&ids="
					+ ids;
			    data.SendToUrl(url, function(data) {
			    	var results = eval("(" + data.responseText + ")");
			    	if(results.length>0){
				    	for(var i=0;i<results.length;i++){
					    	//判断指定明细是否已存在
					    	if(stockListIds.indexOf(results[i].fdId,0)==-1){
						    	//将明细ID存入全局字符串
						    	stockListIds+=results[i].fdId;
						    	//自动带出全部采购明细信息
						    	var content = new Array();
						    	content.push(null);
						    	content.push(results[i].stockFdNo);
						    	content.push(results[i].fdName);
						    	content.push(results[i].fdStandard);
						    	content.push(results[i].fdMeasure);
						    	content.push(results[i].fdPrice.toString());
						    	content.push(results[i].fdStockAmount.toString());
						    	content.push(results[i].fdReceiveAmount.toString());
						    	content.push(results[i].fdStocker);
						    	content.push(results[i].fdProvider);
						    	content.push(results[i].fdDate);
						    	//增加采购明细行
						    	DocList_AddRow("TABLE_DocList_Stock",content);
						    	//自动带出部分入库明细信息
						    	
						    	/*
						    	var optTB = document.getElementById("TABLE_DocList_In");
						    	var oneRow = [];
						    	oneRow["kmAssetApplyInListForms[!{index}].fdStockListId"]=results[i].fdId;
					        	oneRow["kmAssetApplyInListForms[!{index}].fdStockNo"]=results[i].stockFdNo;
					        	oneRow["kmAssetApplyInListForms[!{index}].fdName"]=results[i].fdName;
					        	oneRow["kmAssetApplyInListForms[!{index}].fdStockAmount"]=results[i].fdStockAmount;
					        	oneRow["kmAssetApplyInListForms[!{index}].fdReceiveAmount"]=results[i].fdReceiveAmount;
					        	DocList_AddRow(optTB,null,oneRow); 
						    	*/
						    	
						    	content = new Array();
						    	content.push(null);
						    	content.push("<input type='hidden' name='kmAssetApplyInListForms[!{index}].fdStockListId' value='"+results[i].fdId+"' /><input type='hidden' name='kmAssetApplyInListForms[!{index}].fdStockNo' value='"+results[i].stockFdNo+"' />"+results[i].stockFdNo);
						    	content.push("<input type='hidden' name='kmAssetApplyInListForms[!{index}].fdName' value='"+results[i].fdName+"' />"+results[i].fdName);
						    	content.push("<input type='hidden' name='kmAssetApplyInListForms[!{index}].fdStockAmount' value='"+results[i].fdStockAmount+"' />"+results[i].fdStockAmount);
						    	content.push("<input type='hidden' name='kmAssetApplyInListForms[!{index}].fdReceiveAmount' value='"+results[i].fdReceiveAmount+"' />"+results[i].fdReceiveAmount);
								//增加入库明细行
								DocList_AddRow("TABLE_DocList_In",content);
					    	}
					    }
				    }
				});
			}
			else{
				  return false;
		   }
		 },{width:950,height:550});
	}
	

	//选择采购明细
	function selectStockList(){
		showStockList();
	}
</script>
<tr>
	<td colspan="4">
		<table  class="tb_normal" width=100%  align="center">
			<tr>
				<%-- 申购明细标题 --%>
				<td colspan="2" class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyStockList"/>
				</td>
			</tr>
			<%-- 搜索关联单 --%>
			<tr>
				<td width="15%"><bean:message bundle="km-asset" key="kmAssetApplyIn.relateStock"/></td>
				<td>
					<input type="button" class="lui_form_button" value="<bean:message bundle='km-asset' key='kmAssetApplyIn.searchStock'/>"  onclick="selectStockList();"/>
				</td>
			</tr>
		</table>
	
		<table class="tb_normal" width=100% id="TABLE_DocList_Stock" align="center">
			<tr align="center">
				<%--序号--%> 
				<td class="td_normal_title" width=4%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdOrder"/>
				</td>
				<%--采购单号--%> 
				<td class="td_normal_title" width=11%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<%--资产名称--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdName"/>
				</td>
				<%--规格型号--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStandard"/>
				</td>
				<%--单位--%>
				<td class="td_normal_title" width=5%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdMeasure"/>
				</td>
				<%--单价--%>
				<td class="td_normal_title" width=5%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdPrice"/>
				</td>
				<%--采购数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
				</td>
				<%--已到数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
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
				<td class="td_normal_title" width=15%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockDate"/>
				</td>
				<%--操作--%>
				<td class="td_normal_title" width="5%" align="center">
					<bean:message bundle="km-asset" key="kmAssetApplyIn.operate"/>
				</td>
			</tr>
			
			<!-- 基准行 -->
			<tr KMSS_IsReferRow="1" style="display: none" >
				<td KMSS_IsRowIndex="1" width="4%">!{index}
				</td>
				<td width="11%" ></td>
				<td width="10%" ></td>
				<td width="10%" ></td>
				<td width="5%" ></td>
				<td width="5%" ></td>
				<td width="7%" ></td>
				<td width="7%" ></td>
				<td width="10%" ></td>
				<td width="11%" ></td>
				<td width="15%" ></td>
				<!-- 删除 -->
				<td width="5%" align="center">
					<a href="#" onclick="deleteRow('!{index}');" name="link_!{index}"><img
						src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
				</td>
			</tr>
			
			<c:forEach items="${stockLists}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1">
					<td width="4%">
						<script type="text/javascript">
							stockListIds+="${item.fdId}";
						</script>
						${vstatus.index+1}
					</td>
					<td width=11%>${item.fdAssetApplyStock.fdNo}</td>
					<td width=10%>${item.fdName}</td>
					<td width=10%>${item.fdStandard}</td>
					<td width=5%>${item.fdMeasure}</td>
					<td width=5%>${item.fdPrice}</td>
					<td width=7%>${item.fdStockAmount}</td>
					<td width=7%>${item.fdReceiveAmount}</td>
					<td width=10%>${item.fdStocker.fdName}</td>
					<td width=11%>${item.fdProvider.fdName}</td>
					<td width=15%>
						<kmss:showDate value="${item.fdStockDate}" type="date" />
					</td>
					<td width="5%" align="center">
						<a href="#" onclick="deleteRow(${vstatus.index});" name="link_${vstatus.index}"><img
							src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
					</td>
				</tr>
			</c:forEach>
			
		</table>
	</td>
</tr>

<%-- 分隔符 --%>
<tr><td colspan="4">&nbsp;</td></tr>
				
<tr>
	<td colspan="4">
		<table class="tb_normal" width=100%  align="center">
			<tr>
 				<%-- 入库明细标题 --%>
				<td class="td_normal_title" align="center">
					<bean:message bundle="km-asset" key="table.kmAssetApplyInList"/>
				</td>
			</tr>
		</table>
	
		<table class="tb_normal" width=100% id="TABLE_DocList_In" align="center">
			<tr align="center">
				<%--序号--%> 
				<td class="td_normal_title" width=4%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdOrder"/>
				</td>
				<%--采购单号--%> 
				<td class="td_normal_title" width=11%>
					<bean:message bundle="km-asset" key="kmAssetApplyBase.fdNo"/>
				</td>
				<%--资产名称--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdName"/>
				</td>
				<%--采购数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdStockAmount"/>
				</td>
				<%--已到数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyStockList.fdReceiveAmount"/>
				</td>
				<%--资产类别--%>
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdAssetCategory"/>
				</td>
				<%--资产序列号--%>
				<td class="td_normal_title" width=10%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdNo"/>
				</td>
				<%--资产编码,1:手动,2:自动--%>
					<td class="td_normal_title" width=15%>
						<bean:message bundle="km-asset" key="kmAssetApplyInList.fdCode"/>
					</td>
				<%--组织机构代码--%>
				<td class="td_normal_title" width=12%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdDeptCode"/>
				</td>
				<%--到货数量--%>
				<td class="td_normal_title" width=7%>
					<bean:message bundle="km-asset" key="kmAssetApplyInList.fdInNum"/>
				</td>
				<%--操作--%>
				<td class="td_normal_title" width="5%" align="center">
					<bean:message bundle="km-asset" key="kmAssetApplyIn.operate"/>
				</td>
			</tr>
			
			<!-- 基准行 -->
			<tr  KMSS_IsReferRow="1" style="display: none">
				<td KMSS_IsRowIndex="1" width="4%"></td>
				<td width="11%">
					<input type="hidden" name="kmAssetApplyInListForms[!{index}].fdStockListId" />
					<input type="text" readonly="readonly" name="kmAssetApplyInListForms[!{index}].fdStockNo"/>
				</td>
				<td width="10%">
					<input type="text" readonly="readonly" name="kmAssetApplyInListForms[!{index}].fdName" />
				</td>
				<td width="7%">
					<input type="text" readonly="readonly" name="kmAssetApplyInListForms[!{index}].fdStockAmount" />
				</td>
				<td width="7%">
					<input type="text" readonly="readonly" name="kmAssetApplyInListForms[!{index}].fdReceiveAmount"/>
				</td>
				<td width="12%">
					<input type="hidden" name="kmAssetApplyInListForms[!{index}].fdAssetCategoryId" />
					<DIV onclick="Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','kmAssetApplyInListForms[!{index}].fdAssetCategoryId','kmAssetApplyInListForms[!{index}].fdAssetCategoryName',false);"
					 	class=inputselectsgl style="WIDTH: 110px;float: left;clear: both;display:inline;">
					 	<DIV class=input style="WIDTH: 105px">
					 	<INPUT style="WIDTH: 100px" readonly="readonly" subject="<%=ResourceUtil.getString(request,"kmAssetApplyInList.fdAssetCategory","km-asset")%>" 
					 	 name="kmAssetApplyInListForms[!{index}].fdAssetCategoryName"  validate="required" ></DIV>
					 	<DIV class=selectitem isChannel="true">
					 	</DIV>
					 	<span class="txtstrong" style="display:block;position:absolute;width: 15px;height:100%;left:115px;">*</span>
					</DIV>
				</td>
				<td width="10%">
					<xform:text	property="kmAssetApplyInListForms[!{index}].fdNo" validators="maxLength(36)" style="width:90%"/>
				</td>
				<td width="15%">
					<c:if test="${codeRule == '1'}">
						<xform:text	property="kmAssetApplyInListForms[!{index}].fdCode" required="true" validators="maxLength(500)" onValueChange="checkCode"  style="width:90%"/>
					</c:if>
					<c:if test="${codeRule == '2'}">
						<bean:message bundle="km-asset"  key="kmAssetApplyInList.fdCodeAuto" />
					</c:if>
				</td>
				<td width="12%">
					<xform:text	property="kmAssetApplyInListForms[!{index}].fdDeptCode" validators="maxLength(36)" style="width:90%"/>
				</td>
				<td width="7%">
					<xform:text	property="kmAssetApplyInListForms[!{index}].fdInNum"
						subject='<%=ResourceUtil.getString(request,"kmAssetApplyInList.fdInNum","km-asset")%>'
						required="true"  style="width:80%" onValueChange="calculate" validators="number scaleLength(0) digits min(0)"/>
				</td>
				<td width="5%" align="center">
					<a href="#" onclick="deleteRow('!{index}');" name="link_!{index}"><img
						src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
				</td>
			</tr>
			
			<c:forEach items="${kmAssetApplyInForm.kmAssetApplyInListForms}"  var="item" varStatus="vstatus">
				<tr KMSS_IsContentRow="1">
					<td width="4%">${vstatus.index+1}</td>
					<td width=11%>
						${item.fdStockNo}
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdStockNo"  value="${item.fdStockNo}"/>
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdStockListId"  value="${item.fdStockListId}"/>
					</td>
					<td width=10%>
						${item.fdName}
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdName"  value="${item.fdName}"/>
					</td>
					<td width=7%>
						${item.fdStockAmount}
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdStockAmount"  value="${item.fdStockAmount}"/>
					</td>
					<td width=7%>
						${item.fdReceiveAmount}
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdReceiveAmount"  value="${item.fdReceiveAmount}"/>
					</td>
					<td width="12%">
					
						<input type="hidden" name="kmAssetApplyInListForms[${vstatus.index}].fdAssetCategoryId"  value="${item.fdAssetCategoryId}"/>
						
						<DIV onclick="Dialog_SimpleCategory('com.landray.kmss.km.asset.model.KmAssetCategory','kmAssetApplyInListForms[${vstatus.index}].fdAssetCategoryId','kmAssetApplyInListForms[${vstatus.index}].fdAssetCategoryName',false);"
						 	class=inputselectsgl style="WIDTH: 110px">
						 	<DIV class=input style="WIDTH: 105px">
						 	<INPUT style="WIDTH: 100px" readonly="readonly" title="<%=ResourceUtil.getString(request,"kmAssetApplyInList.fdAssetCategory","km-asset")%>" 
						 	 name="kmAssetApplyInListForms[${vstatus.index}].fdAssetCategoryName" value="${item.fdAssetCategoryName}"  validate="required" isChannel="true"></DIV>
						 	<DIV class="selectitem" isChannel="true">
						 	</DIV>
						</DIV>
					</td>
					<td width=10%>
						<xform:text	property="kmAssetApplyInListForms[${vstatus.index}].fdNo" value="${item.fdNo}" validators="maxLength(36)" style="width:90%"/>
					</td>
					<td width=15%>
						<c:if test="${codeRule=='1'}">
							<xform:text	property="kmAssetApplyInListForms[${vstatus.index}].fdCode" required="true" value="${item.fdCode}" validators="maxLength(500)" style="width:90%"/>
						</c:if>
						<c:if test="${codeRule=='2'}">
							<bean:message bundle="km-asset"  key="kmAssetApplyInList.fdCodeAuto" />
						</c:if>
					</td>
					<td width=12%>
						<xform:text	property="kmAssetApplyInListForms[${vstatus.index}].fdDeptCode" value="${item.fdDeptCode}" validators="maxLength(36)" style="width:90%"/>
					</td>
					<td width=7%>
						<xform:text	property="kmAssetApplyInListForms[${vstatus.index}].fdInNum"  value="${item.fdInNum}"
							subject='<%=ResourceUtil.getString(request,"kmAssetApplyInList.fdInNum","km-asset")%>'
							required="true"  style="width:80%" onValueChange="calculate" validators="number scaleLength(0) digits min(0)"/>
					</td>
					<td width="5%" align="center">
						<a href="#" onclick="deleteRow(${vstatus.index});" name="link_${vstatus.index}"><img
							src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</td>
</tr>
