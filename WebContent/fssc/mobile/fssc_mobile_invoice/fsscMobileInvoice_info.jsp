<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

   		<div class="ld-remember-invoiceInfo">
            <div class="ld-remember-invoiceInfo-title">
                <h3>${lfn:message('fssc-mobile:table.invoices')}</h3>
                <i></i>
            </div>
            	<c:forEach items="${invoices}" var="list">
		            <ul>
		                <li>
		                    <div class="ld-remember-invoiceInfo-top" >
		                        <div>
		                            <img src="../resource/images/specialTicket.png" alt=""><span>${list.title}</span>
		                             <c:if test="${list.state=='0'}">
		                            	<span class="ld-remember-invoiceInfo-top-satuts">${lfn:message('fssc-mobile:invoice.satuts.0')}</span>
		                            </c:if>
		                             <c:if test="${list.state=='1' }">
		                            	<span class="ld-remember-invoiceInfo-top-satuts">${lfn:message('fssc-mobile:invoice.satuts.1')}</span>
		                            </c:if>
		                             <c:if test="${ empty list.state }">
		                            	<span class="ld-remember-invoiceInfo-top-satuts">${lfn:message('fssc-mobile:invoice.satuts.2')}</span>
		                            </c:if>
		                            
		                             <c:if test="${list.fdDeductible=='0' ||  empty list.fdDeductible}">
		                            	<span class="ld-remember-invoiceInfo-top-satuts">${lfn:message('fssc-mobile:invoice.fdDeductible.0')}</span>
		                            </c:if>
		                             <c:if test="${list.fdDeductible=='1' }">
		                            	<span class="ld-remember-invoiceInfo-top-satuts">${lfn:message('fssc-mobile:invoice.fdDeductible.1')}</span>
		                            </c:if>
		                            
		                        </div>
		                        <i onclick="deleteInvoice('${list.id}')"></i>
		                    </div>
		                    <div class="ld-remember-invoiceInfo-bottom"  onclick="editInvoice('${list.id}')">
		                        <span>${list.invoiceNo}</span>
		                        <span>???${list.value}</span>
		                    </div>
		                </li>
		            </ul>
	            </c:forEach>
	            
            <div class="ld-remember-invoiceInfo-btn">
                <i></i><span>${lfn:message('fssc-mobile:fsscExpenseMain.addInvice')}</span>
            </div>
	  </div>
<script type="text/javascript">

//??????
function editInvoice(id){
	var fdModelName =$("[name='fdModelName']").val();
	var fdModelId =$("[name='fdModelId']").val();
	var formMethod =$("[name='method_GET']").val();
	var fdCostCenterName = $("[name='fdCostCenterName']").val();
	
	window.open("${LUI_ContextPath}/fssc/mobile/fssc_mobile_invoice/fsscMobileInvoice.do?method=view&fdId="+id+"&fdModelName="+fdModelName+"&fdModelId="+fdModelId+"&formMethod="+formMethod, '_self');

}

//??????
function deleteInvoice(fdId){
	 var fdModelId = $("[name='fdModelId']").val();
	 $.ajax({
			 url:Com_Parameter.ContextPath+"fssc/mobile/fssc_mobile_invoice/fsscMobileInvoice.do?method=delete&fdId="+fdId,
	         type: 'POST', 
	         dataType:"json",
	         data:{fdModelId:fdModelId},
	         async:false,    //???????????????   async. ?????????true?????????????????????
         }).success(function (data) {
        	 var rtn = data;
        	 if(data.result=='success'){
        		 alert("???????????????");
        		 window.location.reload();
        	 } else {
        		 alert("???????????????");
        		 window.location.reload();
        	 }
         }).error(function () {
             console.log("????????????");
     	})
}

//??????
$('.ld-remember-invoiceInfo-btn').click(function(){
	var fdModelName =$("[name='fdModelName']").val();
	var fdModelId =$("[name='fdModelId']").val();
	var formMethod =$("[name='method_GET']").val();
	window.open( "${LUI_ContextPath}/fssc/mobile/fssc_mobile_invoice/fsscMobileInvoice.do?method=add&fdModelName="+fdModelName+"&fdModelId="+fdModelId+"&formMethod="+formMethod, '_self');
});

</script>
