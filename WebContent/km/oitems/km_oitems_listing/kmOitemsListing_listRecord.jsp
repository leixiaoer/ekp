<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js");
</script>
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

			
		//查询条件
		function findOitems(){
			var fdCategoryId = document.getElementsByName("fdCategoryId")[0].value ; 
			var fdCategoryName = document.getElementsByName("fdCategoryName")[0].value;
			var fdOitemsName = document.getElementsByName("fdOitemsName")[0].value ; 
			var fdOitemsNumber = document.getElementsByName("fdOitemsNumber")[0].value ; 
			//Com_Submit(document.kmOitemsListingForm, 'recordList');
			//Com_OpenWindow('<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do" />?method=recordList&categoryId='+fdCategoryId+'&categoryName='+fdCategoryName+'&fdOitemsName='+fdOitemsName+'&fdOitemsNumber='+fdOitemsNumber,'_self');
			document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=recordList" />&fdCategoryId='+fdCategoryId+'&fdCategoryName='+encodeURIComponent(fdCategoryName)
			+'&fdOitemsName='+encodeURIComponent(fdOitemsName)+'&fdOitemsNumber='+encodeURIComponent(fdOitemsNumber);
		}
		
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
					 document.getElementById('listIframe').contentWindow.document.getElementsByName("List_Selected")[obj].checked="true";
				 }
			 }
			 if(obj2.value.match("^[.0-9]+$")==null&&obj2.value.length>0&&obj3==2){
				 dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsWarehousingRecord.please.float"/>');
				 obj2.value=0;
				 return false; 
			 }
			var fdNumber = document.getElementById('listIframe').contentWindow.document.getElementsByName("fdNumber"+obj)[0].value ; 
			var fdPrice = document.getElementById('listIframe').contentWindow.document.getElementsByName("fdPrice"+obj)[0].value ; 
			var fdAccountPrice = document.getElementById('listIframe').contentWindow.document.getElementsByName("fdAccountPrice"+obj)[0] ; 
			if(fdNumber.length>0&&fdPrice.length>0){
				fdAccountPrice.value = formatnumber((fdNumber*fdPrice).toString(),false,1,true);
			}
		}
		
		function checkList_Selected(){
			var check=document.getElementById('listIframe').contentWindow.document.getElementsByName("List_Selected");
			var boolean = false ; 
			for(var i=0;i<check.length;i++){
				if (check[i].checked){
					boolean = true ;
				}
			}
			if(boolean == false){
				dialog.alert('<bean:message  bundle="km-oitems" key="kmOitemsListing.please.checked"/>');
				return false  ;
			}else{
				return true ;
			}
		
		}
		
		function checkAll_Selected(){
			var check=document.getElementById('listIframe').contentWindow.document.getElementsByName("List_Selected");
			var List_Tongle=document.getElementById('listIframe').contentWindow.document.getElementsByName("List_Tongle")[0];
			if(List_Tongle.checked==true){
				for(var i=0;i<check.length;i++){
					check[i].checked = true ;
				}		
			}else{
				for(var i=0;i<check.length;i++){
					check[i].checked = false ;
				}
			}
		};

	function clear_value(){
			document.getElementsByName("fdCategoryId")[0].value = "";
			document.getElementsByName("fdCategoryName")[0].value = "";
			document.getElementsByName("fdOitemsName")[0].value = "";
			document.getElementsByName("fdOitemsNumber")[0].value = "";
			//location.href="${LUI_ContextPath }/km/oitems/km_oitems_listing/kmOitemsListing.do?method=showRecordList";
			document.getElementById("listIframe").src = '<c:url value="/km/oitems/km_oitems_listing/kmOitemsListing.do?method=recordList" />';
	}

	//add by liushengbin date:2010-04-27增加判断单价不能为空后，再提交
	function Com_btnSubmit(){
		
		var check=document.getElementById('listIframe').contentWindow.document.getElementsByName("List_Selected");
		for(var i=0;i<check.length;i++){
			if (check[i].checked){
				var numObj = document.getElementById('listIframe').contentWindow.document.getElementsByName("fdNumber"+check[i].getAttribute("data-index"))[0];
				if(numObj.value==""|| numObj == null || numObj == "undefined"){
					dialog.alert("入库数量不能为空!");
					return false;
				}
				var priceObj = document.getElementById('listIframe').contentWindow.document.getElementsByName("fdPrice"+check[i].getAttribute("data-index"))[0];
				if(priceObj.value==""|| priceObj == null || priceObj == "undefined"){
					dialog.alert("入库单价不能为空！");
					return false;
				}
			}
		}	

		var url = "${LUI_ContextPath}/km/oitems/km_oitems_listing/kmOitemsListing.do?method=importOitems";
		$.ajax({
			url: url,
			type: 'POST',
			dataType: 'json',
			async: false,
			data: $("#listIframe").contents().find("#kmOitemsListingForm").serialize(),
			success: function(data, textStatus, xhr) {//操作成功
				dialog.alert('<bean:message key="return.optSuccess" />');
				findOitems();
			}
		});
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
	window.onload =function (){
		setTimeout(dyniFrameSize,100);
	}; 
	function dyniFrameSize() {
		try {
			// 调整高度
			var arguObj = document.getElementById("contentDiv");
			if (arguObj != null && window.frameElement != null && window.frameElement.tagName == "IFRAME") {
				window.frameElement.style.height = (arguObj.offsetHeight + 40) + "px";
				if("${success}"=="true"){
					dialog.alert('<bean:message key="return.optSuccess" />');
				}
			}
		} catch (e) {}
	}; 
</script>
<html:form action="/km/oitems/km_oitems_listing/kmOitemsListing.do">

<ui:tabpanel id="kmOitemsShowRecordListPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="kmOitemsShowRecordListContent" title="${ lfn:message('km-oitems:kmOitems.tree.stock.manage2') }">
		<div id="contentDiv" style="width:95%;min-height:500px;padding: 20px">
			<div style="float:right;padding-right:30px">
					<ui:button text="${lfn:message('button.update') }" order="2" onclick="if(!checkList_Selected())return;Com_btnSubmit();">
					</ui:button>&nbsp;
					<ui:button text="${lfn:message('km-oitems:kmOitemsWarehousingRecord.down') }" order="2" onclick="Com_OpenWindow('${LUI_ContextPath}/km/oitems/km_oitems_listing/kmOitemsListing.do?method=downloadExcel');">
					</ui:button>&nbsp;
					<ui:button text="${lfn:message('km-oitems:kmOitemsWarehousingRecord.import') }" order="2" 
					    onclick="Com_OpenWindow('${LUI_ContextPath}/km/oitems/km_oitems_listing/km_oitems_listing_Upload.jsp');">
					</ui:button>
			</div>
			<center>
			<div style="width:98%;padding-top:35px">
			<table width="70%" class="tb_normal"  >
				<tr>
				    <td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdName"/> 
					</td>
					<td><input class="inputsgl" type="text" name="fdOitemsName" style="width:95%" value="${lfn:escapeHtml(fdOitemsName)}"></td>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="kmOitemsListing.fdNo"/>
					</td>
					<td><input class="inputsgl" type="text" style="width:95%" name="fdOitemsNumber" value="${lfn:escapeHtml(fdOitemsNumber)}"></td>			
				</tr>
				<tr>
					<td class="td_normal_title"><bean:message  bundle="km-oitems" key="table.kmOitemsManage"/>
					</td>
					<td colspan="3">
					   <xform:dialog propertyId="fdCategoryId" propertyName="fdCategoryName" style="width:98%" showStatus="edit" idValue="${fdCategoryId}" >
					         Dialog_SimpleCategory('com.landray.kmss.km.oitems.model.KmOitemsManage','fdCategoryId','fdCategoryName',true);
					    </xform:dialog>
		            </td>
				</tr>
			</table>
			</div>
			<br/>
				
				    <ui:button id="ok_id" text="${lfn:message('km-oitems:kmOitems.button.search') }" order="2" onclick="findOitems();">
				    </ui:button>&nbsp;&nbsp;
				    <ui:button text="${lfn:message('km-oitems:kmOitems.button.clear') }" order="2" onclick="clear_value();">
					</ui:button>
				
			<br/><br/>
			<div style="width:98%" id="hehe">
			
			<div>
				<iframe id="listIframe" width=100% height=100% frameborder=0  scrolling=no ></iframe>
			</div>
			
			</div>
			</center>
		</div>
	</ui:content>
</ui:tabpanel>		


</html:form>
	</template:replace>
</template:include>