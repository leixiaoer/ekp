<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/kmss-xform.tld" prefix="xform"%>
<%@ include file="/resource/jsp/view_top.jsp"%>
<script type="text/javascript">
Com_IncludeFile("jquery.js|list.js");
</script>
<script type="text/javascript">
function expandMethod(domObj) {
	var thisObj = $(domObj);
	var isExpand = thisObj.attr("isExpanded");
	if(isExpand == null)
		isExpand = "1";
	var trObj=thisObj.parents("tr");
	trObj = trObj.next("tr");
	var imgObj = thisObj.find("img");
	if(trObj.length > 0){
		if(isExpand=="0"){
			trObj.show();
			thisObj.attr("isExpanded","1");
			imgObj.attr("src","${KMSS_Parameter_StylePath}icons/collapse.gif");
		}else{
			trObj.hide();
			thisObj.attr("isExpanded","0");
			imgObj.attr("src","${KMSS_Parameter_StylePath}icons/expand.gif");
		}
	}
 }
</script>


<div id="optBarDiv"><input type="button"
	value="<bean:message key="button.close"/>" onclick="Com_CloseWindow();">
</div>

<p class="txttitle">${HtmlParam.name}接口说明</p>

<center>
<div style="width: 95%;text-align: left;">
	<p>&nbsp;&nbsp;可以通过该接口调用TIC中配置的第三方接口</p>
</div>
<br/>

<table border="0" width="95%">
	<tr>
		<td><b>1、接口说明</b></td>
	</tr>
	<tr>
		<td style="cursor: pointer;font-size: 15px;" onclick="expandMethod(this);">&nbsp;&nbsp;1.1&nbsp;&nbsp;调用TIC接口（/api/tic-core/ticCore/callFunc）
			<img src="${KMSS_Parameter_StylePath}icons/collapse.gif" border="0" align="bottom"/>
			</td>
	</tr>
	<tr>
		<td>
			<table class="tb_normal" cellpadding="0" cellspacing="0"  style="width: 85%;margin-left: 40px;">
				<tr>
					<td class="td_normal_title" width="20%">参数信息</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;body数据（JSON对象），详细说明如下:</div>
						<table class="tb_normal" cellpadding="0" cellspacing="0" width=100%>
							<tr class="tr_normal_title">
								<td align="center" width="10%"><b>程序名</b></td>
								<td align="center" width="10%"><b>描述</b></td>
								<td align="center" width="10%"><b>类型</b></td>
								<td align="center" width="15%"><b>可否为空</b></td>
								<td align="center" width="55%"><b>备注说明</b></td>
							</tr>
							<tr>
								<td>key</td>
								<td>函数的fdId或者关键字</td>
								<td>String</td>
								<td>不允许为空</td>
								<td>
									可以是原始函数，也可以是转换函数
	 							</td>
							</tr>
							<tr>
								<td>inParam</td>
								<td>函数入参</td>
								<td>JSON对象</td>
								<td>允许为空</td>
								<td>
									如果调用的是原始函数，则按照原始函数中的入参定义构建该参数值。
									如果调用的是转换函数，则按照转换函数中的“转换函数入参”的定义构建该参数值。
									<a href="./help/api_callFunc.html" style="color:blue" target="_blank">参数格式可以参考ekp内部的调用方式</a>
								</td>
							</tr>
					</table>
					</td>
				</tr>
				
				
				<tr>
					<td class="td_normal_title" width="20%">返回信息</td>
					<td style="padding: 0px;"><div style="margin: 8px;">&nbsp;&nbsp;body数据（JSON对象），详细说明如下:</div>
						<table class="tb_normal" cellpadding="0" cellspacing="0" width=100%>
							<tr class="tr_normal_title">
								<td align="center" width="10%"><b>程序名</b></td>
								<td align="center" width="10%"><b>描述</b></td>
								<td align="center" width="10%"><b>类型</b></td>
								<td align="center" width="15%"><b>可否为空</b></td>
								<td align="center" width="55%"><b>备注说明</b></td>
							</tr>
							<tr>
								<td>errcode</td>
								<td>结果标识</td>
								<td>数字</td>
								<td>不允许为空</td>
								<td>
									0表示成功，其它值表示失败
	 							</td>
							</tr>
							<tr>
								<td>errMsg</td>
								<td>错误信息</td>
								<td>String</td>
								<td>允许为空</td>
								<td>
									当errcode为非0时，该字段有值
								</td>
							</tr>
							<tr>
								<td>data</td>
								<td>响应数据</td>
								<td>JSON对象</td>
								<td>允许为空</td>
								<td>
									接口返回的业务数据，当errcode为0时，该字段有值
								</td>
							</tr>
					</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
	
	
</table>

</center>

<%@ include file="/resource/jsp/view_down.jsp"%>