<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/mobile/mui.tld" prefix="mui"%>
<mui:cache-file name="mui-nav.js" cacheType="md5" />

<div data-dojo-type="mui/header/Header" data-dojo-props="height:'4.4rem'" class="muiHeaderNav">
	<div data-dojo-type="mui/nav/MobileCfgNavBar"
		data-dojo-props="modelName:'com.landray.kmss.kms.knowledge.model.KmsKnowledgeBaseDoc'">
	</div>
	
	<div data-dojo-type="mui/search/SearchButtonBar"
        data-dojo-props="modelName:'com.landray.kmss.kms.wiki.model.KmsWikiMain;com.landray.kmss.kms.multidoc.model.KmsMultidocKnowledge'" >
    </div>
</div>

<div data-dojo-type="mui/header/NavHeader">
</div>

<div data-dojo-type="mui/list/NavView" id="kms-knowledge-view-container">
       <ul data-dojo-type="mui/list/HashJsonStoreList" 
          data-dojo-mixins="mui/list/ComplexLItemListMixin">
       </ul>
</div>
<script type="text/javascript">
    window.onload = function(){
      var bar = document.getElementById("mui_search_SearchButtonBar_0")
      bar.style.verticalAlign = "middle";
    }
 </script>
