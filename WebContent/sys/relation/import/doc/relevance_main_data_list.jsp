<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sunbor.web.tag.Page" %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<link rel=stylesheet href="${KMSS_Parameter_ResPath}style/default/list/list_page.css">
<style>
	.tr_listrowcur2{
		background:#6fb2eb;
	}
	.tr_listrowcur2 td{
	  color:#fff;
	  overflow:hidden;  
	 }
</style> 
<body>
	<div class="listtable_box" id="listtable_box">
			<%
			if (((Page) request.getAttribute("queryPage")).getTotalrows() == 0) {
			%>
			<%@ include file="/resource/jsp/list_norecord.jsp"%>
			<%
			} else {
			%>
			<table id="List_ViewTable" width="100%" style="margin:0px 0px;">
				<tr class="tr_listfirst">
					<td style="width:2%;"><input type="checkbox" onclick="selectedAll(this);"></td>
					<td style="min-width:28px;"><bean:message key="page.serial" /></td>
					<td style="width:35%">
						<bean:message key="calendar.subject" />
					</td>
					<td style="width:20%">
						<bean:message bundle="sys-xform" key="sysFormMain.relevance.number" />
					</td>
					<td style="width:10%">
						<bean:message key="page.state" />
					</td>
					<td style="width:13%;">
						<bean:message key="model.fdCreator" />
					</td>
					<td style="width:15%;">
						<bean:message key="model.fdCreateTime" />
					</td>
				</tr>
				<!-- baseModel = [fdId,docSubject,docCreator.fdName,creatTime,url,modelName,isCreator] -->
				<c:forEach items="${queryPage.list}" var="baseModel"
					varStatus="vstatus">
					<tr style="text-align:center;height:26px;line-height:26px;"
						kmss_href="<c:url value="${baseModel[4]}" />?method=view&fdId=${baseModel[0]}">
						<td style="width:15px;"><input type="checkbox" name="List_Selected" value="${baseModel[0]}"></td>
						<td>${vstatus.index+1}</td>
						<td align="left">
					      <span name="subjectTb" 
					      		data-isCreator="${baseModel[6]}" 
					      		data-modelName="${baseModel[5]}">
					      		<c:out value="${baseModel[1]}"/>
					       </span>  
					    </td>
					    <td>
					    	<c:out value="${baseModel[8]}"/>
					    </td>
					    <td>
					    	<c:out value="${baseModel[7]}"/>
					    </td>
						<td>
							<c:out value="${baseModel[2]}"/>
						</td>
						<td>
							<c:out value="${baseModel[3]}"/>
						</td>
					</tr>
				</c:forEach>
			</table>
			<%@ include file="relevance_main_data_list_pagenav_down.jsp"%>
			<%
			}
			%>
	</div>
<script type="text/javascript">
	
	seajs.use(['lui/jquery', 'lui/topic'],function($, topic){
		$(document).ready(function(){
			//??????
			$("#List_ViewTable").delegate("input[name='List_Selected']","click",function(event){
				var checkBoxDom = event.target;
				triggerSelected(checkBoxDom);
			});
			
			// ????????????????????????
			var List_ViewTable= $("#List_ViewTable");
		    var height = List_ViewTable.height() + 50;
		    if(!List_ViewTable.height()) {
		    	// ???????????????????????????
		    	height = 250;
		    }
		    //$('#dataShowList', window.parent.document).height(400);
		    
		    // ?????????????????????
		    relevance_list_InitRow();
		});
	});

		//????????????????????????
		function updateParentPath(){
			if('${modelPath}' && '${modelPath}' != ''){
				parent.updatePath('${modelPath}');
			}
			//??????????????????fdKey?????????????????????????????????????????????????????????????????????????????????????????????????????????modelName
			if('${_fdKey}' && '${_fdKey}' != ''){
				parent.relevace_dialog_setFdKey('${_fdKey}');	
			}
		}
		
		Com_AddEventListener(window, 'load', updateParentPath);

		//??????|????????????
		function selectedAll(obj){
			$("input[name='List_Selected']").each(function(){
				//$(this).attr('checked',!$(this).attr("checked")); ??????jq???????????????--????????????????????????????????????$(this).attr("checked")???undefined?????????????????????
				if(obj.checked){
					this.checked = true;
				}else{
					this.checked = false;
				}
				triggerSelected(this);
			});	
		}

		//???????????????
		function triggerSelected(checkBoxDom){
			var config = {};		
			var tr = $(checkBoxDom).closest('tr');
			var subject = tr.find("span[name='subjectTb']");
			var docId = tr.find("input[type='checkbox']").val();		
			config.docId = docId;
			config.subject = subject.text();
			config.isCreator = subject.attr('data-isCreator');
			config.checked = checkBoxDom.checked;
			//??????????????????????????????????????????????????????????????????
			if(config.isCreator && config.isCreator == 'true'){
				config.openRight = 'true';
			}else{
				config.openRight = 'false';
			}
			config.fdModelName = subject.attr('data-modelName');
			changeSelectedArea(config);
		}

		//??????????????????
		function changeSelectedArea(config){
			if(config == null){
				return;
			}
			var checked = config.checked == true ? config.checked : false;
			if(checked){
				addSelectedArea(config);
			}else{
				deleteSelectedData(config.docId);
			}
		}

		//????????????
		function deleteSelectedData(docId){
			var selectedData = parent.getSelectedData();
			//???????????????????????????????????????
			if(selectedData.length > 0){
				for(var i = 0; i < selectedData.length; i++){
					if(selectedData[i].docId == docId){
						selectedData.splice(i, 1);
					}
				}
			}
		}

		//????????????
		function addSelectedArea(config){
			var selectedData = parent.getSelectedData();
			//???????????????????????????????????????
			if(selectedData.length >= 0){
				if(selectedData.length == 0){
					selectedData.push(config);
				}else{
					for(var i = 0; i < selectedData.length; i++){
						if(selectedData[i].docId == config.docId){
							break;
						}
						if(i == selectedData.length - 1){
							selectedData.push(config);
						}
					}
				}
				
			}
		}


		/***********************************************
		???????????????????????????
		***********************************************/
		function relevance_list_ClickRow(){
			//?????????????????????tr??????????????????????????????????????????????????????????????????
			if(arguments[0] && arguments[0].target && arguments[0].target.type == 'checkbox'){
				return;
			};
			Com_OpenWindow(this.getAttribute("kmss_href"),"_target");
		}

		/***********************************************
		???????????????mouseover??????
		***********************************************/
		function relevance_list_Onmouseover(){
			if(relevance_list_CurrentRowInfo.rowObj!=null)
				relevance_list_CurrentRowInfo.rowObj.className = relevance_list_CurrentRowInfo.className;
			relevance_list_CurrentRowInfo.rowObj = this;
			relevance_list_CurrentRowInfo.className = relevance_list_CurrentRowInfo.rowObj.className;
			this.className = "tr_listrowcur2";
		}

		relevance_list_CurrentRowInfo = new Object;		//??????????????????

		//???????????????????????????????????????
		function detailWithCheckedRow(row){
			//?????????
			var $selected = $(row).find("input[name='List_Selected']");
			//id
			var rowId = $selected.val();
			//??????????????????
			var selectedDatas = parent.getSelectedData();
			//??????????????????
			for(var i =0;i < selectedDatas.length;i++){
				var data = selectedDatas[i];
				//???????????????
				if(data.docId && data.docId == rowId){
					$selected.attr('checked',true);
					break;
				}
			}
			this.checked = true;
		}
		
		function relevance_list_InitRow(){  //??????
			setTimeout("___init___initRow()", 100);
		}
		
		function ___init___initRow() {
			var tbObj = document.getElementById("List_ViewTable");
			if(tbObj){
				for(var i = 1;i < tbObj.rows.length; i++){
					var row = tbObj.rows[i];
					//??????????????????
					detailWithCheckedRow(row);
					var href = row.getAttribute("kmss_href");
					if(href!=null && href!=""){
						row.onmouseover = relevance_list_Onmouseover;
						row.onclick = relevance_list_ClickRow;
						row.style.cursor = "pointer";
					}
				}
			}
		}
		//#88279
		function validateInteger(field) {
			var bValid = true;
		    if (field.type == 'text' ||
		    	field.type == 'textarea' ||
				field.type == 'select-one' ||
				field.type == 'radio') {
				var value = '';
				if (field.type == "select-one") {
					var si = field.selectedIndex;
				    if (si >= 0) {
					    value = field.options[si].value;
				    }
				} else {
					value = field.value;
				}
				if (value.length > 0) {
					if (!isAllDigits(value)) {
						bValid = false;
						field.focus();					        
					} else {
						var iValue = parseInt(value);
						if (isNaN(iValue) || !(iValue >= -2147483648 && iValue <= 2147483647)) {
							if (i == 0) {
								focusField = field;
							}
							bValid = false;
						}
					}
				}
			}
			return bValid;
		}
		
		function isAllDigits(argvalue) {
			argvalue = argvalue.toString();
			var validChars = "0123456789";
			var startFrom = 0;
			if (argvalue.substring(0, 2) == "0x") {
			   validChars = "0123456789abcdefABCDEF";
			   startFrom = 2;
			} else if (argvalue.charAt(0) == "0") {
			   validChars = "01234567";
			   startFrom = 1;
			} else if (argvalue.charAt(0) == "-") {
			   startFrom = 1;
			}
			
			for (var n = startFrom; n < argvalue.length; n++) {
			    if (validChars.indexOf(argvalue.substring(n, n+1)) == -1) return false;
			}
			return true;
		}
</script>
</body>