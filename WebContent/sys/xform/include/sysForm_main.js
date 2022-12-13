	/**
	 * html解码
	 */
	function sysFormMain_HtmlUnEscape(s){
		if (s == null || s ==' ') return '';
		s = s.replace(/&amp;/g,"\&");
		s = s.replace(/&quot;/g,"\"");
		s = s.replace(/&lt;/g,"\<");
		s = s.replace(/&#39;/g,"\'");
		return s.replace(/&gt;/g,"\>");
	}

	/**
	 * 修复placeholder转译问题
	 */
	function sysFormMain_fixPlaceholder(dom){
		var placeholder = $(dom).attr('placeholder');
		if(placeholder){
			placeholder = sysFormMain_HtmlUnEscape(placeholder);
			$(dom).attr('placeholder',placeholder);
		}
	}

	/**
	 * 修复Xform提示信息转译问题
	 * @param argus
	 * @private
	 */
	function __fixXformTipInfo(argus) {
		var context = document;
		if (argus && argus.row) {
			context = argus.row;
		}
		//修复input转译提示问题
		$(context).find("xformflag input").each(function (index, dom){
			sysFormMain_fixPlaceholder(dom);
		});
		//修复textarea转译提示问题
		$(context).find("xformflag textarea").each(function (index, dom){
			sysFormMain_fixPlaceholder(dom);
		});
	}

	function __fixLabelStyle(argus) {
		var context = document;
		if (argus && argus.row) {
			context = argus.context;
		}
		$('.xform_label',context).each(function (index, dom) {
			var html = dom.innerHTML;
			var reg = new RegExp("&nbsp;","g");
			html = html.replace(reg, " ");
			html = html.replace(/\s*$/g, "");
			dom.innerHTML = html;
		});
	}

	/**
	 * 修复xform问题
	 * @param argus
	 * @private
	 */
	function __fixXformProblem(argus){
		// #100523 单词截断，把空格符替换成空格保证换行样式能生效
		__fixLabelStyle(argus);
		__fixXformTipInfo(argus);
	}

	Com_AddEventListener(window, 'load', function() {
		__fixXformProblem();
	});
	
	//复制事件绑定
	$(document).on('table-copy-new','table[showStatisticRow]',function(e,argus){
		__fixXformProblem(argus);
	});
	
	// 新增行的时候，也自动计算
	$(document).on('table-add-performance','table[showStatisticRow]',function(e,argus){
		__fixXformProblem(argus);
	});

