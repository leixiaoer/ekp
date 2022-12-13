<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
	<template:replace name="body">
<script type="text/javascript">
seajs.use(['theme!form']);
</script>
<script type="text/javascript">
	Com_IncludeFile("docutil.js|calendar.js|dialog.js|doclist.js|optbar.js|jquery.js");
</script>
<script type="text/javascript">
seajs.use(['lui/dialog'], function(dialog){
	window.dialog=dialog;
 });
//标志是否初始化年份
var init_year = false ;
// 设置类型
function setType(obj){
	var fdType = document.getElementById("fdType");
	var deptSelector = document.getElementById("deptSelector");
	var fdDeptId = document.getElementById("fdDeptId");
	var fdDeptName = document.getElementById("fdDeptName");
	var containPerson = document.getElementById("containPerson");
	var containPersonTr = document.getElementById("containPersonTr");
	fdType.value = obj.value;
	if( 1 == fdType.value ){
		containPersonTr.style.display = "none";
		containPerson.disabled = "disabled";
		containPerson.checked = false;
		fdDeptId.value = "";
		fdDeptName.value = "";
		deptSelector.onclick = function(){
			Dialog_Address(true, 'fdDeptId','fdDeptName', ';',ORG_TYPE_DEPT|ORG_TYPE_PERSON|ORG_FLAG_AVAILABLEALL)
			};
		}else{
			fdDeptId.value = "";
			fdDeptName.value = "";
			containPersonTr.style.display = "";
			containPerson.disabled = false;
			deptSelector.style.display = "";
			deptSelector.onclick = function(){
				Dialog_Address(true, 'fdDeptId','fdDeptName', ';',ORG_TYPE_DEPT|ORG_FLAG_AVAILABLEALL)
				};
			}
}
// 年份选择器
function  Year_Select(id,length){ 
	var date = new Date();
	var obj=document.getElementById(id); 
	var year;
	  if(!init_year){
         year = date.getFullYear();
       }else{
    	   year = obj.value;
    	   obj.options.length = 0;
            }
    var tempYear = year;
	for(var i = 0;i<= length;i++){
		if(i==0){
		   //当前年份之前
           for(var j=10;j>0;j--){
        	   var before=new Option(year-j,year-j);
        	       obj.add(before);
               }
			}
		var op=new Option(year,year); 
		year++;
        obj.add(op); 
	   }
	//设置选中的值
	obj.value = tempYear;
	init_year = true;
	}
//月份选择器
function  Month_Select(id){ 
	var date = new Date();
	var obj=document.getElementById(id); 
	for(var i= 1;i<= 12;i++){ 
	var op=new Option(i,i);
	obj.add(op); 
	   } 
	obj.value = date.getMonth()+1;
	}
// 统计函数
function doCount(){
	var fdYear = document.getElementById("fdYear");
	var fdMonth = document.getElementById("fdMonth");
	var fdType = document.getElementById("fdType");
	var fdDeptId = document.getElementById("fdDeptId");
	var containPerson = document.getElementById("containPerson");
	var docSubject = document.getElementById("docSubject");

    // 部门不能为空
    if(!fdDeptId.value||fdDeptId.value ==''){
    	dialog.alert('<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.noNull.dept"/>');
              return false;
          }
	
	var url = "GeesunOitemsCountListingService"
        + "&fdYear=" + encodeURIComponent(fdYear.value)
        + "&fdMonth=" + encodeURIComponent(fdMonth.value)
        + "&fdType=" + encodeURIComponent(fdType.value)
        + "&fdDeptId="+encodeURIComponent(fdDeptId.value)
	    + "&docSubject="+encodeURIComponent(docSubject.value);
	var data = new KMSSData(); 
	    if(2 == fdType.value){
			url = url+"&containPerson="+encodeURIComponent(containPerson.checked);
		}
	    data.SendToBean(url, afterCountListing);
	}
//回调函数
function afterCountListing(rtnData){
	if(rtnData.GetHashMapArray().length >= 1){
		var result = rtnData.GetHashMapArray()[0];
		if(result['result']&&'success'==result['result']){
			    dialog.alert('<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.success"/>');
			}else{
				dialog.alert('<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.failure"/>');
				}
		}
}

$(document).ready(function(){
	Year_Select("fdYear",10);
	Month_Select("fdMonth");
});
</script>
<html:form action="/geesun/oitems/geesun_oitems_listing/geesunOitemsListing.do">
<ui:tabpanel id="geesunOitemsReceiveCountPanel" layout="sys.ui.tabpanel.list" >
	<ui:content id="geesunOitemsReceiveCountContent" title="${ lfn:message('geesun-oitems:geesunOitems.tree.receive.report') }">
		<div style="height:400px;padding:20px">
		<p class="txttitle">
		<bean:message bundle="geesun-oitems" key="geesunOitems.tree.receive.report"/>
		</p>
		<center>
		<table class="tb_normal" width=70%>
			<tr>
			<!-- 名称 -->
			<td class="td_normal_title" width=12% align="center">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.docSubject"/></td>
			<td width="35%" colspan="4">
			<input type="text" id="docSubject" name="docSubject" class="inputsgl" style="width: 70%"><bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.remark"/>
			</td>
			</tr>
			<tr>
			    <!-- 领用年份 -->
				<td class="td_normal_title" width=12% align="center">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.year"/>
				</td><td width="35%" colspan="4">
					 <select id="fdYear" name="fdYear" onchange="Year_Select('fdYear',10)"></select>
								<span class="txtstrong">*</span>
				</td>
			</tr>
			<tr>
			   <!-- 领用月份 -->
				<td class="td_normal_title" width=12% align="center">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.month"/>
				</td><td width="35%" colspan="4">
					 <select id="fdMonth" name="fdMonth"></select>
								<span class="txtstrong">*</span>
				</td>
			</tr>
		      <!-- 选择类型 -->	   
			<tr>
				<td class="td_normal_title" width=12% align="center">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveType"/>
				</td><td width="35%" colspan="4">
				    <div style="float:left">
					 <input type="hidden" id="fdType" name="fdType" value="1">
				     <input type="radio" name="type" value="1" checked="checked" onclick="setType(this);"/>
				     <bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveType.person"/>
					 <input type="radio" name="type" value="2"  onclick="setType(this);"/>
					 <bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveType.dept"/>
					</div>
					 <div id="containPersonTr" style="float:left;padding-left:12px;display: none">
						<input type="checkbox" id="containPerson" disabled="disabled">
						<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.isContainPerson"/>
					</div>
				</td>
			</tr>
			<tr>
			    <!-- 选择部门 -->
				<td class="td_normal_title" width=12% align="center">
					<bean:message bundle="geesun-oitems" key="geesunOitemsMonthReport.receiveDept"/>
				</td><td width="35%" colspan="4">
					<input type="hidden" name="fdDeptId" id="fdDeptId"/> 
					<input type="text" name="fdDeptName" readonly="readonly" class="inputsgl" id="fdDeptName" style="width: 70%">
					<a href="#" style="cursor: hand; text-decoration: underlinel;" id="deptSelector"
					   onclick="Dialog_Address(true, 'fdDeptId','fdDeptName', ';',ORG_TYPE_DEPT|ORG_TYPE_PERSON);"> 
					   <bean:message key="dialog.selectOther" />
					</a><span class="txtstrong">*</span>
				</td>
			</tr>
			<tr>
			    <!-- 操作 -->
				<td width=10% colspan="5" align="center">
					<ui:button text="${lfn:message('geesun-oitems:geesunOitems.tree.reporting') }" order="2" onclick="doCount();">
				    </ui:button>
				</td>    
			</tr>
		</table>
		</div>
	</ui:content>
</ui:tabpanel>	
</center>
</html:form>
	</template:replace>
</template:include>
