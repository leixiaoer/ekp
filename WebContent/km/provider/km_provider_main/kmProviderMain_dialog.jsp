<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="/resource/jsp/list_top.jsp"%>
<script type="text/javascript">
	Com_IncludeFile("document.js", "style/"+Com_Parameter.Style+"/doc/");
	Com_IncludeFile("dialog.js|jquery.js");
</script>
<script>

	//初始化列表
	window.onload=function(){
		document.kmProviderMainForm.submit();
	};

	//新增供应商
	function addProvider(){
		var path=location.href;
		path=Com_SetUrlParameter(Com_Parameter.ContextPath+'resource/jsp/frame.jsp','url',Com_Parameter.ContextPath+'km/provider/km_provider_main/kmProviderMain.do?method=add');
		//window.showModalDialog(path);
		window.open(path);
	}
	
	//重置搜索内容
	function clear_value(){
		document.getElementsByName("categoryId")[0].value = "";
		document.getElementsByName("categoryName")[0].value = "";
		document.getElementsByName("fdName")[0].value = "";
		document.getElementsByName("fdBiao")[0].value = "";
	}

	//回车搜索供应商
	document.onkeydown=function(event){
		  var e = event || window.event || arguments.callee.caller.arguments[0];
		  //回车enter键
		  if(e && e.keyCode==13){
				findProviders();
			}
	};

	//搜索供应商
	function findProviders(){
		var multi='${JsParam.multi}';
		var categoryIds = document.getElementsByName("categoryId")[0].value ; 
		var categoryNames = document.getElementsByName("categoryName")[0].value ;
		var fdName = document.getElementsByName("fdName")[0].value ; 
		var fdBiao = document.getElementsByName("fdBiao")[0].value ; 
		var form=document.getElementsByName("kmProviderMainForm")[0];
		form.action=encodeURI(form.action.split("&")[0]+"&multi="+multi+"&categoryIds="+categoryIds+"&categoryNames="+categoryNames+"&fdName="+fdName+"&fdBiao="+fdBiao);
		form.submit();
	}
	
	//选择供应商
	function selectProvider(multi,split){
		var selectedId="",selectedName="";
		var ids= window.frames["iframe"].document.getElementsByName("selectProviderId");
		var names = window.frames["iframe"].document.getElementsByName("selectProviderName");
		var count = 0;
		for(var i=0;i<ids.length;i++) {
			if(ids[i].checked) {
				selectedId += ids[i].value;
				selectedName += names[i].value;
				count++;
				if(multi=="true"){
					selectedId+=split;
					selectedName+=split;
				}else{
					break;
				}			
			}
		}
		if(count==0){
			alert("<bean:message  bundle='km-provider' key='kmProviderMain.description.noselect'/>"); 
			return false;
		}
		else{
			if(multi=="true"){
				selectedId=selectedId.substring(0, selectedId.length-1);
				selectedName=selectedName.substring(0,selectedName.length-1);
			}
			var rtnArray = new Array(selectedId,selectedName);		
			parent.$dialog.hide(rtnArray);
			return true;		
		}
	}
	
	//取消选择供应商
	function cancelProvider(){
		parent.$dialog.hide("cancelselect");
		return false;
	}

	function showCategoryTree()
	{
		Dialog_Tree(true, 'categoryId', 'categoryName', 
				';','kmProviderCategoryService&parentId=!{value}',
				'<bean:message key="table.kmProviderCategory" bundle="km-provider"/>',
				false, null,null, null, null,
				'<bean:message key="table.kmProviderCategory" bundle="km-provider"/>');
	}
	
</script>
<br />
<p class="txttitle">
	<bean:message bundle="km-provider" key="kmProviderMain.title.selectProvider"/>
</p>
<br />
<html:form action="/km/provider/km_provider_main/kmProviderMainSelect.do?method=list" target="iframe">
	<!-- 供应商list查询栏 -->
	<center >
	<div style="width: 95%" >
		<table width="100%" class="tb_normal"  align="center">
			<tr>
				<td class="td_normal_title" style="width: 15%">
					<bean:message  bundle="km-provider" key="kmProviderMain.fdName"/>
				</td>
				<td style="width: 15%">
					<input class="inputsgl" type="text" size="15" maxlength="50" name="fdName">
				</td>
				<td class="td_normal_title" style="width: 15%">
					<bean:message  bundle="km-provider" key="kmProviderMain.fdBiao"/>
				</td>
				<td style="width: 15%">
					<input class="inputsgl" type="text" size="15" maxlength="50"  name="fdBiao">
				</td>
				<td class="td_normal_title" style="width: 15%">
					<bean:message  bundle="km-provider" key="table.kmProviderCategory"/>
				</td>
				<td style="width: 23%">
					<xform:dialog propertyId="categoryId" propertyName="categoryName" style="width:90%" showStatus="edit"  dialogJs="showCategoryTree();"></xform:dialog>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="center">
						<input type="button" id="ok_id"  class="lui_form_button"
						value="<bean:message  bundle="km-provider" key="kmProviderMain.btn.search"/>" onclick="findProviders();"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="lui_form_button"
							value="<bean:message  bundle="km-provider" key="kmProviderMain.btn.clear"/>" onclick="clear_value();"/>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="lui_form_button"
							value="<bean:message  bundle="km-provider" key="kmProviderMain.btn.add"/>" onclick="addProvider();"/>
				</td>
			</tr>
			<tr>
				<td colspan=6 width="100%"  height="250px;" id="listTxt">
					<iframe id="iframe" name="iframe" width="100%" height="100%" frameborder="0"  src=""></iframe>
				</td>
			</tr>
			<tr>
				<td colspan="6" align="center">
					<input type="button"  class="lui_form_button" value="<bean:message key="button.select" />" name="F_Select" onclick="selectProvider('${JsParam.multi}','${JsParam.split}');" />
					&nbsp;&nbsp;&nbsp;
					<input type="button"  class="lui_form_button" value="<bean:message key="button.cancel" />" name="F_Select" onclick="parent.$dialog.hide();" />
					&nbsp;&nbsp;&nbsp;
					<input type="button" class="lui_form_button"  value="<bean:message key="dialog.selectNone" />" name="F_Select" onclick="cancelProvider();"/>
				</td>
			</tr>
		</table>
	</div>
	</center>
</html:form>