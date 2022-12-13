seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/util/env','lang!fssc-ledger','lang!'], function($, dialog , topic,env,lang,comlang) {
	if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1
			||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
		setTimeout(function(){initData();},3000);
	}else{//非IE
		LUI.ready(function(){
			initData();
		});
	};

	window.initData = function(){
		var fdContractType=$("[name='fdContractType']").val();
		var validate=$("input[name='fdContractAmount']").attr("validate");
		if(fdContractType == 1){
			$(".div1").attr("style","display:none;");
			//定额合同，合同金额必填
			$("input[name='fdContractAmount']").attr("validate",validate+" required");
			$("input[name='fdContractAmount']").parent().find('span').show();
		} else {
			$(".div1").attr("style","");
			//框架合同，合同金额非必填
			$("input[name='fdContractAmount']").attr("validate",validate.replace('required',''));
			$("input[name='fdContractAmount']").parent().find('span').hide();
		}
	}
	
	Com_AddEventListener(window,'load',function(){
		//新建默认新增一行付款条件
		var method=$("[name='method_GET']").val();
		setTimeout(function(){
			if(method=='add'){
				FSSC_AddClauseDetail();
			}
		},500);
	})
	
	//增加一行付款条件
	window.FSSC_AddClauseDetail = function(){
		DocList_AddRow('TABLE_DocList_fdDetailList_Form');
	}
	//根据合同编号查找合同
	window.changeCode = function(){
		var fdContractCode = $("[name=fdContractCode]").val();
		if(!fdContractCode){
			return false;
		}
		$.post(
			env.fn.formatUrl('/fssc/ledger/fssc_ledger_contract/fsscLedgerContract.do?method=findContractByCode&fdCode='+fdContractCode),
			function(msg) {
				var msgs=JSON.parse(msg);
                if("error"==msgs.value){
                	dialog.alert(lang['message.fsscLedgerContract.fdContractCode.isExist']);
                	// 清空值
					$("[name=fdContractCode]").val("");
        			return false;
				}
			}
		);
	}
	
	//提示校验 "合同生效日期不能早于签约日期"
	window.checkDate = function(){
		var fdSignDate = $('input[name="fdSignDate"]').val();
		var fdEffectDate = $('input[name="fdEffectDate"]').val();
		var time1 = new Date(fdSignDate.replace(/\-/gi,"/")).getTime();
		var time2 = new Date(fdEffectDate.replace(/\-/gi,"/")).getTime();	
		if(time1 != null && time1 != "" && time2 != null && time2 != ""){
			if(time2<time1){
				dialog.alert(lang['fsscLedgerContract.fdEffectDate.IsEarly']);
				$('input[name="fdEffectDate"]').val("");
				return false;
			}
		}
	}
	//定额合同不需要单价
	window.Fs_fdContractTypeIsPrice = function(v){
		if(v == "1"){
			$(".div1").attr("style","display:none;");
			$("[name='fdPrice']").val("");
			$(".class1").attr("style","color:#FF0000;");
			$(".class1").show();
			$("[name='fdContractAmount']").attr("validate", "currency-dollar min(0) required");
		} else {
			$(".div1").attr("style","");
			$("[name='fdContractAmount']").attr("validate", "currency-dollar min(0)");
			$(".class1").attr("style","display:none;");
		}
	}
	//根据付款比例得到付款金额
	window.FS_getFdMoneyByPaymentRatio = function() {
		var method=$("[name='method_GET']").val();
		var v = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var fdContractAmount = Number($("[name='fdContractAmount']").val());
		var fdPaymentRatio = Number($("input[name='fdDetailList_Form["+v+"].fdPaymentRatio']").val());
		var paymentTotal = 0; //计算付款总额(不算最后一行)
		var ratioTotal = 0;
		var fdPaymentAmount = 0;
		if(fdPaymentRatio > 0 && fdContractAmount > 0) {
			$("input[name='fdDetailList_Form["+v+"].fdPaymentAmount']").val((fdContractAmount * fdPaymentRatio / 100).toFixed(2));
			fdPaymentAmount = $("input[name='fdDetailList_Form["+v+"].fdPaymentAmount']").val();
			for(var i=0 ; i<v+1; i++){
				if(i>0){
					paymentTotal = addPoint(paymentTotal, $("input[name='fdDetailList_Form["+(i-1)+"].fdPaymentAmount']").val());	//付款金额合计(不包括最后一行)
				}
				var ratio = Number($("input[name='fdDetailList_Form["+i+"].fdPaymentRatio']").val());
				ratioTotal = addPoint(ratioTotal, ratio);	//付款比例合计
				if(ratioTotal == 100) {	//付款比例为100%时,最后一行付款金额 = 合同金额 - 上面合计
					$("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val(subPoint(fdContractAmount, paymentTotal));
					fdPaymentAmount = $("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val();
				}
			}
		}
		if(method=='add'){
			$("input[name='fdDetailList_Form["+v+"].fdLeftMoney']").val(fdPaymentAmount);	//新建时剩余应付金额=付款金额
			$("input[name='fdDetailList_Form["+v+"].fdPaymentMoney']").val('0.00');	//已付金额 0
		} else {
			var fdPaymentMoney = $("input[name='fdDetailList_Form["+v+"].fdPaymentMoney']").val();	//已付金额
			$("input[name='fdDetailList_Form["+v+"].fdLeftMoney']").val(subPoint(fdPaymentAmount, fdPaymentMoney)); //剩余应付金额=付款金额-已付金额
		}
	}
	//根据付款金额得到付款比例
	window.Fs_getFdPaymentAmount = function() {
		var method=$("[name='method_GET']").val();
		var v = DocListFunc_GetParentByTagName('TR').rowIndex-1;
		var fdContractAmount = Number($("[name='fdContractAmount']").val());
		var fdPaymentAmount = Number($("input[name='fdDetailList_Form["+v+"].fdPaymentAmount']").val());
		if(fdPaymentAmount > 0 && fdContractAmount > 0){
			if(getPayAmount()==fdContractAmount){
				$("input[name='fdDetailList_Form["+v+"].fdPaymentRatio']").val((100-getPayAmount(v)).toFixed(2));
			}else{
				$("input[name='fdDetailList_Form["+v+"].fdPaymentRatio']").val((fdPaymentAmount / fdContractAmount * 100).toFixed(2));
			}
			
		}
		if(method=='add'){
			$("input[name='fdDetailList_Form["+v+"].fdLeftMoney']").val(fdPaymentAmount);	//新建时剩余应付金额=付款金额
			$("input[name='fdDetailList_Form["+v+"].fdPaymentMoney']").val('0.00');	//已付金额 0
		} else {
			var fdPaymentMoney = $("input[name='fdDetailList_Form["+v+"].fdPaymentMoney']").val();	//已付金额
			$("input[name='fdDetailList_Form["+v+"].fdLeftMoney']").val(subPoint(fdPaymentAmount, fdPaymentMoney)); //剩余应付金额=付款金额-已付金额
		}
	}
	
	//计算总额
	window.getPayAmount = function(v,flag){
		var fdContractAmount = Number($("[name='fdContractAmount']").val());
		var total = 0;//计算付款总额
		var table = document.getElementById("TABLE_DocList_fdDetailList_Form");
		var rows1 = table.rows;
		var trCount = rows1.length;
		var fdPaymentRatio = 0;
		for ( var i = 0; i<trCount-1; i++) {
			var fdAmount = $("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val();
			if(v !=i ){
				fdPaymentRatio = addPoint(fdPaymentRatio, $("input[name='fdDetailList_Form["+i+"].fdPaymentRatio']").val());
			}
			total = (total*1.0) + (fdAmount*1.0);
		}
		total = Number((total*1.0).toFixed(2));
		if(v){
			return fdPaymentRatio;
		}else {
			return total;
		}
	};
	
	//改变合同金额同步改变明细的付款金额
	window.FS_changeFdContractAmount = function() {
		var method=$("[name='method_GET']").val();
		var fdContractAmount = Number($("input[name='fdContractAmount']").val());
		var fdPayedAmount = Number($("input[name='fdPayedAmount']").val());  //已付
		var fdPayingAmount = Number($("input[name='fdPayingAmount']").val());  //付款中
		//根据金额重新计算，当合同台账变更时
		if(fdPayedAmount + fdPayingAmount <= fdContractAmount){
			$("[name='fdUnpayAmount']").parent().html(Number(fdContractAmount-fdPayedAmount-fdPayingAmount).toFixed(2)+' <input name="fdUnpayAmount" value="'+Number(fdContractAmount-fdPayedAmount-fdPayingAmount).toFixed(2)+'" type="hidden">');
		}
		
		//编辑时,定额合同总额不允许小于已付和付款中的金额
		if(method=='edit' && $("[name='fdContractType']").val()=='1'){
			if(fdPayedAmount + fdPayingAmount > fdContractAmount){
				dialog.alert(lang['message.fdContractAmount.isWrong']);
				$("input[name='fdContractAmount']").val("");
				return;
			}
		}
		var total = 0;
		var table = document.getElementById("TABLE_DocList_fdDetailList_Form");
		var rows1 = table.rows;
		var trCount = rows1.length;
		var ratioTotal = 0;	//付款比例合计
		var paymentTotal = 0;	//付款金额合计(不算最后一行)
		for ( var i = 0; i<trCount-1; i++) {
			var fdPaymentRatio = Number($("input[name='fdDetailList_Form["+i+"].fdPaymentRatio']").val());
			if(fdPaymentRatio > 0) {
				$("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val((fdContractAmount * fdPaymentRatio / 100).toFixed(2));
				var fdPaymentAmount = $("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val();
				if(i>0){
					paymentTotal = addPoint(paymentTotal, $("input[name='fdDetailList_Form["+(i-1)+"].fdPaymentAmount']").val());	//付款金额合计(不包括最后一行)	
				}
				ratioTotal = addPoint(ratioTotal, fdPaymentRatio);	//付款比例合计
				if(ratioTotal == 100) {	//付款比例为100%时,最后一行付款金额 = 合同金额 - 上面合计
					$("input[name='fdDetailList_Form["+(trCount-2)+"].fdPaymentAmount']").val(subPoint(fdContractAmount, paymentTotal));
					fdPaymentAmount = $("input[name='fdDetailList_Form["+(trCount-2)+"].fdPaymentAmount']").val();
				}
				if(method=='add'){
					$("input[name='fdDetailList_Form["+i+"].fdLeftMoney']").val(fdPaymentAmount);	//新建时剩余应付金额=付款金额
					$("input[name='fdDetailList_Form["+i+"].fdPaymentMoney']").val('0.00');	//已付金额 0
				} else {
					var fdPaymentMoney = $("input[name='fdDetailList_Form["+i+"].fdPaymentMoney']").val();	//已付金额
					$("input[name='fdDetailList_Form["+i+"].fdLeftMoney']").val(subPoint(fdPaymentAmount, fdPaymentMoney)); //剩余应付金额=付款金额-已付金额
				}
			}
		}
	}
	//校验金额是否相等，框架合同不用校验
	window.validateMoney = function(form,method) {
		var fdContractType = $("[name='fdContractType']").val();
		if(fdContractType == "2"){
			var validateResult = true;
		} else {
			var validateResult = validateAmount();
		}
		if(validateResult == true) {
			Com_Submit(form,method); 
		} else {
			return false;
		}
	}
	//校验付款金额
	window.validateAmount = function(){
		var fdContractAmount = Number($("[name='fdContractAmount']").val());
		var total = 0;//计算付款总额
		var table = document.getElementById("TABLE_DocList_fdDetailList_Form");
		var rows1 = table.rows;
		var trCount = rows1.length;
		for ( var i = 0; i<trCount-1; i++) {
			var fdAmount = $("input[name='fdDetailList_Form["+i+"].fdPaymentAmount']").val();
			total = (total*1.0) + (fdAmount*1.0);
		}
		total = Number((total*1.0).toFixed(2));
		if(fdContractAmount > 0 && fdContractAmount != total) {
			dialog.alert(lang['fdContractAmount.isNotEquals.fdPaymentAmountTotal']);
			return false;
		}
		return true;
	};
});