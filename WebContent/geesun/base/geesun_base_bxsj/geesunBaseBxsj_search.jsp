<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.util.DateUtil,java.util.Date,java.util.Calendar"%>
<%-- <%
	Calendar c = Calendar.getInstance();
	int month = c.get(Calendar.MONTH);
	int year = c.get(Calendar.YEAR);
	String fdNowMonth = "1" + String.valueOf(year);
	if (month < 10) {
		fdNowMonth += "0" + month;
	}
	request.setAttribute("nowMonth", fdNowMonth + "00");
%> --%>
<template:include ref="default.simple" sidebar="no" spa="true">
		<template:replace name="body">
		<script type="text/javascript" src="${KMSS_Parameter_StylePath}resource/js/jquery.js"></script>
		<script type="text/javascript">
	//页面初始化
	 $(document).ready(function(){ 
		doSerch();
	 }); 
	
	//键盘事件监听
	if (document.addEventListener) {//如果是Firefox      
		document.addEventListener("keypress", handler, true);  
	} else {  
		document.attachEvent("onkeypress", handler);  
	}  

	//回车事件，查询	 
	function handler(evt) {  
		if (evt.keyCode == 13) {  
			doSerch();  
		 }  
	}

	//搜索
	function doSerch(){
		var subject = document.getElementsByName("subject")[0].value;
		var number = document.getElementsByName("number")[0].value;
		var beginDate = document.getElementsByName("fdBeginDate")[0].value;
		var endDate = document.getElementsByName("fdEndDate")[0].value;
		var status = $("select[name='status']").find("option:selected").val();
		var type = $("select[name='type']").find("option:selected").val();
		/* var fdMonth = $("select[name='fdMonth']").find("option:selected").val(); */
		var url="<c:url value='/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=listQuery'/>"; 
		if(subject.length>0){
			url = url+"&subject="+encodeURIComponent(subject);
		}
		if(number.length>0){
			url = url+"&number="+encodeURIComponent(number);
		}
		if(status.length>0){
			url = url+"&status="+encodeURIComponent(status);
		}
		if(type.length>0){
			url = url+"&type="+encodeURIComponent(type);
		}
		if(beginDate.length>0){
			url = url+"&beginDate="+encodeURIComponent(beginDate);
		}
		if(endDate.length>0){
			url = url+"&endDate="+encodeURIComponent(endDate);
		}
		/* if(fdMonth && fdMonth.length>0){
			url = url+"&fdMonth="+encodeURIComponent(fdMonth);
		} else {
			url = url+"&fdMonth="+encodeURIComponent("${nowMonth}");
		} */ 
		$("#searchIframe").attr("src",url);
	}
	
	//导出
	function exportResult(){
		var subject = document.getElementsByName("subject")[0].value;
		var number = document.getElementsByName("number")[0].value;
		var status = $("select[name='status']").find("option:selected").val();
		var type = $("select[name='type']").find("option:selected").val();
		var beginDate = document.getElementsByName("fdBeginDate")[0].value;
		var endDate = document.getElementsByName("fdEndDate")[0].value;
		/* var fdMonth = $("select[name='fdMonth']").find("option:selected").val(); */
		var url="<c:url value='/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do?method=exportReportData'/>"; 
		if(subject.length>0){
			url = url+"&subject="+encodeURIComponent(subject);
		}
		if(number.length>0){
			url = url+"&number="+encodeURIComponent(number);
		}
		if(status.length>0){
			url = url+"&status="+encodeURIComponent(status);
		}
		if(type.length>0){
			url = url+"&type="+encodeURIComponent(type);
		}
		/* if(fdMonth.length>0){
			url = url+"&fdMonth="+encodeURIComponent(fdMonth);
		} */
		if(beginDate.length>0){
			url = url+"&beginDate="+encodeURIComponent(beginDate);
		}
		if(endDate.length>0){
			url = url+"&endDate="+encodeURIComponent(endDate);
		}
		Com_OpenWindow(url, '_blank');
	}

</script>
<center>
<html:form action="/geesun/base/geesun_base_bxsj/geesunBaseBxsj.do">
<style>
	.bt{
	    background: none repeat scroll 0 0 #47b5e6;
	    border: 1px solid #35a1d0;
	    color: #fff;
	    cursor: pointer;
	    font-size: 14px;
	    height: 25px;
	    line-height: 25px;
	    margin-right: 14px;
	    text-align: center;
	    width: 60px;
	}
	.txtlistpath{
		display:block; 
		background:url(dot.gif) repeat-x left bottom; 
		height:20px; 
		padding:0 0 5px 0;
		color:#2792C6; 
		line-height:20px; 
		margin:10px 0 0; 
		text-align:left;
		padding-left: 10px;
	}
</style>
		<table class="tb_normal" style="width:95%">
			<tr>
				<td class="td_normal_title" colspan="4" align="center">
					财务报表总表数据查询
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					主题
				</td><td width="35%">
					<xform:text property="subject" showStatus="edit" style="width:70%"/>
				</td>
				<td class="td_normal_title" width="15%">
					类型
				</td><td width="35%">
					<select name="type">
						<option value="">==请选择==</option>
						<option value="1787bde51d21bfc828cb12a4358a13da">费用报销</option>
						<option value="1796454cc441e9d1866f5b44fcb96980">付款申请</option>
						<option value="1787be42f2631c4cb4b66cf4e329a937">差旅报销</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					单据编号
				</td><td width="35%">
					<xform:text property="number" showStatus="edit" style="width:70%"/>
				</td>
				<td class="td_normal_title" width="15%">
					单据状态
				</td><td width="35%">
					<xform:select property="status" showStatus="edit">
						<xform:enumsDataSource enumsType="common_status"></xform:enumsDataSource>
					</xform:select>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">
					申请时间
				</td><td colspan="3" style="white-space: nowrap;">
					<nobr><xform:datetime property="fdBeginDate" dateTimeType="date" showStatus="edit" style="width:30%"/>
					&nbsp;&nbsp;&nbsp;&nbsp;至&nbsp;&nbsp;&nbsp;&nbsp;
					<xform:datetime property="fdEndDate" dateTimeType="date" showStatus="edit" style="width:30%"/></nobr>
					<%-- <kmss:period property="fdMonth" periodTypeValue="1" value="${nowMonth}"/> --%>
					<%-- <kmss:showPeriod value="${fsBudgetCommonForm.fdYear}" property="fdMonth" /> --%>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" colspan="4" align="center">
					<input name="button" class="bt" type="button" value="查询" id="ok_id"
						onclick="doSerch();">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="button" class="bt" type="button" value="导出"
						onclick="exportResult();">
				</td>
			</tr>
		</table>
		<div>
			<iframe src="" name="searchIframe" id="searchIframe" align="top" onload="this.height=searchIframe.document.body.scrollHeight" width="100%" Frameborder="no">
    		</iframe>
		</div> 
</html:form>
</center>
</template:replace>
</template:include>