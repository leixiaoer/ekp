<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ page import="com.landray.kmss.sys.organization.model.SysOrgPerson"%>
<%@ page import="java.util.*"%>
<script>
    Com_IncludeFile("dialog.js|jquery.js");
    Com_IncludeFile("sysUnitDialog.js", Com_Parameter.ContextPath+ "sys/unit/resource/js/", "js", true);
</script> 
<div class="lui_supervise_plan_wrap">
	<div class="lui_supervise_plan_title">
    	<div class="lui_supervise_plan_left lui_tabpage_float_header_title">
        	<span class="lui_text_primary"><bean:message key="py.zhiDingJiHua" bundle="km-supervise"/></span>
        	<div class="lui_task_status_help">
		       <div class="lui_task_status_help_pop">
		           <div class="lui_task_status_item">
		           	<span class="lui_task_label"><bean:message key="py.makePlan.tip" bundle="km-supervise"/></span>
		           </div>
		       </div>
		   </div>
        </div>
        <div class="lui_supervise_plan_right">
            <!-- 按钮组 -->
	        <div class="lui_supervise_plan_btnGroup">
	        	<span>
		            <bean:message bundle="km-supervise" key="py.An" />
					<xform:select property="fdStageType" showPleaseSelect="false" showStatus="edit" onValueChange="stageChange" style="width:15%!important">
						<xform:enumsDataSource enumsType="km_supervise_task_stage"></xform:enumsDataSource>
					</xform:select>
					<bean:message bundle="km-supervise" key="py.ZiDongShengChengJieDuan"/>
	        	</span>
	            <span class="lui_supervise_link lui_text_primary" onclick="addRow()"><i
	                    class="lui_icon_s icon_add"></i><span><bean:message bundle="km-supervise" key="py.TianJiaJieDuan" /></span></span>
	            <span class="lui_supervise_link lui_text_primary" onclick="importExcel()"><i
	                    class="lui_icon_s icon_import"></i><span><bean:message bundle="km-supervise" key="py.PiLiangDaoRu" /></span></span>
	            <span class="lui_supervise_link lui_text_primary" onclick="downloadTemlate()"><i
	                    class="lui_icon_s icon_download"></i><span><bean:message bundle="km-supervise" key="py.MoBanXiaZai" /></span></span>
	        </div>
    	</div>
	</div>
    <div class="lui_supervise_plan_table">
    	<table id="TABLE_DocList" tbdraggable="true">
    		<tr>
                <td class="td_normal_title" style="width: 10%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
    			</td>
    			<td class="td_normal_title" style="width: 18%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
    			</td>
    			<td class="td_normal_title" style="width: 15%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanStartTime"/>
    			</td>
    			<td class="td_normal_title" style="width: 15%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdPlanEndTime"/>
    			</td>
    			<c:if test="${param.isEnable eq 'true'}">
    			<td class="td_normal_title" style="width: 13%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
    			</td>
    			<td class="td_normal_title" style="width: 10%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
    			</td>
    			<td class="td_normal_title" style="width: 13%">
    				<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
    			</td>
    			</c:if>
    			<td class="td_normal_title" style="width: 6%">
    				<bean:message key="list.operation"/>
    			</td>
            </tr>
            <!-- 基准行 -->
			<tr KMSS_IsReferRow="1" style="display: none" align="center" class="task_add_class">
				<td >
					<html:hidden property="fdItems[!{index}].fdId" value=""/>
					<html:hidden property="fdItems[!{index}].fdOrder" value="!{index}"/>
					<xform:text property="fdItems[!{index}].docSubject" style="width:80%" required="true" validators="maxLength(200)"/>
				</td>
				<td>
					<xform:textarea property="fdItems[!{index}].docContent" style="width:85%" htmlElementProperties="data-actor-expand='true'" required="true" validators="maxLength(1000)"/>
				</td>
				<td>
					<xform:datetime property="fdItems[!{index}].fdPlanStartTime" style="width:93%;" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" dateTimeType="datetime"  required="true" validators="validateTime"/>
				</td>
				<td>
					<xform:datetime property="fdItems[!{index}].fdPlanEndTime"  style="width:93%;" subject="${ lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" dateTimeType="datetime" required="true" validators="validateTime"/>
				</td>
				<c:if test="${param.isEnable eq 'true'}">
				<td>
					<c:choose>
						<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
							<xform:dialog propertyId="fdItems[!{index}].fdSysUnitId"
					              propertyName="fdItems[!{index}].fdSysUnitName"
						          style="width:95%;" 
						          className="inputsgl"
						          mulSelect="false"
						          useNewStyle="true">
							      Dialog_UnitTreeList(false, 'fdItems[!{index}].fdSysUnitId', 'fdItems[!{index}].fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
							      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
							</xform:dialog>
						</c:when>
						<c:otherwise>
							<xform:address propertyId="fdItems[!{index}].fdUnitId" propertyName="fdItems[!{index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;"/>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<xform:address propertyId="fdItems[!{index}].fdSponsorId" propertyName="fdItems[!{index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;"/>
				</td>
				<td>
					<c:choose>
						<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
							<xform:dialog propertyId="fdItems[!{index}].fdOtherUnitIds"
					              propertyName="fdItems[!{index}].fdOtherUnitNames"
						          style="width:95%;" 
						          className="inputsgl"
						          mulSelect="true"
						          onValueChange="changeUnit"
						          useNewStyle="true">
							      Dialog_UnitTreeList(true, 'fdItems[!{index}].fdOtherUnitIds', 'fdItems[!{index}].fdOtherUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
							      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
							</xform:dialog>
						</c:when>
						<c:otherwise>
							<xform:address propertyId="fdItems[!{index}].fdOUnitIds" propertyName="fdItems[!{index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mulSelect="true"/>
						</c:otherwise>
					</c:choose>
				</td>
				</c:if>
				<!-- 删除、上移、下移按钮 -->
				<td align="center">
					<a href="javascript:void(0);" onclick="DocList_DeleteRow();" title="${lfn:message('doclist.delete')}">
						<img src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" />
					</a>
				</td>
			</tr>
			<c:forEach items="${kmSuperviseMainForm.fdItems}"  var="fdItem" varStatus="vstatus">
				<tr KMSS_IsContentRow="1" class="task_add_class">
					<td >
						<html:hidden property="fdItems[${vstatus.index}].fdId" value="${fdItem.fdId}"/>
						<html:hidden property="fdItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
						<xform:text property="fdItems[${vstatus.index}].docSubject" style="width:80%" required="true"  validators="maxLength(200)"/>
					</td>
					<td>
						<xform:textarea property="fdItems[${vstatus.index}].docContent" style="width:85%" htmlElementProperties="data-actor-expand='true'" required="true"  validators="maxLength(1000)"/>
					</td>
					<td>
						<xform:datetime property="fdItems[${vstatus.index}].fdPlanStartTime" style="width:93%;" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" dateTimeType="datetime"  required="true" validators="validateTime"/>
					</td>
					<td>
						<xform:datetime property="fdItems[${vstatus.index}].fdPlanEndTime"  style="width:93%;" subject="${ lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" dateTimeType="datetime" required="true" validators="validateTime"/>
					</td>
					<c:if test="${param.isEnable eq 'true'}">
					<td>
						<c:choose>
							<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
								<xform:dialog propertyId="fdItems[${vstatus.index}].fdSysUnitId"
						              propertyName="fdItems[${vstatus.index}].fdSysUnitName"
							          style="width:95%;" 
							          className="inputsgl"
							          mulSelect="false"
							          useNewStyle="true">
								      Dialog_UnitTreeList(false, 'fdItems[${vstatus.index}].fdSysUnitId', 'fdItems[${vstatus.index}].fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
								      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
								</xform:dialog>
								<script>
									initNewDialog("fdItems[${vstatus.index}].fdSysUnitId","fdItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"","",null);
									resetNewDialog("fdItems[${vstatus.index}].fdSysUnitId","fdItems[${vstatus.index}].fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",false,"${fdItem.fdSysUnitId}","${fdItem.fdSysUnitName}",null);
								</script>
							</c:when>
							<c:otherwise>
								<xform:address propertyId="fdItems[${vstatus.index}].fdUnitId" propertyName="fdItems[${vstatus.index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;"/>
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<xform:address propertyId="fdItems[${vstatus.index}].fdSponsorId" propertyName="fdItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;"/>
					</td>
					<td>
						<c:choose>
							<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
								<xform:dialog propertyId="fdItems[${vstatus.index}].fdOtherUnitIds"
						              propertyName="fdItems[${vstatus.index}].fdOtherUnitNames"
							          style="width:95%;" 
							          className="inputsgl"
							          mulSelect="true"
							          useNewStyle="true">
								      Dialog_UnitTreeList(true, 'fdItems[${vstatus.index}].fdOtherUnitIds', 'fdItems[${vstatus.index}].fdOtherUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
								      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',null,'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
								</xform:dialog>
								<script>
									initNewDialog("fdItems[${vstatus.index}].fdOtherUnitIds","fdItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",null);
									resetNewDialog("fdItems[${vstatus.index}].fdOtherUnitIds","fdItems[${vstatus.index}].fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"${fdItem.fdOtherUnitIds}","${fdItem.fdOtherUnitNames}",null);
								</script>
							</c:when>
							<c:otherwise>
								<xform:address propertyId="fdItems[${vstatus.index}].fdOUnitIds" propertyName="fdItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mulSelect="true"/>
							</c:otherwise>
						</c:choose>
					</td>
					</c:if>
					<!-- 删除、上移、下移按钮 -->
					<td align="center">
						<a href="#" onclick="DocList_DeleteRow();"><img
							src="${KMSS_Parameter_StylePath}/icons/delete.gif" border="0" /></a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
    <div class="lui_supervise_plan_other">
		<table class="tb_simple">
    		<tr>
		    	<td class="td1">
		      		<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>：
		      	</td>
	          	<td class="td2">
	          		<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" style="width:12%!important">
						<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
					</xform:select>
					<div style="display:inline-block;margin-left:5px" class="lui_supervise_right lui_text_primary" onclick="previewBackDay()"><bean:message key="py.backDay.preview" bundle="km-supervise"/><i class="lui_arrow arrow_right"></i></div>
	          	</td>
			</tr>
			<tr>
				<td class="td1"><bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>：</td>
	        	<td class="td2">
	          		<c:import url="/sys/attachment/sys_att_main/sysAttMain_edit.jsp" charEncoding="UTF-8">
		            	<c:param name="fdKey" value="attTask" />
		                <c:param name="formBeanName" value="kmSuperviseMainForm" />
		                <c:param name="fdMulti" value="true" />
	            	</c:import>
	            </td>
	        </tr>
	    </table>
	</div>
</div>
<script type="text/javascript">
	var validation = $KMSSValidation(document.forms['kmSuperviseMainForm']);
	validation.addValidator('validateTime','11111',function(v,e,o){
		var flag = false;
		var result = _validateTime(v,e,o);
		if(result == "0"){
			flag = true;
		}
		if(result == "1"){
			validator = this.getValidator('validateTime');
			var error = '督办开始时间和结束时间不能为空';
			validator.error = error;
		}
		if(result == "2"){
			validator = this.getValidator('validateTime');
			var error = '计划开始时间不能早于督办开始时间';
			validator.error = error;
		}
		if(result == "3"){
			validator = this.getValidator('validateTime');
			var error = '计划开始时间不能晚于督办结束时间';
			validator.error = error;
		}
        if(result == "4"){
            validator = this.getValidator('validateTime');
            var error = '计划截止时间不能早于督办开始时间';
            validator.error = error;
        }
        if(result == "5"){
            validator = this.getValidator('validateTime');
            var error = '计划截止时间不能晚于督办结束时间';
            validator.error = error;
        }
		if(result == "6"){
			validator = this.getValidator('validateTime');
			var error = '计划截止时间不能早于计划开始时间';
			validator.error = error;
		}
		if(result == "7"){
			validator = this.getValidator('validateTime');
			var error = '计划开始时间不能早于计划结束时间';
			validator.error = error;
		}
		return flag;
	});
	
	validation.addValidator('validateSuperviseTime','2222',function(v,e,o){
		var fdStartTime = $('[name="fdStartTime"]').val();
		var fdFinishTime = $('[name="fdFinishTime"]').val();
		if(fdStartTime == ""){
			validator = this.getValidator('validateSuperviseTime');
			var error = '请先选择开始时间';
			validator.error = error;
			return false;
		}
		var ds = Com_GetDate(fdStartTime);
		var de = Com_GetDate(fdFinishTime);
		if(de < ds){
			validator = this.getValidator('validateSuperviseTime');
			var error = '结束时间不能早于开始时间';
			validator.error = error;
			return false;
		}else{
			return true
		}
	});
	
	var _validateTime = function(v,e,o){
		var fdStartTime = $('[name="fdStartTime"]').val();
		var fdFinishTime = $('[name="fdFinishTime"]').val();
		if(fdStartTime == "" || fdFinishTime==""){
			return "1";
		}
		var ds = Com_GetDate(fdStartTime);
		var de = Com_GetDate(fdFinishTime);
		var dv = Com_GetDate(v);

		if(e.name.indexOf("fdPlanStartTime") > -1 ){
			var fdPlanEndTime = e.name.replace("fdPlanStartTime","fdPlanEndTime");
			var endTime = $('[name="'+fdPlanEndTime+'"]').val();
			var end = Com_GetDate(endTime);
            if(dv < ds){
                return "2";
            }
            if(dv > de){
                return "3";
            }
            if(dv > end){
				return "7";
			}
		}else if(e.name.indexOf("fdPlanEndTime") > -1){
			var fdPlanStartTime = e.name.replace("fdPlanEndTime","fdPlanStartTime");
			var startTime = $('[name="'+fdPlanStartTime+'"]').val();
			var start = Com_GetDate(startTime);
            if(dv < ds){
                return "4";
            }
            if(dv > de){
                return "5";
            }
			if(dv < start){
				return "6";
			}
		}
		return "0";
	};
	
	var isEnable = "${param.isEnable}";
	var isSysUnitEnable = "${kmSuperviseMainForm.fdSysUnitEnable}";
	
	if(isSysUnitEnable == 'true'){
		$(document).on('table-add',"table[id$='TABLE_DocList']",function(e, row) {
			if(window.$) {
				try {
					var ads = $(row).find('[xform-newdialog="true"]'); 
					$.each(ads,function(index,item) {
						var $item = $(item);
						var xformName = $item.attr('xform-name');
						var _field = $("[xform-name='"+xformName+"']")[0];
						var idField = document.getElementsByName($item.data('propertyid'))[0];
						var nameField = document.getElementsByName($item.data('propertyname'))[0];
						var idValue = idField.value;
						var nameValue = nameField.value;
						var $input = $(_field);
						var propertyId = $input.data('propertyid');
						var propertyName = $input.data('propertyname');
						var isMulti = eval($input.data('ismulti'));
						emptyNewAddress(propertyName,null,0,false);
						initNewDialog(propertyId,propertyName,";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",isMulti,"","",function(rtn, objs){
						});
						if(idValue != "" && nameValue !=""){
							resetNewDialog(propertyId,propertyName,";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",isMulti,idValue,nameValue,null);
						}
					});
				}catch(err) {
				}
			}
		});
	}
	
	//增加行
	function addRow(){
		var fieldValues = new Object();
		var optTB = document.getElementById("TABLE_DocList");
		var tbInfo = DocList_TableInfo[optTB.id];
		var index = tbInfo.lastIndex;
		var length = tbInfo.lastIndex - tbInfo.firstIndex;
		var fdStartTime = document.getElementsByName("fdStartTime"), 
			fdFinishTime = document.getElementsByName("fdFinishTime");
		if(fdStartTime.length > 0) {
			fieldValues["fdItems[!{index}].fdPlanStartTime"]=fdStartTime[0].value;
		}
		if(fdFinishTime.length > 0) {
			fieldValues["fdItems[!{index}].fdPlanEndTime"]=fdFinishTime[0].value;
		}
		fieldValues["fdItems[!{index}].docSubject"]="阶段"+ tbInfo.lastIndex;
		if(isEnable == 'true'){
			if(isSysUnitEnable == 'true'){
				var otherUnitIds = document.getElementsByName("fdOtherUnitIds");
				var otherUnitNames = document.getElementsByName("fdOtherUnitNames");
				if(otherUnitIds.length>0 && otherUnitNames.length>0){
					var unitIds=otherUnitIds[0].value;
					var unitNames=otherUnitNames[0].value;
					fieldValues["fdItems[!{index}].fdOtherUnitIds"]=unitIds;
					fieldValues["fdItems[!{index}].fdOtherUnitNames"]=unitNames;
				}
			}else{
				var oUnitIds = document.getElementsByName("fdOUnitIds");
				var oUnitNames = document.getElementsByName("fdOUnitNames");
				if(oUnitIds.length>0 && oUnitNames.length>0){
					var unitIds=oUnitIds[0].value;
					var unitNames=oUnitNames[0].value;
					fieldValues["fdItems[!{index}].fdOUnitIds"]=unitIds;
					fieldValues["fdItems[!{index}].fdOUnitNames"]=unitNames;
				}
			}
		}
		
		DocList_AddRow("TABLE_DocList",null,fieldValues);
	}
	
	seajs.use(['lui/dialog'],function(dialog){
		window.stageChange = function(val){
			var stage = "";
			if(val == "0"){
				stage = "默认";
			}else if(val == "1"){
				stage = "周";
			}else if(val == "2"){
				stage = "双周";
			}else if(val == "3"){
				stage = "月";
			}else if(val == "4"){
				stage = "季度";
			}else if(val == "5"){
				stage = "年";
			}
			var fdStartTime = document.getElementsByName("fdStartTime")[0];
			var fdFinishTime = document.getElementsByName("fdFinishTime")[0];
			var startTime = fdStartTime.value;
			var finishTime = fdFinishTime.value;
			if (startTime == null || startTime=="" || finishTime == null || finishTime=="") {
				dialog.alert("${lfn:message('km-supervise:stage.alert.tip')}");
				return;
			}
			dialog.confirm("${lfn:message('km-supervise:py.description.refreshStage')}".replace('%stage%',stage),function(flag){
				if(flag){
					var allTR = document.getElementById("TABLE_DocList").getElementsByClassName("task_add_class");
					for(var i = allTR.length - 1 ; i >= 0 ;i--){
						DocList_DeleteRow(allTR[i]);
					}
					var data = new KMSSData();
					var url = "${KMSS_Parameter_ContextPath}km/supervise/km_supervise_task/kmSuperviseTask.do?method=autoAddTask&fdStartTime="+startTime+"&fdFinishTime="+finishTime+"&fdStageType="+val;
				    data.SendToUrl(url, function(data) {
						var results = eval("(" + data.responseText + ")");
						if (results.length > 0) {
							for(var j=0;j<results.length;j++){
								var fieldValues = new Object();
								fieldValues["fdItems[!{index}].docSubject"]="阶段"+(j+1);
								fieldValues["fdItems[!{index}].fdPlanStartTime"]=results[j].fdPlanStartTime;
								fieldValues["fdItems[!{index}].fdPlanEndTime"]=results[j].fdPlanEndTime;
								if(isEnable == 'true'){
									if(isSysUnitEnable == 'true'){
										var otherUnitIds = document.getElementsByName("fdOtherUnitIds");
										var otherUnitNames = document.getElementsByName("fdOtherUnitNames");
										if(otherUnitIds.length>0 && otherUnitNames.length>0){
											var unitIds=otherUnitIds[0].value;
											var unitNames=otherUnitNames[0].value;
											fieldValues["fdItems[!{index}].fdOtherUnitIds"]=unitIds;
											fieldValues["fdItems[!{index}].fdOtherUnitNames"]=unitNames;
										}
									} else{
										var oUnitIds = document.getElementsByName("fdOUnitIds");
										var oUnitNames = document.getElementsByName("fdOUnitNames");
										if(oUnitIds.length>0 && oUnitNames.length>0){
											var unitIds=oUnitIds[0].value;
											var unitNames=oUnitNames[0].value;
											fieldValues["fdItems[!{index}].fdOUnitIds"]=unitIds;
											fieldValues["fdItems[!{index}].fdOUnitNames"]=unitNames;
										}
									}
								}
								DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
						   }
						}
					});
				}
			});
		}
		
		window.downloadTemlate = function(){
			Com_OpenWindow('<c:url value="/km/supervise/km_supervise_task/kmSuperviseTask.do" />?method=downloadTemplate&isSysUnitEnable=${kmSuperviseMainForm.fdSysUnitEnable}');
		}
		
		window.importExcel = function(){
			var path = "/km/supervise/km_supervise_task/task_upload.jsp?isSysUnitEnable=${kmSuperviseMainForm.fdSysUnitEnable}"
			dialog.iframe(path,"${lfn:message('km-supervise:kmSuperviseTask.import.title')}",function(results){
				if(results){
					if (results.length > 0) {
						for(var i=0;i<results.length;i++){
							var fieldValues = new Object();
							fieldValues["fdItems[!{index}].docSubject"]=results[i].docSubject;
							fieldValues["fdItems[!{index}].docContent"]=results[i].docContent;
							fieldValues["fdItems[!{index}].fdPlanStartTime"]=results[i].fdPlanStartTime;
							fieldValues["fdItems[!{index}].fdPlanEndTime"]=results[i].fdPlanEndTime;
							if(isEnable == 'true'){
								if(isSysUnitEnable == 'true'){
									if(results[i].fdSysUnitId&&results[i].fdSysUnitName){
										fieldValues["fdItems[!{index}].fdSysUnitId"]=results[i].fdSysUnitId;
										fieldValues["fdItems[!{index}].fdSysUnitName"]=results[i].fdSysUnitName;
									}
									if(results[i].fdOtherUnitIds&&results[i].fdOtherUnitNames){
										fieldValues["fdItems[!{index}].fdOtherUnitIds"]=results[i].fdOtherUnitIds;
										fieldValues["fdItems[!{index}].fdOtherUnitNames"]=results[i].fdOtherUnitNames;
									}
								}else{
									if(results[i].fdUnitId&&results[i].fdUnitName){
										fieldValues["fdItems[!{index}].fdUnitId"]=results[i].fdUnitId;
										fieldValues["fdItems[!{index}].fdUnitName"]=results[i].fdUnitName;
									}
									if(results[i].fdOUnitIds&&results[i].fdOUnitNames){
										fieldValues["fdItems[!{index}].fdOUnitIds"]=results[i].fdOUnitIds;
										fieldValues["fdItems[!{index}].fdOUnitNames"]=results[i].fdOUnitNames;
									}
								}
								
								if(results[i].fdSponsorId&&results[i].fdSponsorName){
									fieldValues["fdItems[!{index}].fdSponsorId"]=results[i].fdSponsorId;
									fieldValues["fdItems[!{index}].fdSponsorName"]=results[i].fdSponsorName;
								}
							}
							DocList_AddRow(document.getElementById("TABLE_DocList"),null,fieldValues);
					   }
					}
				}
			},{width:450,height:240});
		}
		
		window.previewBackDay = function(){
			console.info(15);
			var fdBackType = document.getElementsByName("fdBackType")[0];
			var backType = fdBackType.value;
			var allTR = document.getElementById("TABLE_DocList").getElementsByClassName("task_add_class");
			var stages = []; 
			for(var i = 0 ;i < allTR.length;i++){
				var vals = {};
				var optTR = allTR[i];
				$(optTR).find(":input").each(function(idx, elem){
					var domNode = $(elem); 
					if(elem && elem.name){
						if(elem.name.indexOf("fdPlanStartTime") > -1 ){
							vals["fdPlanStartTime"] = DocList_getFiledValue(optTR,elem.name);
						}else if(elem.name.indexOf("fdPlanEndTime") > -1){
							vals["fdPlanEndTime"] = DocList_getFiledValue(optTR,elem.name);
						}else if(elem.name.indexOf("docSubject") > -1){
							vals["docSubject"] = DocList_getFiledValue(optTR,elem.name);
						}
					}
				});
				stages.push(vals);
			}
			var stageStr = JSON.stringify(stages);
			stageStr = encodeURI(stageStr);
			dialog.iframe("/km/supervise/km_supervise_main/import/back_day_preview_frame.jsp?fdBackType="+backType+"&stages="+stageStr,
           			'反馈日预览',null,{width:600,height:360});
		}
	});
	
</script>