<%@page import="com.landray.kmss.util.StringUtil"%>
<%@page import="com.landray.kmss.util.IDGenerator"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="com.landray.kmss.sys.ui.taglib.fn.LuiFunctions"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
JSONObject var = JSONObject.fromObject(request.getParameter("var"));
pageContext.setAttribute("luivar",var);
pageContext.setAttribute("luivarid","var_"+IDGenerator.generateID());
pageContext.setAttribute("luivarparam",StringUtil.isNotNull(var.getString("body")) ? JSONObject.fromObject(var.get("body")) : new JSONObject());
//out.print(request.getParameter("var")); 
%>
<style>
	.varkindIcon .titleIconShowBox{
		display:inline-block;
		background-color:#e3e3e3;
	}
	.varkindIcon .lui_icon_l{
		padding:0px;
		height:50px;
		width:50px;
		line-height:50px;
		font-size:50px;
		magrin:3px;
	}
	.varkindIcon a{
		color:#3eb2e6;
	}
</style>
<script>
${param['jsname']}.VarSet.push({
	"name":"${ luivar['key'] }",
	"getter":function(){
		$("#iconPreview").attr("class","lui_icon_l "+$("#${ luivarid }").val())
		return $("#${ luivarid }").val();
	},
	"setter":function(val){
		$("#${ luivarid }").val(val);
		$("#iconPreview").attr("class","lui_icon_l "+$("#${ luivarid }").val())
	},
	"validation":function(){
		var val = this['getter'].call();
		var requ = ${ luivar['require'] ? "true" : "false" };
		if(requ){
			if($.trim(val)==""){
				return "${ lfn:msg(luivar['name']) }不能为空";
			}
		}
	}
});

function selectIcon(){
	seajs.use(['lui/dialog'],function(dialog){
		dialog.build({
			config : {
					width : 500,
					height : 400,  
					title : "${ lfn:message('sys-portal:sysPortalPage.msg.selectIcon') }",
					content : {  
						type : "iframe",
						url : "/sys/ui/jsp/iconfont.jsp"
					}
			},
			callback : function(value, dia) {
				if(value==null){
					return ;
				}
				$("#iconPreview").attr("class","lui_icon_l "+value);
				var key = "${ luivar['key'] }";
				$("[name='"+key+"']").val(value);
			}
		}).show(); 
	});
}
function clearIcon(){
	$("#iconPreview").attr("class","lui_icon_l ");
	var key = "${ luivar['key'] }";
	$("[name='"+key+"']").val("");
}
</script>
<tr>
	<td>${ lfn:msg(luivar['name']) }</td>
	<td class="varkindIcon">
		<div class="titleIconShowBox ">
			<div style="cursor: pointer;" id='iconPreview' class="lui_icon_l ${luivar['default']}" onclick="selectIcon()"></div>
		</div>
		<a class="icon" href="javascript:void(0)" onclick="selectIcon()">
			${ lfn:message('sys-ui:ui.vars.select') }
		</a>
		&nbsp;
		<a href="javascript:void(0)" onclick="clearIcon()">
			${ lfn:message('sys-ui:ui.vars.clear') }
		</a>
		<input style="width:95%" class="inputsgl" id="${ luivarid }" name="${ luivar['key'] }" type="hidden" value="${luivar['default']}" />
		${ luivar['require'] ? "<span style='color:red;'>*<span>" : "" }
		<span class="com_help">${ lfn:msg(luivarparam['help']) }</span>
	</td>
</tr>