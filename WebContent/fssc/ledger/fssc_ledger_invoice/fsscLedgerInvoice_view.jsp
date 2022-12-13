<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/sys/ui/jsp/common.jsp" %>
<%@page import="com.landray.kmss.fssc.ledger.util.FsscLedgerUtil" %>
    
        <%
            pageContext.setAttribute("currentPerson", UserUtil.getKMSSUser().getUserId());
        pageContext.setAttribute("currentPost", UserUtil.getKMSSUser().getPostIds());
        pageContext.setAttribute("currentDept", UserUtil.getKMSSUser().getDeptId());
        if(UserUtil.getUser().getFdParentOrg() != null) {
            pageContext.setAttribute("currentOrg", UserUtil.getUser().getFdParentOrg().getFdId());
        } else {
            pageContext.setAttribute("currentOrg", "");
        } %>
    
    <template:include ref="default.view">
        <template:replace name="head">
            <style type="text/css">
                
                			.lui_paragraph_title{
                				font-size: 15px;
                				color: #15a4fa;
                		    	padding: 15px 0px 5px 0px;
                			}
                			.lui_paragraph_title span{
                				display: inline-block;
                				margin: -2px 5px 0px 0px;
                			}
                			.inputsgl[readonly], .tb_normal .inputsgl[readonly] {
                			    border: 0px;
                			    color: #868686
                			}
                		
            </style>
            <script type="text/javascript">
                var formInitData = {

                };
                var messageInfo = {

                    'fdDetail': '${lfn:escapeJs(lfn:message("fssc-ledger:table.fsscLedgerDetail"))}'
                };
                Com_IncludeFile("swf_attachment.js", "${KMSS_Parameter_ContextPath}sys/attachment/js/", "js", true);
            </script>
        </template:replace>
        <template:replace name="title">
            <c:out value="${fsscLedgerInvoiceForm.fdInvoiceNumber} - " />
            <c:out value="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" />
        </template:replace>
        <template:replace name="toolbar">
            <script>
                function deleteDoc(delUrl,fdId) {
                	 seajs.use(['lui/dialog','lang!fssc-ledger','lang!'], function(dialog,lang,comlang) {
                	  $.ajax({
                      	url:'${LUI_ContextPath}/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=checkDelete',
                      	data:{fdId:fdId},
                      	dataType:'json',
                      	type:'POST',
                      	success:function(data){
                           dialog.confirm('${ lfn:message("page.comfirmDelete") }', function(isOk) {
                            if(isOk) {
                                Com_OpenWindow(delUrl, '_self');
                            }
                        });
                     
                    },error:function(req){
                 		if(req.responseJSON){
                 			var data = req.responseJSON;
                 			if(!data.status){
                 				 dialog.alert(lang['message.checkUseStatus']);
                 			}
                 		}else{
                 			dialog.alert('操作失败');
                 		}
                 		del_load.hide();
                 	}
                 }); 
                });
                }

                function openWindowViaDynamicForm(popurl, params, target) {
                    var form = document.createElement('form');
                    if(form) {
                        try {
                            target = !target ? '_blank' : target;
                            form.style = "display:none;";
                            form.method = 'post';
                            form.action = popurl;
                            form.target = target;
                            if(params) {
                                for(var key in params) {
                                    var
                                    v = params[key];
                                    var vt = typeof
                                    v;
                                    var hdn = document.createElement('input');
                                    hdn.type = 'hidden';
                                    hdn.name = key;
                                    if(vt == 'string' || vt == 'boolean' || vt == 'number') {
                                        hdn.value =
                                        v +'';
                                    } else {
                                        if($.isArray(
                                            v)) {
                                            hdn.value =
                                            v.join(';');
                                        } else {
                                            hdn.value = toString(
                                                v);
                                        }
                                    }
                                    form.appendChild(hdn);
                                }
                            }
                            document.body.appendChild(form);
                            form.submit();
                        } finally {
                            document.body.removeChild(form);
                        }
                    }
                }

                function doCustomOpt(fdId, optCode) {
                    if(!fdId || !optCode) {
                        return;
                    }

                    if(viewOption.customOpts && viewOption.customOpts[optCode]) {
                        var param = {
                            "List_Selected_Count": 1
                        };
                        var argsObject = viewOption.customOpts[optCode];
                        if(argsObject.popup == 'true') {
                            var popurl = viewOption.contextPath + argsObject.popupUrl + '&fdId=' + fdId;
                            for(var arg in argsObject) {
                                param[arg] = argsObject[arg];
                            }
                            openWindowViaDynamicForm(popurl, param, '_self');
                            return;
                        }
                        var optAction = viewOption.contextPath + viewOption.basePath + '?method=' + optCode + '&fdId=' + fdId;
                        Com_OpenWindow(optAction, '_self');
                    }
                }
                window.doCustomOpt = doCustomOpt;
                var viewOption = {
                    contextPath: '${LUI_ContextPath}',
                    basePath: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do',
                    customOpts: {

                        ____fork__: 0
                    }
                };

                Com_IncludeFile("security.js");
                Com_IncludeFile("domain.js");
            </script>
            <style>
        .fontColor {
            color: #38adff;
            font-size: 12px!important;
        }

        .my_project_laydate {
            cursor: pointer;
        }

        .mfs-del {
            font-size: 24px;
            color: #ff7374;
        }

        .mfs-add {
            font-size: 24px;
        }

        .mfs-bx-titile {
            color: #38ADFF;
            font-size: 24px;
            position: relative;
            padding-bottom: 13px;
            height: 65px;
            line-height: 65px;
            text-align: center;
            letter-spacing: 3px;
            border-bottom-style: double;
            border-bottom-width: 4px;
            width: 300px;
        }

        .mfs-bx-titile2 {
            color: #38ADFF;
            font-size: 20px;
            letter-spacing: 7px;
        }

        .mfs-bx-lay {
            margin: 10px 20px;
        }

        .bill-file {
            margin: 10px 0;
        }

            .bill-file label {
                color: #38ADFF;
                font-size: 12px;
                margin-right: 20px;
                display: inline-block;
                vertical-align: middle;
            }

            .bill-file .file-btns {
                display: inline-block;
            }

                .bill-file .file-btns .layui-btn {
                    border: 1px solid #38adff;
                    color: #38adff;
                }

                .bill-file .file-btns .btn-qrcode {
                    margin-left: 60px;
                }

                .bill-file .file-btns .layui-btn:hover {
                    color: #fff;
                    background-color: #38adff;
                }

                .bill-file .file-btns .layui-btn + .layui-btn {
                    margin-left: 40px;
                }


        .mfs-bx-submit {
            height: 30px;
            line-height: 30px;
            background-color: #687586;
            font-size: 12px;
        }

        .fapiao {
            width: 90%;
            border: 1px solid #866f4f;
            text-align: center;
            margin: 0 auto;
            font-size: 12px;
        }

            .fapiao input, textarea {
                width: 90%;
                border: 0;
            }

        .fapiaoTable {
            width: 100%;
        }

        .shuli {
            width: 20px;
            border-right: 1px solid #866f4f;
            padding: 10px 10px;
        }

        .shuli2 {
            width: 20px;
            padding: 10px 10px;
            border-right: 1px solid #866f4f;
            border-left: 1px solid #866f4f;
        }

        .BuyTable {
            width: 100%;
        }

            .BuyTable input, textarea {
                border: 0;
                width: 90%;
            }

        .BuyTableName {
            padding: 2px 2px;
            padding-bottom: 0px;
            width: 20%;
        }

        .GoodsTable {
            width: 100%;
            border: 1px solid #866f4f;
            border-right: none;
            border-left: none;
            text-align: center;
        }

            .GoodsTable td {
                border-right: 1px solid #866f4f;
            }

        .GoodsTotal {
            border-top: 1px solid #866f4f;
        }

        .BuyTableContent {
            width: 80%;
        }

        .TextArea {
            padding: 5px 2px 5px 15px;
        }

        .mfs-bx {
            margin: 0 auto;
            text-align: center;
            margin-bottom: 20px;
            height: 100px;
            margin-left: 41%;
            width: 60%;
        }

        .TableTitle {
            font-size: 12px;
            float: left;
            margin-left: 70px;
            margin-top: 10px;
        }

            .TableTitle input {
                border: none;
            }

        .mfs-bx-header {
            float: left;
            width: 251px;
        }

        .TableFooter {
            width: 60%;
            text-align: center;
            margin: 0 auto;
        }
            .TableFooter input {
                border: none;
                width: 15%;
            }
            .isTrue{
                float: right;
			    margin-right: 15%;
			    margin-bottom: 0;
			    background-color: #d43535;
			    color: #f9f9f9;
			    font-size: 20px;
			    margin-top: -20px;
			   }
    </style>
            <ui:toolbar id="toolbar" layout="sys.ui.toolbar.float" count="3">

                <!--edit-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.edit')}" onclick="Com_OpenWindow('fsscLedgerInvoice.do?method=edit&fdId=${param.fdId}','_self');" order="2" />
                </kmss:auth>
                <!--delete-->
                <kmss:auth requestURL="/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoice.do?method=delete&fdId=${param.fdId}">
                    <ui:button text="${lfn:message('button.delete')}" onclick="deleteDoc('fsscLedgerInvoice.do?method=delete&fdId=${param.fdId}','${param.fdId }');" order="4" />
                </kmss:auth>
                <ui:button text="${lfn:message('button.close')}" order="5" onclick="Com_CloseWindow();" />


            </ui:toolbar>
        </template:replace>
        <template:replace name="path">
            <ui:menu layout="sys.ui.menu.nav">
                <ui:menu-item text="${ lfn:message('home.home') }" icon="lui_icon_s_home" href="/" target="_self" />
                <ui:menu-item text="${ lfn:message('fssc-ledger:table.fsscLedgerInvoice') }" href="/fssc/ledger/fssc_ledger_invoice/" target="_self" />
            </ui:menu>
        </template:replace>
        <template:replace name="content">
    <div class="layui-fluid">
        <div class="layui-card-body layui-card">
            <div class="mfs-bx">
            <c:if test="${fsscLedgerInvoiceForm.fdState=='0'||fsscLedgerInvoiceForm.fdState== 0}">
            	<div class="isTrue">
            		<c:if test="${fsscLedgerInvoiceForm.fdCheckStatus eq '1'}">已验真</c:if>
            		<c:if test="${fsscLedgerInvoiceForm.fdCheckStatus eq '0' or empty fsscLedgerInvoiceForm.fdCheckStatus}">未验真</c:if>
            	</div>
            	</c:if>
                <div class="mfs-bx-header ">
                    <span class="mfs-bx-titile" id="title">
                    <xform:select property="fdInvoiceType" htmlElementProperties="id='fdInvoiceType'" showStatus="view">
                                            <xform:enumsDataSource enumsType="fssc_ledger_type" />
                                        </xform:select>
                    </span></p>
                    <span class="mfs-bx-titile2" id="Span1">发票联
                    </span>
                </div>
                <div class="TableTitle">
                    <table>
                        <tr>
                            <td>发票代码：</td>
                            <td>
                                <input type="text" value="${fsscLedgerInvoiceForm.fdInvoiceCode }" /></td>
                        </tr>
                        <tr>
                            <td>发票号码：</td>
                            <td>
                                <input type="text" value="${fsscLedgerInvoiceForm.fdInvoiceNumber }" /></td>
                        </tr>
                        <tr>
                            <td>开票日期：</td>
                            <td>
                                <input type="text" value="${fsscLedgerInvoiceForm.fdBillingDate }" /></td>
                        </tr>
                        <tr>
                            <td>校&nbsp;&nbsp;验&nbsp;&nbsp;码：</td>
                            <td>
                                <input type="text" value="${fsscLedgerInvoiceForm.fdJym }" /></td>
                        </tr>

                    </table>
                </div>
            </div>
            <div class="fapiao">
                <table class="fapiaoTable">
                    <tr>
                        <td colspan="1" class="shuli">购买方</td>
                        <td colspan="4" style="width: 50%">
                            <table class="BuyTable">
                                <tr>
                                    <td class="BuyTableName">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdPurchaserName }" /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">纳税人识别号：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdPurchaserTaxNo }" /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">地址、&nbsp;&nbsp;&nbsp;电话：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdGfdzdh }"  /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">开户行及账号：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdGfyhzh }" /></td>
                                </tr>
                            </table>
                        </td>
                        <td class="shuli2">密码区</td>
                        <td colspan="4">
                            <table>
                                <tr>
                                    <td rowspan="3" class="TextArea">
                                        <textarea rows="5" cols="100" style="resize: none">
                                            </textarea>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <table class="GoodsTable">
                    <tr>
                        <td style="width: 20%">货物或应税劳务、服务名称</td>
                        <td style="width: 10%">规格型号</td>
                        <td style="width: 5%">单位</td>
                        <td style="width: 10%">数量</td>
                        <td style="width: 10%">单价</td>
                        <td style="width: 20%">金额</td>
                        <td style="width: 5%">税率</td>
                        <td style="width: 20%; border-right: none;">税额</td>
                    </tr>
                    <c:forEach items="${fsscLedgerInvoiceForm.fdDetail_Form}" var="fdDetail_FormItem" varStatus="vstatus">
                    <tr>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdSpmc }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdGgxh }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdJldw }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdSl }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdDj }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdJe }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdSlv }" /></td>
                        <td>
                            <input type="text"  value="${fdDetail_FormItem.fdSe }" /></td>
                    </tr>
                    </c:forEach>
                    <tr>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td>合计</td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr class="GoodsTotal">
                        <td>价税合计(大写)</td>
                        <td colspan="7">
                            <input type="text" style="width: 60%" />
                            (小写)
                            <c:choose>
								<c:when test="${not empty fsscLedgerInvoiceForm.fdJshj}">
									<input type="text" style="width: 30%" value="<kmss:showNumber value="${fsscLedgerInvoiceForm.fdJshj }" pattern="0.00"  />" />
								</c:when>
								<c:when test="${empty fsscLedgerInvoiceForm.fdJshj}">""</c:when>
							</c:choose>
						</td>
                    </tr>
                </table>
                <table class="fapiaoTable">
                    <tr>
                        <td colspan="1" class="shuli">销售方</td>
                        <td colspan="4" style="width: 50%">
                            <table class="BuyTable">
                                <tr>
                                    <td class="BuyTableName">名&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdSalesTaxName }"  /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">纳税人识别号：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdSalesTaxNo }"  /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">地址、&nbsp;&nbsp;&nbsp;电话：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdXfdzdh }"  /></td>
                                </tr>
                                <tr>
                                    <td class="BuyTableName">开户行及账号：</td>
                                    <td class="BuyTableContent">
                                        <input type="text"  value="${fsscLedgerInvoiceForm.fdXfyhzh }"  /></td>
                                </tr>
                            </table>
                        </td>
                        <td class="shuli2">备注</td>
                        <td colspan="4">
                            <table>
                                <tr>
                                    <td rowspan="3" class="TextArea">
                                         <textarea rows="5" cols="100" style="resize: none">${fsscLedgerInvoiceForm.fdBz }
                                            </textarea>
                                        </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>

            </div>
            <div class="TableFooter">
                <span>收款人：
                    <input type="text" />
                </span>
                <span>复核：
                    <input type="text" />
                </span>
                <span>开票人：
                    <input type="text" />
                </span>
                <span>销售方：（章）
                </span>
            </div>
        </div>
    </div>
            
        </template:replace>

    </template:include>