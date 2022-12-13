<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do" styleId="kmOitemsListingForm">

<script type="text/javascript">
Com_AddEventListener(document,"keydown",function(){
	var eventObj = Com_GetEventObject();
	var keyCode = eventObj.keyCode;  
    if (keyCode == 13) {   
    	var clickObj = document.getElementById("ok_id"); 		  
		 	 clickObj.click();
    }   
});
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
 });
window.onload =function (){
	setTimeout(dyniFrameSize,100);
}; 
	function dyniFrameSize() {
	try {
		// 调整高度
		var arguObj = document.getElementById("contentDiv");
		if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
			window.frameElement.style.height = (arguObj.offsetHeight + 40) + "px";
		}
	} catch (e) {}
};
</script>
<script type="text/javascript">
//计算值
function count(obj,obj2,obj3){
	if(obj2.value.match("^-{0,1}[0-9]+$")==null&&obj2.value.length>0&&obj3==1){
		dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.please.integer.negative"/>');
		 obj2.value=0;
		 return false; 
	 }else{
		 var fdNumber = document.getElementsByName("fdNumber"+obj)[0].value ; 
		 var fdAmount = document.getElementsByName("fdAmount"+obj)[0].value ; 
		 if(parseInt(fdNumber)+parseInt(fdAmount)<0){
			 dialog.alert("减库存不能大于当前库存量!");
			 return false; 
		 }
		 if(obj2.value != ''&& obj2.value != '0'){
			 document.getElementsByName("List_Selected")[obj].checked="true";
		 }
	 }
	 if(obj2.value.match("^[.0-9]+$")==null&&obj2.value.length>0&&obj3==2){
		 dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.please.float"/>');
		 obj2.value=0;
		 return false; 
	 }
	var fdNumber = document.getElementsByName("fdNumber"+obj)[0].value ; 
	var fdPrice = document.getElementsByName("fdPrice"+obj)[0].value ; 
	var fdAccountPrice = document.getElementsByName("fdAccountPrice"+obj)[0] ; 
	if(fdNumber.length>0&&fdPrice.length>0){
		fdAccountPrice.value = formatnumber((fdNumber*fdPrice).toString(),false,1,true);
	}
}

//格式化数字精度
function formatnumber(fnumber,fdivide,fpoint,fround){

    var ff = fnumber.substr(0, 1);
    var fnum = fnumber + '';
    if(ff == "-")fnum = fnum.substr(1);
    var revalue="";

    if(fnum==null){
        for(var i=0;i<fpoint;i++)revalue+="0";
        return "0."+revalue;
    }
    fnum = fnum.replace(/^\s*|\s*$/g,'');
    if(fnum==""){
        for(var i=0;i<fpoint;i++)revalue+="0";
        return "0."+revalue;
    }

    fnum=fnum.replace(/,/g,"");

    if(fround){
        var temp = "0.";
        for(var i=0;i<fpoint;i++)temp+="0";
        temp += "5";

        fnum = Number(fnum) + Number(temp);
        fnum += '';
    }

    var arrayf=fnum.split(".");

    if(fdivide){
        if(arrayf[0].length>3){
            while(arrayf[0].length>3){
                revalue=","+arrayf[0].substring(arrayf[0].length-3,arrayf[0].length)+revalue;
                arrayf[0]=arrayf[0].substring(0,arrayf[0].length-3);
            }
        }
    }
    revalue=arrayf[0]+revalue;

    if(arrayf.length==2&&fpoint!=0){
        arrayf[1]=arrayf[1].substring(0,(arrayf[1].length<=fpoint)?arrayf[1].length:fpoint);

        if(arrayf[1].length<fpoint)
            for(var i=0;i<fpoint-arrayf[1].length;i++)arrayf[1]+="0";
        revalue+="."+arrayf[1];
    }else if(arrayf.length==1&&fpoint!=0){
        revalue+=".";
        for(var i=0;i<fpoint;i++)revalue+="0";
    }

    return ff == "-" ? "-" + revalue : revalue;
}

</script>

<%-- <ui:tabpanel id="kmOitemsShowRecordListPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsShowRecordListContent" title="${ lfn:message('km-oitems:kmOitems.tree.stock.manage2') }"> --%>
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<table width="100%"  class="tb_normal" style="table-layout:fixed;">
				<tr style="background-color:#d8e9fd" height="30px" >		
						<td width="4%"><input type="checkbox" name="List_Tongle" onclick="window.parent.checkAll_Selected();"></td>
						<td width="5%"><bean:message key="page.serial"/></td> 
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
						</td>
						<td width="14%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/>
						</td>
						<td width="10%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdCategoryId"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdSpecification"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdBrand"/>
						</td>
						<td width="6%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdUnit"/>
						</td>
						<td width="10%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdReferencePrice.inprice.last"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsListing.fdAmount"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdNumber"/>
						</td>
						<td width="8%">
							<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdPrice"/>
						</td>
						<td width="14%">
							<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.fdAccountPrice"/>
						</td>
				
				</tr>
				<c:forEach items="${rtnList}" var="kmOitemsListing" varStatus="vstatus">		
					<tr height="30px" 
						kmss_href="<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do" />?method=view&fdId=${kmOitemsListing.fdId}">
						<td>
							<input type="checkbox" name="List_Selected" data-index="${vstatus.index}" value="${kmOitemsListing.fdId}_${vstatus.index}">
						</td>
						<td>${vstatus.index+1}</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdNo}">
							<c:out value="${kmOitemsListing.fdNo}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title="${kmOitemsListing.fdName}">
							<c:out value="${kmOitemsListing.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title="${kmOitemsListing.fdCategory.fdName}">
							<c:out value="${kmOitemsListing.fdCategory.fdName}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdSpecification}">
							<c:out value="${kmOitemsListing.fdSpecification}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdBrand}">
							<c:out value="${kmOitemsListing.fdBrand}" />
						</td>
						<td style="text-overflow:ellipsis;overflow:hidden;white-space: nowrap;"
						title = "${kmOitemsListing.fdUnit}">
							<c:out value="${kmOitemsListing.fdUnit}" />
						</td>
						<td style="overflow:hidden;white-space: nowrap;"
						title = "<kmss:showNumber value="${kmOitemsListing.fdReferencePrice }" pattern="0.00#"/>">
							<kmss:showNumber value="${kmOitemsListing.fdReferencePrice }" pattern="0.00#"/>
						</td>
						<td>
						    <input  style="width:90%;border:0" type="text" name="fdAmount${vstatus.index}" readonly="readonly" value="${kmOitemsListing.fdAmount}">
						</td>
						<td>
							<input class="inputsgl" style="width:90%" type="text" name="fdNumber${vstatus.index}" onblur="count(${vstatus.index},this,1);">
						</td>
						<td>
							<input class="inputsgl" style="width:90%" type="text" name="fdPrice${vstatus.index}" value="<kmss:showNumber value="${kmOitemsListing.fdReferencePrice}" pattern="0.00#"/>" onblur="count(${vstatus.index},this,2);">
						</td>
						<td>
						    <xform:text property="fdAccountPrice${vstatus.index}" showStatus="readOnly" style="border:0;width:90%"></xform:text>
						</td>
					</tr>
				</c:forEach>
			</table>
			</div>
			</center>
		</div>
	<%-- </ui:content>
</ui:tabpanel>	 --%>	


</html:form>
	</template:replace>
</template:include>