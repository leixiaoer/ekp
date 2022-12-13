/**
 * 新闻头部模板，用于“待我审的”页签
 */
define(['mui/createUtils','mui/i18n/i18n!km-asset:kmAssetApplyBase'], function(createUtils,msg){
	
	var h = createUtils.createTemplate;
	
	// 排序（申请日期）
	var createTimeSort = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'fdCreateDate',
			subject: msg['kmAssetApplyBase.fdCreateDate'],
			value: 'down'
		}
	});
	
	
	// 属性筛选器
	var propertyFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'km/asset/mobile/apply_asset/js/header/ApprovalPropertyMixin'
	});
	
	return [createTimeSort, propertyFilter].join('');
	
});