DocList_Info.push('TABLE_DocList_fdInvoiceListTemp_Form');
seajs.use(['lui/dialog','lang!fssc-expense'],function(dialog,lang){
	
	$(document).ready(function(){
		if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1
				||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
			setTimeout(function(){
				if(typeof(attachmentObject_attInvoice)=='undefined'){
					return;
				}
				attachmentObject_attInvoice.uploadObj.on("uploadSuccess",function(files) {
					uploadSuccess(files);
				});
				initRequired();//初始化发票必填
			},1000);
		}else{
			setTimeout(function(){
				if(typeof(attachmentObject_attInvoice)=='undefined'){
					return;
				}
				attachmentObject_attInvoice.uploadObj.on("uploadSuccess",function(files) {
					uploadSuccess(files);
				});
				initRequired();//初始化发票必填
			},2000);
		}
	});
	
	LUI.ready(function() {
		if($("input[name='method_GET']").val()=='edit'){
			displayTempDetail();  //隐藏发票明细不存在的发票，后续提交表单再处理后台数据
		}
	});
	
	window.initRequired=function(){
		var len=$("#TABLE_DocList_fdInvoiceListTemp_Form [name$=fdInvoiceNumber]").length;
		for(var i=0;i<len;i++){
			displayVat($("[name='fdInvoiceListTemp_Form["+i+"].fdIsVat']").parent().parent().parent(),i);
		}
	}
	//隐藏发票明细不存在的发票，后续提交表单再处理后台数据
	window.displayTempDetail=function(){
		var len=$(window.parent.document).find("#TABLE_DocList_fdInvoiceList_Form [name$=fdInvoiceNumber]").length; //获取报销页面发票明细信息
		var invoices=[];
		if(len>0){
			for(var i=0;i<len;i++){
				var fdInvoiceNumber=$(window.parent.document).find("[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").val();
				var fdInvoiceCode=$(window.parent.document).find("[name='fdInvoiceList_Form["+i+"].fdInvoiceCode']").val();
				if((fdInvoiceNumber+fdInvoiceCode)&&invoices.indexOf(fdInvoiceNumber+";"+fdInvoiceCode)==-1){//不重复存入
					invoices.push(fdInvoiceNumber+";"+fdInvoiceCode);
				}
			}
			
		}
		$("#TABLE_DocList_fdInvoiceListTemp_Form tr").each(function(){
			var number=$(this).find("input[name$='fdInvoiceNumber']").val();
			var code=$(this).find("[name$='fdInvoiceCode']").val();
			if((number+code)&&invoices.indexOf(number+";"+code)==-1){//发票明细不存在，则隐藏
				$(this).hide();
			}
		});
	}
	window.uploadSuccess = function (file){
		var filename = file.name.split(".");
		filename = filename[filename.length-1];
		var fileId=file.id;
		var doc = attachmentObject_attInvoice.getDoc(fileId);
		var fdMainId=formInitData["fdMainId"];
		var fdCompanyId = formInitData["fdCompanyId"];
		var data = new KMSSData();
		data.UseCache = false;
		var rtnData = data.AddBeanData("fsscExpenseMainService&flag=checkInvoice&fdAttId="+doc.fileKey+"&fdCompanyId="+fdCompanyId+"&fdMainId="+fdMainId).GetHashMapArray();
		if(rtnData.length>0){
			if("failure"==rtnData[0].flag){
				dialog.alert(lang['tips.invoice.exists']);
				doc.fileStatus = -1;
				$("#"+doc.fdId).remove();
				// 编辑状态下删除发送事件
				attachmentObject_attInvoice.emit('editDelete',{"file":doc});
			}else{
				var data = rtnData[0].data?rtnData[0].data:rtnData[0].info;
				var number=[];
				$($("#TABLE_DocList_fdInvoiceListTemp_Form [name$=fdInvoiceNumber]")).each(function(i){
						var code=$("[name='fdInvoiceListTemp_Form["+i+"].fdInvoiceCode']").val();
						number.push($(this).val()+code);
					}
				)
				//如果识别了发票，则填充到发票明细
				if(data&&data.length>0){
					data = JSON.parse(data);
					for(var i=0;i<data.length;i++){
						if(number.indexOf(data[i].number+data[i].code)>-1){
							dialog.alert(lang['tips.invoice.exist']);
							doc.fileStatus = -1;
							$("#"+doc.fdId).remove();
							// 编辑状态下删除发送事件
							attachmentObject_attInvoice.emit('editDelete',{"file":doc});
							continue;
						}
						DocList_AddRow("TABLE_DocList_fdInvoiceListTemp_Form");
						var index = $("#TABLE_DocList_fdInvoiceListTemp_Form>tbody>tr").length-2;
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceDocId']").val(doc.fileKey);//附件页面id
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceType']").val(data[i].type);
						if("10506"==data[i].type){ //机票
							$("[name='fdInvoiceListTemp_Form["+index+"].fdNonDeductMoney']").val(data[i].caac_development_fund);  //民航发展基金不可抵扣
						}
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceNumber']").val(data[i].number);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceCode']").val(data[i].code);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceDate']").val(data[i].date);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceMoney']").val(data[i].total);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdTaxMoney']").val(data[i].tax);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdExpenseTypeId']").val(data[i].fdExpenseItemId);
						$("[name='fdInvoiceListTemp_Form["+index+"].fdExpenseTypeName']").val(data[i].fdExpenseItemName);
						var notax=data[i].notax;
						if(!notax){
							notax=data[i].pretax_amount;
						}
						if(data[i].tax&&notax){
							var fdRate=numMulti(divPoint(data[i].tax,notax),100);
							$("[name='fdInvoiceListTemp_Form["+index+"].fdTax']").val(fdRate);
						}
						$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(notax);
						//如果是增值税专用发票
						if("10100"==data[i].type){
							displayVat($("[name='fdInvoiceListTemp_Form["+index+"].fdIsVat']").parent().parent().parent(),index);
						}
//						FSSC_GetInputTax(data[i].fdExpenseItemId,index);
					}
				}
			}
		}
	};
	
	//发票明细选择费用类型
	window.FSSC_SelectInvoiceType = function(obj){
		var index = DocListFunc_GetParentByTagName('TR',obj).rowIndex-1;
		var fdCompanyId = formInitData["fdCompanyId"];
		var fdCategoryId = formInitData["fdCategoryId"];  //报销分类
		if(!fdCompanyId){
			dialog.alert(lang['tips.pleaseSelectCompany']);
			return false;
		}
		dialogSelect(false,'fssc_base_expense_item_selectExpenseItem','fdInvoiceListTemp_Form[*].fdExpenseTypeId','fdInvoiceListTemp_Form[*].fdExpenseTypeName',null,{fdCompanyId:fdCompanyId,fdNotId:'fdNotId',fdCategoryId:fdCategoryId},function(rtn){
			if(!rtn){
				return;
			}
//			FSSC_GetInputTax(rtn[0].fdId,index);  //获取进项税率
		});
	}
	/*******************************************************
	 * 是否可抵扣以费用类型为准，配置了进项税率则可抵扣
	 *******************************************************/
	window.FSSC_GetInputTax=function(fdExpenseItemId,index){
		var data = new KMSSData();
		data = data.AddBeanData("fsscBaseInputTaxService&authCurrent=true&fdExpenseItemId="+fdExpenseItemId).GetHashMapArray();
		if(data&&data.length>0){
			var fdInvoiceMoney = $("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceMoney']").val(); //价税合计
			if(data[0].fdIsInputTax=='true'){
				var fdNonDeductMoney = $("[name='fdInvoiceListTemp_Form["+index+"].fdNonDeductMoney']").val(); //不可抵扣金额
				if(!fdNonDeductMoney){
					fdNonDeductMoney=0;
				}
				var fdTaxMoney=numSub(fdInvoiceMoney,fdNonDeductMoney);
				var fdTaxRate = divPoint(data[0].fdTaxRate,100);//(票面金额÷(1+税额)*税额)
				fdTaxMoney = multiPoint(divPoint(fdTaxMoney,numAdd(fdTaxRate,1.00)),fdTaxRate);
				$("[name='fdInvoiceListTemp_Form["+index+"].fdTaxMoney']").val(fdTaxMoney);  //税额
				$("[name='fdInvoiceListTemp_Form["+index+"].fdIsVat']").val(true);
				$("[name='fdInvoiceListTemp_Form["+index+"].fdTax']").val(data[0].fdTaxRate);
				if(data[0].fdTaxRate){
					$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(subPoint(numSub(fdInvoiceMoney,fdNonDeductMoney),fdTaxMoney));//不含税金额
				}else{
					$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(subPoint(fdInvoiceMoney,fdTaxMoney));//不含税金额
				}
			}else{
				$("[name='fdInvoiceListTemp_Form["+index+"].fdIsVat']").val(false);
			}
		}else{
			$("[name='fdInvoiceListTemp_Form["+index+"].fdIsVat']").val(false);
		}
	}
	
	
	//发票明细切换是否增值税发票，是则设置为可抵扣
	window.FSSC_ChangeIsVat = function(v,e){
		var tr = DocListFunc_GetParentByTagName("TR");
		var index = DocListFunc_GetParentByTagName('TR',e).rowIndex-1;
		displayVat(tr,index);
	}
	window.displayVat=function(tr,index){
		if(index==null||isNaN(index)){
    		index = tr.rowIndex - 1;
		}
		var fdInvoiceType = $("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceType']").val();
		if("10100"==fdInvoiceType){
			$(tr).find(".vat").find(".txtstrong").show();
			$(tr).find(".vat").find("input[type=text]").each(function(){
				var validate = $(this).attr("validate")||'';
				if(validate.indexOf('required')==-1){
					validate += ' required';
				}
				$(this).attr("validate",validate);
			});
		}else{
			$(tr).find(".vat").find(".txtstrong").hide();
			$(tr).find(".vat").parent().find(".validation-advice").hide();
			$(tr).find(".vat").find("input[type=text]").each(function(){
				var validate = $(this).attr("validate")||'';
					validate = validate.replace(/required/g,'');
				$(this).attr("validate",validate);
			});
		}
	}
	window.FSSC_GetTaxMoney = function(obj,e){
		if(e){
			obj = e;
		}
		var index = DocListFunc_GetParentByTagName('TR',obj).rowIndex-1;
		var rate = $("[name='fdInvoiceListTemp_Form["+index+"].fdTax']").val()*1;
		//计算税额、不含税额
		var fdInvoiceMoney = $("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceMoney']").val()*1;
		var fdNonDeductMoney = $("[name='fdInvoiceListTemp_Form["+index+"].fdNonDeductMoney']").val(); //不可抵扣金额
		if(!fdNonDeductMoney){
			fdNonDeductMoney=0;
		}
		var fdTaxMoney=numSub(fdInvoiceMoney,fdNonDeductMoney);  //可抵扣总金额
		rate=divPoint(rate,100);
		fdTaxMoney = multiPoint(divPoint(fdTaxMoney,numAdd(rate,1.00)),rate);  //税额
		//不含税额=发票金额/(1+税率)
		var fdNotTaxMoney = numDiv(fdTaxMoney,numAdd(1,numDiv(rate,100)));
		fdNotTaxMoney = parseFloat(fdNotTaxMoney).toFixed(2);
		$("[name='fdInvoiceListTemp_Form["+index+"].fdTaxMoney']").val(fdTaxMoney);
		if(rate&&rate>0){
			var num=formatScientificToNum(subPoint(numSub(fdInvoiceMoney,fdNonDeductMoney),fdTaxMoney),2);
			$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(num);
		}else{
			var num=formatScientificToNum(subPoint(fdInvoiceMoney,fdTaxMoney),2);
			$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(num);
		}
	}
	window.deleteInvoice=function(fileKey){
		var inputDom=$("[name$='fdInvoiceDocId'][value='"+fileKey+"']")[0];
		if(inputDom){
			var index=inputDom.name.substring(inputDom.name.indexOf("[")+1,inputDom.name.indexOf("]"));
			DocList_DeleteRow(inputDom.parentNode.parentNode.parentNode);
		}
	}
	//从费用明细点击的，提交校验发票费用类型必需一致
	window.FSSC_Submit=function(method_){
		var index=formInitData["index"];
		var fdExpenseTempDetailIds=formInitData["fdExpenseTempDetailIds"];
		var len=$("#TABLE_DocList_fdInvoiceListTemp_Form [name$='fdInvoiceNumber']").length;
		var method=formInitData["method"];
		var submit=true;
		if(len>1&&((index&&method=='add')||(index&&method=='edit'&&fdExpenseTempDetailIds&&fdExpenseTempDetailIds.split(";").length==len))){
			//校验同一条费用明细的费用类型必需一致
			var number="";
			for(var i=0;i<len;i++){
				var fdExpenseTypeId=$("[name='fdInvoiceListTemp_Form["+i+"].fdExpenseTypeId']").val();
				if(!number){
					number=fdExpenseTypeId;
				}else{
					if(number.indexOf(fdExpenseTypeId)==-1){
						//出现不一致费用类型
						submit=false;
						break;
					}
				}
			}
		}
		if(submit){
			Com_Submit(document.fsscExpenseTempForm, method_);	
		}else{
			//出现不一致费用类型
			dialog.confirm(lang['tips.expenseTemp.check'],function(val){
				if(val){
					Com_Submit(document.fsscExpenseTempForm, method_);		
				}
			});
		}	
		
	}
	//选择发票
	window.FSSC_SelectInvoice = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceListTemp_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		dialogSelect(false,'fssc_ledger_fdInvoice','fdInvoiceListTemp_Form[*].fdInvoiceNumberId','fdInvoiceListTemp_Form[*].fdInvoiceNumber',null,{type:'doccreator',fdUseStatus:'0',fdState:'0'},function(rtn){
			if(rtn){
				$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceNumber']").val(rtn[0]['fdInvoiceNumber']);
				if(rtn[0]['fdInvoiceCode']){
					$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceCode']").val();
				}
				getInvoiceInfo(rtn[0]['fdInvoiceNumber'],rtn[0]['fdInvoiceCode'],index);
			}
		});
	}
	//选择发票
	window.FSSC_Invoice = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceListTemp_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var fdInvoiceNumber=$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceNumber']").val();
		var fdInvoiceCode=$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceCode']").val();
		getInvoiceInfo(fdInvoiceNumber,fdInvoiceCode,index);
	}
	
	/**
	 * 根据发票号码获取发票信息
	 */
	window.getInvoiceInfo=function(fdInvoiceNumber,fdInvoiceCode,index){
		var fdCompanyId=$("[name='fdCompanyId']").val();
		var fdExpenseItemId=$("[name='fdInvoiceListTemp_Form["+index+"].fdExpenseTypeId']").val();
		//通过发票单号自动带出对应的信息
		var data = new KMSSData();
		data.AddBeanData("fsscExpenseDataService&type=getInvoiceInfoByCode&authCurrent=true&fdInvoiceNumber="+fdInvoiceNumber+"&fdInvoiceCode="+(fdInvoiceCode?fdInvoiceCode:"")+"&fdExpenseItemId="+fdExpenseItemId);
		var rtnVal = data.GetHashMapArray();
		if(rtnVal.length>0){
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceCode']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceDate']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceMoney']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdTax']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdTaxMoney']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val("");
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceCode']").val(rtnVal[0].fdInvoiceCode);
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceDate']").val(rtnVal[0].fdInvoiceDate);
			$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceType']").val(rtnVal[0].type);
			$("[name='fdInvoiceListTemp_Form["+index+"].fdCompanyId']").val(fdCompanyId);
			if(rtnVal[0].fdJshj){
				$("[name='fdInvoiceListTemp_Form["+index+"].fdInvoiceMoney']").val(formatFloat(rtnVal[0].fdJshj,2));
			}
			if(rtnVal[0].fdSl){
				if(rtnVal[0].noRate=='true'){
					dialog.alert(lang['msg.expense.no.input.rate'].replace('{0}',rtnVal[0].fdSl));
				}else{
					$("[name='fdInvoiceListTemp_Form["+index+"].fdTax']").val(formatFloat(parseFloat(rtnVal[0].fdSl),2));
				}
			}
			if(rtnVal[0].fdTotalTax){
				$("[name='fdInvoiceListTemp_Form["+index+"].fdTaxMoney']").val(formatFloat(rtnVal[0].fdTotalTax,2));
			}
			if(rtnVal[0].fdJshj&&rtnVal[0].fdTotalTax){
				$("[name='fdInvoiceListTemp_Form["+index+"].fdNoTaxMoney']").val(subPoint(rtnVal[0].fdJshj,rtnVal[0].fdTotalTax));
			}
		}
	}
	//弹框校验发票是否重复
	Com_Parameter.event["submit"].push(function(){ 
		var flag=true;
		var length=$("#TABLE_DocList_fdInvoiceListTemp_Form [name$=fdInvoiceNumber]").length;
		var number=[];
		if(length>0){
			for(var i=0;i<length;i++){
				var fdInvoiceNumber=$("[name='fdInvoiceListTemp_Form["+i+"].fdInvoiceNumber']").val();
				var fdInvoiceCode=$("[name='fdInvoiceListTemp_Form["+i+"].fdInvoiceCode']").val();
				if((fdInvoiceNumber+fdInvoiceCode)&&number.indexOf(fdInvoiceNumber+";"+fdInvoiceCode)>-1){
					dialog.alert(lang['tips.invoice.repeat']);
					return false;
				}else{
					number.push(fdInvoiceNumber+";"+fdInvoiceCode);
				}
			}
		}
	 	return flag;
	 });

});