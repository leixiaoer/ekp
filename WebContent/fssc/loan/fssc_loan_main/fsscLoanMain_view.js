seajs.use(['lui/jquery','lui/dialog','lui/dialog_common','lui/util/str','lang!fssc-loan'], function($, dialog, dialogCommon,strutil,lang){
	if(window.navigator.userAgent.toLowerCase().indexOf("msie")>-1
			||window.navigator.userAgent.toLowerCase().indexOf("trident")>-1){//IE
				setTimeout(function(){initData();},3000);
		}else{//非IE
			LUI.ready(function(){
				initData();
			});
		};
		window.initData=function(){
			var loanMoney=$("input[name='fdLoanMoney']").val();
			$("#fdLoanUpperMoney").html(FSSC_MenoyToUppercase(loanMoney));
		}
	window.loanToRepayment=function(){
    	dialog.simpleCategoryForNewFile('com.landray.kmss.fssc.loan.model.FsscLoanReCategory', '/fssc/loan/fssc_loan_repayment/fsscLoanRepayment.do?method=add&i.docTemplate=!{id}&fdLoanId='+Com_GetUrlParameter(location.href, 'fdId'),
    			false,null,null,getValueByHash("docTemplate"));
	};
	function getValueByHash(key){
        var value = Com_GetUrlParameter(location.href, 'q.'+key);
        if(value){
            return value;
        }
        var hash = window.location.hash;
        if(hash.indexOf(key)<0){
            return "";
        }
        var url = hash.split("cri.q=")[1];
            var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
        var r=url.match(reg);
        if(r!=null){
            return unescape(r[2]);
        }
        return "";
    }
});
