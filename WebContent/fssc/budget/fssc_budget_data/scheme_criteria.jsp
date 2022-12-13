<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@ taglib uri="/WEB-INF/KmssConfig/fssc/common/fssc.tld" prefix="fssc"%>
<%@page import="com.landray.kmss.fssc.budget.util.FsscBudgetUtil" %>
 <script>
 	function refreshCriteria(vals,oldValues,queryType,id){
 		if (vals.length > 0 && vals[0] != null) {
			var val = vals[0].value;
			var data = new KMSSData();
			var rtn = data.AddBeanData("fsscBudgetCriteriaService&fdCompanyId=&&queryType="+queryType+"parentId="+val+"&authCurrent=true").GetHashMapArray();
			if(rtn.length > 0){
				LUI(id).source.setUrl("/sys/common/dataxml.jsp?s_bean=fsscBudgetCriteriaService&fdCompanyId=&&queryType="+queryType+"parentId="+val+"&authCurrent=true");
				LUI(id).source.resolveUrl();
				LUI(id).refresh();
			}
		}
 	}
 </script>
 <!-- 筛选 -->
 <list:criteria id="criteria1">
     <!-- 年份 -->
	<list:cri-criterion title="${ lfn:message('fssc-budget:fsscBudgetData.fdYear')}" key="fdYear" expand="true" multi="false">
		<list:box-select>
			<list:item-select>
				<ui:source type="AjaxXml">
					{"url":"/sys/common/dataxml.jsp?s_bean=fsscBudgetCriteriaService&queryType=fdYear&authCurrent=true"}
				</ui:source>
			</list:item-select>
		</list:box-select>
	</list:cri-criterion>
     <!-- 月度 -->
	<list:cri-criterion title="${ lfn:message('fssc-budget:fsscBudgetData.fdPeriod')}" key="fdMonth" expand="true" multi="false">
		<list:box-select>
			<list:item-select >
				<ui:source type="Static">
					[{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdYearMoney')}', value:'5'},
<%-- 					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdFirstQuarterMoney')}', value:'300'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdSecondQuarterMoney')}', value:'301'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdThirdQuarterMoney')}', value:'302'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdFourthQuarterMoney')}', value:'303'},
 --%>					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdJanMoney')}', value:'100'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdFebMoney')}', value:'101'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdMarMoney')}', value:'102'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdAprMoney')}', value:'103'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdMayMoney')}', value:'104'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdJunMoney')}', value:'105'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdJulMoney')}', value:'106'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdAugMoney')}', value:'107'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdSeptMoney')}', value:'108'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdOctMoney')}', value:'109'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdNovMoney')}', value:'110'},
					{text:'${ lfn:message('fssc-budget:fsscBudgetDetail.fdDecMoney')}', value:'111'}]
				 
				</ui:source>
			</list:item-select>
		</list:box-select>
	</list:cri-criterion>
	<!-- 公司组 -->  
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="1">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdCompanyGroup')}" key="fdCompanyGroupName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdCompanyGroup')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
   </fssc:budgetScheme>
   <!-- 公司 -->  
   <fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="2">
   		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdCompany')}" key="fdCompanyName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdCompany')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 成本中心组 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="3">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdCostCenterGroup')}" key="fdCostCenterGroupName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdCostCenterGroup')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 成本中心 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="4">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdCostCenter')}" key="fdCostCenterName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdCostCenter')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 项目 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="5">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdProject')}" key="fdProjectName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdProject')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- WBS -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="6">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdWbs')}" key="fdWbsName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdWbs')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 内部订单 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="7">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdInnerOrder')}" key="fdInnerOrderName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdInnerOrder')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 预算科目 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="8">
		<list:cri-criterion title="${lfn:message('fssc-budget:fsscBudgetData.fdBudgetItem')}" key="fdBudgetItemName" expand="true">
            <list:box-select>
                <list:item-select type="lui/criteria/criterion_input!TextInput">
                    <ui:source type="Static">
                        [{placeholder:'${lfn:message('fssc-budget:fsscBudgetData.fdBudgetItem')}'}]
                    </ui:source>
                </list:item-select>
            </list:box-select>
        </list:cri-criterion>
	</fssc:budgetScheme>
	<!-- 员工 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="10">
    	<list:cri-auto modelName="com.landray.kmss.fssc.budget.model.FsscBudgetData" property="fdPerson" />
    </fssc:budgetScheme>
    <!-- 部门 -->
	<fssc:budgetScheme fdSchemeId="${param.fdSchemeId}" value="11">
    	<list:cri-auto modelName="com.landray.kmss.fssc.budget.model.FsscBudgetData" property="fdDept" />
    </fssc:budgetScheme>
     <list:cri-criterion expand="false" title="${lfn:message('fssc-budget:fsscBudgetData.fdBudgetStatus')}" key="fdBudgetStatus" multi="false">
      <list:box-select>
           	<list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
				<ui:source type="Static">
				[{text:'${ lfn:message('fssc-budget:enums.budget.status.enable')}', value:'1'},
				{text:'${ lfn:message('fssc-budget:enums.budget.status.pause')}',value:'2'},
				{text:'${ lfn:message('fssc-budget:enums.budget.status.close')}',value:'3'}]
				</ui:source>
			</list:item-select>
      </list:box-select>
 	 </list:cri-criterion>
 	 <list:cri-auto modelName="com.landray.kmss.fssc.budget.model.FsscBudgetData" property="docCreator" />
 	 <list:cri-auto modelName="com.landray.kmss.fssc.budget.model.FsscBudgetData" property="docCreateTime" />
 </list:criteria>