<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<template:include file="/sys/profile/resource/template/list.jsp" spa="true">
    <template:replace name="content">
        <%-- 筛选器 --%>
        <list:criteria id="criteria1" multi="true">
            <list:cri-auto modelName="com.landray.kmss.km.institution.model.KmInstitutionKnowledgeAbolish" property="docSubject,docCreator,docCreateTime"/>
            <%-- 搜索条件:状态 --%>
            <list:cri-criterion title="${ lfn:message('km-institution:kmInstitution.kmInstitutionKnowledge.docStatus')}" key="docStatus" >
                <list:box-select>
                    <list:item-select>
                        <ui:source type="Static">
                            [
                            {text:'${ lfn:message('km-institution:kmInstitution.status.examine') }',value:'20'}, {text:'${ lfn:message('km-institution:kmInstitution.status.refuse') }', value: '11'},
                            {text:'${ lfn:message('km-institution:kmInstitution.status.discard') }', value:'00'},{text:'${ lfn:message('km-institution:kmInstitution.status.publish') }', value:'30'}
                            ]
                        </ui:source>
                    </list:item-select>
                </list:box-select>
            </list:cri-criterion>
        </list:criteria>
        <div class="lui_list_operation">
            <!-- 全选 -->
            <div class="lui_list_operation_order_btn">
                <list:selectall></list:selectall>
            </div>
            <!-- 分页 -->
            <div class="lui_list_operation_page_top">
                <list:paging layout="sys.ui.paging.top" >
                </list:paging>
            </div>
            <!-- 操作按钮 -->
            <div style="float:right">
                <div style="display: inline-block;vertical-align: middle;">
                    <ui:toolbar count="3">
                        <%-- 视图选择 --%>
                        <ui:togglegroup order="0">
                            <ui:toggle icon="lui_icon_s_zaiyao" title="${ lfn:message('list.rowTable') }"
                                       group="tg_1" text="${ lfn:message('list.rowTable') }" value="rowtable" selected="true"
                                       onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
                            </ui:toggle>
                            <ui:toggle icon="lui_icon_s_liebiao" title="${ lfn:message('list.columnTable') }"
                                       value="columntable"	 group="tg_1" text="${ lfn:message('list.columnTable') }"
                                       onclick="hideExport(this.value);LUI('listview').switchType(this.value);">
                            </ui:toggle>
                        </ui:togglegroup>
                        <%-- 收藏 --%>
                        <c:import url="/sys/bookmark/import/bookmark_bar_all.jsp" charEncoding="UTF-8">
                            <c:param name="fdTitleProName" value="docSubject" />
                            <c:param name="fdModelName"	value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
                        </c:import>
                        <%-- 新建--%>
                        <kmss:authShow roles="ROLE_KMINSTITUTION_CREATE">
                            <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2"></ui:button>
                        </kmss:authShow>
                        <kmss:authShow roles="ROLE_KMINSTITUTION_TRANSPORT_EXPORT">
                            <ui:button text="${lfn:message('button.export')}" id="export" onclick="listExport('${LUI_ContextPath}/sys/transport/sys_transport_export/SysTransportExport.do?method=listExport&fdModelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge')" order="2" ></ui:button>
                        </kmss:authShow>
                        <%-- ------置顶-----  --%>
                        <kmss:authShow roles="ROLE_KMINSTITUTION_VIEWDISPLY">
                            <ui:button id="setTop"  text="${lfn:message('km-institution:kmInstitutionKnowledge.button.setTop')}" onclick="setTop(true)"  order="4"></ui:button>
                            <ui:button id="unSetTop" text="${lfn:message('km-institution:kmInstitutionKnowledge.button.unSetTop')}" onclick="setTop(false)"  order="4"></ui:button>
                        </kmss:authShow>
                        <%--删除--%>
                        <ui:button text="${lfn:message('button.deleteall')}" onclick="window.delDoc()" order="3"
                                   cfg-map="{\"docStatus\":\"criteria('docStatus')\",\"docCategory\":\"criteria('docCategory')\"}"
                                   cfg-auth="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&status=!{docStatus}&categoryId=!{docCategory}">
                        </ui:button>
                        <%-- 修改权限 --%>
                        <c:import url="/sys/right/import/doc_right_change_button.jsp" charEncoding="UTF-8">
                            <c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
                            <c:param name="spa" value="true"/>
                        </c:import>
                        <%-- 分类转移 --%>
                        <%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
                        <%
                            if(com.landray.kmss.util.UserUtil.checkRole("ROLE_KMINSTITUTION_OPTALL")) {
                                request.setAttribute("authType", "00");
                            }
                        %>
                        <c:import url="/sys/simplecategory/import/doc_cate_change_button.jsp" charEncoding="UTF-8">
                            <c:param name="modelName" value="com.landray.kmss.km.institution.model.KmInstitutionKnowledge" />
                            <c:param name="docFkName" value="kmInstitutionTemplate" />
                            <c:param name="cateModelName" value="com.landray.kmss.km.institution.model.KmInstitutionTemplate" />
                            <%-- 如果用户有“分类权限扩充”角色，则允许转移到所有的分类 --%>
                            <c:param name="authType" value="${authType}" />
                            <c:param name="spa" value="true"/>
                        </c:import>
                    </ui:toolbar>
                </div>
            </div>
        </div>
        <ui:fixed elem=".lui_list_operation"></ui:fixed>
        <list:listview id="listview">
            <ui:source type="AjaxJson">
                {url:'/km/institution/km_institution_knowledge/kmInstitutionKnowledgeIndex.do?method=listChildren&q.mydoc=${JsParam.mydoc }&q.j_path=/${JsParam.path }'}
            </ui:source>
            <%--列表视图--%>
            <list:colTable url="${LUI_ContextPath }/sys/profile/listShow/sys_listShow/sysListShow.do?method=getSort&modelName=com.landray.kmss.km.institution.model.KmInstitutionKnowledge" id="colTable" isDefault="false" layout="sys.ui.listview.columntable"
                           rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}"  name="columntable">
                <list:col-checkbox></list:col-checkbox>
                <list:col-serial></list:col-serial>
                <list:col-auto props="" ></list:col-auto>
            </list:colTable>
            <list:rowTable isDefault="false" id="rowView"
                           rowHref="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId=!{fdId}" name="rowtable" >
                <list:row-template>
                    {$

                    <div class="clearfloat lui_listview_rowtable_summary_content_box">
                        <dl>
                            <dt>
                                <input type="checkbox" data-lui-mark="table.content.checkbox" value="{%row.fdId%}" name="List_Selected"/>
                                <span class="lui_listview_rowtable_summary_content_serial">{%row.index%}</span>
                            </dt>
                        </dl>
                        <dl>
                            <dt>
                                <a class="textEllipsis com_subject" onclick="Com_OpenNewWindow(this)" data-href="${LUI_ContextPath}/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=view&fdId={%row.fdId%}" target="_blank" data-lui-mark-id="{%row.rowId%}">{%row.row_docSubject%}</a>
                            </dt>
                            <dd class="lui_listview_rowtable_summary_content_box_foot_info">
                                <span>${lfn:message('km-institution:kmInstitution.fdNumber') }：{%row['fdNumber']%}</span>
                                <span>${lfn:message('sys-doc:sysDocBaseInfo.docCreator')}：{%row['docCreator']%}</span>
                                <span>${lfn:message('sys-doc:sysDocBaseInfo.docDept') }：{%row['docDept.fdName']%}</span>
                                $}
                                if(row['status'] == "50") {
                                {$ <span>${ lfn:message('km-institution:kmInstitution.fdAbolishTime') }：{%row['fdAbolishTime']%}</span>
                                <span>${ lfn:message('km-institution:kmInstitution.fdAbolishLink') }：{%row['fdAbolishLink']%}</span> $}
                                } else {
                                {$ <span>{%row['docPublishTime_row']%}</span> $}
                                }
                                {$
                                <span>{%row['fdTagNames']%}</span>
                            </dd>
                        </dl>
                    </div>
                    $}
                </list:row-template>
            </list:rowTable>
        </list:listview>
        <list:paging></list:paging>
        <script type="text/javascript">
            var SYS_SEARCH_MODEL_NAME ="com.landray.kmss.km.institution.model.KmInstitutionKnowledge";
        </script>
        <!-- 引入JS -->
        <script type="text/javascript">
        seajs.use(['lui/jquery','lui/dialog','lui/topic','lui/spa/Spa','lui/spa/const','lang!sys-ui'], function($, dialog , topic, Spa, spaConst, lang_ui) {                //新建
                window.addDoc = function() {
                    dialog.simpleCategoryForNewFile(
                        'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
                        '/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=add&fdTemplateId=!{id}&.fdTemplate=!{id}&i.docTemplate=!{id}',false,null,null,Spa.spa.getValue('docCategory'));
                };


                window.delDoc = function(){
                    var values = [];
                    $("input[name='List_Selected']:checked").each(function(){
                        values.push($(this).val());
                    });
                    if(values.length==0){
                        dialog.alert(lang['page.noSelect']);
                        return;
                    }

                    var delUrl = Com_Parameter.ContextPath + 'km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&categoryId=' + Spa.spa.getValue('docCategory');
                    dialog.iframe('/sys/edition/import/doc_delete_iframe.jsp?fdModelName=com.landray.kmss.km.doc.model.Institution&fdType=POST',
                        lang_ui['ui.dialog.operation.title'],
                        function (value){
                            // 回调方法
                            if(value) {
                                if(window.del_load!=null)
                                    window.del_load.hide();
                                if(typeof (value.responseText) != 'undefined'){
                                    var obj = eval('(' + value.responseText + ')');
                                    if(false==obj.status){
                                        var msg =obj.message;
                                        dialog.failure(msg[0].msg);
                                    }else{
                                        topic.publish("list.refresh");
                                        dialog.result(value);
                                    }
                                }else{
                                    topic.publish("list.refresh");
                                    dialog.result(value);
                                }
                            }
                        },
                        {width:400,height:170,params:{url:delUrl,data:$.param({"List_Selected":values},true)}}
                    );
                }
                window.delDoc = function(){
                    var values = [];
                    $("input[name='List_Selected']:checked").each(function(){
                        values.push($(this).val());
                    });
                    if(values.length==0){
                        dialog.alert(lang['page.noSelect']);
                        return;
                    }

                    var delUrl = Com_Parameter.ContextPath + 'km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=deleteall&categoryId=' + Spa.spa.getValue('docCategory');
                    dialog.iframe('/sys/edition/import/doc_delete_iframe.jsp?fdModelName=com.landray.kmss.km.doc.model.Institution&fdType=POST',
                        lang_ui['ui.dialog.operation.title'],
                        function (value){
                            // 回调方法
                            if(value) {
                                if(window.del_load!=null)
                                    window.del_load.hide();
                                if(typeof (value.responseText) != 'undefined'){
                                    var obj = eval('(' + value.responseText + ')');
                                    if(false==obj.status){
                                        var msg =obj.message;
                                        dialog.failure(msg[0].msg);
                                    }else{
                                        topic.publish("list.refresh");
                                        dialog.result(value);
                                    }
                                }else{
                                    topic.publish("list.refresh");
                                    dialog.result(value);
                                }
                            }
                        },
                        {width:400,height:170,params:{url:delUrl,data:$.param({"List_Selected":values},true)}}
                    );
                }


                window.setTop=function(isTop){
                    var values = [];
                    $("input[name='List_Selected']:checked").each(function(){
                        values.push($(this).val());
                    });
                    if(values.length==0){
                        dialog.alert('<bean:message key="page.noSelect"/>');
                        return;
                    }
                    var days=null;
                    if(isTop){
                        dialog.iframe("/km/institution/km_institution_ui/kmInstitutionKnowledge_topday.jsp","${lfn:message('km-institution:kmInstitutionKnowledge.kmDocKnowledge.fdTopTime')}",function (value){
                            days=value;
                            if(days==null){
                                return;
                            }else{
                                window.del_load = dialog.loading();
                                $.ajax({
                                    url: '<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop"/>',
                                    type: 'POST',
                                    data:$.param({"List_Selected":values,"fdIsTop":isTop,"fdDays":days,categoryId:'${JsParam.categoryId}'},true),
                                    dataType: 'json',
                                    error: function(data){
                                        if(window.del_load!=null){
                                            window.del_load.hide();
                                        }
                                        dialog.failure('<bean:message key="return.optFailure" />');
                                    },
                                    success: topCallback
                                });
                            }
                        },{width:400,height : 200});
                    }else{
                        days=0;
                        dialog.confirm('<bean:message bundle="km-institution" key="kmInstitutionKnowledge.setTop.confirmCancel"/>',function(value){
                            if(value==true){
                                window.del_load = dialog.loading();
                                $.ajax({
                                    url: '<c:url value="/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop"/>',
                                    type: 'POST',
                                    data:$.param({"List_Selected":values,"fdIsTop":isTop,"fdDays":days,categoryId:'${JsParam.categoryId}'},true),
                                    dataType: 'json',
                                    error: function(data){
                                        if(window.del_load!=null){
                                            window.del_load.hide();
                                        }
                                        dialog.failure('<bean:message key="return.optFailure" />');
                                    },
                                    success: topCallback
                                });
                            }
                        });
                    }
                };

                topic.subscribe(spaConst.SPA_CHANGE_VALUES, function(evt) {
                    LUI.pageHide('_rIframe');
                });

                // 监听新建更新等成功后刷新
                topic.subscribe('successReloadPage', function() {
                    topic.publish('list.refresh');
                });

                window.setCategory = function(cateId) {
                    var url = "";
                    if(Com_GetUrlParameter(window.location.href, "categoryId") != null) {
                        url = Com_SetUrlParameter(window.location.href, "categoryId", cateId);
                    } else {
                        var temp = location.href.split("#");
                        url = temp[0] + "?categoryId=" + cateId;
                        if (temp.length > 1) {
                            url += "#" + temp[1];
                        }
                    }
                    window.location.href = url;
                };

                window.delCallback = function(data){
                    if(window.del_load!=null)
                        window.del_load.hide();
                    if(data!=null && data.status==true){
                        topic.publish("list.refresh");
                        dialog.success(lang["return.optSuccess"]);
                    }else{
                        dialog.failure(lang["return.optFailure"]);
                    }
                };

                //根据地址获取key对应的筛选值
                window.getValueByHash = function(key){
                    var hash = window.location.hash;
                    if(hash.indexOf(key)<0){
                        return "";
                    }
                    var url = hash.split("cri.q=")[1];
                    var reg = new RegExp("(^|;)"+ key +":([^;]*)(;|$)");
                    var r=url.match(reg);
                    if(r!=null){
                        return unescape(r[2]);
                    }
                    return "";
                };

                //置顶、取消置顶回调
                window.topCallback = function(data){
                    if(window.del_load!=null)
                        window.del_load.hide();
                    if(data!=null && data.status==true){
                        topic.publish("list.refresh");
                        dialog.success('<bean:message key="return.optSuccess" />');
                    }else{
                        dialog.failure('<bean:message key="return.optFailure" />');
                    }
                };

                var docCategory = '', nodeType = '', docStatus = '';
                topic.subscribe('criteria.spa.changed', function(evt) {

                    // 获取分类Id
                    docCategory = Spa.spa.getValue('docCategory') || '';

                    // 记录状态筛选项是否清空
                    var isEmptyStatus = true;

                    for (var i = 0; i < evt['criterions'].length; i++) {
                        // 获取流程状态值
                        if (evt['criterions'][i].key=="docStatus") {
                            isEmptyStatus = false;
                            docStatus = evt['criterions'][i].value[0];
                        }
                    }

                    // 清空的情况
                    if (isEmptyStatus == true) {
                        docStatus = "";
                    }

                    showTopButtons(docCategory, nodeType, docStatus);
                });

                function showTopButtons(docCategory, nodeType, docStatus){
                    if(LUI('setTop') && LUI('unSetTop')) {
                        LUI('setTop').setVisible(false);
                        LUI('unSetTop').setVisible(false);
                    }
                    var checkSetTopUrl = "/km/institution/km_institution_knowledge/kmInstitutionKnowledge.do?method=setTop&status="+docStatus+"&categoryId="+docCategory+"&nodeType="+nodeType;
                    var data = new Array();

                    if (docStatus == '30') {
                        data.push(["setTopBtn",checkSetTopUrl]);
                        $.ajax({
                            url: Com_Parameter.ContextPath + "sys/authorization/SysAuthUrlCheckAction.do?method=checkUrlAuth",
                            dataType : 'json',
                            type : 'post',
                            data:{  data : LUI.stringify(data) },
                            async : false,
                            success : function(rtn){
                                if (rtn.length > 0) {
                                    for (var i=0; i<rtn.length; i++) {
                                        if (rtn[i]['setTopBtn'] == 'true') {
                                            if(LUI('setTop') && LUI('unSetTop')) {
                                                LUI('setTop').setVisible(true);
                                                LUI('unSetTop').setVisible(true);
                                            }
                                        } else {
                                            if(LUI('setTop') && LUI('unSetTop')) {
                                                LUI('setTop').setVisible(false);
                                                LUI('unSetTop').setVisible(false);
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    } else {
                        if(LUI('setTop') && LUI('unSetTop')) {
                            LUI('setTop').setVisible(false);
                            LUI('unSetTop').setVisible(false);
                        }
                    }
                }
            });
        </script>
    </template:replace>
</template:include>
