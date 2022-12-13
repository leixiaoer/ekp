<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<script type="text/javascript">
      Com_IncludeFile("jquery-barcode.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
      Com_AddEventListener(window,'load',function(){
    	//生成条形码
         var docNumber = '${param.docNumber}';
         if(null != docNumber && '' != docNumber){
             $("#barcodeTarget").barcode(docNumber, "code128",{barWidth:1, barHeight:40});
         }
  	})
</script>