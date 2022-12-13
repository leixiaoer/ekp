<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/lfn.tld" prefix="lfn"%>
<%@ taglib uri="/WEB-INF/KmssConfig/sys/ui/ui.tld" prefix="ui"%>
<%@ taglib uri="/WEB-INF/kmss-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/kmss.tld" prefix="kmss"%>
<kmss:auth
			requestURL="/sys/right/cchange_doc_right/cchange_doc_right.jsp?modelName=${param.modelName}&categoryId=${param.categoryId}&nodeType=${param.nodeType }"
			requestMethod="GET">
	<script type="text/javascript">
	
	function changeRightCheckSelect() { 
		var values = "";
		var selected;
		var select = document.getElementsByName("List_Selected");
		for ( var i = 0; i < select.length; i++) {
			if (select[i].checked) {
				selected = true;
				values += select[i].value+';';
			}
		}
		if(values){
			values = values.substring(0,values.length - 1);
		}
		if (selected) {
			var url="/km/pindagate/km_pindagate_ui/kmPindagateMain_changeDocRight.jsp";
			url+="?modelName=${JsParam.modelName}&categoryId=${JsParam.categoryId}";
			url+="&authReaderNoteFlag=${JsParam.authReaderNoteFlag}";
			url+="&fdIds="+values;
			url+="&attributeList=${JsParam.attributeList}";
			url+="&attributelabelList=${JsParam.attributelabelList}";
			seajs.use( [ 'lui/dialog','lui/topic' ], function(dialog,topic) {
				dialog.iframe(url,"${lfn:message('sys-right:right.button.changeRightBatch')}", function(value) {
					//topic.publish('list.refresh');
				}, {
					"width" : 800,
					"height" : 500
				});
			});
			//Com_OpenWindow(url,'_blank','height=650, width=800, toolbar=0, menubar=0, scrollbars=1, resizable=1, status=1');
			return;
		} else {
			seajs
					.use(
							[ 'lui/dialog' ],
							function(dialog) {
								dialog
										.alert("${lfn:message('sys-right:right.change.batch.selectdocfirst')}");
							});
		}
	}
</script>
	<ui:button
		text="${ lfn:message('sys-right:right.button.changeRightBatch')}"
		order="4" onclick="changeRightCheckSelect()">
	</ui:button>
</kmss:auth>
