define([ "dojo/_base/declare","mui/search/SearchBar","mui/i18n/i18n!sys-mobile"],
		function(declare, SearchBar,Msg) {

			return declare("mui.selectdialog.DialogSearchBar",
					[ SearchBar ],{
						
						//搜索请求地址
						searchUrl : null,
						//搜索结果直接挑转至searchURL界面
						jumpToSearchUrl:false,
						
						//搜索关键字
						keyword : "",
						
						//例外类别id
						exceptValue:'',
						
						//提示文字
						placeHolder : Msg['mui.search.search'],

						//是否需要输入提醒
						needPrompt:false,
						
						orgType:null,
		});
});
