<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<div class="lui_matrix_div_wrap">
   <!-- 矩阵卡片 - 左右移动 Starts  -->
   <div class="lui_matrix_field_tb_wrap">
       <!-- 类型 -->
       <div class="lui_matrix_field_tb_item lui_matrix_field_tb_item_type">
           <table id="matrix_type_table" class="lui_matrix_tb_normal" style="width: 80px;">
               <tr>
                   <td class="lui_matrix_td_normal_title"><bean:message key="sys.common.viewInfo.type"/></td>
               </tr>
               <tr style="height: 80px;">
                   <td class="lui_matrix_td_normal_title"><bean:message bundle="sys-organization" key="sysOrgMatrixRelation.fdFieldName"/><br><bean:message bundle="sys-organization" key="sysOrgMatrixRelation.fdFieldName.alias"/></td>
               </tr>
               <tr>
                   <td class="lui_matrix_td_normal_title lui_matrix_td_normal_empty">&nbsp;</td>
               </tr>
               <c:if test="${sysOrgMatrixForm.matrixType!='1'}">
	               <tr>
	                   <td class="lui_matrix_td_normal_title"><bean:message key="list.operation"/></td>
	               </tr>
               </c:if>
           </table>
       </div>
       <!-- 条件数据 -->
       <div class="lui_matrix_field_tb_item lui_matrix_field_tb_item_condition">
           <table id="matrix_table" class="lui_matrix_tb_normal">
				<!-- 表头行 -->
				<tr id="matrix_field_type">
				</tr>
				<!-- 内容行 -->
              	<tr id="matrix_field_value" style="height: 80px;">
				</tr>
				<!-- 空白行 -->
				<tr id="matrix_field_blank">
				</tr>
				<!-- 操作行 -->
				 <c:if test="${sysOrgMatrixForm.matrixType!='1'}">
	              	<tr id="matrix_field_opt">
					</tr>
				</c:if>
           </table>
       </div>
   </div>
   <kmss:auth requestURL="/sys/organization/sys_org_matrix_relation/sysOrgMatrixRelation.do?method=check&matrixId=${sysOrgMatrixForm.fdId}" requestMethod="GET">
   <c:if test="${not empty delCountDesc}">
   <div style="padding-top: 20px;">
   		<span style="color: red;">
   			<c:out value="${delCountDesc}"/>
   			<a href="javascript:;" onclick="fieldCheck();">${lfn:message('sys-organization:sysOrgMatrix.field.check')}</a>
   		</span>
   </div>
   </c:if>
   </kmss:auth>
</div>
<!-- 模板数据  sysOrgMatrixForm.matrixType=='1'内置的矩阵数据不被修改 -->
<script id="tpl_con_type" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType=='1'}">
		<xform:select property="fdRelationConditionals[0].fdType" showStatus="readOnly"  required="true" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdType1') }" style="width:90%;" onValueChange="conditionalChange">
			<xform:enumsDataSource enumsType="sys_org_matrix_conditional" />
		</xform:select>
	</c:if>
    <c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<xform:select property="fdRelationConditionals[0].fdType" required="true" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdType1') }" style="width:90%;" onValueChange="conditionalChange">
			<xform:enumsDataSource enumsType="sys_org_matrix_conditional" />
		</xform:select>
	</c:if>
	<input type="hidden" name="fdRelationConditionals[0].fdId">
	<div class="main_data_div" style="display: none;">
		<input type="hidden" name="fdRelationConditionals[0].fdMainDataType" disabled="disabled">
		<xform:text property="fdRelationConditionals[0].fdMainDataText" style="width:70%"  validators="maxLength(200)" />
		<a href="javascript:void(0);" onclick="selectMainData(this);"><bean:message key="dialog.selectOther" /></a>
	</div>
	<label>
		<div class="org_dept_div" style="display: none;">
			<input type="hidden" name="fdRelationConditionals[0].fdIncludeSubDept" class="type_dept" disabled="disabled">
			<input type="checkbox" disabled="disabled" onclick=setValue(this)><bean:message bundle='sys-organization' key='sysOrgMatrix.match.subdept'/>
			<div class="item_tips lui_icon_s lui_icon_s_cue4" title="<bean:message bundle='sys-organization' key='sysOrgMatrix.match.subdept.tip'/>"></div>
		</div>
	</label>
	<div class="unique_div">
		<label>
			<input type="hidden" name="fdRelationConditionals[0].fdIsUnique">
			<input type="checkbox" onclick=setValue(this)><bean:message bundle='sys-organization' key='sysOrgMatrixRelation.fdIsUnique'/>
			<div class="item_tips lui_icon_s lui_icon_s_cue4" title="<bean:message bundle='sys-organization' key='sysOrgMatrixRelation.fdIsUnique.note'/>"></div>
		</label>
	</div>
</script>
<script id="tpl_res_type" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType=='1'}">
		<xform:select property="fdRelationResults[0].fdType" required="true" showStatus="readOnly" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdType2') }" style="width:90%;">
			<xform:enumsDataSource enumsType="sys_org_matrix_result" />
		</xform:select>
	</c:if>
	
	<c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<xform:select property="fdRelationResults[0].fdType" required="true" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdType2') }" style="width:90%;">
			<xform:enumsDataSource enumsType="sys_org_matrix_result" />
		</xform:select>
	</c:if>
	
	<input type="hidden" name="fdRelationResults[0].fdId">
</script>
<script id="tpl_con_value" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType=='1'}">
		<xform:text property="fdRelationConditionals[0].fdName" showStatus="readOnly" style="width:93%;border:none;" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdFieldName1') }" required="true" validators="maxLength(200)" />
	</c:if>
	<c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<xform:text property="fdRelationConditionals[0].fdName" style="width:93%" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdFieldName1') }" required="true" validators="maxLength(200)" />
	</c:if>
</script>
<script id="tpl_res_value" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType=='1'}">
		<xform:text property="fdRelationResults[0].fdName" showStatus="readOnly" style="width:93%;border:none;" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdFieldName2') }" required="true" validators="maxLength(200)" />
	</c:if>
	<c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<xform:text property="fdRelationResults[0].fdName" style="width:93%" subject="${lfn:message('sys-organization:sysOrgMatrixRelation.fdFieldName2') }" required="true" validators="maxLength(200)" />
	</c:if>
</script>
<script id="tpl_con_opt" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<span class="lui_matrix_opt_bar">
         <a class="lui_text_primary lui_matrix_link icon_left" href="javascript:;" onclick="leftCon(this);" name="left" title="${lfn:message('sys-organization:sysOrgMatrixRelation.move.left')}"></a>
         <a class="lui_text_primary lui_matrix_link icon_del" href="javascript:;" onclick="delCon(this);" name="del" title="${lfn:message('button.delete')}"></a>
         <a class="lui_text_primary lui_matrix_link icon_add" href="javascript:;" onclick="addCon(this);" name="add" title="${lfn:message('button.create')}"></a>
		 <a class="lui_text_primary lui_matrix_link icon_right" href="javascript:;" onclick="rightCon(this);" name="right" title="${lfn:message('sys-organization:sysOrgMatrixRelation.move.right')}"></a>
    	</span>
	</c:if>
	
</script>
<script id="tpl_res_opt" type='text/template'>
	<c:if test="${sysOrgMatrixForm.matrixType!='1'}">
		<span class="lui_matrix_opt_bar">
        	<a class="lui_text_primary lui_matrix_link icon_left" href="javascript:;" onclick="leftRes(this);" name="left" title="${lfn:message('sys-organization:sysOrgMatrixRelation.move.left')}"></a>
        	<a class="lui_text_primary lui_matrix_link icon_del" href="javascript:;" onclick="delRes(this);" name="del" title="${lfn:message('button.delete')}"></a>
	    	<a class="lui_text_primary lui_matrix_link icon_add" href="javascript:;" onclick="addRes(this);" name="add" title="${lfn:message('button.create')}"></a>
			<a class="lui_text_primary lui_matrix_link icon_right" href="javascript:;" onclick="rightRes(this);" name="right" title="${lfn:message('sys-organization:sysOrgMatrixRelation.move.right')}"></a>
   		</span>
	</c:if>
	
</script>

<script language="JavaScript">
	// 字段检测
	window.fieldCheck = function() {
		Com_OpenWindow('<c:url value="/sys/organization/sys_org_matrix_relation/sysOrgMatrixRelation.do?method=check&matrixId=${sysOrgMatrixForm.fdId}"/>');
	}
</script>

<!-- 固定列的表格脚本 -->
<script type="text/javascript" src="${LUI_ContextPath}/sys/organization/resource/js/martrixEditField.js" ></script>
