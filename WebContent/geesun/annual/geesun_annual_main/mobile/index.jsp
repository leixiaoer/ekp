<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<template:include ref="mobile.list">
    <template:replace name="title">
        <c:if test="${param.moduleName!=null && param.moduleName!=''}">
            <c:out value="${param.moduleName}"></c:out>
        </c:if>
        <c:if test="${param.moduleName==null || param.moduleName==''}">
            <c:out value="${ lfn:message('geesun-annual:table.geesunAnnualMain') }" />
        </c:if>
    </template:replace>
    <template:replace name="head">
        <%-- 自定义js或css --%>
        <script type="text/javascript">
            var listOption = {

            };
        </script>
        <script type="text/javascript" src="${LUI_ContextPath}/geesun/annual/resource/js/mobile_list.js?s_cache=${MUI_Cache}"></script>
    </template:replace>
    <template:replace name="content">
        <c:choose>
            <c:when test="${ param.filter == '1' }">
                <div data-dojo-type="mui/header/Header" data-dojo-props="height:'3.8rem'">
                    <div data-dojo-type="mui/header/HeaderItem" data-dojo-mixins="mui/folder/_Folder,mui/back/HrefBackMixin" data-dojo-props="href:'/geesun/annual/geesun_annual_main/mobile/index.jsp'">
                    </div>
                    <div data-dojo-type="mui/header/HeaderItem" data-dojo-props="label:'${lfn:escapeHtml(JsParam.moduleName)}',referListId:'_filterDataList'">
                    </div>

                </div>
                <div id="scroll" data-dojo-type="mui/list/StoreScrollableView">
                    <div data-dojo-type="mui/search/SearchBar" data-dojo-props="modelName:'com.landray.kmss.geesun.annual.model.GeesunAnnualMain',needPrompt:false,height:'3.8rem'">
                    </div>
                    <ul id="_filterDataList" data-dojo-type="mui/list/JsonStoreList" data-dojo-mixins="mui/list/TextItemListMixin" data-dojo-props="url:'${lfn:escapeHtml(JsParam.queryStr)}', lazy:false">
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <div data-dojo-type="mui/header/Header" data-dojo-props="height:'3.8rem'">
                    <div data-dojo-type="mui/nav/MobileCfgNavBar" data-dojo-props="defaultUrl:'/geesun/annual/geesun_annual_main/mobile/nav.jsp', modelName:'com.landray.kmss.geesun.annual.model.GeesunAnnualMain'">
                    </div>
                    <div data-dojo-type="mui/header/HeaderItem" data-dojo-mixins="mui/folder/Folder" data-dojo-props="tmplURL:'/geesun/annual/geesun_annual_main/mobile/query.jsp'"></div>
                </div>
                <div data-dojo-type="mui/list/NavSwapScrollableView">
                    <ul data-dojo-type="mui/list/JsonStoreList" data-dojo-mixins="mui/list/TextItemListMixin">
                    </ul>
                </div>
            </c:otherwise>
        </c:choose>

        <ul data-dojo-type="mui/tabbar/TabBar" fixed="bottom">
            <li data-dojo-type="mui/back/BackButton">
            </li>
            <kmss:auth requestURL="/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=add">
                <li data-dojo-type="mui/tabbar/CreateButton" data-dojo-props="_onClick:function(){location='${LUI_ContextPath}/geesun/annual/geesun_annual_main/geesunAnnualMain.do?method=add'}">
                    ${lfn:message('button.add')}
                </li>
            </kmss:auth>
            <li data-dojo-type="mui/tabbar/TabBarButtonGroup" data-dojo-props="icon1:'mui mui-more'">
                <div data-dojo-type="mui/back/HomeButton">
                </div>
                <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'mui mui-ul', href:'/geesun/annual/geesun_annual_use/mobile/index.jsp', label:'${lfn:message('geesun-annual:table.geesunAnnualUse')}'">
                </div>
                <div data-dojo-type="mui/tabbar/TabBarButton" data-dojo-props="icon1:'mui mui-ul', href:'/geesun/annual/geesun_annual_alter/mobile/index.jsp', label:'${lfn:message('geesun-annual:table.geesunAnnualAlter')}'">
                </div>
            </li>
        </ul>
    </template:replace>
</template:include>