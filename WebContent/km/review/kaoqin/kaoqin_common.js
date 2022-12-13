function selectedIndex (domObj) {
	if (window.dojo) {
		if ($(domObj)[0].name) {
			return $(domObj)[0].name.split(".")[2];
		} else {
			return $(domObj)[0].valueField.split(".")[2];
		}

	} else {
		return $(domObj).attr("name").split(".")[2];
	}	
}

function getInputField(fielId, tableId, index) {
	var domObj = null;
	if (index != null && index != 'undefined') {		
		domObj = $('input[name="extendDataFormInfo.value(' + tableId + '.' + index + '.' + fielId + ')"]');
	} else {
		domObj = $('input[name="extendDataFormInfo.value(' + fielId +')"]');
	}
	return domObj;
}

function getSelectField(fielId, tableId, index) {
	if (window.dojo) {
		return getInputField(fielId, tableId, index);
	} else {
		var domObj = null;
		if (index != null && index != 'undefined') {
			domObj = $('select[name="extendDataFormInfo.value(' + tableId + '.' + index + '.' + fielId + ')"]');
		} else {
			domObj = $('select[name="extendDataFormInfo.value(' + fielId +')"]');
		}
		return domObj;
	}
}

function showMsg (msg) {
	if (window.dojo) {
		require(["mui/dialog/Tip"], function (tip) {
			tip.fail({
				text : msg
			});
		});
	} else {
		seajs.use(['lui/dialog'], function(dialog) {
			dialog.alert(msg);
		});	
	}
}

