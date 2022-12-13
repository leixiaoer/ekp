/**
 * 规范制度头部模板，用于待我审的
 */
define(['mui/createUtils', 'mui/i18n/i18n!km-institution:mobile'], function(createUtils, msg){
	
	var h = createUtils.createTemplate;
	
	// 排序（录入时间）
	var createTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docCreateTime',
			subject: msg['mobile.kmInstitution.entryTime'],
			value: 'down'
		}
	});
	
	// 属性筛选器
	var propertyFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'km/institution/mobile/resource/js/header/ApprovalInstitutionPropertyMixin'
	});
	
	// 分类筛选器
	var categoryFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/catefilter/FilterItem',
		dojoMixins: 'mui/simplecategory/SimpleCategoryMixin',
		dojoProps: {
			modelName: 'com.landray.kmss.km.institution.model.KmInstitutionTemplate',
			catekey: 'categoryId',
			prefix:''
		}
	});

	return [createTimeFilter, propertyFilter, categoryFilter].join('');
	
});