<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.edit" sidebar="auto">
	
	<template:replace name="head">
		<link type="text/css" rel="stylesheet" href="${LUI_ContextPath}/km/supervise/resource/css/supervise.css?s_cache=${LUI_Cache}"/>
        <style type="text/css">
            .lui_form_body{background:white;}
          	.all>input{opacity:0;position:absolute;width:2em;height:2em;margin:0;cursor:pointer;top:auto;}
		    .all>input:nth-of-type(1),
		    .all>span:nth-of-type(1){display:none;}
		    .all>span{font-size:2em;color:gold;
		      -webkit-transition:color .8s;
		      transition:color .8s;
		    }
		    .all>input:checked~span{color:#666;}
		    .all>input:checked+span{color:gold;}
        </style>
    </template:replace>
	
	<%--操作按钮--%>
	<template:replace name="toolbar">
		<ui:toolbar id="toolbar" layout="sys.ui.toolbar.float">
			<%--add页面的按钮--%>
			<ui:button text="${lfn:message('button.update') }" order="2" onclick="commitMethod('save');">
			</ui:button>
			<%--关闭--%>
			<ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();">
			</ui:button>
		</ui:toolbar>
	</template:replace>
	
	
	<%--督办评价表单--%>
	<template:replace name="content"> 
		<html:form action="/km/supervise/km_supervise_main_remark/kmSuperviseMainRemark.do">
			<html:hidden property="fdId"/>
			<html:hidden property="method_GET"/>
		    <p class="lui_form_subject">${ lfn:message('km-supervise:py.DuBanKaoPing') }</p>
	        <div class="lui_form_content_frame" >
	            <table class="tb_normal" width="95%">
	            	<tr>
	            		<td class="td_normal_title" width="15%">
	            			<bean:message bundle="km-supervise" key="kmSupervise.items" />
	            		</td>
	            		<td colspan="3">
	            			<xform:text property="docSubject" showStatus="view"/>
	            		</td>
	            	</tr>
	                <tr>
						<!-- 分管领导 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdLeads" />
						</td>
						<td width="35%">
							<xform:address propertyName="fdLeadNames" propertyId="fdLeadIds" showStatus="view" />
						</td>
						<!-- 主办单位 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSysUnit" />
						</td>
						<td width="35%">
							<c:choose>
								<c:when test="${kmSuperviseMainRemarkForm.fdSysUnitEnable eq 'true'}">
									<xform:address propertyName="fdSysUnitName" propertyId="fdSysUnitId" showStatus="view"/>
								</c:when>
								<c:otherwise>
									<xform:address propertyName="fdUnitName" propertyId="fdUnitId" showStatus="view"/>
								</c:otherwise>
							</c:choose>
						</td>	
					</tr>
					<tr>
						<!-- 主办单位责任人 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdSponsor" />
						</td>
						<td width="35%">
							<xform:address propertyName="fdSponsorName" propertyId="fdSponsorId" showStatus="view" />
						</td>
						<!-- 协办单位 -->
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdOtherUnits" />
						</td>
						<td width="35%">
							<c:choose>
								<c:when test="${kmSuperviseMainRemarkForm.fdSysUnitEnable eq 'true'}">
									<xform:address propertyName="fdOtherUnitNames" propertyId="fdOtherUnitIds" showStatus="view" />
								</c:when>
								<c:otherwise>
									<xform:address propertyName="fdOUnitNames" propertyId="fdOUnitIds" showStatus="view"/>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdFinishLevel" />
						</td>
						<td colspan="3">
							<p class="all">
							 <input type="radio" name="fdFinishLevel" value="0" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="1" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="2" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="3" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="4" checked="checked" />
						      <span>★</span>
						      <input type="radio" name="fdFinishLevel" value="5" />
						      <span>★</span>
						    </p>
						</td>
					</tr>
					<!-- 评价说明 -->
					<tr>
						<td class="td_normal_title" width="15%">
							<bean:message bundle="km-supervise" key="kmSuperviseMain.fdRemark" />
						</td>
						<td colspan="3">
							<xform:textarea property="fdRemark" style="width:98%;" validators="maxLength(2000)"/>
						</td>
					</tr>
	            </table>
	        </div>
		    <script>
		        $KMSSValidation(document.kmSuperviseMainRemarkForm);
		        window.commitMethod = function(method){
		        	Com_Submit(document.kmSuperviseMainRemarkForm,method);
		        };
		    </script>
		</html:form>
	</template:replace>
	
</template:include>