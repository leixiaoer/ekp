<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% response.addHeader("X-UA-Compatible", "IE=Edge"); %>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ include file="/sys/ui/jsp/jshead.jsp"%>
<%@ include file="/resource/jsp/edit_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("jquery.js|data.js");
	//文件上传
	function upload(){
		var file = document.getElementsByName("file");
		if(file[0].value==null || file[0].value.length==0){
			seajs.use(['lui/dialog'],function(dialog){
				dialog.alert("<bean:message bundle='km-pindagate' key='kmPindagateMain.import.file.required'/>");
			});
			return false;
		}
		else{
			//修改状态为正在执行
			var uploadProcess=document.getElementById("div_uploadProcess");
			uploadProcess.innerHTML="<font color='blue'><bean:message bundle='km-pindagate' key='kmPindagateMain.title.uploadDoing'/></font>";
			var form=document.getElementsByName("kmPindagateMainForm")[0];
			form.target="file_frame";
			form.submit();
		}
	}
	
	//excel文件上传完毕,显示操作信息
	function callback(result){
		if(result.addresses.length>0){
				window.parent.AddAddress(result.addresses);
		}
		document.getElementById("div_errorCell").innerHTML=createTable(result);
		var uploadStatus=document.getElementById("div_uploadStatus");
		uploadStatus.innerHTML="<bean:message bundle='km-pindagate' key='kmPindagateMain.title.upload.success'/>";
		var uploadProcess=document.getElementById("div_uploadProcess");
		uploadProcess.innerHTML="<font color='red'>" + result.importMsg + "</font>";
		$(".msglist").show();
	}
	function createTable(json) {
		if(json == null) return "";
		if(typeof json !== 'object') return "";
		if(json.hasError != 1) return "";
		var htmlStr = "<table class='tb_normal' style='width:100%;'>";
		var colLength;
		//标题
		var titles = json.titles;
		if(titles != null) {
			htmlStr += "<thead style='background:#ddd;'><tr>";
			var colLength = titles.length;
			titles.forEach(function(item,index) {
				htmlStr += "<th style='padding:5px 10px;text-align:center;border-left:1px solid #d1d1d1;'>"+item+"</th>"
			});
			htmlStr += "</tr></thead>";
		}
		htmlStr += "<tbody>";
		//内容
		var rows = json.errorRows;
		if(rows != null) {
			rows.forEach(function(item,index) {
				var errColNumbers = item.errColNumbers.split(",").map(function(item,index) {
					return parseInt(item);
				});
				htmlStr += "<tr>";
				htmlStr += "<td>"+item.errRowNumber+"</td>";
				var contents = item.contents;
				contents.forEach(function(it,idx) {
					if($.inArray(idx,errColNumbers) > -1)
						htmlStr += "<td style='color:#FF0000;'>"+formatNull(it)+"</td>";
					else
						htmlStr += "<td>"+formatNull(it)+"</td>";	
				});
				htmlStr += "<td style='color:#FF0000'>"+item.errInfos+"</td>";
				htmlStr += "</tr>";
			});
		}
		//其他错误
		var otherErrors = json.otherErrors;
		if(otherErrors && otherErrors.length>0) {
			var colspanStr = colLength==null?"":"colspan='"+colLength+"'";
			htmlStr += "<tr><td "+colspanStr+"><p><b><bean:message bundle='km-pindagate' key='kmPindagateMain.import.otherErrors'/></b></p>";
			otherErrors.forEach(function(item,index) {
				htmlStr += "<p style='color:#FF0000;'>"+item+"</p>";
			});
			htmlStr += "</td></tr>";
		}
		htmlStr += "</tbody></table>";
		return htmlStr;
	}
	function formatNull(val) {
		if(val===null||val===undefined||val==="null"||val==="NULL") {
			return "";
		}
		return val;
	}
	//展开出错列表
	function showMoreErrInfo(srcImg){
		var obj = document.getElementById("div_errorCell");
		if($('.muiCheckBlock').hasClass('active')){
			$('.muiCheckBlock').removeClass("active lui_icon_s_icon_ok");
			obj.style.display="none";
		}else{
			$('.muiCheckBlock').addClass("active lui_icon_s_icon_ok");
			obj.style.display="block";
		}
	}

	//改变上传附件,重置导出结果
	function resetResult(){
		var uploadStatus=document.getElementById("div_uploadStatus");
		uploadStatus.innerHTML="<bean:message bundle='km-pindagate' key='kmPindagateMain.title.uploadDoing'/>";
		document.getElementById("div_errorCell").innerHTML="";
	} 
	$(document).ready(function() {  
        $(".upload").change(function() {  
            var arrs=$(this).val().split('\\');  
            var filename=arrs[arrs.length-1];  
            $(".show").html(filename); 
            resetResult();
            upload();
        }).hover(function() {
        	$(".blueButton").css({'background-color':"#008de2"});
        },function() {
        	$(".blueButton").css({'background-color':"#00b3ee"});
        });
    });
</script>
<style>
br{
   display:none;
}
/*蓝色按钮,绝对定位*/  
.blueButton {
    display: inline-block;  
    width: 80px;  
    height: 30px;  
    background-color: #00b3ee;  
    color: #fff;  
    text-decoration: none;  
    text-align: center;  
    font:normal normal normal 16px/30px 'Microsoft YaHei';  
    cursor: pointer;  
    border-radius: 4px;
    margin:0 30px;
    font-size:14px;
}  
.blueButton:hover {  
    text-decoration: none; 
}  
/*自定义上传,位置大小都和a完全一样,而且完全透明*/  
.upload  {  
	top:0px;
    position: absolute;  
    display: block;  
    width: 80px;  
    height: 30px;  
    opacity: 0;
    cursor: pointer; 
    left:28px;
}
/*显示上传文件夹名的Div*/  
.show {  
    width: 90%;  
    height: 30px;
    font:normal normal normal 14px/30px 'Microsoft YaHei';  
}
.upload-container {
	overflow:auto;
	width:967px;
	padding:10px;
	background-color:#fff;
}
#template{
    width :110px;
    height:30px;
    background-color:#fff;
    color:#3e9ece;
    border:1px #3e9ece solid;
    float:right;
}
.txttitle{
    color:#000;
    font-weight:normal;
    font-size:17px;
}
#div_uploadStatus{
    color:#1b83d8;
     font-size:12px;
     margin-left:30px;
}
.muiCheckBlock{
    cursor:pointer;
    width:14px;
    height:14px;
    border:1px solid #d5d5d5;
    border-radius:2px;
    display:inline-block;
    position:relative;
    top:2px;
}
/* .muiCheckBlock.active{
     border:1px solid #37aee9;
     background-color:#37aee9;
} */
.muiCheckBlock.active::before{
     display:block;
     color:#fff;
     font-size:12px;
     line-height:15px;
     font-weight:900;
     -webkit-transform:scale(0.8);
    /*  content:"\C091"; */
}
</style>
<form name="downloadForm" action="${LUI_ContextPath }/km/pindagate/km_pindagate_main/kmPindagateMain.do" method="post" target="_blank">
</form>
<html:form action="/km/pindagate/km_pindagate_main/kmPindagateMain.do?method=importAddressData" 
	enctype="multipart/form-data">
	<iframe name="file_frame" style="display:none;"></iframe>	
<center>
<div class="upload-container">
<p class="txttitle"><bean:message  bundle="km-pindagate" key="kmPindagateMain.dataImport"/>
	<input type="button" id="template" value="<bean:message bundle="km-pindagate" key="kmPindagateMain.import.template.download"/>" onclick="Com_SubmitNoEnabled(document.downloadForm,'downloadTemplate');">
</p>
<hr>
<table style="width:100%;">
	<tr>
		<td class="td_normal_title" style="width:100px">
			<bean:message  bundle="km-pindagate" key="kmPindagateMain.upload.file"/>
			<div style="position:relative;height:34px;display: inline-block;">
				<a href="javascript:void(0);" class="blueButton"><bean:message bundle="km-pindagate" key="kmPindagateMain.import.selectFile"/></a>  
				<input name="file" accept=".xls,.xlsx" type="file" class="upload" />
			<span style="font-size:13px;color:gray;"><bean:message  bundle="km-pindagate" key="kmPindagateMain.button.upload.tip"/></span>
		</div>
		</td>

	</tr>
	<tr><td><div><span  class="show"></span>
		<span id="div_uploadStatus">
		</span>
		</div>
	</td>
	</tr>
	<tr>
		<td colspan="2" style="line-height:28px;">

			<table class="tb_noborder" width="100%">
				<tr height="25px">
					<td class="msglist" colspan="3" style="display:none">
						<bean:message bundle="km-pindagate" key="kmPindagateMain.title.uploadProcess"/>
						<span id="div_uploadProcess">
								<bean:message bundle="km-pindagate" key="kmPindagateMain.title.uploadNotDo"/>
						</span>
					</td> 
				</tr>
				<tr height="25px">
					<td class="msglist" colspan="3" style="display:none">
						<span class="muiCheckBlock" onclick='showMoreErrInfo(this);' style='cursor:pointer'></span>
						<bean:message bundle="km-pindagate" key="kmPindagateMain.title.detail"/>
						<div id="div_errorCell" style="display:none;margin-top: 5px;width:100%;overflow:auto;"></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div>
</center>
</html:form>
<%@ include file="/resource/jsp/edit_down.jsp"%>