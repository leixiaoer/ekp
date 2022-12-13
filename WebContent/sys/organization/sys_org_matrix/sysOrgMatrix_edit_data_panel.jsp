<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/sys/ui/jsp/common.jsp"%>
<!-- 增加数据类别按钮  start-->
<div class="lui_maxtrix_toolbar">
	<div class="lui_maxtrix_toolbar_r matrix_data_cate" style="float: left;margin-top: 10px;">
		
	</div>
</div>
<!-- 增加数据类别按钮  end-->
<!-- 矩阵卡片 - 左右移动 Starts  -->
<div class="lui_matrix_data_tb_wrap">
    <!-- 类型 -->
    <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_l">
        <table id="matrix_seq_table_${HtmlParam.version}" name="matrix_seq_table_${HtmlParam.version}" data-version="${HtmlParam.version}" class="lui_matrix_tb_normal">
            <tr style="height: 50px;">
                <th class="lui_matrix_td_normal_title"><input id="matrix_seq_checkbox_${HtmlParam.version}" type="checkbox"></th>
                <th class="lui_matrix_td_normal_title"><bean:message key="page.serial"/></th>
            </tr>
        </table>
    </div>
    <!-- 条件数据 -->
    <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_c">
        <table id="matrix_data_table_${HtmlParam.version}" name="matrix_data_table_${HtmlParam.version}" data-version="${HtmlParam.version}" class="lui_matrix_tb_normal">
            <tr style="height: 50px;">
            </tr>
        </table>
    </div>
    <!-- 操作数据 -->
    <div class="lui_matrix_data_tb_item lui_matrix_data_tb_item_r">
        <table id="matrix_opt_table_${HtmlParam.version}" name="matrix_opt_table_${HtmlParam.version}" data-version="${HtmlParam.version}" class="lui_matrix_tb_normal">
            <tr style="height: 50px;">
                <th><bean:message key="list.operation"/></th>
            </tr>
        </table>
    </div>
</div>
<list:paging id="matrix_data_table_${HtmlParam.version}_page" viewSize="5"></list:paging>
<!-- 矩阵卡片 Ends  -->
<!-- 表格脚本 -->
<script language="JavaScript">
	seajs.use(['lui/jquery','lui/dialog', 'lui/topic', 'sys/organization/resource/js/matrixPanel'], function($, dialog, topic, matrixPanel) {
		var matrixPanel = new matrixPanel.MatrixPanel({'version': '${JsParam.version}'});
		matrixPanel.render();
		matrixPanelArray['${JsParam.version}'] = matrixPanel;
		
		//这样处理新建或编辑页面不是直接进入第三步的时候，删除所有版本再建会有bug，先注销掉 #100387
		/* 如果是直接跳到数据页面，需要立即初始化 */
		// 初始化表格
		
		//重复渲染会造成xss转义有问题 先注释 #105130
		//matrixPanel.initDataTab();
		// 初始化数据
		//matrixPanel.initData(); 
		
		window.reloadInitData = function(obj, val) {
			//点击类别切换时保存矩阵数据
			var cateId = $("#lui_matrix_panel_content_" + window.curVersion).find(".lui_maxtrix_cate_item_dis").data("cateid");
			saveCateData(cateid);
			//清除选中样式
			$(obj).parent().parent().find("li").find("a").css({"background-color":"white","color":"black"});
			$(obj).parent().parent().find("li").find("input").removeClass(window.curVersion);
			//设置选中样式
			$(obj).css({"background-color":"#47b5e6","color":"white"});
			$(obj).parent().find("input").addClass(window.curVersion);
			window.fdMartrixTypeId = val;
			//点击每个版本下的数据类别时，动态取对应的版本对象，刷新对应版本下的table
			var matrixPanels = matrixPanelArray[window.curVersion];
			matrixPanels.render();
			// window.fdMartrixTypeId =val+"_"+window.curVersion;
			// 初始化表格
			matrixPanels.initDataTab();
			// 初始化数据
			matrixPanels.initData();
		}
		
		//矩阵加载数据类别时，只触发刷新获取第一个类别的数据，不保存矩阵数据
		window.reloadInitData2 = function(obj, val) {
			//清除选中样式
			$(obj).parent().parent().find("li").find("a").css({"background-color":"white","color":"black"});
			$(obj).parent().parent().find("li").find("input").removeClass(window.curVersion);
			//设置选中样式
			$(obj).css({"background-color":"#47b5e6","color":"white"});
			$(obj).parent().find("input").addClass(window.curVersion);
			window.fdMartrixTypeId = val;
			matrixPanel.render();
			// window.fdMartrixTypeId =val+"_"+window.curVersion;
			// 初始化表格
			matrixPanel.initDataTab();
			// 初始化数据
			matrixPanel.initData();
		}
	});
</script>