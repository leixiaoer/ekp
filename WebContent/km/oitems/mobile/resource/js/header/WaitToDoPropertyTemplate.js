/**
 * 资源头部模板，用于“待我审的”页签
 */
define(['mui/createUtils','mui/i18n/i18n!km-oitems:kmOitemsBudgerApplication.docCreateTime'], function(createUtils,msg){
	
	var h = createUtils.createTemplate;
	
	// 排序（创建时间）
	var publishTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docCreateTime',
			subject: msg['kmOitemsBudgerApplication.docCreateTime'],
			value: 'down'
		}
	});

	// 属性筛选器
	var propertyFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'km/oitems/mobile/resource/js/header/OitemPropertyWaitToDoMixin'
	});
	
	return [publishTimeFilter, propertyFilter].join('');
	
});