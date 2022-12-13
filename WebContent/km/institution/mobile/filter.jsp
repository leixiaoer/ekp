<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<div data-dojo-type="mui/header/Header" data-dojo-props="height:'3.8rem'">
	<div data-dojo-type="mui/header/HeaderItem" 
		data-dojo-mixins="mui/folder/_Folder,mui/back/HrefBackMixin"
		data-dojo-props="href:'/km/institution/mobile/index.jsp'">
	</div>
	<div data-dojo-type="mui/header/HeaderItem" 
		data-dojo-props="label:'${param.moduleName}',referListId:'_filterDataList'">
	</div>
	<div 
		data-dojo-type="mui/header/HeaderItem" 
		data-dojo-mixins="mui/folder/_Folder,mui/simplecategory/SimpleCategoryDialogMixin" 
		data-dojo-props="icon:'mui mui-ul',authType:'00',
			modelName:'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
			redirectURL:'/km/institution/mobile/index.jsp?moduleName=!{curNames}&filter=1',
			filterURL:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&categoryId=!{curIds}&q.docStatus=30&orderby=docPublishTime&ordertype=down'">
	</div> 
</div>
<div id="scroll" data-dojo-type="mui/list/StoreScrollableView" class="gray">
	<div
		data-dojo-type="mui/search/SearchBar" 
		data-dojo-props="modelName:'com.landray.kmss.km.institution.model.KmInstitutionKnowledge',needPrompt:false,height:'3.8rem'">
	</div>
    <ul id="_filterDataList"
    	data-dojo-type="mui/list/JsonStoreList" 
    	data-dojo-mixins="mui/list/CardItemListMixin"
    	data-dojo-props="url:'${param.queryStr}', lazy:false">
	</ul>
</div>
