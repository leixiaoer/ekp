<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/resource/jsp/common.jsp"%>
<%@ include file="/sys/config/resource/edit_top.jsp"%>
<%@page import="com.landray.kmss.third.im.kk.util.KK5Util"%>
<%@page import="com.landray.kmss.util.ResourceUtil"%>
<script>
	Com_IncludeFile("doclist.js|dialog.js");
</script>
<script>
	var gzhInfo=new Array();
	var gzhSelected = "<%=ResourceUtil
									.getKmssConfigString("kmss.ims.notify.kk5.service.select")%>";
	function config_kk_onloadFunc() {
		var tbObj = document.getElementById("config.integrate.kk");
		for ( var i = 0; i < tbObj.rows.length; i++) {
			var cfgFields = tbObj.rows[i].getElementsByTagName("INPUT");
			for ( var j = 0; j < cfgFields.length; j++) {
				cfgFields[j].disabled = "disabled";
			}
		}
	}

	function config_kk5_onloadFunc() {
		var tbObj = document.getElementById("config.integrate.kk5");
		var field = tbObj.rows[0].getElementsByTagName("INPUT")[0];
		for ( var i = 0; i < tbObj.rows.length; i++) {
			var cfgFields = tbObj.rows[i].getElementsByTagName("INPUT");
			for ( var j = 0; j < cfgFields.length; j++) {
				cfgFields[j].disabled = "disabled";
			}
		}
		
		var _type = document.getElementsByName("value(kmss.kk5.notify.type)"), type = null;
		for(var i = 0; i < _type.length; i++) {
			if(_type[i].checked) {
				type = _type[i].value;
				break;
			}
		}
		if(type == null) {
			_type[0].checked = true;
			type = "corpNotify";
		}
		config_notify_type(field.checked,type);
	}

	function config_other_onloadFunc() {
		var tbObj = document.getElementById("integrate.kk");
		for ( var i = 0; i < tbObj.rows.length; i++) {
			var cfgFields = tbObj.rows[i].getElementsByTagName("INPUT");
			for ( var j = 0; j < cfgFields.length; j++) {
				cfgFields[j].disabled = "disabled";
			}
		}
	}


	var commonAccountListTdParam = {
			"border" : false,
			"width" : "60px",
			"type" : "select",
			"id" : "commonAccountList",
			"defaultInputText" : "",
			"checkInputText" : "",
			"defaultSelectValue" : "",
			"checkSelectValue" : "",
			"innerText" : ""
		};

		var commonAccountDescriptionTdParam = {
			"border" : false,
			"width" : "150px",
			"type" : "",
			"id" : "",
			"defaultInputText" : "",
			"checkInputText" : "",
			"defaultSelectValue" : "",
			"checkSelectValue" : "",
			"innerText" : ""
		};

		var commonAccountValues;

		function getCommonAccountValues() {
			if (commonAccountValues === undefined) {
				return new Array();
			}
			return commonAccountValues;
		}

		function createTdElement(trElement, tdParam, options) {
			var tdElement = trElement.insertCell(trElement.cells.length);
			if (tdParam.border == true) {
				tdElement.style.borderTop = "0px";
			}
			if (tdParam.width != "") {
				tdElement.style.width = tdParam.width;
			}
			if (tdParam.type == "select") {
				tdElement.innerHTML = getSelectElementHTML(tdParam.id, options,
						tdParam.checkSelectValue, tdParam.defaultSelectValue)
						+ tdParam.innerText;
				return tdElement;
			}
			tdElement.innerHTML = tdParam.innerText;
			return tdElement;
		}

		function getSelectElementHTML(id, options, checkSelectValue,
				defaultSelectValue) {
			var rtnResult = new Array();
			rtnResult.push('<option value=\'choose\'>${ lfn:message("third-im-kk:robotnode_hint_3") }</option>');
			if (options == null || options.length == 0) {
				var value = checkSelectValue || defaultSelectValue;
				if (value != '')
					rtnResult.push('<option value=\'' + value + '\' selected>'
							+ value + '</option>');
			} else {
				var value = checkSelectValue || defaultSelectValue;
				for (var i = 0, length = options.length; i < length; i++) {
					var option = options[i], optionValue = option.value;
					rtnResult.push('<option value=\'' + optionValue + '\'');
					if (optionValue == value) {
						rtnResult.push(' selected');
					}
					rtnResult.push('>' + option.name + '</option>');
				}
			}
			if (id == "commonAccountList") {
				return '<select name="value(kmss.ims.notify.kk5.service.select)" onchange="changeDescription(this);" id="' + id
						+ '"' + ' style=\'width: 160px;\'>' + rtnResult.join('')
						+ '</select>';
			}
			return '<select id="' + id + '"' + ' style=\'width: 160px;\'>'
					+ rtnResult.join('') + '</select>';
		}

		function changeDescription(select) {
			if (select.value == "choose") {
				document.getElementById("commonAccountDescription").innerHTML = "";
			} else {
				var values = getCommonAccountValues();
				for (var i = 0, length = values.length; i < length; i++) {
					if (values[i].value == select.value) {
						document.getElementById("commonAccountDescription").innerHTML = values[i].description;
						break;
					}
				}
			}
		}

		function createCommonAccountList(trElement, options) {
			if (trElement != null && options != null) {
				var tdElement = createTdElement(trElement,
						commonAccountListTdParam, options);
				tdElement = createTdElement(trElement,
						commonAccountDescriptionTdParam, null);
				tdElement.id = "commonAccountDescription";
			}
		}

		function transCommonAccountList(jsonArray) {
			var rtnResult = new Array();
			if (!jsonArray)
				return rtnResult;
			for (var i = 0, length = jsonArray.length; i < length; i++) {
				if(jsonArray[i].serviceState==0){
					continue;
				}
				rtnResult.push({
					value : jsonArray[i].corp+"&"+jsonArray[i].service,
					name : jsonArray[i].serviceName,
					description : jsonArray[i].serviceDesc
				});
			}
			return rtnResult;
		};

		function initCommonAccountList(enable) {
			var tdCommonAccount=document.getElementById("commonAccountList");
			var tdCommonAccountDescription=document.getElementById("commonAccountDescription");
			if(enable){
				if(tdCommonAccount==null){
					commonAccountListTdParam.checkSelectValue = gzhSelected;
					commonAccountValues=transCommonAccountList(gzhInfo);
					var values = getCommonAccountValues();
					for (var i = 0, length = values.length; i < length; i++) {
						if (values[i].value == commonAccountListTdParam.checkSelectValue) {
							commonAccountDescriptionTdParam.innerText = values[i].description;
							break;
						}
					}
					createCommonAccountList(document
							.getElementById("tr_kk5_gzh_Notify"), commonAccountValues);
				}else{
					document.getElementById("commonAccountList").value=gzhSelected;
					var values = getCommonAccountValues();
					for (var i = 0, length = values.length; i < length; i++) {
						if (values[i].value == gzhSelected) {
							document.getElementById("commonAccountDescription").innerHTML = values[i].description;
							break;
						}
					}
					tdCommonAccount.style.display="";
					tdCommonAccountDescription.style.display="";
				}
			}else{
				if(tdCommonAccount!=null){
					tdCommonAccount.style.display="none";
					tdCommonAccountDescription.style.display="none";
				}
			}
		}

	function handle(data){
		gzhInfo=data;
		if(gzhInfo.length==0){
			alert("???????????????????????????????????????KK5??????????????????????????????KK5????????????????????????");
		}else{
			initCommonAccountList(true);
		}
	}

	function initialGzhInfo(){
		var kk5ServerUrl=document.getElementsByName("value(kmss.kk5.serverURL)")[0].value;
		var getGzhUrl=kk5ServerUrl+"/info/listService.ajax";
		$.getJSON(Com_Parameter.ContextPath+"third/im/kk/webparts/getGzhInfo.jsp?getGzhUrl="+getGzhUrl,function (data){handle(data);})
	}

	function enableChoosegzh() {
		var enableGzh = document.getElementsByName("_value(kmss.ims.notify.kk5.service.enable)")[0];
		if(enableGzh.checked){
			initialGzhInfo();
		}else{
			initCommonAccountList(false);
		}
	}

	function config_notify_type(kk5enable,notifyType){
		var tr_kk5_notifyToDo=document.getElementById("tr_kk5_notifyToDo");
		var tr_kk5_notifyToRead=document.getElementById("tr_kk5_notifyToRead");
		var tr_kk5_gzh_Notify=document.getElementById("tr_kk5_gzh_Notify");
		var corpNotifyMessage=document.getElementById("corpNotifyMessage");
		var gzhNotifyMessage=document.getElementById("gzhNotifyMessage");

		var kk5_notifyToDo = document.getElementsByName("value(kmss.ims.notify.todo.kk5.enable)")[0];
		var kk5_notifyToRead = document.getElementsByName("value(kmss.ims.notify.toread.kk5.enable)")[0];
		//
		if(typeof(kk5enable) == "undefined"){
			kk5enable=false;
		}
		if("corpNotify"==notifyType){
			//tr_kk5_gzh_Notify.style.display = 'none';
			//tr_kk5_notifyToDo.style.display = kk5enable?'':'none';
			//tr_kk5_notifyToRead.style.display = kk5enable?'':'none';
			tr_kk5_notifyToDo.disabled = false;
			tr_kk5_notifyToRead.disabled = false;
			corpNotifyMessage.style.display = kk5enable?'':'none';
			gzhNotifyMessage.style.display = 'none';
			initCommonAccountList(false);
		}
		if("gzhNotify"==notifyType){
			//tr_kk5_gzh_Notify.style.display = kk5enable?'':'none';
			//tr_kk5_notifyToDo.style.display = 'none';
			//tr_kk5_notifyToRead.style.display = 'none';
			tr_kk5_notifyToDo.disabled = true;
			tr_kk5_notifyToRead.disabled = true;
			corpNotifyMessage.style.display = 'none';
			gzhNotifyMessage.style.display = kk5enable?'':'none';
			initialGzhInfo();
		}
	}


	window.onload = function(){
		config_other_onloadFunc();
		config_kk_onloadFunc();
		config_kk5_onloadFunc();
	}
</script>
<html:form action="/third/im/kk/config.do?method=config">
<table id="integrate.kk" class="tb_normal" width=95%>
	<tr>
		<td>
		<table class="tb_normal" width=100% id="config.integrate.kk">
			<tr>
				<td class="td_normal_title" colspan="4"><b> <label>
				<xform:checkbox property="value(kmss.integrate.kk.enabled)"
					onValueChange="config_kk_onloadFunc()" showStatus="edit"
					htmlElementProperties="id=\"kmss.integrate.kk.enabled\"">
					<xform:simpleDataSource value="true">??????KK4</xform:simpleDataSource>
				</xform:checkbox> </label> </b></td>

			</tr>
			<tr>
				<td class="td_normal_title" width="15%">kk???????????????</td>
				<td colspan="3"><xform:text
					property="value(third.im.kk.serverIp)" style="width:30%"
					subject="?????????IP" required="true" showStatus="edit"
					htmlElementProperties="disabled='true'" /> <span class="message">??????????????????ip
				???????????? ???kk.landray.com ??? 192.168.1.69</span></td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">kk??????ID</td>
				<td colspan="3"><xform:text
					property="value(kmss.ims.notify.kk.requestid)" style="width:30%"
					subject="kk??????ID" required="true" showStatus="edit"
					htmlElementProperties="disabled='true'" /> <span class="message">(KK??????ID,requestid)</span>
				</td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">kk????????????????????????</td>
				<td colspan="3"><xform:text
					property="value(kmss.ims.notify.kk.port)" style="width:30%"
					subject="kk????????????????????????" required="true" showStatus="edit"
					htmlElementProperties="disabled='true'" /> <span class="message">??????8002</span>
				</td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">KK??????????????????</td>
				<td><xform:checkbox property="value(kmss.ims.kk.enable)"
					showStatus="edit" htmlElementProperties="disabled='true'">
					<xform:simpleDataSource value="true">??????</xform:simpleDataSource>
				</xform:checkbox> <span class="message">(?????????????????????,?????????????????????????????????????????????)</span></td>

				<td class="td_normal_title" width="15%">????????????</td>
				<td><xform:text property="value(kmss.ims.kk.awareport)"
					style="width:30%" subject="kk????????????????????????" required="false"
					showStatus="edit" htmlElementProperties="disabled='true'" /> <span
					class="message">??????8081</span></td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">??????KK????????????</td>
				<td colspan=3><xform:checkbox
					property="value(kmss.ims.notify.todo.kk.enable)" showStatus="edit"
					htmlElementProperties="disabled='true'">
					<xform:simpleDataSource value="true">??????</xform:simpleDataSource>
				</xform:checkbox> <span class="message">(??????????????????????????????????????????KK?????????)</span></td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">??????KK????????????</td>
				<td colspan=3><xform:checkbox
					property="value(kmss.ims.notify.toread.kk.enable)"
					showStatus="edit" htmlElementProperties="disabled='true'">
					<xform:simpleDataSource value="true">??????</xform:simpleDataSource>
				</xform:checkbox> <span class="message">(??????????????????????????????????????????KK?????????)</span></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>
		<table class="tb_normal" width=100% id="config.integrate.kk5">
			<tr>
				<td class="td_normal_title" colspan="4"><b> <label>
				<xform:checkbox property="value(kmss.integrate.kk5.enabled)"
					onValueChange="config_kk5_onloadFunc()" showStatus="edit"
					htmlElementProperties="id=\"kmss.integrate.kk5.enabled\"">
					<xform:simpleDataSource value="true">??????KK5</xform:simpleDataSource>
				</xform:checkbox> </label> </b></td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">???????????????</td>
				<td colspan="3"><xform:text
					property="value(kmss.kk5.serverURL)" style="width:30%"
					subject="kk5???????????????" required="true" showStatus="edit"
					htmlElementProperties="disabled='true'" /> <span class="message">KK5????????????????????????http://192.168.1.69:8000/serverj</span>
				</td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">??????????????????</td>
				<td><xform:radio property="value(kmss.kk5.notify.type)"
					showStatus="edit"
					onValueChange="config_notify_type(true,this.value);"
					subject="??????????????????" required="true">
					<xform:simpleDataSource value="corpNotify">????????????</xform:simpleDataSource>
					<xform:simpleDataSource value="gzhNotify">?????????</xform:simpleDataSource>
				</xform:radio></td>
				<td colspan="2"><span id="corpNotifyMessage" class="message">??????????????????KK?????????KK??????????????????????????????</span>
				<span id="gzhNotifyMessage" class="message">??????????????????????????????????????????????????????????????????????????????</span></td>
			</tr>

			<tr id="tr_kk5_notifyToDo">
				<td class="td_normal_title" width="15%">????????????</td>
				<td colspan=3><xform:checkbox
					property="value(kmss.ims.notify.todo.kk5.enable)" showStatus="edit"
					htmlElementProperties="disabled='true'">
					<xform:simpleDataSource value="true">??????</xform:simpleDataSource>
				</xform:checkbox></td>
			</tr>
			<tr id="tr_kk5_notifyToRead">
				<td class="td_normal_title" width="15%">????????????</td>
				<td colspan=3><xform:checkbox
					property="value(kmss.ims.notify.toread.kk5.enable)"
					showStatus="edit" htmlElementProperties="disabled='true'">
					<xform:simpleDataSource value="true">??????</xform:simpleDataSource>
				</xform:checkbox></td>
			</tr>
			<tr id="tr_kk5_gzh_Notify">
				<td class="td_normal_title" width="15%">?????????</td>

			</tr>

		</table>

		</td>
	</tr>

	<tr>
		<td>
		<table>
			<tr>
				<td class="td_normal_title" width="15%">kk??????????????????????????????</td>
				<td colspan=3><xform:text
					property="value(kmss.ims.notify.kk.logBak.days)" style="width:5%"
					showStatus="edit" /> ??? <span class="message">(kk???????????????????????????????????????????????????????????????????????????????????????????????????30?????????)</span>
				</td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">kk??????????????????????????????</td>
				<td colspan=3><xform:text
					property="value(kmss.ims.notify.kk.failure.times)" style="width:5%"
					showStatus="edit" /> ??? <span class="message">(kk????????????????????????????????????????????????????????????????????????????????????KK???????????????????????????????????????????????????????????????
				????????????????????????kk????????????????????????????????????????????????????????????<a target="_blank"
					href='<c:url value="/third/im/kk.index"/>'>/third/im/kk.index</a>???
				?????????1000?????????????????????-1????????????)</span></td>
			</tr>
			<tr>
				<td class="td_normal_title" width="15%">??????????????????????????????????????????</td>
				<td colspan=3><xform:text
					property="value(kmss.ims.notify.kk.failure.notify)"
					style="width:10%" showStatus="edit" /> <span class="message">(??????????????????????????????????????????????????????)</span>
				</td>
			</tr>

			<tr>
				<td class="td_normal_title" width="15%">WebKK???????????????</td>
				<td colspan="3"><xform:text
					property="value(third.im.kk.webkk.urlPrefix)" subject="WebKK???????????????"
					showStatus="edit" style="width:30%" /> <span class="message">WebKK????????????????????????http://webkk.landray.com.cn:8081???</span></td>
			</tr>

		</table>
		</td>
	</tr>
</table>
</html:form>
<br>
<div align="center">
<b>?????????????????????????????????????????????????????????????????????admin.do->??????????????????????????????</b>
</div>