var formOption = {
    formName: 'fsscBaseCostCenterForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },

        fssc_base_cost_type_fdType: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostType',
            sourceUrl: '/fssc/base/fssc_base_cost_type/fsscBaseCostTypeData.do?method=fdType'
        },

        fssc_base_cost_center_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=fdParent'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};