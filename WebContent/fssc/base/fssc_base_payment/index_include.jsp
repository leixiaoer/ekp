<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>

<template:include ref="default.simple4list">
    <template:replace name="title">
        <c:out value="${ lfn:message('fssc-base:module.fssc.base') }-${ lfn:message('fssc-base:table.fsscBasePayment') }" />
    </template:replace>
    <template:replace name="content">
    	<ui:tabpanel id="fsscBasePaymentPanel" layout="sys.ui.tabpanel.list" cfg-router="true">
		<ui:content id="fsscBasePaymentContent" title="${ lfn:message('fssc-base:message.include.payment.content.title') }">
        <div style="margin:5px 10px;">
            <!-- 筛选 -->
            <list:criteria id="criteria1">
                <list:cri-ref key="fdSubject" ref="criterion.sys.docSubject" title="${lfn:message('fssc-base:fsscBasePayment.fdSubject')}" />
                <list:cri-criterion title="${lfn:message('fssc-base:fsscBasePayment.fdModelName')}" key="fdModelName" expand="true">
                    <list:box-select>
                        <list:item-select type="lui/criteria/select_panel!TabCriterionSelectDatas">
                            <ui:source type="AjaxJson">
                                {url:'/fssc/base/fssc_base_payment/fsscBasePayment.do?method=getModelName'}
                            </ui:source>
                        </list:item-select>
                    </list:box-select>
                </list:cri-criterion>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBasePayment" property="fdModelNumber"  expand="true"/>
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBasePayment" property="fdPaymentTime" />
                <list:cri-auto modelName="com.landray.kmss.fssc.base.model.FsscBasePayment" property="fdStatus" />

            </list:criteria>
            <!-- 操作 -->
            <div class="lui_list_operation">

                <div style='color: #979797;float: left;padding-top:1px;'>
                    ${ lfn:message('list.orderType') }：
                </div>
                <div style="float:left">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar layout="sys.ui.toolbar.sort" style="float:left">
                            <list:sort property="fsscBasePayment.fdPaymentTime" text="${lfn:message('fssc-base:fsscBasePayment.fdPaymentTime')}" group="sort.list" />
                        </ui:toolbar>
                    </div>
                </div>
                <div style="float:left;">
                    <list:paging layout="sys.ui.paging.top" />
                </div>
                <div style="float:right">
                    <div style="display: inline-block;vertical-align: middle;">
                        <ui:toolbar count="3">
							<kmss:auth requestURL="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=batchConfirmPayment">
                                <ui:button text="${lfn:message('fssc-base:button.batchConfirmPayment')}" onclick="batchConfirmPayment()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=add">
                                <ui:button text="${lfn:message('button.add')}" onclick="addDoc()" order="2" />
                            </kmss:auth>
                            <kmss:auth requestURL="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=deleteall">
                                <c:set var="canDelete" value="true" />
                            </kmss:auth>
                            <!---->
                            <ui:button text="${lfn:message('button.deleteall')}" onclick="deleteAll()" order="4" id="btnDelete" />
                        </ui:toolbar>
                    </div>
                </div>
            </div>
            <ui:fixed elem=".lui_list_operation" />
            <!-- 列表 -->
            <list:listview id="listview">
                <ui:source type="AjaxJson">
                    {url:appendQueryParameter('/fssc/base/fssc_base_payment/fsscBasePayment.do?method=data')}
                </ui:source>
                <!-- 列表视图 -->
                <list:colTable isDefault="false" rowHref="/fssc/base/fssc_base_payment/fsscBasePayment.do?method=view&fdId=!{fdId}" name="columntable">
                    <list:col-checkbox />
                    <list:col-serial/>
                    <list:col-auto props="fdModelName;fdSubject;fdModelNumber;fdPaymentMoney;fdPaymentTime;fdStatus.name" /></list:colTable>
            </list:listview>
            <!-- 翻页 -->
            <list:paging />
        </div>
        </ui:content>
        </ui:tabpanel>
        <script>
            var listOption = {
                contextPath: '${LUI_ContextPath}',
                modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayment',
                templateName: '',
                basePath: '/fssc/base/fssc_base_payment/fsscBasePayment.do',
                canDelete: '${canDelete}',
                mode: '',
                customOpts: {

                    ____fork__: 0
                },
                lang: {
                    noSelect: '${lfn:message("page.noSelect")}',
                    comfirmDelete: '${lfn:message("page.comfirmDelete")}'
                }

            };
            Com_IncludeFile("list.js", "${LUI_ContextPath}/fssc/base/resource/js/", 'js', true);
            seajs.use(['lui/dialog'],function(dialog){
            	window.batchConfirmPayment = function(){
            		var fdModelName = LUI('criteria1').findSelectedValuesByKey("fdModelName").values;
            		if(fdModelName.length>1){
            			dialog.alert("${lfn:message('fssc-base:message.multiSelect')}");
            			return;
            		}
            		if(fdModelName.length==0){
            			dialog.alert("${lfn:message('fssc-base:message.selectOne')}");
            			return;
            		}
            		fdModelName = fdModelName[0].value;
            		var fdPaymentStatus = LUI('criteria1').findSelectedValuesByKey("fdStatus").values;
            		if(fdPaymentStatus.length!=1||fdPaymentStatus[0].value!='1'){
            			dialog.alert("${lfn:message('fssc-base:message.selectStatus')}");
            			return;
            		}
					var ids = [];
					$("[name=List_Selected]:checked").each(function(){
						ids.push(this.value);
					})
					if(ids.length==0){
						dialog.alert("${lfn:message('page.noSelect')}")
						return;
					}
					dialog.confirm("${lfn:message('fssc-base:message.batchConfirmPayment')}",function(rtn){
						if(rtn){
							var modelIds = [],data = LUI('listview')._data.datas;
							for(var i=0;i<data.length;i++){
								for(var k=0;k<ids.length;k++){
									if(ids[k]==getValueByColName(data[i],'fdId')){
										modelIds.push(getValueByColName(data[i],'fdModelId'));
									}
								}
							}
							var dia = dialog.loading();
							$.ajax({
		                		url:'${LUI_ContextPath}/fssc/base/fssc_base_payment/fsscBasePayment.do?method=batchConfirmPayment',
		                		data:{'ids':modelIds.join(';'),'fdModelName':fdModelName},
		                		dataType:'json',
		                		async:false,
		                		success:function(rtn){
		                			dia.hide();
		                			if(rtn.result == 'success'){
		                    			dialog.success("${lfn:message('return.success')}");
		                    			topic.publish('list.refresh');
		                			}else{
		                				dialog.alert(rtn.message);
		                			}
		                		}
		                	});
						}
					})
				}
            	window.getValueByColName = function(data,col){
                	for(var i=0;i<data.length;i++){
                		if(data[i].col==col){
                			return data[i].value;
                		}
                	}
                }
            })
        </script>
    </template:replace>
</template:include>