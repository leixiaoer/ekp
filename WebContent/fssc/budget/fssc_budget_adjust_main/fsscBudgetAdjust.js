seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/util/env','lang!fssc-budget','lang!'], function($, dialog , topic,env,lang,comlang) {
	window.afterSelectCompany=function(data){
		$("[name='fdCurrencyId']").val(data[0]['fdBudgetCurrency.id']);
		$("[name='fdCurrencyName']").val(data[0]['fdBudgetCurrency.name']);
		var fdCompanyId=data[0].fdId;  //当前选择公司ID
		var fdOldCompanyId=$("[name='fdOldCompanyId']").val(); //选择前公司Id
		if(fdCompanyId!=fdOldCompanyId){
			//替换对应公司Id
			$("[name='fdOldCompanyId']").val(fdCompanyId);
			//清除明细
			$("#TABLE_DocList_fdDetailList_Form tr:not(:first):not(:last)").remove();
			DocList_TableInfo["TABLE_DocList_fdDetailList_Form"].lastIndex=1;
		}
	};
	//填写完金额触发
	window.checkSameDimension=function(val,obj){
		if($("input[name='fdSchemeType']").val()=='2'){ //预算追加不校验
			return true;
		}
		return checkSame(val,obj);
	};
	//选择完对象触发
	window.validateSame=function(data){
		if($("input[name='fdSchemeType']").val()=='2'){ //预算追加不校验
			return true;
		}
		var field=data.field;
		if(!checkSame(data[0].fdId,$("[name='"+field+"']")[0])){
			dialog.alert(lang['message.fsscBudgetAdjust.fdDimension.error']);
		}
	};
	window.checkSame=function(value,object){
		var rtnFlag=false;
		//获取校验对象在表格中的行序号
		var index = object.name.substring(object.name.indexOf("[")+1,object.name.indexOf("]"));
		var borrowObjList=$("input[name*='fdDetailList_Form["+index+"].fdBorrow']");
		var lendObjList=$("input[name*='fdDetailList_Form["+index+"].fdLend']");
		var borrowParams = {};
		var lendParams = {};
		//借出方和借入方是成对出现的，只做一次循环
		for(var i=0;i<borrowObjList.length;i++){
			var borrowPro=borrowObjList[i].name.substring(borrowObjList[i].name.indexOf(".")+1,borrowObjList[i].name.length);
			var value=borrowObjList[i].value;
			borrowPro=borrowPro.replace("Borrow",""); 
			borrowParams[borrowPro]=value;
			if(!value){
				rtnFlag=true;//说明数据没填写完全，不继续校验
				break;
			}
			var lendPro=lendObjList[i].name.substring(lendObjList[i].name.indexOf(".")+1,lendObjList[i].name.length);
			var value=lendObjList[i].value;
			lendPro=lendPro.replace("Lend",""); 
			lendParams[lendPro]=value;
			if(!value){
				rtnFlag=true;//说明数据没填写完全，不继续校验
				break;
			}
		}
		for(var key in borrowParams){
	　　　　if(lendParams[key]!=borrowParams[key]){//同样的维度，值不一致，说明不同，不可能一致，不需要校验
				rtnFlag=true;
				break;
	　　　　}
	　　}
		return rtnFlag;
	};
	//增加一行调整明细
	window.FSSC_AddAdjustDetail = function(){
		DocList_AddRow('TABLE_DocList_fdDetailList_Form');
	}
	//提交前校验明细不能为空
	Com_Parameter.event["submit"].push(function(){ 
		//暂存不作校验
		if($("[name=docStatus]").val()=='10'){
			return true;
		}
		if($("#TABLE_DocList_fdDetailList_Form >tbody >tr").find("input[name$='fdMoney']").length==0){
			dialog.alert(lang['message.budget.nodetail.tips']);
			return false;
		}
		return true;
	 });
});

Com_AddEventListener(window,'load',function(){
	if(Com_GetUrlParameter(window.location.href,"method")=='add'){
		FSSC_AddAdjustDetail();
	}
})

LUI.ready(function(){	
	seajs.use('lui/jquery',function($){
		var method=Com_GetUrlParameter(window.location.href,"method");
		if(method=="edit"){
			var len=$("#TABLE_DocList_fdDetailList_Form >tbody >tr").find("input[name$='fdMoney']").length;
			if(len>0){
				for(var i=0;i<len;i++){
					//借入部门编辑初始化显示
					var id=$("[name='fdDetailList_Form["+i+"].fdBorrowDeptId']").val();
					var name=$("[name='fdDetailList_Form["+i+"].fdBorrowDeptName']").val();
					if(id&&name){
						emptyNewAddress("fdDetailList_Form["+i+"].fdBorrowDeptName",null,null,false);
						$("[name='fdDetailList_Form["+i+"].fdBorrowDeptId']").val(id);
						$("[name='fdDetailList_Form["+i+"].fdBorrowDeptName']").val(name);
						var addressInput = $("[xform-name='mf_fdDetailList_Form["+i+"].fdBorrowDeptName']")[0];
					    var addressValues = new Array();
					    addressValues.push({id:id,name:name});
						newAddressAdd(addressInput,addressValues);
					}
					//借入员工编辑初始化显示
					id=$("[name='fdDetailList_Form["+i+"].fdBorrowPersonId']").val();
					name=$("[name='fdDetailList_Form["+i+"].fdBorrowPersonName']").val();
					if(id&&name){
						emptyNewAddress("fdDetailList_Form["+i+"].fdBorrowPersonName",null,null,false);
						$("[name='fdDetailList_Form["+i+"].fdBorrowPersonId']").val(id);
						$("[name='fdDetailList_Form["+i+"].fdBorrowPersonName']").val(name);
						var addressInput = $("[xform-name='mf_fdDetailList_Form["+i+"].fdBorrowPersonName']")[0];
					    var addressValues = new Array();
					    addressValues.push({id:id,name:name});
						newAddressAdd(addressInput,addressValues);
					}
					//借出部门编辑初始化显示
					id=$("[name='fdDetailList_Form["+i+"].fdLendDeptId']").val();
					name=$("[name='fdDetailList_Form["+i+"].fdLendDeptName']").val();
					if(id&&name){
						emptyNewAddress("fdDetailList_Form["+i+"].fdLendDeptName",null,null,false);
						$("[name='fdDetailList_Form["+i+"].fdLendDeptId']").val(id);
						$("[name='fdDetailList_Form["+i+"].fdLendDeptName']").val(name);
						var addressInput = $("[xform-name='mf_fdDetailList_Form["+i+"].fdLendDeptName']")[0];
						var addressValues = new Array();
						addressValues.push({id:id,name:name});
						newAddressAdd(addressInput,addressValues);
					}
					//借出员工编辑初始化显示
					id=$("[name='fdDetailList_Form["+i+"].fdLendPersonId']").val();
					name=$("[name='fdDetailList_Form["+i+"].fdLendPersonName']").val();
					if(id&&name){
						emptyNewAddress("fdDetailList_Form["+i+"].fdLendPersonName",null,null,false);
						$("[name='fdDetailList_Form["+i+"].fdLendPersonId']").val(id);
						$("[name='fdDetailList_Form["+i+"].fdLendPersonName']").val(name);
						var addressInput = $("[xform-name='mf_fdDetailList_Form["+i+"].fdLendPersonName']")[0];
						var addressValues = new Array();
						addressValues.push({id:id,name:name});
						newAddressAdd(addressInput,addressValues);
					}
				}
			}
		}
	});
});
