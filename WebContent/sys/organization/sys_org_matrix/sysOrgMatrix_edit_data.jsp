<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>

<script language="JavaScript">
// 当前版本
window.curVersion = undefined;
// 最大版本
window.lastVersion = 1;
<c:if test="${ sysOrgMatrixForm.method_GET == 'edit' || sysOrgMatrixForm.method_GET == 'dataCate' }">
window.lastVersion = ${lastVersion};
</c:if>
// 页签集合，保存所有页签对象，可以通过版本名称获取
window.matrixPanelArray = {};
// 保存已经加载数据的页签
window.matrixDataArray = {};
seajs.use(['lui/jquery', 'lui/dialog', 'lui/topic'], function($, dialog, topic) {
	/* 增加一行 */
	window.addData = function() {
		if(window.matrixPanelArray[window.curVersion]) {
			window.matrixPanelArray[window.curVersion].addData();
		} else {
			dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.empty'/>");
		}
	}
	
	/* 删除一行 */
	window.delData = function(elem) {
		if(window.matrixPanelArray[window.curVersion]) {
			window.matrixPanelArray[window.curVersion].delData(elem);
		} else {
			dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.empty'/>");
		}
	}
	
	/* 批量删除 */
	window.delAllData = function() {
		if(window.matrixPanelArray[window.curVersion]) {
			window.matrixPanelArray[window.curVersion].delAllData();
		} else {
			dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.empty'/>");
		}
	}
	
	/* 导入(整个矩阵) */
	window.importData = function() {
		window.open(Com_Parameter.ContextPath + "sys/organization/sys_org_matrix/sysOrgMatrix.do?method=importData&fdId=" + window.MatrixResult.fdId, "_blank");
	}
	
	/* 批量新增 */
	window.addMoreDatas = function (){
		if(window.curVersion.indexOf("V") > -1){
			dialog.iframe("/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=addMoreDatas&fdId=" + window.MatrixResult.fdId + "&curVersion=" + window.curVersion, 
					'<bean:message key="sysOrgMatrix.edit.bulk" bundle="sys-organization"/>', null, {
					width:900,
					height:600,
					buttons:[{
						name : '<bean:message key="button.ok"/>',
						value : true,
						focus : true,
						fn : function(value, _dialog) {
							var frame = _dialog.frame[0];
							var contentWin = $(frame).find("iframe")[0].contentWindow;
							contentWin.sumitAllData();
							topic.publish("buildTable",contentWin.resultList);
							_dialog.hide();
						}
					}, {
						name : '<bean:message key="button.cancel"/>',
						styleClass:"lui_toolbar_btn_gray",
						value : false,
						fn : function(value, _dialog) {
							_dialog.hide();
						}
					}]
				});
		}else{
			dialog.alert("<bean:message key='sysOrgMatrix.edit.bulk.add.version.tip' bundle='sys-organization'/>");
		}
	}
	
	/* 下载模板(整个矩阵) */
	window.downloadTemplet = function() {
		$.post('<c:url value="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=getVersions" />', {'fdId': window.MatrixResult.fdId}, function(res) {
			if(res.length < 1) {
				dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.nodata.error'/>");
				return;
			} else {
				var downloadForm = $("#downloadTempletForm");
				downloadForm.attr("action", window.downloadTempletFormAction + window.MatrixResult.fdId)
				downloadForm.submit();
			}
		}, 'json');
		
	}
	/* 导出(整个矩阵) */
	window.exportData = function() {
		$.post('<c:url value="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=getVersions" />', {'fdId': window.MatrixResult.fdId}, function(res) {
			if(res.length < 1) {
				dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.nodata.error'/>");
				return;
			} else {
				var downloadForm = $("#downloadMatrixDataForm");
				downloadForm.attr("action", window.downloadMatrixDataFormAction + window.MatrixResult.fdId)
				downloadForm.submit();
			}
		}, 'json');
	}
	
	/* 批量替换 */
	window.batchReplace = function() {
		if(window.matrixPanelArray[window.curVersion]) {
			window.matrixPanelArray[window.curVersion].batchReplace();
		} else {
			dialog.alert("<bean:message bundle='sys-organization' key='sysOrgMatrix.version.empty'/>");
		}
	}
});
</script>

<div class="lui_matrix_div_wrap">
	<!-- 操作按钮 -->
	<div class="lui_maxtrix_toolbar">
		<div class="lui_maxtrix_toolbar_r">
			<a class="com_bgcolor_d" href="javascript:;" onclick="addData();"><bean:message key="button.add"/></a>
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=downloadTemplet&fdId=${sysOrgMatrixForm.fdId}">
			<a class="com_bgcolor_d" href="javascript:;" onclick="downloadTemplet();"><bean:message bundle="sys-organization" key="sysOrgMatrix.template.download"/></a>
			</kmss:auth>
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=importData&fdId=${sysOrgMatrixForm.fdId}">
			<a class="com_bgcolor_d" href="javascript:;" onclick="importData();"><bean:message key="button.import"/></a>
			</kmss:auth>
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=exportMatrixData&fdId=${sysOrgMatrixForm.fdId}">
			<a class="com_bgcolor_d" href="javascript:;" onclick="exportData();"><bean:message key="button.export"/></a>
			</kmss:auth>
			<a class="com_bgcolor_d" href="javascript:;" onclick="addMoreDatas();"><bean:message bundle="sys-organization" key="sysOrgMatrix.edit.bulk.button"/></a>
			<a class="com_bgcolor_d" href="javascript:;" onclick="batchReplace();"><bean:message bundle="sys-organization" key="sysOrgMatrix.edit.batchReplace.button"/></a>
			<a class="com_bgcolor_d" href="javascript:;" onclick="delAllData();"><bean:message key="button.deleteall"/></a>
		</div>
	</div>
	<c:set var="titleicon" value="" />
	<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=deleteVersion&fdId=${sysOrgMatrixForm.fdId}">
	<%-- 有权限时才显示“删除版本”按钮 --%>
	<c:set var="titleicon" value="maxtri_btn_del" />
	</kmss:auth>
	<ui:tabpanel id="lui_matrix_panel" layout="sys.ui.tabpanel.sucktop" var-average='false' var-useMaxWidth='true'>
		<c:choose>
			<c:when test="${ sysOrgMatrixForm.method_GET == 'edit' || sysOrgMatrixForm.method_GET == 'dataCate' }">
				<c:forEach items="${ allVersions }" var="version">
					<ui:content id="lui_matrix_panel_content_${ version.fdName }" title="${ version.fdName }" titleicon="${titleicon}">
						<c:import url="/sys/organization/sys_org_matrix/sysOrgMatrix_edit_data_panel.jsp" charEncoding="UTF-8">
			 		 		<c:param name="version" value="${ version.fdName }"></c:param>
			 		 		<c:param name="step" value="${ param.step }"></c:param>
			  			</c:import>
					</ui:content>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<ui:content id="lui_matrix_panel_content_V1" title="V1" titleicon="maxtri_btn_del">
					<c:import url="/sys/organization/sys_org_matrix/sysOrgMatrix_edit_data_panel.jsp" charEncoding="UTF-8">
		 		 		<c:param name="version" value="V1"></c:param>
		 		 		<c:param name="step" value="${ param.step }"></c:param>
		  			</c:import>
				</ui:content>
				<script language="JavaScript">
					window.lastVersion = 1;
				</script>
			</c:otherwise>
		</c:choose>
		<ui:content id="__add" title="+ ${lfn:message('sys-organization:sysOrgMatrix.version')}" titleicon="maxtri_btn_add">
		</ui:content>
	</ui:tabpanel>
	<c:if test="${ sysOrgMatrixForm.method_GET == 'edit' }">
	<%-- 矩阵与流程模板关系 --%>
	<c:import url="/sys/organization/sys_org_matrix/sysOrgMatrix_template_relation.jsp" charEncoding="UTF-8" >
		<c:param name="matrixId" value="${sysOrgMatrixForm.fdId}"></c:param>
	</c:import>
	</c:if>
</div>
<script language="JavaScript">
	window.historyArray = [];
	seajs.use(['lui/jquery','lui/dialog', 'lui/topic', 'lui/panel'], function($, dialog, topic, panel) {
		LUI.ready(function() {
			var lui_matrix_panel = LUI("lui_matrix_panel");
			var flag = false;
			panelChange = function(evt) {
				if(flag) {
					return false;
				}
				// 获取当前点击的页签
				var cur = evt.panel.contents[evt.index.after];
				var saveFlag = true;
				if(!cur) {
					evt.cancel = true;
					return false;
				}
				var temp = cur.config.title;
				if(cur.id != "__add" && window.curVersion == temp) {
					// 取消切换，防止复制渲染
					evt.cancel = true;
					return false;
				} else if(window.curVersion == temp){
					return false;
				}else if(cur.id != "__add" && window.curVersion&&window.curVersion.indexOf("V") == -1){
					saveFlag = false;
				}
				window.curVersion = temp;
				flag = true;
				var lastVer = historyArray.slice(-1);
				// 页签切换，保存上一个页签的数据
				if(saveFlag){
					saveLastVerData(lastVer);
				}
				// 增加页签逻辑
				if(cur.id == "__add") {
					// 取消切换
					evt.cancel = true;
					window.historyArray.push("add");
					addVersion();
				} else {
					// 加载数据
					var ver = window.curVersion || "V1";
					var __panel = window.matrixPanelArray[ver];
					if(__panel) {
						// 生成表格
						__panel.initDataTab();
						// 填充数据
						__panel.initData(panel.page);
					}
					window.historyArray.push(temp);
				}
				flag = false;
				// 把add后面的标签删除，重新加入当前标签
				var _idx = historyArray.indexOf("add");
				if(_idx > -1) {
					historyArray = historyArray.splice(0, _idx);
				}
			}
			lui_matrix_panel.on("indexChanged", function(evt) {
				setTimeout(function() {panelChange(evt);}, 200);
			});
			
			function addVersion() {
				var max = $("#lui_matrix_panel").find("[data-lui-mark='panel.nav.title']").length - 1;
				var _panel = LUI("lui_matrix_panel");
				// 当前页签
				var curNavFrame = _panel.navs[max].navFrame;
				var newVer = "V" + (window.lastVersion + 1);
				var newId = "lui_matrix_panel_content_" + newVer;
				var newNavFrame = curNavFrame.clone();
				// 设置页签标题
				newNavFrame.find(".lui_tabpanel_navs_item_title").text(newVer);
				// 调整页签位置
				curNavFrame.before(newNavFrame);
				// 增加一个页签
				var content = new panel.Content({"title": newVer, "id": newId});
				_panel.addChild(content);
				_panel.children[max + 1] = _panel.children.splice(max + 2, 1, _panel.children[max + 1])[0];
				_panel.contents[max] = _panel.contents.splice(max + 1, 1, _panel.contents[max])[0];
				// 重新渲染页签
				content.parent = _panel;
				content.startup();
				_panel.doLayout($("#lui_matrix_panel"));
				// 选中新增加的页签
				_panel.setSelectedIndex(max);
				// 填充页签模板
				$.post('<c:url value="/sys/organization/sys_org_matrix/sysOrgMatrix_edit_data_panel.jsp" />', {'version': newVer, 'step': '${param.step}'}, function(html) {
					if(window.console) {
						console.log("增加新版本：", newVer);
					}
					// 版本号+1
					window.lastVersion++;
					$("#lui_matrix_panel_content_" + newVer).html(html);
					// 只生成表格，不填充数据
					var __panel = window.matrixPanelArray[window.curVersion || "V1"];
					if(__panel) {
						__panel.initDataTab(true);
					}
				}, 'html');
			}
			<kmss:auth requestURL="/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=deleteVersion&fdId=${sysOrgMatrixForm.fdId}">
			// 删除版本
			$("#lui_matrix_panel").on("click", ".maxtri_btn_del", function(evt) {
				var __count = $("#lui_matrix_panel").find("[data-lui-mark='panel.nav.frame']").length;
				if(__count <= 2) {
					dialog.alert("至少保留一个版本！");
					return false;
				}
				dialog.confirm(Msg_Info.delete_version, function(value) {
					if(value == true) {
						var version = $(evt.target).parent().attr("title");
						$.post(Com_Parameter.ContextPath + 'sys/organization/sys_org_matrix/sysOrgMatrix.do?method=deleteVersion&fdId=${sysOrgMatrixForm.fdId}', {'fdVersion': version}, function(res) {
							dialog.result(res);
							if(res.status) {
								// 删除标题
								$("#lui_matrix_panel").find("[data-lui-mark='panel.nav.frame']").each(function(i, n) {
									var _nav = $(n).find("[title='" + version + "']");
									if(_nav.length > 0) {
										$(n).remove();
									}
								});
								// 删除内容
								$("#lui_matrix_panel_content_" + version).parents("[data-lui-mark='panel.content']").remove();
								// 删除组件对象
								for(var i=0; i<lui_matrix_panel.children.length; i++) {
									var child = lui_matrix_panel.children[i];
									if(child.config.title == version) {
										lui_matrix_panel.children.splice(i, 1);
										break;
									}
								}
								for(var i=0; i<lui_matrix_panel.contents.length; i++) {
									var content = lui_matrix_panel.contents[i];
									if(content.config.title == version) {
										lui_matrix_panel.contents.splice(i, 1);
										break;
									}
								}
								// 重新渲染页面样式
								lui_matrix_panel.doLayout($("#lui_matrix_panel"));
								// 选择第1个页签
								$("#lui_matrix_panel").find("[data-lui-mark='panel.nav.title']").each(function(i, n) {
									if($(n).attr("title").indexOf("V") > -1) {
										$(n).click();
										return false;
									}
								});
							}
						}, 'json');
					}
				});
			});
			</kmss:auth>
		});
		
		saveLastVerData = function(lastVer) {
			var _panel = LUI("lui_matrix_panel_content_" + lastVer);
			if(_panel) {
				var cateid = _panel.element.find(".lui_maxtrix_cate_item_dis").data("cateid");
				var isEnabledCate = $("[name=fdIsEnabledCate]:checked").val();
				if(isEnabledCate == '1' && !cateid) {
					// 开启分组，但是没有取到分组ID，忽略保存
					return false;
				}
				var version = _panel.title;
				saveCateData(version, cateid, function(res) {
					if(res) {
						// 清空页面数据
						$("#matrix_data_table_" + version).find("tr:gt(0)").remove();
						$("#matrix_seq_table_" + version).find("tr:gt(0)").remove();
						$("#matrix_opt_table_" + version).find("tr:gt(0)").remove();
					}
				});
			}
		}
		
		// ==================== 以下为公共方法（注意公共方法取页面元素时，需要指定当前版本） ==================

		/* 判断字符串结尾 */
		window.endWith = function(str, target) {
			var start = str.length - target.length;
			var arr = str.substr(start, target.length);
			if(arr == target) {
				return true;
			}
			return false;
		}
		
		/* 去除数组中的空字符串 */
		window.trimSpace = function(array) {
			for(var i=0; i<array.length; i++) {
		         if(array[i] == "" || array[i] == " " || array[i] == null || typeof(array[i]) == "undefined") {
		         	array.splice(i,1);
		            i= i-1;
		         }
		     }
		     return array;
		}
		
		/* 唯一校验提示 */
		window.uniqueError = function(val) {
			dialog.failure("<bean:message bundle='sys-organization' key='sysOrgMatrixRelation.fdIsUnique.err.left'/>" + val + "<bean:message bundle='sys-organization' key='sysOrgMatrixRelation.fdIsUnique.err.right'/>");
		}
		
		/* 地址本 */
		window.Dialog_Address_Cust = function(mulSelect, idField, nameField, splitStr, selectType, action) {
			var curArea = $("#lui_matrix_panel_content_" + window.curVersion);
			var _idField = curArea.find("input[name='" + idField + "']");
			var _nameField = curArea.find("input[name='" + nameField + "']");
			var _tmplField = curArea.find("div[data-name='" + nameField + "']");
			
			// 往临时表单填充数据
			$("input[name='__idField']").val(_idField.val());
			$("input[name='__nameField']").val(_nameField.val());
			
			Dialog_Address(mulSelect, "__idField", "__nameField", splitStr, selectType, function(result) {
				if(action) {
					action(result, idField, nameField);
				} else {
					if(result.data.length > 0) {
						var rowNum = _idField.parent().parent().parent().prevAll().length;
						var ___idField = idField.replace(/\[[^\]]+\]/g, '');
						var checked = checkUnique(___idField, rowNum, result.data[0].id);
						if(checked) {
							var ids = [], names = [];
							for(var i=0; i<result.data.length; i++) {
								ids.push(result.data[i].id);
								names.push(result.data[i].name);
							}
							_idField.val(ids.join(";"));
							_nameField.val(names.join(";"));
							_tmplField.html(names.join(";"));
						} else {
							uniqueError(result.data[0].name);
						}
					} else {
						_idField.val("");
						_nameField.val("");
						_tmplField.html("");
					}
				}
				// 清除临时表单填充数据
				$("input[name=__idField]").val("");
				$("input[name=__nameField]").val("");
			});
		}
		
		/* 常量唯一性校验 */
		window.checkconstant = function(elem) {
			var val = $(elem).val(),
				name = $(elem).attr("name"),
				name = name.replace(/\[[^\]]+\]/g, ''),
				rowNum = $(elem).parent().parent().prevAll().length;
			if(!checkUnique(name, rowNum, val)) {
				$(elem).val("");
				uniqueError(val);
			}
		}
		
		/* 唯一性校验 */
		window.checkUnique = function(field, rowNum, value) {
			var checked = true;
			value = value.replace(/(^\s*)|(\s*$)/g, "");
			if(value.length == 0) {
				// 空数据不校验
				return checked;
			}
			if(window.MatrixResult.fdRelationConditionals) {
				for(var i=0; i<window.MatrixResult.fdRelationConditionals.length; i++) {
					var con = window.MatrixResult.fdRelationConditionals[i];
					if(field == con.fdId && "true" == String(con.fdIsUnique)) {
						var id = $("#matrix_seq_table_" + window.curVersion + " tr:eq(" + rowNum + ")").find("[type=checkbox]").val();
						// 检查后台数据
						var data = new KMSSData();
						data.UseCache = false;
						data.AddBeanData("sysOrgMatrixService&type=unique&matrixId=${sysOrgMatrixForm.fdId}&field=" + field + "&version=" + window.curVersion + "&id=" + id + "&value=" + window.encodeURIComponent(value));
						var rtn = data.GetHashMapArray();
						if(rtn.length > 0) {
							checked = false;
						}
						if(checked) {
							// 如果后台数据没有重复，还需要检查页面数据
							var tab = $("#matrix_data_table_" + window.curVersion),
								th = tab.find("th[data-field='" + con.fdFieldName + "']"),
								idx = th.prevAll().length;
							tab.find("tr").each(function(i, n) {
								var val = $(n).find("td:eq(" + idx + ")").find("[name^="+field+"]").val();
								if(value == val && rowNum != i) {
									checked = false;
									return false;
								}
							});
						}
						break;
					}
				}
			}
			return checked;
		}
		
		/* 检查结果集数量 */
		window.resultCheck = function(rtnVal, idField, nameField) {
			var curArea = $("#lui_matrix_panel_content_" + window.curVersion),
			__idField = curArea.find("input[name='" + idField + "']"),
			__nameField = curArea.find("input[name='" + nameField + "']");
			if(rtnVal && rtnVal.data) {
				// 大于27组数据，强制裁剪
				if(rtnVal.data.length > 27) {
					rtnVal.data = rtnVal.data.slice(0, 27);
					// 弹出提示信息
					dialog.alert(Msg_Info.sysOrgMatrix_result_maxLen);
				}
				var ids = [], names = [];
				for(var i=0; i<rtnVal.data.length; i++) {
					ids.push(rtnVal.data[i].id);
					names.push(rtnVal.data[i].name);
				}
				__idField.val(ids.join(";"));
				__nameField.val(names.join(";"));
			} else {
				__idField.val("");
				__nameField.val("");
			}
		}
		
		/* 主要处理人+岗位的数据 */
		window.resultCheck2 = function(rtnVal, idField, nameField) {
			var curArea = $("#lui_matrix_panel_content_" + window.curVersion);
			var split = idField.split("_"),
				id = split[0],
				type = split[1],
				field = curArea.find("input[name='" + id + "']"),
				__idField = curArea.find("input[name='" + idField + "']"),
				__nameField = curArea.find("input[name='" + nameField + "']"),
				value = field.val() || "{}",
				json = JSON.parse(value);
				
			var __postId, __postName;
			// 如果选择的是人员，需要把岗位带出来
			if(idField.indexOf("_person") > 0) {
				var postIdField = idField.replace(/person/g, "post");
				var __post = $(curArea).find("div[name='" + postIdField + "']");
				__postId = __post.find("input[name='" + postIdField + "']"),
				__postName = __post.find("input[name='" + nameField.replace(/person/g, "post") + "']");
			}
			if(rtnVal && rtnVal.data && rtnVal.data.length > 0) {
				// 增加或替换
				json[type] = rtnVal.data[0].id;
				__idField.val(rtnVal.data[0].id);
				__nameField.val(rtnVal.data[0].name);
				if(__postId) {
					// 根据人员获取该人员的岗位信息
					var data = new KMSSData();
					data.UseCache = false;
					data.AddBeanData("sysOrgMatrixService&type=get_post&person=" + rtnVal.data[0].id);
					var rtn = data.GetHashMapArray();
					if(rtn.length > 0) {
						var postId = rtn[0].postId;
						var postName = rtn[0].postName;
						// 岗位信息填充到页面
						json['post'] = postId;
						__postId.val(postId);
						__postName.val(postName);
					} else {
						delete json['post'];
						__postId.val("");
						__postName.val("");
					}
				}
			} else {
				// 删除
				delete json[type];
				__idField.val("");
				__nameField.val("");
				if(__postId) {
					delete json['post'];
					__postId.val("");
					__postName.val("");
				}
			}
			field.val(JSON.stringify(json));
		}
		
		/* 自定义数据 */
		window.Dialog_CustData = function(mulSelect, idField, nameField, splitStr, treeBean, treeTitle) {
			var curArea = $("#lui_matrix_panel_content_" + window.curVersion);
			var _idField = curArea.find("input[name='" + idField + "']");
			var _nameField = curArea.find("input[name='" + nameField + "']");
			// 往临时表单填充数据
			$("input[name='__idField']").val(_idField.val());
			$("input[name='__nameField']").val(_nameField.val());
			Dialog_Tree(mulSelect, "__idField", "__nameField", splitStr, treeBean, treeTitle, null, function(result) {
				if(result.data.length > 0) {
					var rowNum = _idField.parent().parent().parent().prevAll().length;
					var ___idField = idField.replace(/\[[^\]]+\]/g, '');
					var checked = checkUnique(___idField, rowNum, result.data[0].id);
					if(checked) {
						var ids = [], names = [];
						for(var i=0; i<result.data.length; i++) {
							ids.push(result.data[i].id);
							names.push(result.data[i].name);
						}
						_idField.val(ids.join(";"));
						_nameField.val(names.join(";"));
					} else {
						uniqueError(result.data[0].name);
					}
				} else {
					_idField.val("");
					_nameField.val("");
				}
				// 清除临时表单填充数据
				$("input[name=__idField]").val("");
				$("input[name=__nameField]").val("");
			});
		}

		/* 系统主数据 */
		window.Dialog_MainData = function(fieldId, fieldName, title) {
			var curArea = $("#lui_matrix_panel_content_" + window.curVersion);
			var _idField = curArea.find("input[name='" + fieldId + "']");
			var selected = _idField.val();
			// fieldName过滤[X]字符
			var _fieldName = fieldName.replace(/\[[^\]]+\]/g, '');
			dialog.iframe("/sys/organization/sys_org_matrix/sysOrgMatrixData_mainData.jsp?matrixId=" + window.MatrixResult.fdId + "&fieldName=" + _fieldName + "&selected=" + selected,
					title, function(data) {
				if(data) {
					if(data == "clear") {
						curArea.find("input[name='" + fieldId + "']").val("");
						curArea.find("input[name='" + fieldName + "']").val("");
					} else {
						var rowNum = _idField.parent().parent().parent().prevAll().length;
						var ___idField = fieldId.replace(/\[[^\]]+\]/g, '');
						var checked = checkUnique(___idField, rowNum, data.id);
						if(checked) {
							curArea.find("input[name='" + fieldId + "']").val(data.id);
							curArea.find("input[name='" + fieldName + "']").val(data.name);
						} else {
							uniqueError(data.name);
						}
					}
				}
			}, {
				width : 1200,
				height : 600,
				buttons : [{
					name : Msg_Info.button_ok,
					focus : true,
					fn : function(value, dialog) {
						if(dialog.frame && dialog.frame.length > 0) {
							var frame = dialog.frame[0];
							var contentDoc = $(frame).find("iframe")[0].contentDocument;
							$(contentDoc).find("input[name='List_Selected']:checked").each(function(i, n) {
								value = {};
								value.id = $(n).val();
								value.name = $(n).parent().parent().find("td.mainData_title:first").text();
								return true;
							});
						}
						setTimeout(function() {
							dialog.hide(value);
						}, 200);
					}
				}, {
					name : Msg_Info.button_cancel,
					styleClass : 'lui_toolbar_btn_gray',
					fn : function(value, dialog) {
						dialog.hide();
					}
				}, {
					name : Msg_Info.button_clear,
					styleClass : 'lui_toolbar_btn_gray',
					fn : function(value, dialog) {
						dialog.hide("clear");
					}
				}]
			});
		}
		
		/* 分组数据切换 */
		window.switchCateData = function(elem, dataCateId) {
			var parent = $(elem).parent(),
				cateid = parent.find(".lui_maxtrix_cate_item_dis").data("cateid");
			// 禁用本按钮，启用其它按钮
			if($(elem).hasClass("lui_maxtrix_cate_item_dis")) {
				return false;
			}
			parent.find("a").each(function(i, n) {
				$(n).removeClass("lui_maxtrix_cate_item_dis");
			});
			$(elem).addClass("lui_maxtrix_cate_item_dis");
			// 保存原分组数据，保存成功后，加载新分组数据
			saveCateData(window.curVersion, cateid, function(res) {
				if(res) {
					// 清空页面数据
					$("#matrix_data_table_" + window.curVersion).find("tr:gt(0)").remove();
					$("#matrix_seq_table_" + window.curVersion).find("tr:gt(0)").remove();
					$("#matrix_opt_table_" + window.curVersion).find("tr:gt(0)").remove();
					// 重新加载分组数据
					window.fdDataCateId = dataCateId;
					var _panel = window.matrixPanelArray[window.curVersion];
					if(_panel) {
						_panel.initData();
					}
				}
			});
		}
		
		/* 保存分组数据 */
		window.saveCateData = function(version, cateid, callback) {
			var datas = [];
			$("#matrix_seq_table_" + version + " tbody").find("tr:gt(0)").each(function(i, n) {
				var obj = {};
				var fdId = $(n).find("[type=checkbox]").val();
				if(fdId.length > 0 && fdId != 'on' && fdId.indexOf("new_") == -1) {
					obj['fdId'] = fdId;
				}
				var hasVal = false;
				$("#matrix_data_table_" + version).find("tbody tr:eq(" + (i + 1) + ")").find("[data-type=fieldId]").each(function(j, m) {
					var name = $(m).attr("name").replace(/\[[^\]]+\]/g, '');
					var value = $(m).val();
					if(value.length > 0) {
						hasVal = true;
						obj[name] = value;
					}
				});
				if(hasVal) {
					datas.push(obj);
				}
			});
			if(datas.length == 0) {
				if(callback) {
					callback(true);
				}
				return false;
			}
			$.ajax({
				url :'${LUI_ContextPath}/sys/organization/sys_org_matrix/sysOrgMatrix.do?method=saveMatrixDataByCate',
				type: 'POST',
				dataType: 'json',
				data: {'matrixId': window.MatrixResult.fdId, 'version': version, 'cateId': cateid, 'matrixData': JSON.stringify(datas)},
				success: function(res) {
					if(callback) {
						callback(res);
					} else {
						if(!res.status) {
							dialog.failure(res.msg);
						}
					}
				},
				error: function() {
					dialog.failure(Msg_Info.errors_unknown);
				}
			});
		}
		
		$(function() {
			// 监听STEP的变化
			topic.subscribe('showMatrixData', function(evt) {
				if(evt) {
					window.MatrixResult = evt;
				}
				if(window.matrixPanelArray) {
					for(var idx in window.matrixPanelArray) {
						var panel = window.matrixPanelArray[idx];
						if(panel) {
							// 生成表格
							panel.initDataTab();
						}
					}
					// 填充数据
					if(!$.isEmptyObject(window.matrixPanelArray)) {
						var _panel = window.matrixPanelArray[window.curVersion || "V1"];
						if(_panel) {
							_panel.initData(panel.page);
						}
					}
				}
			});
			topic.subscribe('buildTable', function(evt) {
				if(evt && evt.length > 0) {
					if(window.matrixPanelArray) {
						// 填充数据
						window.matrixPanelArray[window.curVersion || "V1"].initDataByBulkAdd(panel.page,evt);
					}
				}
			});
		});
	});
</script>