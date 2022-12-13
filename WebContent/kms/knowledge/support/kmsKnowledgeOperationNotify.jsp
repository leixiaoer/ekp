<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<%-- 是否只显示内容，即是否包含tr td元素，默认 false --%>
<c:set var="showOnlyContent" value="${empty JsParam.showOnlyContent? false : JsParam.showOnlyContent}"/>
<style>
    .inputselectmul textarea {
        border: 0px !important;
    }
    .fdNotifyPersonTypeTr {
        display: none;
    }
    .fdNotifyPersonTypeTr .fdNotifyPerson_customize {
        display: none;
    }
</style>
<c:choose>
    <c:when test="${showOnlyContent == true}">
        <tr>
            <td class="tb_normal_title" width="15%">
                <div class="knowledge_notify">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify")}</div>
            </td>
            <td width="85%"  colspan="3">
                <input type="radio" name="fdIsNotify" value="1" onclick="onFdIsNotifyClick('1')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify.yes")}
                <input type="radio" name="fdIsNotify" value="0" checked onclick="onFdIsNotifyClick('0')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify.no")}
                <span class="com_help">${lfn:message('kms-knowledge:kmsKnowledgeBase.fdNotify.tip')}</span>
            </td>
        </tr>
        <tr class="fdNotifyPersonTypeTr">
            <td class="tb_normal_title" width="15%">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType")}</td>
            <td width="85%"  colspan="3">
		            <span>
		                <input type="radio" name="fdNotifyTypeForUpdate" value="0" onclick="onFdNotifyPersonType('0')" checked>${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.0")}
		                <input type="radio" name="fdNotifyTypeForUpdate" value="1" onclick="onFdNotifyPersonType('1')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.1")}
		                <input type="radio" name="fdNotifyTypeForUpdate" value="2" onclick="onFdNotifyPersonType('2')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.2")}
		            </span>
                <br/>
                <span class="com_help com_help_0" style="font-size: 12px">文档可阅读者为空时，不发送通知</span>
                <div class="fdNotifyPerson_customize">
                    <xform:address
                            subject="${lfn:message('kms-knowledge:kmsKnowledgeBase.fdNotifyPersons')}"
                            showStatus="edit"
                            orgType="ORG_TYPE_PERSON"
                            textarea="true"
                            mulSelect="true"
                            propertyId="fdNotifyPersonIds"
                            propertyName="fdNotifyPersonNames"
                            style="width:97%;height:90px;" >
                    </xform:address>
                </div>
            </td>
        </tr>
    </c:when>
    <c:otherwise>
        <ui:content title="通知" id="kmsKnowledgeNotify">
            <table class="tb_normal" width=100%>
                <tr>
                    <td class="tb_normal_title" width="15%">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify")}</td>
                    <td width="85%">
                        <input type="radio" name="fdIsNotify" value="1" onclick="onFdIsNotifyClick('1')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify.yes")}
                        <input type="radio" name="fdIsNotify" value="0" checked onclick="onFdIsNotifyClick('0')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdIsNotify.no")}
                        <span class="com_help">${lfn:message('kms-knowledge:kmsKnowledgeBase.fdNotify.tip')}</span>
                    </td>
                </tr>
                <tr class="fdNotifyPersonTypeTr">
                    <td class="tb_normal_title" width="15%">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType")}</td>
                    <td width="85%">
		                    <span>
		                        <input type="radio" name="fdNotifyTypeForUpdate" value="0" onclick="onFdNotifyPersonType('0')" checked>${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.0")}
		                        <input type="radio" name="fdNotifyTypeForUpdate" value="1" onclick="onFdNotifyPersonType('1')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.1")}
		                        <input type="radio" name="fdNotifyTypeForUpdate" value="2" onclick="onFdNotifyPersonType('2')">${lfn:message("kms-knowledge:kmsKnowledgeBase.fdNotifyType.2")}
		                    </span>
                        <br/>
                        <span class="com_help com_help_0" style="font-size: 12px">文档可阅读者为空时，不发送通知</span>
                        <div class="fdNotifyPerson_customize">
                            <xform:address
                                    subject="${lfn:message('kms-knowledge:kmsKnowledgeBase.fdNotifyPersons')}"
                                    showStatus="edit"
                                    orgType="ORG_TYPE_PERSON"
                                    textarea="true"
                                    mulSelect="true"
                                    propertyId="fdNotifyPersonIds"
                                    propertyName="fdNotifyPersonNames"
                                    style="width:97%;height:90px;" >
                            </xform:address>
                        </div>
                    </td>
                </tr>
            </table>
        </ui:content>
    </c:otherwise>
</c:choose>
<script>

    function onFdIsNotifyClick(type){
        if("1" == type ){
            $(".fdNotifyPersonTypeTr").show();
        }else{
            $(".fdNotifyPersonTypeTr").hide();
        }
    }

    function onFdNotifyPersonType(type){
        var value =  $("[name='fdNotifyTypeForUpdate']:checked").val();
        if(!type && value) {
            type = value;
        }

        if("2" == type){
            $(".fdNotifyPersonTypeTr .fdNotifyPerson_customize").show();
        }else {
            $(".fdNotifyPersonTypeTr .fdNotifyPerson_customize").hide();
        }

        if("0" == type){
            $(".com_help_0").show();
        }else {
            $(".com_help_0").hide();
        }
    }
</script>