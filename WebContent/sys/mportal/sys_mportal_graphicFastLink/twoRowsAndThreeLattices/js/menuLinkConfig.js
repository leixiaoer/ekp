	/**
	 * 打开系统链接选择框
	 * @return
	 */
	function openSelectSystemLinkDialog(nameField,linkField,jsp,title){
		var _dialogWin = window.parent || dialogWin || window;
		seajs.use(['lui/dialog','lui/jquery'],function(dialog){
			dialog.iframe(jsp, title, function(val){
				if(!val){
					return;
				}
				var title = "";
				var link = "";
				if(val.length>0){
					title = val[0].name;
					link = val[0].link;
				}
				$("#"+nameField).val(title);
				$("#"+linkField).val(link);
			}, {width:750,height:580,"topWin":_dialogWin});
		});
	}
	
	/**
	 * 打开图标选择框
	 * @return
	 */
	function openSelectIconDialog(iconField,jsp,title){
		var _dialogWin = window.parent || dialogWin || window;
		seajs.use(['lui/dialog','lui/jquery'],function(dialog){
			dialog.iframe(jsp, title, function(returnData){
				if(!returnData){
					return;
				}
				var iconType = returnData.iconType; // 1、图片图标      2、字体图标     3、文字 
				var val = "";
				if(iconType == 1){  // 图片图标
					val = returnData.className;
				}else if(iconType == 2){        // 字体图标 
					val = returnData.className;
				}else if(iconType == 3){  // 文字
					val = returnData.text;
				}
				setIconContent(iconField,val);
			}, {width:750,height:580,"topWin":_dialogWin});
		});		
	}
	
	
	function setIconContent(iconField,val){	
		var claz2 = val;
		var $iconPanel = $("#"+iconField+"_panel");
		var claz1 = $iconPanel.attr('claz');
		$iconPanel.attr('claz',claz2);
		if(claz2.indexOf('mui')>=0){ // 图标
			$iconPanel.text("");
			$iconPanel.removeClass(claz1);
			$iconPanel.addClass(claz2);
		}else{ // 文字
			$iconPanel.removeClass(claz1);
			$iconPanel.text(claz2);
		}
		$("#"+iconField).val(claz2);		
	}