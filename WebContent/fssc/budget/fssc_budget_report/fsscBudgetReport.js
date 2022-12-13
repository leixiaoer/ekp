seajs.use(['lui/jquery','lui/dialog','lui/util/env','lang!fssc-budget','lang!'], function($, dialog ,env,lang,commonLang) {
	if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
		setTimeout(function(){initData();},2000);
	}else{//非IE
		LUI.ready(function(){
			initData();
		});
	};
	window.initData=function(){
		var data = new KMSSData();
		data.UseCache = false;
		var rtn = data.AddBeanData("fsscBudgetReportService&authCurrent=true&fdType=getYear").GetHashMapArray();
		var obj=document.getElementsByName('fdYear')[0];
		obj.options.length=0; 
		obj.add(new Option("==请选择==",""));
		if(rtn.length > 0){
			for(var i=0;i<rtn.length;i++){
				obj.add(new Option(rtn[i].text,rtn[i].value));
			}
			// 默认为当前年份
			//var yearValue=new Date().getFullYear();
			//$('select[name="fdYear"] option[value="'+yearValue+'"]').attr("selected", true);	 
		}	
	};
	window.checkCompany=function(){
		var fdCompanyId=$("[name='fdCompanyId']").val();
		if(fdCompanyId){
			return true;
		}else{
			dialog.alert(lang["message.pleaseSelectCompany"]);
			return false;
		}
	};
	//选择成本中心组
	window.selectCostCenterGroup=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_cost_center_group_fdCostCenterGroup','fdCostCenterGroupId','fdCostCenterGroupName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	//选择成本中心
	window.selectCostCenter=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_cost_center_selectCostCenter','fdCostCenterId','fdCostCenterName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	//选择项目
	window.selectProject=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_project_project','fdProjectId','fdProjectName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	//选择WBS
	window.selectWbs=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_wbs_fdWbs','fdWbsId','fdWbsName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	//选择内部订单
	window.selectInnerOrder=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_inner_order_fdInnerOrder','fdInnerOrderId','fdInnerOrderName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	//选择预算项目
	window.selectBudgetItem=function(){
		if(checkCompany()){
			dialogSelect(false,'fssc_base_budget_item_com_fdBudgetItem','fdBudgetItemId','fdBudgetItemName',null,{'fdCompanyId':$("[name='fdCompanyId']").val()});
		}
	};
	
	/*******************************************
	 * 期间类型发生变化
	 * @param : val 期间类型的值（1:月；3:季；5:年）
	 *******************************************/
	window.FS_ChangePeriodType=function(val){
		$("#fdPeriod_td").find(".validation-advice").remove();
		if(val=="5"){
			$('#periodSpan').html("");
		}else{
			$('#periodSpan').html("");
			$('#periodSpan').html(FS_GetPeriodHTML(val));
		}
	}
	/*******************************************
	 * 返回费用预算期间HTML
	 * @param : periodType 期间类型（1:月；3:季；5:年）
	 *******************************************/
	window.FS_GetPeriodHTML=function(periodType){
		var PeriodHTML ='';
		if(periodType == "1"){
			var months=["fdJanMoney","fdFebMoney","fdMarMoney","fdAprMoney","fdMayMoney","fdJunMoney","fdJulMoney","fdAugMoney","fdSeptMoney","fdOctMoney","fdNovMoney","fdDecMoney"];
			var val=["00","01","02","03","04","05","06","07","08","09","10","11"];
			PeriodHTML += '<select name="fdPeriod">';
			PeriodHTML += '<option value="">'+commonLang["page.firstOption"]+'</option>';
			for(var i=0;i<12;i++){
				PeriodHTML += '<option value="'+val[i]+'">'+lang["fsscBudgetDetail."+months[i]]+'</option>';
			}
			PeriodHTML += '</select>';
		}else if(periodType == "3"){
			var quarter=["first","second","third","fourth"];
			var val=["00","01","02","03"];
			PeriodHTML += '<select name="fdPeriod">';
			PeriodHTML += '<option value="">'+commonLang["page.firstOption"]+'</option>';
			for(var i=0;i<4;i++){
				PeriodHTML += '<option value="'+val[i]+'">'+lang["report.quarter."+quarter[i]]+'</option>';
			}
			PeriodHTML += '</select>';
		}
		return PeriodHTML;
	}
	//根据方案展现不同的筛选条件
	window.displaySearch=function(data){
		if(data&&data.length>0){
			clearValue();//清除其他筛选条件的值
			var all=[1,2,3,4,5,6,7,8,9,10,11];
			$("[name='fdDimension']").val(data[0]["fdDimension"]);
			var dis=data[0]["fdDimension"].split(";");
			//显示对应筛选条件
			for(var i=0;i<dis.length;i++){
				$("#fdDimension"+dis[i]).attr("style","");
				delete all[dis[i]-1];  //删除
			}
			//其他隐藏
			for(var i=0;i<all.length;i++){
				if(all[i]){
					$("#fdDimension"+all[i]).attr("style","display:none;");
				}
			}
			for(var i=0;i<dis.length;i++){
				//维度有公司的需选择公司
				if(dis[i]=='3'||dis[i]=='4'||dis[i]=='5'||dis[i]=='6'||dis[i]=='7'||dis[i]=='8'){
					$("#fdDimension2").attr("style","");
					return;
				}
			}
		}
	}
	//清除字段值，extendField不需要清空的值，多个;连接
	window.clearValue=function(extendField){
		var property=["fdCompanyGroup","fdCompany","fdCostCenterGroup","fdCostCenter","fdProject","fdWbs","fdInnerOrder","fdBudgetItem","fdDept","fdPerson"];
		for(var i=0;i<property.length;i++){
			if((";"+extendField+";").indexOf(";"+property[i]+";")>-1){//说明不需要清空值
				continue;
			}
			$('[name="'+property[i]+'Id"]').val('');
			$('[name="'+property[i]+'Name"]').val('');
			if("fdDept"==property[i]||"fdPerson"==property[i]){
				emptyNewAddress(property[i]+"Name",null,null,false);
			}
		}
		$("select[name='fdBudgetStatus']").val("1");
	}
	window.changeCompany=function(data){
		if(data){
			clearValue('fdCompany');
		}
	}
	window.FSSC_Search=function(){
    	var src = env.fn.formatUrl('/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=executeLedger');
    	//预算方案
    	var fdSchemeId=$("[name='fdSchemeId']").val();
    	if(!fdSchemeId){
    		dialog.alert(lang["message.select.budget.scheme.tips"]);
    		return false;
    	}else{
    		src = Com_SetUrlParameter(src,"fdSchemeId",fdSchemeId);
    	}
    	//方案维度
    	var fdDimension = $('[name="fdDimension"]').val();
    	if(fdDimension){
    		src = Com_SetUrlParameter(src,"fdDimension",fdDimension);
    	}
    	//公司组
    	var fdCompanyGroupId = $('[name="fdCompanyGroupId"]').val();
    	if(fdCompanyGroupId){
    		src = Com_SetUrlParameter(src,"fdCompanyGroupId",fdCompanyGroupId);
    	}
    	//公司
    	var fdCompanyId = $('[name="fdCompanyId"]').val();
    	if(fdCompanyId){
    		src = Com_SetUrlParameter(src,"fdCompanyId",fdCompanyId);
    	}
    	//成本中心组
    	var fdCostCenterGroupId = $('[name="fdCostCenterGroupId"]').val();
    	if(fdCostCenterGroupId){
    		src = Com_SetUrlParameter(src,"fdCostCenterGroupId",fdCostCenterGroupId);
    	}
    	//成本中心
    	var fdCostCenterId = $('[name="fdCostCenterId"]').val();
    	if(fdCostCenterId){
    		src = Com_SetUrlParameter(src,"fdCostCenterId",fdCostCenterId);
    	}
    	//项目
    	var fdProjectId = $('[name="fdProjectId"]').val();
    	if(fdProjectId){
    		src = Com_SetUrlParameter(src,"fdProjectId",fdProjectId);
    	}
    	//WBS
    	var fdWbsId = $('[name="fdWbsId"]').val();
    	if(fdWbsId){
    		src = Com_SetUrlParameter(src,"fdWbsId",fdWbsId);
    	}
    	//内部订单
    	var fdInnerOrderId = $('[name="fdInnerOrderId"]').val();
    	if(fdInnerOrderId){
    		src = Com_SetUrlParameter(src,"fdInnerOrderId",fdInnerOrderId);
    	}
    	//预算科目
    	var fdBudgetItemId = $('[name="fdBudgetItemId"]').val();
    	if(fdBudgetItemId){
    		src = Com_SetUrlParameter(src,"fdBudgetItemId",fdBudgetItemId);
    	}
    	//部门
    	var fdDeptId = $('[name="fdDeptId"]').val();
    	if(fdDeptId){
    		src = Com_SetUrlParameter(src,"fdDeptId",fdDeptId);
    	}
    	//人员
    	var fdPersonId = $('[name="fdPersonId"]').val();
    	if(fdPersonId){
    		src = Com_SetUrlParameter(src,"fdPersonId",fdPersonId);
    	}
    	//年份
    	var fdYear = $("select[name='fdYear']").val();
    	if(fdYear){
    		src = Com_SetUrlParameter(src,"fdYear",fdYear);
    	}
    	//期间类型
    	var fdPeriodType = $("input[name='fdPeriodType']:checked").val();
    	if(fdPeriodType){
    		src = Com_SetUrlParameter(src,"fdPeriodType",fdPeriodType);
    	}
    	//期间
    	var fdPeriod = $("select[name='fdPeriod']").val();
    	if(fdPeriod){
    		src = Com_SetUrlParameter(src,"fdPeriod",fdPeriod);
    	}
    	//预算状态
    	var fdBudgetStatus = $("select[name='fdBudgetStatus']").val();
    	if(fdBudgetStatus){
    		src = Com_SetUrlParameter(src,"fdBudgetStatus",fdBudgetStatus);
    	}
    	$('#searchIframe').attr("src",src);
    }
    
    //重置
    window.FSSC_Reset=function(){	
    	var src = env.fn.formatUrl('/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=executeLedger');
    	$('#searchIframe').attr("src",src);
    	$("[name='fdSchemeId']").val('');
    	$("[name='fdSchemeName']").val('');
    	clearValue();
    	document.getElementsByName("fdYear")[0].value= "5"+new Date().getFullYear()+"0000";
    	document.getElementsByName("fdPeriod")[0].value= "";
    }
    //导出
    window.exportResult=function(){
    	var src = env.fn.formatUrl('/fssc/budget/fssc_budget_data/fsscBudgetData.do?method=exportExecuteLedger');
    	//预算方案
    	var fdSchemeId=$("[name='fdSchemeId']").val();
    	if(!fdSchemeId){
    		dialog.alert(lang["message.select.budget.scheme.tips"]);
    		return false;
    	}else{
    		src = Com_SetUrlParameter(src,"fdSchemeId",fdSchemeId);
    	}
    	//方案维度
    	var fdDimension = $('[name="fdDimension"]').val();
    	if(fdDimension){
    		src = Com_SetUrlParameter(src,"fdDimension",fdDimension);
    	}
    	//公司组
    	var fdCompanyGroupId = $('[name="fdCompanyGroupId"]').val();
    	if(fdCompanyGroupId){
    		src = Com_SetUrlParameter(src,"fdCompanyGroupId",fdCompanyGroupId);
    	}
    	//公司
    	var fdCompanyId = $('[name="fdCompanyId"]').val();
    	if(fdCompanyId){
    		src = Com_SetUrlParameter(src,"fdCompanyId",fdCompanyId);
    	}
    	//成本中心组
    	var fdCostCenterGroupId = $('[name="fdCostCenterGroupId"]').val();
    	if(fdCostCenterGroupId){
    		src = Com_SetUrlParameter(src,"fdCostCenterGroupId",fdCostCenterGroupId);
    	}
    	//成本中心
    	var fdCostCenterId = $('[name="fdCostCenterId"]').val();
    	if(fdCostCenterId){
    		src = Com_SetUrlParameter(src,"fdCostCenterId",fdCostCenterId);
    	}
    	//项目
    	var fdProjectId = $('[name="fdProjectId"]').val();
    	if(fdProjectId){
    		src = Com_SetUrlParameter(src,"fdProjectId",fdProjectId);
    	}
    	//WBS
    	var fdWbsId = $('[name="fdWbsId"]').val();
    	if(fdWbsId){
    		src = Com_SetUrlParameter(src,"fdWbsId",fdWbsId);
    	}
    	//内部订单
    	var fdInnerOrderId = $('[name="fdInnerOrderId"]').val();
    	if(fdInnerOrderId){
    		src = Com_SetUrlParameter(src,"fdInnerOrderId",fdInnerOrderId);
    	}
    	//预算科目
    	var fdBudgetItemId = $('[name="fdBudgetItemId"]').val();
    	if(fdBudgetItemId){
    		src = Com_SetUrlParameter(src,"fdBudgetItemId",fdBudgetItemId);
    	}
    	//部门
    	var fdDeptId = $('[name="fdDeptId"]').val();
    	if(fdDeptId){
    		src = Com_SetUrlParameter(src,"fdDeptId",fdDeptId);
    	}
    	//人员
    	var fdPersonId = $('[name="fdPersonId"]').val();
    	if(fdPersonId){
    		src = Com_SetUrlParameter(src,"fdPersonId",fdPersonId);
    	}
    	//年份
    	var fdYear = $("select[name='fdYear']").val();
    	if(fdYear){
    		src = Com_SetUrlParameter(src,"fdYear",fdYear);
    	}
    	//期间类型
    	var fdPeriodType = $("input[name='fdPeriodType']:checked").val();
    	if(fdPeriodType){
    		src = Com_SetUrlParameter(src,"fdPeriodType",fdPeriodType);
    	}
    	//期间
    	var fdPeriod = $("select[name='fdPeriod']").val();
    	if(fdPeriod){
    		src = Com_SetUrlParameter(src,"fdPeriod",fdPeriod);
    	}
    	//预算状态
    	var fdBudgetStatus = $("select[name='fdBudgetStatus']").val();
    	if(fdBudgetStatus){
    		src = Com_SetUrlParameter(src,"fdBudgetStatus",fdBudgetStatus);
    	}
    		$('#searchIframe').attr("src",src);
    }
});