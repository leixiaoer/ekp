/**
 * 规范制度头部模板，用于“全部制度”页签
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
	
	// 排序（生效时间）
	var publishTimeFilter = h('div', {
		dojoType: 'mui/sort/SortItem',
		dojoProps: {
			name: 'docPublishTime',
			subject: msg['mobile.kmInstitution.effectiveTime'],
			value: ''
		}
	});
	
	// 属性筛选器
	var propertyFilter = h('div', {
		className: 'muiHeaderItemRight',
		dojoType: 'mui/property/FilterItem',
		dojoMixins: 'km/institution/mobile/resource/js/header/AllInstitutionPropertyMixin'
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
	
	return [createTimeFilter, publishTimeFilter, propertyFilter, categoryFilter].join('');
	
});