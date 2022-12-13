<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="/resource/jsp/jsperror.jsp" %>
<%@ include file="/resource/jsp/htmlhead.jsp"%>
<script>
Com_IncludeFile("msg.js", "style/"+Com_Parameter.Style+"/msg/");
Com_IncludeFile("docutil.js");
function showInfo(){
	var moreInfo = document.getElementById("notCloseBro");
	var imgObj = document.getElementById("infoBlockIDImage");
	if(moreInfo.style.display == "none"){
		moreInfo.style.display = "";
		imgObj.src = imgObj.src.replace("down.png","up.png");
	}else{
		moreInfo.style.display = "none";
		imgObj.src = imgObj.src.replace("up.png","down.png");
	}
}
</script>
<style> 
a:link, a:visited,a:active{
	font-family: Arial, Helvetica, sans-serif, "宋体";
	font-size: 12px;
	color: #000000;
	text-decoration: none;
}
a:hover {
	font-size:12px;
	color:#ff0000;
	text-decoration:none;
}
/*旧风格使用的样式*/
.PromptTB{border: 1px solid #000033;}
.barmsg{border-bottom: 1px solid #000033;}
</style>
<%-- 新风格使用的样式 --%>
<link href="${KMSS_Parameter_StylePath}promptBox/prompt.css" rel="stylesheet" type="text/css" />
<title>logout</title>
</head>
<BODY style="margin-left:10px" onload="setTimeout('window.opener=null;window.close()',10000)">
<br><br>
<table align=center>
	<tr>
    	<td><img src="${KMSS_Parameter_StylePath}icons/blank.gif" width=20 height=1></td>
    	<td>
      		<table width=400 border="0" align="center" cellpadding="0" cellspacing="0" class="PromptTB">
        		<tr>
          			<td height=18 valign="middle" class=barmsg><bean:message key="return.systemInfo"/></td>
          		</tr>
        		<tr>
          			<td>
            			<table border=0 cellSpacing=0 cellPadding=0 width="100%" bgColor=#ffffff>
              				<tr>
                				<td width=20><img src="${KMSS_Parameter_StylePath}icons/blank.gif" width=20 height=1></td>
                				<td height="40" class="PromptTD_Center">
                					<table width="100%" border="0" cellspacing="0" cellpadding="0">
                  						<tr>
                    						<td height="30" colspan="2" valign="bottom"><B><font color=#ff0000><bean:message key="home.logout.msg.logout"/></font></B></td>
						                 </tr>
						                 <tr>
						                    <td height="8" colspan="2"></td>
						                 </tr>
						                 <tr>
						                    <td colspan="2" style="line-height:20px"><bean:message key="home.logout.msg.closeWin"/><b>
									<bean:message key="home.logout.msg.closeAll"/></b></td>
						                 </tr>
						                 <tr>
						                    <td height="10" colspan="2"></td>
						                 </tr>
                  						 <tr>
                    						<td width="6%" height="30" valign="middle">
                    							<a onclick=showInfo();>
                    								<img src="${KMSS_Parameter_StylePath}icons/down.png" alt=详细信息 name="infoBlockIDImage" vspace="7" border=0 class=actionIcon id=infoBlockIDImage>
                  								</a>
                 							</td>
                    						<td width="94%" valign="middle"><A href="#" onclick=showInfo(); style="cursor:pointer;">更多信息</A></td>
                  						</tr>
                					</table>
               						<span style="display: none; line-height:18px; color=#4d4d4d" id=notCloseBro><bean:message key="home.logout.msg.notClose"/><br /><bean:message key="home.logout.msg.notCloseBro"/><br></span><br>
                  					<div align=center>
                  						<input class=btnmsg onclick=Com_CloseWindow(); value="<bean:message key="home.logout.confirm.closeWindows"/>" type=button> 
                  						<input type="button" class=btnmsg name="button" value="<bean:message key="home.logout.confirm.reLogin"/>" onclick="Com_OpenWindow(Com_Parameter.ContextPath,'_self');">
                  					</div><br style="FONT-SIZE: 10px">
                  				</td>
                				<td width=20><img src="${KMSS_Parameter_StylePath}icons/blank.gif" width=20 height=1></td>
                			</tr>
                		</table>
                	</td>
            	</tr>
			</table>
		</td>
		<td><IMG src="${KMSS_Parameter_StylePath}icons/blank.gif" width=20 height=1></td>
	</tr>
</table>
<br><br>
</BODY>
</html>