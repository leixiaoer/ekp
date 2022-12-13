<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<table class="muiSimple" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2">
			<table width="100%" cellpadding="0" cellspacing="0" id="TABLE_DocList">
				<tr data-dojo-type="mui/form/Template"  KMSS_IsReferRow="1" style="display:none;" border='0'>
					<td class="detail_wrap_td">
						<table class="muiSimple">
							<tr celltr-title="true">
								<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
									<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
									<span onclick="expandRow(this);">
										${lfn:message('km-supervise:mobile.JieDuan')}!{index}
									</span>
									<xform:editShow>
										<div class="muiDetailTableDel" onclick="deleteRow(this);">
											<bean:message key="button.delete" />
										</div>
									</xform:editShow>
								</td>
							</tr>
							<tr data-celltr="true">
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
								</td>
								<td>
									<xform:config  orient="none">
										<html:hidden property="fdItems[!{index}].fdOrder" value="!{index}"/>
										<xform:text property="fdItems[!{index}].docSubject" showStatus="edit" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" required="true" mobile="true"></xform:text>
									</xform:config>
								</td>
							</tr>
							<tr data-celltr="true">
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
								</td>
								<td>
									<xform:config orient="none">
										<xform:textarea property="fdItems[!{index}].docContent" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}"/>
									</xform:config>
								</td>
							</tr>
							<tr data-celltr="true">
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
								</td>
								<td>
									<xform:config  orient="none">
										<xform:datetime property="fdItems[!{index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
									</xform:config>
								</td>
							</tr>
							<tr data-celltr="true"> 
								<td class="muiTitle">
									${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
								</td>
								<td>
									<xform:config  orient="none">
										<xform:datetime property="fdItems[!{index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
									</xform:config>
								</td>
							</tr>
							<!-- 主办单位 -->
							<tr data-celltr="true">
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
								</td>
								<td>
									<xform:config  orient="none">
										<c:choose>
											<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
												<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
											    	 data-dojo-props='"idField":"fdItems[!{index}].fdSysUnitId","nameField":"fdItems[!{index}].fdSysUnitName","curIds":"","curNames":"","subject":"承办单位","title":"承办单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
											   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
											    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
											    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
												   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
												</div>
											</c:when>
											<c:otherwise>
												<xform:address propertyId="fdItems[!{index}].fdUnitId" propertyName="fdItems[!{index}].fdUnitName" orgType="ORG_TYPE_DEPT"  style="width:90%;" required="true" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
											</c:otherwise>
										</c:choose>
									</xform:config>
								</td>
							</tr>
							<!-- 承办人 -->
							<tr data-celltr="true">
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
								</td>
								<td>
									<xform:config  orient="none">
										<xform:address propertyId="fdItems[!{index}].fdSponsorId" propertyName="fdItems[!{index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" required="true"/>
									</xform:config>
								</td>
							</tr>
							
							<!-- 协办单位 -->
							<tr data-celltr="true">
								<td class="muiTitle">
									<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
								</td>
								<td>
									<xform:config  orient="none">
										<c:choose>
											<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
												<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
											    	 data-dojo-props='"idField":"fdItems[!{index}].fdOtherUnitIds","nameField":"fdItems[!{index}].fdOtherUnitNames","curIds":"","curNames":"","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
											   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
											    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
											    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
												   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
												</div>
											</c:when>
											<c:otherwise>
												<xform:address propertyId="fdItems[!{index}].fdOUnitIds" propertyName="fdItems[!{index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}"/>
											</c:otherwise>
										</c:choose>
									</xform:config>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<c:forEach items="${kmSuperviseMainForm.fdItems}" var="fdItem" varStatus="vstatus">
					<c:choose>
						<c:when test="${fdItem.canEdit eq 'true' }">
							<tr KMSS_IsContentRow="1">
								<td class="detail_wrap_td">
									<table class="muiSimple">
										<tr celltr-title="true">
											<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
												<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
												<span onclick="expandRow(this);">
													${fdItem.docSubject}
												</span>
												<xform:editShow>
													<div class="muiDetailTableDel" onclick="deleteRow(this);">
														<bean:message key="button.delete" />
													</div>
												</xform:editShow>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
											</td>
											<td>
												<xform:config  orient="none">
													<html:hidden property="fdItems[${vstatus.index}].fdId" value="${fdItem.fdId}"/>
													<html:hidden property="fdItems[${vstatus.index}].fdOriginId" value="${fdItem.fdOriginId}"/>
													<html:hidden property="fdItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
													<xform:text property="fdItems[${vstatus.index}].docSubject" showStatus="edit" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" required="true" mobile="true"></xform:text>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
											</td>
											<td>
												<xform:config orient="none">
													<xform:textarea property="fdItems[${vstatus.index}].docContent" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}"/>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true"> 
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="edit" required="true" validators="validateTime" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<!-- 主办单位 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
											</td>
											<td>
												<xform:config  orient="none">
													<c:choose>
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
														    	 data-dojo-props='"idField":"fdItems[${vstatus.index}].fdSysUnitId","nameField":"fdItems[${vstatus.index}].fdSysUnitName","curIds":"${fdItem.fdSysUnitId}","curNames":"${fdItem.fdSysUnitName}","subject":"承办单位","title":"承办单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
														   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
														    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
														    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
															   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
															</div>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdUnitId" propertyName="fdItems[${vstatus.index}].fdUnitName" required="true" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
														</c:otherwise>
													</c:choose>
												</xform:config>
											</td>
										</tr>
										<!-- 承办人 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
											</td>
											<td>
												<xform:config  orient="none">
													<xform:address propertyId="fdItems[${vstatus.index}].fdSponsorId" propertyName="fdItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}"/>
												</xform:config>
											</td>
										</tr>
										
										<!-- 协办单位 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
											</td>
											<td>
												<xform:config  orient="none">
													<c:choose>
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
														    	 data-dojo-props='"idField":"fdItems[${vstatus.index}].fdOtherUnitIds","nameField":"fdItems[${vstatus.index}].fdOtherUnitNames","curIds":"${fdItem.fdOtherUnitIds}","curNames":"${fdItem.fdOtherUnitNames}","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
														   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
														    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
														    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
															   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
															</div>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdOUnitIds" propertyName="fdItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}"/>
														</c:otherwise>
													</c:choose>
												</xform:config>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr KMSS_IsContentRow="1">
								<td>
									<table class="muiSimple">
										<tr celltr-title="true">
											<td colspan="2" align="left" valign="middle" class="muiDetailTableNo">
												<div class="muiDetailDisplayOpt muiDetailDown" onclick="expandRow(this);"></div>
												<span onclick="expandRow(this);">
													${fdItem.docSubject}
												</span>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOrder"/>
											</td>
											<td>
												<xform:config  orient="none">
													<html:hidden property="fdItems[${vstatus.index}].fdId" value="${fdItem.fdId}"/>
													<html:hidden property="fdItems[${vstatus.index}].fdOriginId" value="${fdItem.fdOriginId}"/>
													<html:hidden property="fdItems[${vstatus.index}].fdOrder" value="${vstatus.index}"/>
													<xform:text property="fdItems[${vstatus.index}].docSubject" showStatus="readOnly" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOrder')}" required="true" mobile="true"></xform:text>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdTarget"/>
											</td>
											<td>
												<xform:config orient="none">
													<xform:textarea property="fdItems[${vstatus.index}].docContent" showStatus="readOnly" mobile="true" required="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdTarget')}"/>
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true">
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanStartTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanStartTime')}" showStatus="readOnly" required="true" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<tr data-celltr="true"> 
											<td class="muiTitle">
												${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}
											</td>
											<td>
												<xform:config  orient="none">
													<xform:datetime property="fdItems[${vstatus.index}].fdPlanEndTime" dateTimeType="datetime" subject="${lfn:message('km-supervise:kmSuperviseTask.fdPlanEndTime')}" showStatus="readOnly" required="true" mobile="true"/>	
												</xform:config>
											</td>
										</tr>
										<!-- 主办单位 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdUnit"/>
											</td>
											<td>
												<xform:config  orient="none">
													<c:choose>
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<html:hidden property="fdItems[${vstatus.index}].fdUnitId" value="${fdItem.fdUnitId}"/>
															<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
														    	 data-dojo-props='"idField":"fdItems[${vstatus.index}].fdSysUnitId","nameField":"fdItems[${vstatus.index}].fdSysUnitName","curIds":"${fdItem.fdSysUnitId}","curNames":"${fdItem.fdSysUnitName}","subject":"承办单位","title":"承办单位","showStatus":"edit","isMul":false,"validate":"required","required":true,
														   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
														    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
														    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
															   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
															</div>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdUnitId" propertyName="fdItems[${vstatus.index}].fdUnitName" showStatus="readOnly" orgType="ORG_TYPE_DEPT"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdUnit')}"/>
														</c:otherwise>
													</c:choose>
												</xform:config>
											</td>
										</tr>
										<!-- 承办人 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdSponsor"/>
											</td>
											<td>
												<xform:config  orient="none">
													<xform:address propertyId="fdItems[${vstatus.index}].fdSponsorId" propertyName="fdItems[${vstatus.index}].fdSponsorName" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdSponsor')}" showStatus="readOnly"/>
												</xform:config>
											</td>
										</tr>
										
										<!-- 协办单位 -->
										<tr data-celltr="true">
											<td class="muiTitle">
												<bean:message bundle="km-supervise" key="kmSuperviseTask.fdOtherUnits"/>
											</td>
											<td>
												<xform:config  orient="none">
													<c:choose>
														<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
															<html:hidden property="fdItems[${vstatus.index}].fdOtherUnitIds" value="${fdItem.fdOtherUnitIds}"/>
															<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
														    	 data-dojo-props='"idField":"fdItems[${vstatus.index}].fdOtherUnitIds","nameField":"fdItems[${vstatus.index}].fdOtherUnitNames","curIds":"${fdItem.fdOtherUnitIds}","curNames":"${fdItem.fdOtherUnitNames}","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":false,
														   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
														    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
														    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
															   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
															</div>
														</c:when>
														<c:otherwise>
															<xform:address propertyId="fdItems[${vstatus.index}].fdOUnitIds" propertyName="fdItems[${vstatus.index}].fdOUnitNames" orgType="ORG_TYPE_PERSON"  style="width:90%;" mobile="true" mulSelect="true" subject="${lfn:message('km-supervise:kmSuperviseTask.fdOtherUnits')}" showStatus="readOnly"/>
														</c:otherwise>
													</c:choose>
												</xform:config>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
			</table>
			
			<div 
				data-dojo-type="sys/xform/mobile/controls/DetailTableAddButton" 
				onclick="window.detail_add(event)">
				<bean:message bundle="km-supervise" key="py.TianJiaJieDuan" />
			</div>
		</td>
	</tr>
	<!-- 阶段反馈周期 -->
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-supervise" key="kmSuperviseMain.feedback.time"/>
		</td>
		<td>
			<xform:select property="fdBackType" showPleaseSelect="false" showStatus="edit" mobile="true" value="0">
				<xform:enumsDataSource enumsType="km_supervise_task_back"></xform:enumsDataSource>
			</xform:select>
		</td>
	</tr>
	<!-- 附件上传 -->
	<tr>
		<td class="muiTitle">
			<bean:message bundle="km-supervise" key="py.FuJianShangChuan"/>
		</td>
		<td>
           	<c:import url="/sys/attachment/mobile/import/edit.jsp" charEncoding="UTF-8">
				<c:param name="formName" value="kmSuperviseMainPlanForm"/>
				<c:param name="fdKey" value="attTask" />
				<c:param name="fdMulti" value="true" />
			</c:import>
		</td>
	</tr>
</table>
							
<script type="text/javascript">Com_IncludeFile('doclist.js');</script>
<script type="text/javascript">DocList_Info.push('TABLE_DocList');</script>
<script type="text/javascript">
	
	require(['dojo/ready', 'dijit/registry', 'dojo/topic', 'dojo/request', 
	         'dojo/dom', 'dojo/dom-attr', 'dojo/dom-style', 'dojo/dom-class', 'dojo/query', 'mui/dialog/Tip', "dojo/parser", "mui/pageLoading",'mui/dialog/Dialog',"dojo/_base/lang",], 
			function(ready, registry, topic, request, dom, domAttr, domStyle, domClass, query, Tip, parser, pageLoading,Dialog,lang){
		
		ready(function(){
			DocListFunc_Init();
		});
		
		window.detail_add = function(event) {
			event = event || window.event;
			if (event.stopPropagation)
				event.stopPropagation();
			else
				event.cancelBubble = true;
			detail_addRow("TABLE_DocList");
		};
		
		window.detail_addRow = function(tableId, callbackFun) {
			var newRow = DocList_AddRow(tableId);
			newRow.dojoClick = true;
			parser.parse(newRow).then(function(){
				var tabInfo = DocList_TableInfo[tableId];
				if(tabInfo['_getcols']== null){
					tabInfo.fieldNames=[];
					tabInfo.fieldFormatNames=[];
					DocListFunc_AddReferFields(tabInfo, newRow, "INPUT");
					DocListFunc_AddReferFields(tabInfo, newRow, "TEXTAREA");
					DocListFunc_AddReferFields(tabInfo, newRow, "SELECT");
					tabInfo['_getcols'] = 1;
				}
				detail_fixNo();
				initValue(newRow);//初始化值
				topic.publish("/mui/list/resize",newRow);
				if(callbackFun)callbackFun(newRow);
			});
		}
		
		window.initValue = function(newRow){
			var optTB = document.getElementById("TABLE_DocList");
			var tbInfo = DocList_TableInfo[optTB.id];
			var startTime=document.getElementsByName("fdStartTime")[0].value;
			var finishTime=document.getElementsByName("fdFinishTime")[0].value;
			var stage = "阶段"+ tbInfo.lastIndex;
			
			$(newRow).find("*[widgetid]").each(function(idx,widgetDom){
				var widget = registry.byNode(widgetDom);
				if(idx == 0){
					widget._setValueAttr(stage);
				}else if(idx == 2){
					widget._setValueAttr(startTime);
				}else if(idx == 3){
					widget._setValueAttr(finishTime);
				}
			});
		}
		
		window.detail_fixNo = function() {
			$('#TABLE_DocList').find('.muiDetailTableNo').each(function(i) {
				$(this).children('span').text("阶段" + (i + 1));
			});
		}
		
		window.deleteRow = function(domNode) {
			var td = $(domNode).closest('.detail_wrap_td')[0];
			DocList_DeleteRow_ClearLast(td.parentNode);
			topic.publish('/mui/form/valueChanged');
			topic.publish("/mui/list/resize",td.parentNode);
			detail_fixNo();
		};
		
		window.expandRow = function(domNode){
			var domTable = $(domNode).closest('table')[0];
			var display = domAttr.get(domTable,'data-display'),
				newdisplay = (display == 'none' ? '' : 'none');
			domAttr.set(domTable,'data-display',newdisplay);
			var items = query('tr[data-celltr="true"],tr[statistic-celltr="true"]',domTable);
			for(var i = 0; i < items.length; i++){
				if(newdisplay == 'none'){
					domStyle.set(items[i],'display','none');
				}else{
					domStyle.set(items[i],'display','');
				}
			}
			var opt = query('.muiDetailDisplayOpt',domTable)[0];
			if(newdisplay == 'none'){
				domClass.add(opt,'muiDetailUp');
				domClass.remove(opt,'muiDetailDown');
			}else{
				domClass.add(opt,'muiDetailDown');
				domClass.remove(opt,'muiDetailUp');
			}
		};
		
	});

</script>