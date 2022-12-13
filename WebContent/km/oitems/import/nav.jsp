<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<script type="text/javascript">
	seajs.use(['lui/jquery', 'lui/util/str', 'lui/dialog'], function($, strutil, dialog){
		window.setUrl= function (key,mykey,type){
			LUI.pageHide("_rIframe");
			if(type==''){
				LUI('applyCriteria').clearValue();
			}else{
			 LUI('applyCriteria').setValue(mykey, type);
			}
		 };
		window.openUrl = function(prefix,hash,key){
		    var srcUrl = "${LUI_ContextPath}/km/oitems/index.jsp";
			if(hash!=""){
				srcUrl+="#"+hash;
		    }
			window.open(srcUrl,"_self"); 
		};
	});
</script>
