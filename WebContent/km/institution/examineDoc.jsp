<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include ref="default.simple">
    <template:replace name="body">
        <script type="text/javascript">
            seajs.use(['theme!list']);
        </script>
        <div>
            <ui:tabpanel layout="sys.ui.tabpanel.list">
                <c:choose>
                    <c:when test="${'approval' eq param.type}">
                        <%-- 待我审的 --%>
                        <ui:content title="待我审的制度">
                            <ui:iframe cfg-takeHash="false" src="${LUI_ContextPath }/km/institution/km_institution_knowledge/index.jsp?mydoc=approval&path=approval"></ui:iframe>
                        </ui:content>
                        <ui:content title="待我审的失效制度">
                            <ui:iframe cfg-takeHash="false" src="${LUI_ContextPath }/km/institution/km_inst_knowledge_abolish/index.jsp?mydoc=approval&path=approval"></ui:iframe>
                        </ui:content>
                    </c:when>
                    <c:when test="${'approved' eq param.type}">
                        <%-- 我已审的 --%>
                        <ui:content title="我已审的制度">
                            <ui:iframe cfg-takeHash="false" src="${LUI_ContextPath }/km/institution/km_institution_knowledge/index.jsp?mydoc=approved&path=approved"></ui:iframe>
                        </ui:content>
                        <ui:content title="我已审的失效制度">
                            <ui:iframe cfg-takeHash="false" src="${LUI_ContextPath }/km/institution/km_inst_knowledge_abolish/index.jsp?mydoc=approved&path=approved"></ui:iframe>
                        </ui:content>
                    </c:when>
                </c:choose>
            </ui:tabpanel>
        </div>
    </template:replace>
</template:include>
