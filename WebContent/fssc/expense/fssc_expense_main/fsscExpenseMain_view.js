DocList_Info.push('TABLE_DocList_fdInvoiceListTemp_Form');
seajs.use(['lui/dialog','lang!fssc-expense'],function(dialog,lang){
	$(document).ready(function(){
		var	len=$("[name$='.fdInvoiceType']").length;  //查看页面或者无发票页面len为0
		for(var i=0;i<len;i++){
			var fdInvoiceType = $("[name='fdInvoiceList_Form["+i+"].fdInvoiceType']").val();
			var tr=$("#TABLE_DocList_fdInvoiceList_Form").find("tr")[i+1];
			if("10100"==fdInvoiceType){
				$(tr).find(".vat").find(".txtstrong").show();
				$(tr).find(".vat").find("input[type=text]").each(function(){
					var validate = $(this).attr("validate")||'';
					if(validate.indexOf('required')==-1){
						validate += ' required';
					}
					$(this).attr("validate",validate);
				});
				//发票号码单独处理
				$(tr).find(".inputselectsgl.vat").parent().find(".txtstrong").show();
				var validate = $("[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").attr("validate")||'';
				if(validate.indexOf('required')==-1){
					validate += ' required';
				}
				$("[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").attr('validate',validate);
			}else{
				$(tr).find(".vat").find(".txtstrong").hide();
				$(tr).find(".vat").parent().find(".validation-advice").hide();
				$(tr).find(".vat").find("input[type=text]").each(function(){
					var validate = $(this).attr("validate")||'';
					validate = validate.replace(/required/g,'');
					$(this).attr("validate",validate);
				});
				//发票号码单独处理
				$(tr).find(".inputselectsgl.vat").parent().find(".txtstrong").hide();
				var validate = $("[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").attr("validate")||'';
				validate = validate.replace(/required/g,'');
				$("[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").attr('validate',validate);
			}
		}
		var money=$("input[name='fdTotalStandaryMoney']").val();
		$("#fdTotalStandaryUpperMoney").html(FSSC_MenoyToUppercase(money));
		money=$("input[name='fdTotalApprovedMoney']").val();
		$("#fdTotalApprovedUpperMoney").html(FSSC_MenoyToUppercase(money));
		
		var len = $("#TABLE_DocList_fdAccountsList_Form tr").length-1;
		for(var i=0;i<len;i++){
			var fdPayWayId = $("[name='fdAccountsList_Form["+i+"].fdPayWayId']").val();
			var data = new KMSSData();
			data.UseCache=false;
			data.AddBeanData("fsscBasePayWayService&fdPayWayId="+fdPayWayId);
			data = data.GetHashMapArray();
			if(data.length>0){
				$("[name='fdAccountsList_Form["+i+"].fdIsTransfer']").val(data[0].fdIsTransfer);
				initFS_GetFdIsTransfer(i,data[0].fdIsTransfer);//初始化收款账户信息是否必填
			}
		}
	});
	
	function initFS_GetFdIsTransfer(index, fdIsTransfer){
		if(fdIsTransfer =='false'){	//收款账户信息非必填
			$("[name='fdAccountsList_Form["+index+"].fdAccountName']").attr("validate","");
			$("[name='fdAccountsList_Form["+index+"].fdBankName']").attr("validate","maxLength(400) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdBankAccount']").attr("validate","maxLength(200) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdBankAccountNo']").attr("validate","maxLength(400) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdAccountAreaName']").attr("validate","");
			$(".vat_"+index).hide();
		}else{	//收款账户信息必填
			$("[name='fdAccountsList_Form["+index+"].fdAccountName']").attr("validate","required");
			$("[name='fdAccountsList_Form["+index+"].fdBankName']").attr("validate","required maxLength(400) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdBankAccount']").attr("validate","required maxLength(200) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdBankAccountNo']").attr("validate","required maxLength(400) checkNull");
			$("[name='fdAccountsList_Form["+index+"].fdAccountAreaName']").attr("validate","required");
			$(".vat_"+index).show();
		}
	}
	
	//匹配预提 ，并展示
	window.FSSC_MatchProvsion = function(index){
		if(!LUI('ytContent')){
			return;
		}
		var param = {
			fdExpenseItemId:$("[name='fdDetailList_Form["+index+"].fdExpenseItemId']").val(),
			fdCostCenterId:$("[name='fdDetailList_Form["+index+"].fdCostCenterId']").val(),
			fdProjectId:$("[name='fdDetailList_Form["+index+"].fdProjectId']").val(),
			fdInnerOrderId:$("[name='fdDetailList_Form["+index+"].fdInnerOrderId']").val()||'',
			fdWbsId:$("[name='fdDetailList_Form["+index+"].fdWbsId']").val()||'',
			fdProappId:$("[name=fdProappId]").val()||'',
			fdDetailId:index
		}
		if(!param.fdExpenseItemId){
			return;
		}
		$.post(
			Com_Parameter.ContextPath+'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=matchProvision',
			{params:JSON.stringify([param])},
			function(rtn){
				rtn = JSON.parse(rtn);
				if(rtn.result!='success'){
					return;
				}
				if(rtn[index]){
					var data = rtn[index].data;
					var money = 0,apply = $("[name='fdDetailList_Form["+index+"].fdStandardMoney']").val();
					for(var i=0;i<data.length;i++){
						money = numAdd(money,data[i].fdMoney);
					}
					if(money>apply){
						$("[name='fdDetailList_Form["+index+"].fdProvisionMoney']").val(apply);
					}else{
						$("[name='fdDetailList_Form["+index+"].fdProvisionMoney']").val(money);
					}
					$("[name='fdDetailList_Form["+index+"].fdProvisionInfo']").val(JSON.stringify(data));
				}else{
					$("[name='fdDetailList_Form["+index+"].fdProvisionMoney']").val(0);
					$("[name='fdDetailList_Form["+index+"].fdProvisionInfo']").val("[]");
				}
				FSSC_ReloadProvisionInfo();
			}
		);
	}
	//加载预提信息进行展示
	window.FSSC_ReloadProvisionInfo = function(){
		if(!LUI('ytContent')){
			return;
		}
		$("#ytTable tr:gt(0)").remove();
		var content = LUI("ytContent").element.closest(".lui_tabpage_float_content");
		var contentIndex = 0;
		for(var i=0;i<LUI("ytContent").parent.children.length;i++){
			if(LUI("ytContent").parent.children[i].id=='ytContent'){
				contentIndex = i-1;
			}
		}
		var toggle =$(".lui_tabpage_float_nav_item").eq(contentIndex);
		var provisionInfo = {},fdProvisionLedger = {};
		$("#TABLE_DocList_fdDetailList_Form>tbody>tr:gt(0)").each(function(){
			var fdProvisionInfo = $(this).find("[name$=fdProvisionInfo]").val()||'[]';
			fdProvisionInfo = JSON.parse(fdProvisionInfo);
			for(var i=0;i<fdProvisionInfo.length;i++){
				if(fdProvisionLedger[fdProvisionInfo[i].fdLedgerId]){
					continue;
				}
				var key = [],title = '';
				if(fdProvisionInfo[i].fdProappName){
					key.push(fdProvisionInfo[i].fdProappName);
				}
				if(fdProvisionInfo[i].fdExpenseItemName){
					key.push(fdProvisionInfo[i].fdExpenseItemName);
				}
				if(fdProvisionInfo[i].fdCostCenterName){
					key.push(fdProvisionInfo[i].fdCostCenterName);
				}
				if(fdProvisionInfo[i].fdProjectName){
					key.push(fdProvisionInfo[i].fdProjectName);
				}
				if(fdProvisionInfo[i].fdInnerOrderName){
					key.push(fdProvisionInfo[i].fdInnerOrderName);
				}
				if(fdProvisionInfo[i].fdWbsName){
					key.push(fdProvisionInfo[i].fdWbsName);
				}
				title = key.join('/');
				if(provisionInfo[title]!=null){
					provisionInfo[title] = numAdd(provisionInfo[title],fdProvisionInfo[i].fdMoney);
				}else{
					provisionInfo[title] = fdProvisionInfo[i].fdMoney
				}
				fdProvisionLedger[fdProvisionInfo[i].fdLedgerId] = true;
			}
		})
		//如果有预提信息，则拼接到明细表，并显示content
		if(JSON.stringify(provisionInfo)!='{}'){
			var index = 1;
			for(var i in provisionInfo){
				$("<tr><td align='center'>"+(index++)+"</td><td>"+i+"</td><td>"+provisionInfo[i]+"</td></tr>").appendTo($("#ytTable"));
				content.css({position:'relative',top:0});
				toggle.addClass("selected")
			}
		}else{//没有预提信息，隐藏content
			content.css({position:'absolute',top:'-9999em'});
			toggle.removeClass("selected")
		}
	}
	//选择发票
	window.FSSC_SelectInvoice = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceList_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		dialogSelect(false,'fssc_ledger_fdInvoice','fdInvoiceList_Form[*].fdInvoiceNumberId','fdInvoiceList_Form[*].fdInvoiceNumber',null,{type:'examine'},function(rtn){
			if(rtn){
				$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").val(rtn[0]['fdInvoiceNumber']);
				$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val(rtn[0]['fdInvoiceCode']);
				getInvoiceInfo(rtn[0]['fdInvoiceNumber'],rtn[0]['fdInvoiceCode'],index);
			}
		});
	}
	//选择发票
	window.FSSC_Invoice = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceList_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var fdInvoiceNumber=$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").val();
		var fdInvoiceCode=$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val();
		getInvoiceInfo(fdInvoiceNumber,fdInvoiceCode,index);
	}
	
	/**
	 * 根据发票号码获取发票信息
	 */
	window.getInvoiceInfo=function(fdInvoiceNumber,fdInvoiceCode,index){
		var fdCompanyId=$("[name='fdCompanyId']").val();
		//通过发票单号自动带出对应的信息
		var data = new KMSSData();
		data.AddBeanData("fsscExpenseDataService&type=getInvoiceInfoByCode&authCurrent=true&fdInvoiceNumber="+fdInvoiceNumber+"&fdInvoiceCode="+fdInvoiceCode);
		var rtnVal = data.GetHashMapArray();
		if(rtnVal.length>0){
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceDate']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdTax']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val("");
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val(rtnVal[0].fdInvoiceCode);
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceDate']").val(rtnVal[0].fdInvoiceDate);
			$("[name='fdInvoiceList_Form["+index+"].fdCompanyId']").val(fdCompanyId);
			if(rtnVal[0].fdJshj){
				$("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val(formatFloat(rtnVal[0].fdJshj,2));
			}
			if(rtnVal[0].fdSl){
				$("[name='fdInvoiceList_Form["+index+"].fdTax']").val(formatFloat(rtnVal[0].fdSl,2));
			}
			if(rtnVal[0].fdTotalTax){
				$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(formatFloat(rtnVal[0].fdTotalTax,2));
			}
			if(rtnVal[0].fdJshj&&rtnVal[0].fdTotalTax){
				$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(subPoint(rtnVal[0].fdJshj,rtnVal[0].fdTotalTax));
			}
		}
	}
	//发票明细选择费用类型
	window.FSSC_SelectInvoiceType = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceList_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var fdCompanyId = $("[name='fdInvoiceList_Form["+index+"].fdCompanyId']").val();
		if(!fdCompanyId){
			dialog.alert(lang['tips.pleaseSelectCompany']);
			return false;
		}
		dialogSelect(false,'fssc_base_expense_item_selectExpenseItem','fdInvoiceList_Form[*].fdExpenseTypeId','fdInvoiceList_Form[*].fdExpenseTypeName',null,{fdCompanyId:fdCompanyId,fdNotId:'fdNotId'});
	}
	//发票明细切换是否增值税发票
	window.FSSC_ChangeIsVat = function(v,e,index){
		var tr = DocListFunc_GetParentByTagName("TR");
		if(index==null||isNaN(index)){
    		index = tr.rowIndex - 1;
		}
		var fdInvoiceType = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceType']").val();
		if("10100"==fdInvoiceType){
			$(tr).find(".vat").find(".txtstrong").show();
			$(tr).find(".vat").find("input[type=text]").each(function(){
				var validate = $(this).attr("validate")||'';
				if(validate.indexOf('required')==-1){
					validate += ' required';
				}
				$(this).attr("validate",validate);
			});
			//发票号码单独处理
			$(tr).find(".inputselectsgl.vat").parent().find(".txtstrong").show();
			var validate = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").attr("validate")||'';
			if(validate.indexOf('required')==-1){
				validate += ' required';
			}
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").attr('validate',validate);
		}else{
			$(tr).find(".vat").find(".txtstrong").hide();
			$(tr).find(".vat").parent().find(".validation-advice").hide();
			$(tr).find(".vat").find("input[type=text]").each(function(){
				var validate = $(this).attr("validate")||'';
				validate = validate.replace(/required/g,'');
				$(this).attr("validate",validate);
			});
			//发票号码单独处理
			$(tr).find(".inputselectsgl.vat").parent().find(".txtstrong").hide();
			var validate = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").attr("validate")||'';
			validate = validate.replace(/required/g,'');
			$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").attr('validate',validate);
		}
	}
	//选择税率
	window.FSSC_SelectTaxRate = function(){
		DocList_TableInfo['TABLE_DocList_fdInvoiceList_Form'].firstIndex = 1;
		var index = DocListFunc_GetParentByTagName("TR").rowIndex-1;
		var fdCompanyId = $("[name='fdInvoiceList_Form["+index+"].fdCompanyId']").val();
		if(!fdCompanyId){
			dialog.alert(lang['tips.pleaseSelectCompany']);
			return false;
		}
		dialogSelect(false,'fssc_base_tax_rate_getTaxRate','fdInvoiceList_Form[*].fdTax1','fdInvoiceList_Form[*].fdTax',null,{fdCompanyId:fdCompanyId,fdNotId:'fdNotId'},function(rtn){
			if(!rtn){
				return;
			}
			var rate = rtn[0].fdRate.split('%')[0];
			$("[name='fdInvoiceList_Form["+index+"].fdTax']").val(rate);
			rate = $("[name='fdInvoiceList_Form["+index+"].fdTax']").val()*1;
			//计算税额、不含税额
			var fdInvoiceMoney = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val()*1;
			//不含税额=发票金额/(1+税率)
			var fdNoTaxMoney = numDiv(fdInvoiceMoney,numAdd(1,numDiv(rate,100)));
			fdNoTaxMoney = parseFloat(fdNoTaxMoney).toFixed(2);
			$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(fdNoTaxMoney);
			$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(numSub(fdInvoiceMoney*1,fdNoTaxMoney*1));
		});
	}
	window.FSSC_ChangeInvoiceMoney = function(){
		var index = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var rate = $("[name='fdInvoiceList_Form["+index+"].fdTax']").val()*1;
		//计算税额、不含税额
		var fdInvoiceMoney = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val()*1;
		//不含税额=发票金额/(1+税率)
		var fdNotTaxMoney = numDiv(fdInvoiceMoney,numAdd(1,numDiv(rate,100)));
		fdNotTaxMoney = parseFloat(fdNotTaxMoney).toFixed(2);
		$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(fdNotTaxMoney);
		$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(numSub(fdInvoiceMoney*1,fdNotTaxMoney*1));
	}
	//修改税额
	window.FSSC_ChangeTaxMoney = function(){
		var index = DocListFunc_GetParentByTagName("TR").rowIndex-1;
		var fdInvoiceMoney = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val()*1;
		var fdTaxMoney = $("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val()*1;
		if(fdTaxMoney > fdInvoiceMoney){
			dialog.alert(lang['msg.tax.cannot.over.invoice.error']);
			$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val("");
		}
		$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(numSub(fdInvoiceMoney*1,fdTaxMoney*1));
	}
	//修改不含税额
	window.FSSC_ChangeNoTaxMoney = function(){
		var index = DocListFunc_GetParentByTagName("TR").rowIndex-1;
		var fdInvoiceMoney = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val()*1;
		var fdNoTaxMoney = $("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val()*1;
		if(fdNoTaxMoney > fdInvoiceMoney){
			dialog.alert(lang['msg.notax.cannot.over.invoice.error']);
			$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val("");
		}
		$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(numSub(fdInvoiceMoney*1,fdNoTaxMoney*1));
	}
	
	/*********************************************
	  * 修改不可抵扣金额，重新计算可抵扣金额和不含税金额
	  *********************************************/
	 window.FSSC_CalculateMoney=function(val,obj){
		 var index = obj.name.replace(/\S+\[(\d+)\]\S+/g,'$1');
		 var fdInputTaxRate=$("[name='fdDetailList_Form["+index+"].fdInputTaxRate']").val();  //进项税率
		 var fdApplyMoney=$("[name='fdDetailList_Form["+index+"].fdApplyMoney']").val();  //申请金额
		 var fdNonDeductMoney=$("[name='fdDetailList_Form["+index+"].fdNonDeductMoney']").val();  //不可抵扣金额
		 if(!fdNonDeductMoney){
			 fdNonDeductMoney=0;
		 }
		 if(fdInputTaxRate&&fdApplyMoney){
			 fdInputTaxRate=numDiv(fdInputTaxRate,100);
			 var fdInputTaxMoney=divPoint(multiPoint(fdInputTaxRate,numSub(fdApplyMoney,fdNonDeductMoney)),numAdd(1,fdInputTaxRate));  //进项税额  =税率*含税金额/（1+税率）
			 $("[name='fdDetailList_Form["+index+"].fdInputTaxMoney']").val(fdInputTaxMoney);  //进项税额
			 $("[name='fdDetailList_Form["+index+"].fdNoTaxMoney']").val(subPoint(fdApplyMoney,fdInputTaxMoney));  //不含税金额
		 }
	 }
	/*********************************************
	  * 修改进项税额，重新计算不含税金额
	  *********************************************/
	 window.FSSC_CalculateNoTaxMoney=function(val,obj){
		 var index = obj.name.replace(/\S+\[(\d+)\]\S+/g,'$1');
		 var fdApplyMoney=$("[name='fdDetailList_Form["+index+"].fdApplyMoney']").val();  //申请金额
		 var fdInputTaxMoney=$("[name='fdDetailList_Form["+index+"].fdInputTaxMoney']").val();  //进项税额
		 if(fdApplyMoney&&fdInputTaxMoney){
			$("[name='fdDetailList_Form["+index+"].fdNoTaxMoney']").val(subPoint(fdApplyMoney,fdInputTaxMoney));  //不含税金额
			var fdBudgetMoney = "";
			var fdDeduFlag=$("[name='fdDeduFlag']").val();
			var fdBudgetRate = $("[name='fdDetailList_Form["+index+"].fdBudgetRate']").val();
			var fdNoTaxMoney = $("[name='fdDetailList_Form["+index+"].fdNoTaxMoney']").val();
			if(fdBudgetRate){
				if("2"==fdDeduFlag){  //不含税金额
					fdBudgetMoney = (fdNoTaxMoney*fdBudgetRate).toFixed(2);
				}else{
					fdBudgetMoney = (fdApplyMoney*fdBudgetRate).toFixed(2);
				}
			}
			$("[name='fdDetailList_Form["+index+"].fdBudgetMoney']").val(fdBudgetMoney);
			if("2"==fdDeduFlag){
				FSSC_MatchBudget(null,$("[name='fdDetailList_Form["+index+"].fdApplyMoney']").get(0));  //预算匹配
			}
		 }
	 }
	//单行明细匹配预算
		window.FSSC_MatchBudget = function(v,e){
			var i = e.name.replace(/\S+\[(\d+)\]\S+/g,'$1');
			var fdMoney=$("[name='fdDetailList_Form["+i+"].fdApprovedApplyMoney']").val();
			var fdNoTaxMoney=$("[name='fdDetailList_Form["+i+"].fdNoTaxMoney']").val();
			if(!fdNoTaxMoney||fdNoTaxMoney==0){
				fdNoTaxMoney=fdMoney;
			}
			var param = {
				'fdCompanyId':$("[name='fdDetailList_Form["+i+"].fdCompanyId']").val(),
				'fdProjectId':$("[name='fdDetailList_Form["+i+"].fdProjectId']").val(),
				'fdProappId':$("[name='fdProappId']").val(),
				'fdWbsId':$("[name='fdDetailList_Form["+i+"].fdWbsId']").val(),
				'fdInnerOrderId':$("[name='fdDetailList_Form["+i+"].fdInnerOrderId']").val(),
				'fdExpenseItemId':$("[name='fdDetailList_Form["+i+"].fdExpenseItemId']").val(),
				'fdCostCenterId':$("[name='fdDetailList_Form["+i+"].fdCostCenterId']").val(),
				'fdPersonId':$("[name='fdDetailList_Form["+i+"].fdRealUserId']").val(),
				'fdDeptId':$("[name='fdDetailList_Form["+i+"].fdDeptId']").val(),
				'fdMoney':fdMoney,
				'fdHappenDate':$("[name='fdDetailList_Form["+i+"].fdHappenDate']").val(),
				'fdNoTaxMoney':fdNoTaxMoney,
				'fdCurrencyId':$("[name='fdDetailList_Form["+i+"].fdCurrencyId']").val(),
				'fdDetailId':i
			}
			if(Com_GetUrlParameter(window.location.href,'method')=="view"&&$("[name='fdDetailList_Form["+i+"].fdBudgetInfo']").val()){
				param['fdBudgetInfo']=$("[name='fdDetailList_Form["+i+"].fdBudgetInfo']").val();
			}
			if(!param.fdCompanyId||!param.fdExpenseItemId||!param.fdCostCenterId||!param.fdMoney){
				return;
			}
			var fdProappId = $("[name=fdProappId]").val(),pass = true;
			//如果有立项
			if(fdProappId){
				$.ajax({
					url:Com_Parameter.ContextPath+'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=matchProapp',
					data:{data:JSON.stringify({data:[param],fdProappId:fdProappId})},
					async:false,
					success:function(rtn){
						if(!rtn){
							return;
						}
						rtn = JSON.parse(rtn);
						//匹配失败
						if(rtn.result=='failure'){
							dialog.alert(rtn.message?rtn.message:rtn.budget.errorMessage);
							return;
						}
						var fdProappStatus = "0";
						//如果找到了立项
						FSSC_ApproveShowProappInfo(rtn[i],i,param);
					}
				});
				//立项默认刚控，无论有没有匹配到、有没有超，都不再匹配预算
				return;
			}
			var fdFeeIds = $("[name=fdFeeIds]").val(),pass = true;
			//如果有事前
			if(fdFeeIds){
				$.ajax({
						url:Com_Parameter.ContextPath+'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=matchFee',
						data:{data:JSON.stringify({data:[param],fdFeeIds:fdFeeIds})},
						async:false,
						success:function(rtn){
							if(!rtn){
								return;
							}
							rtn = JSON.parse(rtn);
							//匹配失败
							if(rtn.result=='failure'){
								dialog.alert(rtn.message?rtn.message:rtn.budget.errorMessage);
								return;
							}
							var fdFeeStatus = "0";
							//如果找到了事前
							if(rtn[i]&&rtn[i].length>0){
								fdFeeStatus = "1";
								var money = FSSC_ShowFeeInfo(i,rtn[i]);
								//如果金额超过事前的可用额度且事前为刚控，则提示用户不可以报销
								if(money>0){
									if(rtn['fdForbid']=='1'){
										dialog.alert(lang['tips.fee.over']);
										pass = false;
									}
									fdFeeStatus = "2";
								}else{//没有超事前，则不需要再匹配预算
									pass = false;
								}
								$("[name$='["+i+"].fdFeeStatus']").val(fdFeeStatus);
								//显示红灯及超申请提示
								$("#fee_status_"+i).attr("class","budget_container budget_status_"+fdFeeStatus);
								$("#fee_status_"+i).attr("title",lang['py.fee.'+fdFeeStatus]);
							}else{
								$("[name$='["+i+"].fdFeeInfo']").val('[]');
								$("[name$='["+i+"].fdFeeStatus']").val('0');
								$("#fee_status_"+i).attr("class","budget_container budget_status_0");
								$("#fee_status_"+i).attr("title",lang['py.fee.0']);
							}
						}
				});
			}
			if(!pass){
				return;
			}
			$.post(
				Com_Parameter.ContextPath+'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=matchBudget',
				{data:JSON.stringify(param)},
				function(rtn){
					if(!rtn){
						return;
					}
					rtn = JSON.parse(rtn);
					//匹配失败
					if(rtn.result=='failure'||rtn.budget.result=='0'){
						dialog.alert(rtn.message?rtn.message:rtn.budget.errorMessage);
						return;
					}
					//未匹配到预算
					if(!rtn.budget.data||rtn.budget.data.length==0){
						FSSC_ApproveShowBudgetInfo(i);
						return;
					}
					$("[name$='["+i+"].fdBudgetInfo']").val(JSON.stringify(rtn.budget.data).replace(/\"/g,"'"));
					FSSC_ApproveShowBudgetInfo(i,rtn.budget.data);
				}
			);
			
		}
		window.FSSC_ShowFeeInfo = function(index,info){
			var feeLedgerObj = $("[name$='feeLedgerObj']").val()||'[]';
			var feeLedgerOldObj = JSON.parse((feeLedgerObj).replace(/\'/g,'"'));
			var total = $("[name='fdDetailList_Form["+index+"].fdBudgetMoney']").val()*1;
			//保存事前信息
			$("[name$='["+index+"].fdFeeInfo']").val(JSON.stringify(info).replace(/\"/g,"'"));
			var docStatus=$("input[name='docStatus']").val();
			var detail_id=$("[name='fdDetailList_Form["+index+"].fdId']").val();
			var money_old=feeLedgerOldObj[detail_id];
			if(!money_old){
				money_old=0.0;
			}
			//迭代所有明细，统计相同事前的金额
			$("#TABLE_DocList_fdDetailList_Form tr:gt(0)").each(function(i){
				if(i>=index){
					return;
				}
				var fee = $(this).find("[name*=fdFeeInfo]").val();
				var money = $(this).find("[name*=fdBudgetMoney]").val()*1;
				//待审编辑主文档，判断预算需加回已经占用的预算
				var detail_id=$(this).find("[name*='.fdId']").val();
				var fdBudgetMoneyOld=feeLedgerOldObj[detail_id];
				if(!fdBudgetMoneyOld){
					fdBudgetMoneyOld=0;
				}
				if(fee){
					fee = JSON.parse(fee.replace(/\'/g,"\""));
					//如果当前明细与该明细占用了同一事前台账，需要计算累计金额
					if(FSSC_IsContainsFee(info,fee)){
						total = numAdd(money,total);
						money_old=numAdd(money_old,fdBudgetMoneyOld);
					}
				}
			});
			for(var i=0;i<info.length;i++){
				total = numSub(total,info[i].fdUsableMoney);
			}
			return numSub(total,money_old);
		}
		window.FSSC_IsContainsFee = function(fee,info){
			for(var i=0;i<fee.length;i++){
				for(var k=0;k<info.length;k++){
					if(fee[i].fdLedgerId===info[k].fdLedgerId){
						return true;
					}
				}
			}
			return false;
		}
		window.isInProappControlField = function(property,fdControlField){
			fdControlField = fdControlField.split(";");
			for(var i=0;i<fdControlField.length;i++){
				if(property.toLowerCase().indexOf(fdControlField[i])>-1){
					return true;
				}
			}
			return false;
		}
		window.FSSC_ApproveShowProappInfo = function(data,i,param){
			var pass = true;
			var fdBudgetShowType = $("[name=fdBudgetShowType]").val();
			var div = $("#TABLE_DocList_fdDetailList_Form>tbody>tr:gt(0)").eq(i).find("[id^=proapp_status]");
			if(data){
				fdProappStatus = "1";
				var fdMoney = data.fdUsableMoney+$("[name$='"+i+"].fdBudgetMoneyOld']").val()*1;
				var fdUsableMoney = data.fdUsableMoney;
				$("#TABLE_DocList_fdDetailList_Form>tbody>tr:gt(0)").each(function(k){
					if(k>i)return;
					var object = {
						fdExpenseItemId : $(this).find("[name$=fdExpenseItemId]").val(),
						fdCostCenterId : $(this).find("[name$=fdCostCenterId]").val(),
						fdProjectId : $("[name$=fdProjectId]").val(),
						fdWbsId : $(this).find("[name$=fdWbsId]").val(),
						fdInnerOrderId : $(this).find("[name$=fdInnerOrderId]").val()
					}
					for(var v in object){
						if(object[v]!=param[v]&&(isInProappControlField(v,data.fdControlField)||v=='fdExpenseItemId')){
							return;
						}
					}
					//期间处理，如果立项受益期不是不限，则不同期间的不视为重复
					var fdHappenDate = $(this).find("[name$=fdHappenDate]").val();
					if(data.fdPeriodType=='year'){//受益期类型为年,判断年是否相同
						fdHappenDate = fdHappenDate.substring(0,4);
						var year = param.fdHappenDate.substring(0,4);
						if(year!=fdHappenDate){
							return;
						}
					}else if(data.fdPeriodType=='yearMonth'){//受益期类型为年月,判断年月是否相同
						fdHappenDate = fdHappenDate.substring(0,7);
						var year = param.fdHappenDate.substring(0,7);
						if(year!=fdHappenDate){
							return;
						}
					}
					//待审编辑主文档，判断预算需加回已经占用的预算
					var fdBudgetMoneyOld=$(this).find("[name$=fdBudgetMoneyOld]").val();
					if(!fdBudgetMoneyOld){
						fdBudgetMoneyOld=0;
					}
					fdMoney = numSub(numAdd(fdMoney,fdBudgetMoneyOld),$(this).find("[name$=fdBudgetMoney]").val()*1);
				})
				if(fdMoney<0){
					fdProappStatus = "2";
					pass = false;
				}
				if(data.empty){
					fdProappStatus = "0";
					pass = false;
				}
				$("[name$='["+i+"].fdProappInfo']").val(JSON.stringify(data).replace(/\"/g,"'"));
				$("[name$='["+i+"].fdProappStatus']").val(fdProappStatus);
				div.attr("class","budget_container");
				div.addClass("budget_status_"+fdProappStatus);
				div.attr("title",lang['py.proapp.'+fdProappStatus]);
			}else{
				div.attr("class","budget_container");
				div.addClass("budget_status_0");
				div.attr("title",lang['py.budget.0']);
				$("[name$='["+i+"].fdProappInfo']").val('{}');
				$("[name$='["+i+"].fdProappStatus']").val('0');
			}
			return pass;
		}
		//显示预算状态信息
		window.FSSC_ApproveShowBudgetInfo = function(index,info){
			var fdBudgetShowType = $("[name=fdBudgetShowType]").val();
			var budgetObj = $("[name$='budgetObj']").val()||'[]';
			var budgetOldObj = JSON.parse((budgetObj).replace(/\'/g,'"'));
			$("[name$='["+index+"].fdBudgetInfo']").val("");
			var div = $("#TABLE_DocList_fdDetailList_Form>tbody>tr:gt(0)").eq(index).find("[id^=buget_status]");
			//没有预算信息,显示为无预算
			if(!info){
				$("[name$='["+index+"].fdBudgetstatus']").val("0");
				if(fdBudgetShowType=='1'){//显示图标
					div.attr("class","budget_container");
					div.addClass("budget_status_0");
					div.attr("title",lang['py.budget.0']);
				}else{//显示金额
					div.html(lang['py.money.total']+"0<br>"+lang['py.money.using']+"0<br>"+lang['py.money.used']+"0<br>"+lang['py.money.usable']+"0");
				}
			}else{
				var budgetInfo = {},fdBudgetStatus = '1';
				var fdBudgetMoney = $("[name='fdDetailList_Form["+index+"].fdBudgetMoney']").val();
				$("[name$='["+index+"].fdBudgetInfo']").val(JSON.stringify(info).replace(/\"/g,"'"));
				//迭代所有明细的预算信息，处理多条明细匹配到同一条预算的情况
				$("#TABLE_DocList_fdDetailList_Form tr:gt(0)").find("[name$=fdBudgetInfo]").each(function(){
					var budget = JSON.parse((this.value||'[]').replace(/\'/g,'"'));
					var k = this.name.replace(/\S+\[(\d+)\]\S+/g,'$1');
					var money = $("[name='fdDetailList_Form["+k+"].fdBudgetMoney']").val()*1;
					var detail_id=$("[name='fdDetailList_Form["+k+"].fdId']").val();
					var money_old=budgetOldObj[detail_id];
					for(var i=0;i<budget.length;i++){
						//如果累计的明细在当前明细之后，不统计在内
						if(k>index){
							continue;
						}
						if(!budgetInfo[budget[i].fdBudgetId]){
							budgetInfo[budget[i].fdBudgetId] = {money:money,index:[k],money_old:money_old};
						}else{
							budgetInfo[budget[i].fdBudgetId].money = numAdd(budgetInfo[budget[i].fdBudgetId].money,money);
							budgetInfo[budget[i].fdBudgetId].money_old = numAdd(budgetInfo[budget[i].fdBudgetId].money_old,money_old);
							budgetInfo[budget[i].fdBudgetId].index.push(k);
						}
					}
				});
				var showBudget = null,overBudget = [];
				for(var i=0;i<info.length;i++){
					//获取可用金额最少的预算用于展示
					if(!showBudget||showBudget.fdCanUseAmount>info[i].fdCanUseAmount){
						showBudget = info[i];
					}
					if(budgetInfo[info[i].fdBudgetId]!=null){
						//累计事前占用额
						var fee = $("[name$='["+budgetInfo[info[i].fdBudgetId].index[0]+"].fdFeeInfo']").val()||'[]';
						fee = JSON.parse(fee.replace(/\'/g,'"'));
						//扣除事前可用额
						for(var m=0;m<fee.length;m++){
							//如果该事前未占用预算，不统计在内
							if(fee.fdIsUseBudget!='true'){
								continue;
							}
							budgetInfo[info[i].fdBudgetId].money = numSub(budgetInfo[info[i].fdBudgetId].money,fee[m].fdUsableMoney);
						}
						//超出预算
						if(budgetInfo[info[i].fdBudgetId].money>info[i].fdCanUseAmount){
							fdBudgetStatus = '2';
						}
					}
				}
				$("[name$='["+index+"].fdBudgetStatus']").val(fdBudgetStatus);
				var fdFeeStatus = $("[name$='["+index+"].fdFeeStatus']").val();
				if(fdBudgetShowType=='1'){//显示图标
					div.attr("class","budget_container");
					div.addClass("budget_status_"+fdBudgetStatus);
					div.attr("title",lang['py.budget.'+fdBudgetStatus]);
				}else{//显示金额
					div.html(lang['py.money.total']+showBudget.fdTotalAmount+"<br>"+lang['py.money.using']+showBudget.fdOccupyAmount+"<br>"+lang['py.money.used']+showBudget.fdAlreadyUsedAmount+"<br>"+lang['py.money.usable']+"<span class='budget_money_"+index+"'>"+showBudget.fdCanUseAmount+"</span>");
					$(".budget_money_"+index).css("color",fdBudgetStatus=='2'?"red":"#333");
				}
		}
		}
		window.getTravelDate = function(type,index){
			var fdExpenseType = $("[name=fdExpenseType]").val(),fdIsTravelAlone = $("[name=fdIsTravelAlone]").val();
			//行程独立，从行程明细中获得数据
			if(fdExpenseType=='2'&&fdIsTravelAlone=='true'){
				var travel = $("[name='fdDetailList_Form["+index+"].fdTravel']").val();
				var date = '';
				$("#TABLE_DocList_fdTravelList_Form tr:gt(0)").each(function(){
					if($(this).find("[name$=fdSubject]").val()==travel){
						date=type=='begin'?$(this).find("[name$=fdBeginDate]").val():$(this).find("[name$=fdEndDate]").val();
						return;
					}
				});
				return date;
			}else{//行程合并，从费用明细中获取数据
				return type=='begin'?$("[name='fdDetailList_Form["+index+"].fdStartDate']").val():$("[name='fdDetailList_Form["+index+"].fdHappenDate']").val();
			}
		}
		//判断两段日期是否有交集
		window.isInter = function(begin1,end1,begin2,end2){
			if(begin1==null||begin2==null||end1==null||end2==null){
				return false;
			}
			if(begin1<=begin2&&end1>=begin2){
				return true;
			}
			if(begin1<=end2&&end1>=end2){
				return true;
			}
			if(begin1<=begin2&&end1>=end2){
				return true;
			}
			if(begin1>=begin2&&end1<=end2){
				return true;
			}
			return false;
		}
		window.FSSC_MathStandard = function(i){
			if(!$("[name=checkVersion]").val()){
				return;
			}
			var params = [],fdExpenseType = $("[name=fdExpenseType]").val(),fdIsTravelAlone = $("[name=fdIsTravelAlone]").val();
			params.push({
				'fdCompanyId':$("[name='fdDetailList_Form["+i+"].fdCompanyId']").val(),
				'fdExpenseItemId':$("[name='fdDetailList_Form["+i+"].fdExpenseItemId']").val(),
				'fdPersonId':$("[name='fdDetailList_Form["+i+"].fdRealUserId']").val(),
				'fdMoney':$("[name='fdDetailList_Form["+i+"].fdApprovedApplyMoney']").val(),
				'fdPersonNumber':$("[name='fdDetailList_Form["+i+"].fdPersonNumber']").val(),
				'fdCurrencyId':$("[name='fdDetailList_Form["+i+"].fdCurrencyId']").val(),
				'fdTravel':$("[name='fdDetailList_Form["+i+"].fdTravel']").val(),
				'fdDetailId':$("[name='fdDetailList_Form["+i+"].fdId']").val(),
				'fdHappenDate':$("[name='fdDetailList_Form["+i+"].fdHappenDate']").val(),
				'fdModelId':Com_GetUrlParameter(window.location.href,'fdId'),
				'model':'expense',
				'index':i
			})
			//如果是差旅费类型，参数中需要加上地域、舱位等
			//行程独立，从行程明细中获得数据
			if(fdExpenseType=='2'&&fdIsTravelAlone=='true'){
				var travel = {};
				$("#TABLE_DocList_fdTravelList_Form tr:gt(0)").each(function(){
					travel[$(this).find("[name$=fdSubject]").val()] = {
						'fdTravelDays':$(this).find("[name$=fdTravelDays]").val(),
						'fdVehicleId':$(this).find("[name$=fdVehicleId]").val(),
						'fdBerthId':$(this).find("[name$=fdBerthId]").val(),
						'fdBeginDate':$(this).find("[name$=fdBeginDate]").val(),
						'fdEndDate':$(this).find("[name$=fdEndDate]").val(),
						'fdAreaId':$(this).find("[name$=fdArrivalId]").val()
					}
				});
				for(var i=0;i<params.length;i++){
					if(travel[params[i].fdTravel]){
						for(var k in travel[params[i].fdTravel]){
							params[i][k] = travel[params[i].fdTravel][k];
						}
					}
				}
			}else{//行程合并，从费用明细中获取数据
				for(var i=0;i<params.length;i++){
					params[i].fdTravelDays = $("[name='fdDetailList_Form["+params[i].index+"].fdTravelDays']").val();
					params[i].fdBerthId = $("[name='fdDetailList_Form["+params[i].index+"].fdBerthId']").val();
					params[i].fdAreaId = $("[name='fdDetailList_Form["+params[i].index+"].fdArrivalPlaceId']").val();
					params[i].fdBeginDate = $("[name='fdDetailList_Form["+params[i].index+"].fdStartDate']").val()||'';
					params[i].fdEndDate = $("[name='fdDetailList_Form["+params[i].index+"].fdHappenDate']").val();
				}
			}
			$.ajax({
				url:Com_Parameter.ContextPath + 'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=getStandardData',
				data:{params:JSON.stringify(params)},
				async:false,
				success:function(rtn){
					rtn = JSON.parse(rtn);
					console.log(rtn)
					if(rtn.result=='failure'){
						dialog.alert(rtn.message);
						return;
					}
					for(var i=0;i<rtn.data.length;i++){
						if(rtn.data[i].dayCount){//如果是按日标准，需要校验当前单中是否重复报销
							var fdExpenseItemId = params[0].fdExpenseItemId;
							var fdSchemeId = rtn.data[i].fdSchemeId;
							var fdBeginDate = params[0].fdBeginDate;
							var fdEndDate = params[0].fdEndDate;
							$("#TABLE_DocList_fdDetailList_Form tr:gt(0)").each(function(index){
								var standard = $(this).find("[name$=fdStandardInfo]").val()||'[]';
								standard = JSON.parse(standard);
								if(rtn.data[i].status=='2'||index>=rtn.data[i].index||standard.length==0){
									return;
								}
								var expense = $(this).find("[name$=fdExpenseItemId]").val();
								var begin = getTravelDate('begin',index);
								var end = getTravelDate('end',index);
								var containsScheme = false;
								for(var k=0;k<standard.length;k++){
									if(standard[k].fdSchemeId==fdSchemeId){
										containsScheme=true;
										break;
									}
								}
								if(isInter(fdBeginDate,fdEndDate,begin,end)&&expense==fdExpenseItemId&&containsScheme){
									rtn.data[i].status='2';
								}
							})
						}
						if(rtn.data[i].monthCount){//如果是月次标准，需要校验当前单中是否重复报销
							var fdExpenseItemId = params[rtn.data[i].index].fdExpenseItemId;
							var fdSchemeId = rtn.data[i].fdSchemeId;
							var month = params[0].fdEndDate.split('\-')[1];
							$("#TABLE_DocList_fdDetailList_Form tr:gt(0)").each(function(index){
								var standard = $(this).find("[name$=fdStandardInfo]").val()||'[]';
								standard = JSON.parse(standard);
								if(rtn.data[i].status=='2'||index>=rtn.data[i].index||standard.length==0){
									return;
								}
								var mon = getTravelDate('end',index);
								if(!mon){
									return;
								}
								mon = mon.split('\-')[1];
								var expense = $(this).find("[name$=fdExpenseItemId]").val();
								var containsScheme = false;
								for(var k=0;k<standard.length;k++){
									if(standard[k].fdSchemeId==fdSchemeId){
										containsScheme=true;
										break;
									}
								}
								if(month==mon&&containsScheme&&fdExpenseItemId==expense){
									rtn.data[i].status='2';
								}
							})
						}
						
						$("[name='fdDetailList_Form["+rtn.data[i].index+"].fdStandardStatus']").val(rtn.data[i].status);
						$("[name='fdDetailList_Form["+rtn.data[i].index+"].fdStandardInfo']").val(rtn.data[i].info);
						var div = $("#TABLE_DocList_fdDetailList_Form>tbody>tr:gt(0)").eq(rtn.data[i].index).find("[id^=standard_status]");
						div.attr("class","budget_container");
						div.addClass("standard_status_"+rtn.data[i].status);
						div.attr("title",lang['py.standard.'+rtn.data[i].status]);
					}
				}
			});
		}
		window.viewInvoiceTemp=function(examineFlag){
    		var index= DocListFunc_GetParentByTagName("TR").rowIndex-1;
    		var fdExpenseTempId=$("[name='fdDetailList_Form["+index+"].fdExpenseTempId']").val();
    		var fdExpenseTempDetailIds=$("[name='fdDetailList_Form["+index+"].fdExpenseTempDetailIds']").val();
    		if(fdExpenseTempId){//是由发票识别生成的，点击查看发票
    			var url = "/fssc/expense/fssc_expense_temp/fsscExpenseTemp.do?method=view&fdId="+fdExpenseTempId+"&fdExpenseTempDetailIds="+fdExpenseTempDetailIds+"&examineFlag="+examineFlag+"&index="+index;
    			window.dia = dialog.iframe(url,lang['button.addInvoice'],
    					function(data) {
		    				if(!data){
								return;
							}else{
								updateExpenseAndInvoice(data,'edit');
							}
    					},
    					{
    						height:'800',
    						width:'1200',
    						"buttons" : [],
    						"content" : {
    									scroll :  false
    							}
    					});
    		}
    	}
		
		/*************************************************************
		 * 明细中添加发票或者编辑发票
		 * ***********************************************************/
		 window.updateExpenseAndInvoice=function(data,method){
				data=JSON.parse(data.replace(/\'/g,'"'));
				//重新给当前明细赋值
				var currentIndex=data.index;
				var valueJson=data.valueJson;
				$("[name='fdDetailList_Form["+currentIndex+"].fdInvoiceMoney']").val(valueJson.fdInvoiceMoney);
				var number=new Map(),n=0;
				$($("#TABLE_DocList_fdInvoiceList_Form [name$=fdInvoiceNumber]")).each(function(){
						number.set($(this).val(),n);
						n++;
					}
				)
				//设置是否抵扣，专票&&配置了对应税率时才需要抵扣
				$("[id='_xform_fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").hide();
				$("[id='_xform_fdDetailList_Form["+currentIndex+"].fdInputTaxRate']").hide();
				$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").attr("validate","currency-dollar");
				$("[name='fdDetailList_Form["+currentIndex+"].fdIsDeduct']").val(false);
				$("[name='_fdDetailList_Form["+currentIndex+"].fdIsDeduct'][value=true]").prop('checked',false);
				$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").val(0);
				$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxRate']").val('');
				$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxRateId']").val('');
				$("[name='fdDetailList_Form["+currentIndex+"].fdNoTaxMoney']").val(valueJson.fdInvoiceMoney);//不含税金额
				var fdInvoiceType = valueJson.fdInvoiceType;
				var fdTaxRate = valueJson.fdTax;
				if(fdInvoiceType=='10100'){//专票
					var data1 = new KMSSData();
					data1 = data1.AddBeanData("fsscBaseInputTaxService&authCurrent=true&multi=true&fdExpenseItemId="+$("[name='fdDetailList_Form["+currentIndex+"].fdExpenseItemId']").val());
					data1 = data1.GetHashMapArray();
					if(data1&&data1.length>0){
						var rate = null;
						for(var k=0;k<data1.length;k++){
							if(fdTaxRate*1==data1[k].fdTaxRate*1){//如果配置了同样的税率，则取该税率
								rate = data1[k];
								break;
							}
						}
//						if(!rate){
//							rate = data1[data1.length-1];
//						}
						$("[id='_xform_fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").show();
						$("[id='_xform_fdDetailList_Form["+currentIndex+"].fdInputTaxRate']").show();
						$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").attr("validate","required  currency-dollar");
						$("[name='fdDetailList_Form["+currentIndex+"].fdIsDeduct']").val(true);
						$("[name='_fdDetailList_Form["+currentIndex+"].fdIsDeduct'][value=true]").prop('checked',true);
						//如果进项税率匹配不上基础数据，进项税率、税额和不含税金额不做计算
						var fdNoTaxMoney = null;
						if(null !== rate){
							fdNoTaxMoney = divPoint(valueJson.fdInvoiceMoney*1,numAdd(1,numDiv(rate.fdTaxRate*1,100)));
							$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxRateId']").val(rate.fdTaxRateId);
							$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").val(valueJson.fdTaxMoney);
							$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxRate']").val(rate.fdTaxRate);
						}else{
							fdNoTaxMoney = valueJson.fdInvoiceMoney*1;
						}
						$("[name='fdDetailList_Form["+currentIndex+"].fdNoTaxMoney']").val(fdNoTaxMoney);//不含税金额
						$("[name='fdDetailList_Form["+currentIndex+"].fdInputTaxMoney']").val(subPoint(valueJson.fdInvoiceMoney*1,fdNoTaxMoney));
					}
				}
				//当前发费用明细发票信息更新，新的发票则新增发票信息
				data=data.params;
				for(var i=0;i<data.length;i++){
					if(number.has(data[i].fdInvoiceNumber)){
						var index=number.get(data[i].fdInvoiceNumber);
						//更新现有发票信息
						$("input[name='fdInvoiceList_Form["+index+"].fdInvoiceType']").parent().find("div[id$='.fdInvoiceType']").html(data[i].fdInvoiceTypeName);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceType']").val(data[i].fdInvoiceType);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val(data[i].fdInvoiceCode);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceDate']").val(data[i].fdInvoiceDate);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val(data[i].fdInvoiceMoney);
						$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(data[i].fdTaxMoney);
						$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(data[i].fdNoTaxMoney);
						//如果是增值税专用发票
						if("10100"==data[i].fdInvoiceType||"true"==data[i].fdIsVat){
							$("[name='_fdInvoiceList_Form["+index+"].fdIsVat']").prop("checked",true);
							$("[name='fdInvoiceList_Form["+index+"].fdIsVat']").val(true);
							if("10100"==data[i].fdInvoiceType){
								FSSC_ChangeIsVat_target($("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").get(0),index);
							}
						}else{
							$("[name='_fdInvoiceList_Form["+index+"].fdIsVat']").prop("checked",false);
							$("[name='fdInvoiceList_Form["+index+"].fdIsVat']").val(false);
							FSSC_ChangeIsVat_target($("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").get(0),index);
						}
						$("[name='fdInvoiceList_Form["+index+"].fdExpenseTypeId']").val(data[i].fdExpenseItemId);
						$("[name='fdInvoiceList_Form["+index+"].fdExpenseTypeName']").val(data[i].fdExpenseItemName);
						$("[name='fdInvoiceList_Form["+index+"].fdTax']").val(data[i].fdTax);
						$("[name='fdInvoiceList_Form["+index+"].fdTax1']").val(data[i].fdTaxId);
						$("[name='fdInvoiceList_Form["+index+"].fdCheckStatus']").val(data[i].fdCheckStatus);
					}else{
						//新增的发票
						var index = $("#TABLE_DocList_fdInvoiceList_Form [name$=fdInvoiceNumber]").length;
						DocList_AddRow("TABLE_DocList_fdInvoiceList_Form");
						FSSC_SetDefaultCompany();
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceTypeName']").val(data[i].fdInvoiceTypeName);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceType']").val(data[i].fdInvoiceType);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").val(data[i].fdInvoiceNumber);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceCode']").val(data[i].fdInvoiceCode);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceDate']").val(data[i].fdInvoiceDate);
						$("[name='fdInvoiceList_Form["+index+"].fdInvoiceMoney']").val(data[i].fdInvoiceMoney);
						$("[name='fdInvoiceList_Form["+index+"].fdTaxMoney']").val(data[i].fdTaxMoney);
						$("[name='fdInvoiceList_Form["+index+"].fdNoTaxMoney']").val(data[i].fdNoTaxMoney);
						$("[name='fdInvoiceList_Form["+index+"].fdCheckStatus']").val(data[i].fdCheckStatus);
						//如果是增值税发票
						if("10100"==data[i].fdInvoiceType||"true"==valueJson.fdIsVat){
							$("[name='_fdInvoiceList_Form["+index+"].fdIsVat']").prop("checked",true);
							$("[name='fdInvoiceList_Form["+index+"].fdIsVat']").val(true);
							if("10100"==data[i].fdInvoiceType){
								FSSC_ChangeIsVat_target($("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").get(0),index);
							}else{//非专票可抵扣
								FSSC_ChangeIsVat_target($("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").get(0),index);
							}
						}else{
							$("[name='_fdInvoiceList_Form["+index+"].fdIsVat']").prop("checked",false);
							$("[name='fdInvoiceList_Form["+index+"].fdIsVat']").val(false);
							FSSC_ChangeIsVat_target($("[name='fdInvoiceList_Form["+index+"].fdInvoiceNumber']").get(0),index);
						}
						$("[name='fdInvoiceList_Form["+index+"].fdExpenseTypeId']").val(data[i].fdExpenseItemId);
						$("[name='fdInvoiceList_Form["+index+"].fdExpenseTypeName']").val(data[i].fdExpenseItemName);
						$("[name='fdInvoiceList_Form["+index+"].fdTax']").val(data[i].fdTax);
						$("[name='fdInvoiceList_Form["+index+"].fdTax1']").val(data[i].fdTaxId);
					}
				}
				clearInvoiceDetail();  //清除页面不存在发票
		 }
		 //保存完发票，按发票号码+发票代码组合清空不存在的发票
		 window.clearInvoiceDetail=function(){
			var invoice_data = new KMSSData();
			invoice_data.UseCache=false;  //不使用缓存，实时查询，因为发票可以一直在修改
			var data = invoice_data.AddBeanData("fsscExpenseTempService&authCurrent=true&type=getDetailInvoice&fdExpenseMainId="+formInitData['fdExpenseMainId']);
			var rtnData = data.GetHashMapArray();
			if(rtnData&&rtnData.length>0){
				var keys=[],indexs=[];
				for(var i=0;i<rtnData.length;i++){
					keys.push(rtnData[i]['key']);
				}
				var invoiceDetailLen=$("#TABLE_DocList_fdInvoiceList_Form").find("input[name$='fdInvoiceNumber']").length;
				for(var i=0;i<invoiceDetailLen;i++){
					var type=$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceType']").val()?$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceType']").val():'';
					var number=$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").val()?$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceNumber']").val():'';
					var code=$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceCode']").val()?$("input[name='fdInvoiceList_Form["+i+"].fdInvoiceCode']").val():'';
					if((type+number+code)&&keys.indexOf(type+number+code)==-1){
						indexs.push(i);
					}
				}
				var del_flag=false;  //明细删除标记，true为删了一行，下次循环的index需要-删除的行数
				var del=0;
				for(var n=0;n<indexs.length;n++){
					var index=indexs[n];
					if(del_flag){
						index=index-del;
					}
					var optTR=$("#TABLE_DocList_fdInvoiceList_Form").find("tr").not(".tr_normal_title")[index];
					DocList_DeleteRow(optTR);
					del_flag=true;
					del++;
				}
			}
		 }
		//增加一行时自动设置默认公司
		window.FSSC_SetDefaultCompany = function(){
			var index = $("#TABLE_DocList_fdInvoiceList_Form>tbody>tr").length-2;
			var fdCompanyId = $("[name=fdCompanyId]").val();
			$("[name='fdInvoiceList_Form["+index+"].fdCompanyId']").val(fdCompanyId);
		}
		window.FSSC_ChangeIsVat_target = function(e,index){
			var tr= DocListFunc_GetParentByTagName("TR",e);
			if(index==null||isNaN(index)){
	    		index = tr.rowIndex - 1;
			}
			var fdInvoiceType = $("[name='fdInvoiceList_Form["+index+"].fdInvoiceType']").val();
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
		window.reCalBudgetMoney=function(index){
			 var fdBudgetMoney = "";
			 var fdBudgetRate = $("[name='fdDetailList_Form["+index+"].fdBudgetRate']").val();
			 var fdApplyMoney = $("input[name='fdDetailList_Form["+index+"].fdApprovedApplyMoney']").val();
			 var fdNoTaxMoney = $("input[name='fdDetailList_Form["+index+"].fdNoTaxMoney']").val();
			 var fdDeduFlag=$("[name='fdDeduFlag']").val();
			 if(fdBudgetRate){
				if("2"==fdDeduFlag&&fdNoTaxMoney){  // 不含税金额
					fdBudgetMoney = (fdNoTaxMoney*fdBudgetRate).toFixed(2);
				}else{
					fdBudgetMoney = (fdApplyMoney*fdBudgetRate).toFixed(2);
				}
			 }
			 $("[name='fdDetailList_Form["+index+"].fdBudgetMoney']").val(fdBudgetMoney);
		 }
});