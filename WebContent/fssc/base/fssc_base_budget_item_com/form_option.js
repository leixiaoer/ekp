var formOption = {
    formName: 'fsscBaseBudgetItemComForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom'

    ,
    dialogs: {
        fssc_base_budget_item_com_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom',
            sourceUrl: '/fssc/base/fssc_base_budget_item_com/fsscBaseBudgetItemComData.do?method=fdParent'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};