<%@page import="com.landray.kmss.sys.xform.base.service.controls.fieldlayout.SysFieldsParamsParse"%>
<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.km.supervise.util.KmSuperviseUtil"%>
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
		    String fdOtherUnitIds = parse.getParamValue("fdOtherUnitIds");
		    String fdOtherUnitNames = parse.getParamValue("fdOtherUnitNames");
		    
		    String defaultFdOtherUnitIds = parse.acquireValue("fdOtherUnitIds",fdOtherUnitIds);
		    String defaultFdOtherUnitNames = parse.acquireValue("fdOtherUnitNames",fdOtherUnitNames);
		%>
		<script>
			var otherSponsors = [], otherLeads = [], otherLiaisons = [];
			function __splitOther(ids, names) {
				var values=[], _ids = ids.split(/[,;]/), _names = names.split(/[,;]/);
				for(var i=0; i<_ids.length; i++) {
					values.push({'id': _ids[i], 'name': _names[i]});
				}
				return values;
			}
			// 数组合并（去重）
			function concat(array1, array2) {
				for(var i=0; i<array2.length; i++) {
					var has = false;
					for(var j=0; j<array1.length; j++) {
						if(array1[j].id == array2[i].id) {
							has = true;
							break;
						}
					}
					if(!has) {
						array1.push(array2[i]);
					}
				}
			}
		</script>
		<c:choose>
		    <c:when test="${param.mobile eq 'true'}">
		    	<c:set var="fdOtherUnitIds" value="<%=defaultFdOtherUnitIds%>"></c:set>
		    	<c:set var="fdOtherUnitNames" value="<%=defaultFdOtherUnitNames%>"></c:set>
		    	<c:if test="${kmSuperviseMainForm.method_GET=='edit'}">
		    		<c:set var="fdOtherUnitIds" value="${kmSuperviseMainForm.fdOtherUnitIds}"></c:set>
		    		<c:set var="fdOtherUnitNames" value="${kmSuperviseMainForm.fdOtherUnitNames}"></c:set>
		    	</c:if>
		    	<div data-dojo-type='sys/unit/mobile/selectdialog/UnitSelectDialog'
			    	 data-dojo-props='"afterSelect":function(evt){afterSelectOtherUnit(evt);},"idField":"fdOtherUnitIds","nameField":"fdOtherUnitNames","curIds":"${fdOtherUnitIds}","curNames":"${fdOtherUnitNames}","subject":"协办单位","title":"协办单位","showStatus":"edit","isMul":true,"validate":"required","required":<%=required%>,
			   		 "listDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=!{parentId}&amp;mobile=true",
			    	 "searchDataUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitListService&parentId=searchUnit&amp;fdKeyWord=!{keyword}&amp;mobile=true",
			    	 "detailUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitDetailService&curIds=!{curIds}",
				   	"headerUrl":"/sys/common/datajson.jsp?s_bean=kmImissiveUnitHeaderService&curId=!{curId}"'>
				</div>
				<script>
					require(['dijit/registry'], function(registry) {
						window.afterSelectOtherUnit = function(evt) {
							var unitId = evt.curIds;
							//_initSelectOtherUnit(_fdSysUnitId);
							otherSponsors = [], otherLeads = [], otherLiaisons = [];
							// 协办单位可以多选
							var unitIds = unitId.split(/[,;]/), count = 0;
							for(var i=0; i<unitIds.length; i++) {
								if(unitIds[i].length < 1) {
									continue;
								}
								var data = new KMSSData();
							    data.SendToBean("kmSuperviseUnitService&fdSysUnitId=" + unitIds[i], function(rtnData) {
							    	count++;
							    	var hashArr = rtnData.GetHashMapArray();
							    	if(hashArr.length > 0) {
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
									    	concat(otherSponsors, __splitOther(fdSponsorId, fdSponsorName));
									    }
									    // 分管领导
									    if(fdLeadId && fdLeadName) {
									    	concat(otherLeads, __splitOther(fdLeadId, fdLeadName));
									    }
									    // 督办联络员
									    if(fdSuperViseLiaisonId && fdSuperViseLiaisonName) {
									    	concat(otherLiaisons, __splitOther(fdSuperViseLiaisonId, fdSuperViseLiaisonName));
									    }
							    	}
							    	if(count == unitIds.length) {
								    	_setSelectOtherUnit();
								    }
							    });
							}
						}
						
						window._splitValue = function(datas) {
							var ids = [], names = [];
							for(var i=0; i<datas.length; i++) {
								var data = datas[i];
								ids.push(data.id);
								names.push(data.name);
							}
							return {"ids": ids.join(";"), "names": names.join(";")};
						}
						
						window._setSelectOtherUnit = function() {
							var address = registry.byId('_fdOtherLeadIds');
							if(address) {
								var obj = _splitValue(otherLeads);
								document.getElementsByName("fdOtherLeadIds")[0].value = obj.ids;
							  	document.getElementsByName("fdOtherLeadNames")[0].value = obj.names;
							  	address.set('curIds', obj.ids);
							  	address.set('curNames', obj.names);
							}
							address = registry.byId('_fdOtherLiaisonIds');
							if(address) {
								var obj = _splitValue(otherLiaisons);
								document.getElementsByName("fdOtherLiaisonIds")[0].value = obj.ids;
							  	document.getElementsByName("fdOtherLiaisonNames")[0].value = obj.names;
							  	address.set('curIds', obj.ids);
							  	address.set('curNames', obj.names);
							}
							address = registry.byId('_fdOtherSponsorIds');
							if(address) {
								var obj = _splitValue(otherSponsors);
								document.getElementsByName("fdOtherSponsorIds")[0].value = obj.ids;
							  	document.getElementsByName("fdOtherSponsorNames")[0].value = obj.names;
							  	address.set('curIds', obj.ids);
							  	address.set('curNames', obj.names);
							}
						}
					});
				</script>
		    </c:when>
		    <c:otherwise>
		    	<div id="_fdOtherUnits" valField="fdOtherUnitIds" xform_type="dialog">
				<xform:dialog propertyId="fdOtherUnitIds"
				              propertyName="fdOtherUnitNames"
					          style="<%=parse.getStyle()%>" 
					          idValue="<%=defaultFdOtherUnitIds %>"
					          nameValue="<%=defaultFdOtherUnitNames %>"
					          className="inputsgl"
					          useNewStyle="true"
					          required="<%=required%>"
					          subject="${ lfn:message('km-supervise:kmSuperviseMain.fdOtherUnits') }">  
					          Dialog_UnitTreeList(true, 'fdOtherUnitIds', 'fdOtherUnitNames', ';', 'kmImissiveUnitCategoryTreeService&parentId=!{value}', 
						      '<bean:message key="kmImissiveUnit.fdCategoryId" bundle="sys-unit" />', 'kmImissiveUnitListWithAuthService&parentId=!{value}&type=allUnit',function(){changeOtherUnit(this);},'kmImissiveUnitListWithAuthService&fdKeyWord=!{keyword}&type=allUnit');
				</xform:dialog>
				</div>
				<script>
					$(document).ready(function(){
						var ids = document.getElementsByName("fdOtherUnitIds")[0].value;
					   	var names = document.getElementsByName("fdOtherUnitNames")[0].value;
						initNewDialog("fdOtherUnitIds","fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,"","",null);
					   	if(ids != ""){
					   		resetNewDialog("fdOtherUnitIds","fdOtherUnitNames",";","kmImissiveUnitListWithAuthService&newSearch=true&type=allUnit",true,ids,names,null);
					   	}
					});
					
					function changeOtherUnit(dialog) {
						var fdName = dialog.fieldList[0].name;
						var fdUnit = document.getElementsByName(fdName)[0];
						var unitId = fdUnit.value;
						
						otherSponsors = [], otherLeads = [], otherLiaisons = [];
						// 协办单位可以多选
						var unitIds = unitId.split(/[,;]/), count = 0;
						for(var i=0; i<unitIds.length; i++) {
							if(unitIds[i].length < 1) {
								continue;
							}
							var data = new KMSSData();
						    data.SendToBean("kmSuperviseUnitService&fdSysUnitId=" + unitIds[i], function(rtnData) {
						    	count++;
						    	var hashArr = rtnData.GetHashMapArray();
						    	if(hashArr.length > 0) {
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
								    	concat(otherSponsors, __splitOther(fdSponsorId, fdSponsorName));
								    }
								    // 分管领导
								    if(fdLeadId && fdLeadName) {
								    	concat(otherLeads, __splitOther(fdLeadId, fdLeadName));
								    }
								    // 督办联络员
								    if(fdSuperViseLiaisonId && fdSuperViseLiaisonName) {
								    	concat(otherLiaisons, __splitOther(fdSuperViseLiaisonId, fdSuperViseLiaisonName));
								    }
						    	}
						    	if(count == unitIds.length) {
							    	_setSelectOtherUnit();
							    }
						    });
						}
					}
					
					function _setSelectOtherUnit() {
						var address = Address_GetAddressObj("fdOtherSponsorNames");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, otherSponsors);
						}
						address = Address_GetAddressObj("fdOtherLeadNames");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, otherLeads);
						}
						address = Address_GetAddressObj("fdOtherLiaisonNames");
						if(address) {
							address.reset(";", ORG_TYPE_PERSON, true, otherLiaisons);
						}
					}
				</script>
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<xform:address 
		        propertyId="fdOUnitIds"
		        propertyName="fdOUnitNames"
		        orgType="ORG_TYPE_PERSON"
		        required="<%=required%>" 
		        mulSelect="true"
		        mobile="${param.mobile eq 'true'? 'true':'false'}"
		        style="<%=parse.getStyle()%>"
		        className="inputsgl"
		        htmlElementProperties="id=_fdOUnitIds">
		</xform:address>
	</c:otherwise>
</c:choose>


