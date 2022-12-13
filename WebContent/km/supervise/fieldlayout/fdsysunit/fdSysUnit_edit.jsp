<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/km/supervise/fieldlayout/common/param_parser.jsp"%>
<%
	parse.addStyle("width", "control_width", "95%");

%>
<c:choose>
	<c:when test="${kmSuperviseMainForm.fdSysUnitEnable eq 'true' }">
		<%
		    String fdSysUnitId = parse.getParamValue("fdSysUnitId");
		    String fdSysUnitName = parse.getParamValue("fdSysUnitName");
		    
		    String defaultSysUnitId = parse.acquireValue("fdSysUnitId",fdSysUnitId);
		    String defaultSysUnitName = parse.acquireValue("fdSysUnitName",fdSysUnitName);
		%>
		<script>
			function __split(ids, names) {
				var values=[], _ids = ids.split(/[,;]/), _names = names.split(/[,;]/);
				for(var i=0; i<_ids.length; i++) {
					values.push({'id': _ids[i], 'name': _names[i]});
				}
				return values;
			}
			function _initSelectUnit(unitId) {
				var data = new KMSSData();
			    data.SendToBean("kmSuperviseUnitService&fdSysUnitId=" + unitId, function(rtnData) {
			    	var hashArr = rtnData.GetHashMapArray();
					// 单位领导/责任人
				    var fdSponsorId = hashArr[0].fdSponsorId;
				    var fdSponsorName = hashArr[0].fdSponsorName;
				 	// 分管领导
				    var fdLeadId = hashArr[0].fdLeadId;
				    var fdLeadName = hashArr[0].fdLeadName;
				 	// 督办联络员
				    var fdSuperViseLiaisonId = hashArr[0].fdSuperViseLiaisonId;
				    var fdSuperViseLiaisonName = hashArr[0].fdSuperViseLiaisonName;
				    // 单位领导/责任人
				    if(fdSponsorId && fdSponsorName) {
						var address = Address_GetAddressObj("fdSponsorName");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, __split(fdSponsorId, fdSponsorName));
						}
				    }
				    // 分管领导
				    if(fdLeadId && fdLeadName) {
				    	var address = Address_GetAddressObj("fdLeadNames");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, __split(fdLeadId, fdLeadName));
						}
				    }
				    // 督办联络员
				    if(fdSuperViseLiaisonId && fdSuperViseLiaisonName) {
				    	var address = Address_GetAddressObj("fdLiaisonNames");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, __split(fdSuperViseLiaisonId, fdSuperViseLiaisonName));
						}
				    }
				    
				    
				    if(fdSponsorId&&fdSponsorName){
					   	var fdSponsorObj = registry.byId('_fdSponsorId');
					   	if(fdSponsorObj){
					   		document.getElementsByName("fdSponsorId")[0].value = fdSponsorId;
						  	document.getElementsByName("fdSponsorName")[0].value = fdSponsorName;
						  	fdSponsorObj.set('curIds',fdSponsorId);
						  	fdSponsorObj.set('curNames',fdSponsorName);
					   	}
				    }
				    
				    
			    });
			}
		</script>
		<c:choose>
		    <c:when test="${param.mobile eq 'true'}">
		    	<c:set var="fdSysUnitId" value="<%=defaultSysUnitId%>"></c:set>
		    	<c:set var="fdSysUnitName" value="<%=defaultSysUnitName%>"></c:set>
		    	<c:if test="${kmSuperviseMainForm.method_GET=='edit'}">
		    		<c:set var="fdSysUnitId" value="${kmSuperviseMainForm.fdSysUnitId}"></c:set>
		    		<c:set var="fdSysUnitName" value="${kmSuperviseMainForm.fdSysUnitName}"></c:set>
		    	</c:if>
		    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
			    	 data-dojo-props='"afterSelect":function(evt){afterSelectUnit(evt);},"idField":"fdSysUnitId","nameField":"fdSysUnitName","curIds":"${fdSysUnitId}","curNames":"${fdSysUnitName}","subject":"主办单位","title":"主办单位","showStatus":"edit","isMul":false,"validate":"required","required":<%=required%>,
			   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
			    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
			    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
				   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
				</div>
				<script>
					require(['dijit/registry'], function(registry) {
						window.afterSelectUnit = function(evt) {
							var unitId = evt.curIds;
							if (unitId == null || unitId=="") {
								return;
							}
							var data = new KMSSData();
						    data.SendToBean("kmSuperviseUnitService&fdSysUnitId=" + unitId, function(rtnData) {
						    	var hashArr = rtnData.GetHashMapArray();
								// 单位领导/责任人
							    var fdSponsorId = hashArr[0].fdSponsorId;
							    var fdSponsorName = hashArr[0].fdSponsorName;
							 	// 分管领导
							    var fdLeadId = hashArr[0].fdLeadId;
							    var fdLeadName = hashArr[0].fdLeadName;
							 	// 督办联络员
							    var fdSuperViseLiaisonId = hashArr[0].fdSuperViseLiaisonId;
							    var fdSuperViseLiaisonName = hashArr[0].fdSuperViseLiaisonName;
							    // 单位领导/责任人
							    if(fdSponsorId && fdSponsorName) {
							    	var address = registry.byId('_fdSponsorId');
									if(address) {
										document.getElementsByName("fdSponsorId")[0].value = fdSponsorId;
									  	document.getElementsByName("fdSponsorName")[0].value = fdSponsorName;
									  	address.set('curIds', fdSponsorId);
									  	address.set('curNames', fdSponsorName);
									}
							    }
							    // 分管领导
							    if(fdLeadId && fdLeadName) {
									var address = registry.byId('_fdLeadIds');
									if(address) {
										document.getElementsByName("fdLeadIds")[0].value = fdLeadId;
									  	document.getElementsByName("fdLeadNames")[0].value = fdLeadName;
									  	address.set('curIds', fdLeadId);
									  	address.set('curNames', fdLeadName);
									}
							    }
							    // 督办联络员
							    if(fdSuperViseLiaisonId && fdSuperViseLiaisonName) {
									var address = registry.byId('_fdLiaisonIds');
									if(address) {
										document.getElementsByName("fdLiaisonIds")[0].value = fdSuperViseLiaisonId;
									  	document.getElementsByName("fdLiaisonNames")[0].value = fdSuperViseLiaisonName;
									  	address.set('curIds', fdSuperViseLiaisonId);
									  	address.set('curNames', fdSuperViseLiaisonName);
									}
							    }
						    });
						}
					});
				</script>
		    </c:when>
		    <c:otherwise>
		    	<div id="_fdSysUnit" valField="fdSysUnitId" xform_type="dialog">
				<xform:dialog propertyId="fdSysUnitId"
				              propertyName="fdSysUnitName"
					          style="<%=parse.getStyle()%>" 
					          idValue="<%=defaultSysUnitId %>"
					          nameValue="<%=defaultSysUnitName %>"
					          className="inputsgl"
					          useNewStyle="false" 
					          required="<%=required%>"
					          subject="${ lfn:message('km-supervise:kmSuperviseMain.fdSysUnit') }">  
						      Dialog_UnitTreeList(false, 'fdSysUnitId', 'fdSysUnitName', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}',
						      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',function(){changeSysUnit(this);},'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
				</xform:dialog>
				</div>
				<script>
					$(document).ready(function(){
						var id = document.getElementsByName("fdSysUnitId")[0].value;
					   	var name = document.getElementsByName("fdSysUnitName")[0].value;
						initNewDialog("fdSysUnitId","fdSysUnitName",";","kmImissiveUnitListWithAuthService&newSearch=true",false,id,name);
					});
					
					function changeSysUnit(dialog){
						var fdName = dialog.fieldList[0].name;
						var fdUnit=document.getElementsByName(fdName)[0];
						var unitId = fdUnit.value;
						if (unitId == null || unitId == "") {
							return;
						}
						
						var data = new KMSSData();
					    data.SendToBean("kmSuperviseUnitService&fdSysUnitId=" + unitId, function(rtnData) {
					    	var hashArr = rtnData.GetHashMapArray();
							// 单位领导/责任人
						    var fdSponsorId = hashArr[0].fdSponsorId;
						    var fdSponsorName = hashArr[0].fdSponsorName;
						 	// 分管领导
						    var fdLeadId = hashArr[0].fdLeadId;
						    var fdLeadName = hashArr[0].fdLeadName;
						 	// 督办联络员
						    var fdSuperViseLiaisonId = hashArr[0].fdSuperViseLiaisonId;
						    var fdSuperViseLiaisonName = hashArr[0].fdSuperViseLiaisonName;
						    // 单位领导/责任人
						    if(fdSponsorId && fdSponsorName) {
								var address = Address_GetAddressObj("fdSponsorName");
								if(address) {
									address.reset(";", ORG_TYPE_PERSON, true, __split(fdSponsorId, fdSponsorName));
								}
						    }
						    // 分管领导
						    if(fdLeadId && fdLeadName) {
						    	var address = Address_GetAddressObj("fdLeadNames");
								if(address) {
									address.reset(";", ORG_TYPE_PERSON, true, __split(fdLeadId, fdLeadName));
								}
						    }
						    // 督办联络员
						    if(fdSuperViseLiaisonId && fdSuperViseLiaisonName) {
						    	var address = Address_GetAddressObj("fdLiaisonNames");
								if(address) {
									address.reset(";", ORG_TYPE_PERSON, true, __split(fdSuperViseLiaisonId, fdSuperViseLiaisonName));
								}
						    }
					    });
					}
				</script>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<xform:address 
		        propertyId="fdUnitId"
		        propertyName="fdUnitName"
		        orgType="ORG_TYPE_DEPT"
		        required="<%=required%>" 
		        mobile="${param.mobile eq 'true'? 'true':'false'}"
		        style="<%=parse.getStyle()%>"
		        className="inputsgl"
		        htmlElementProperties="id=_fdUnitId">
		</xform:address>
	</c:otherwise>
</c:choose>