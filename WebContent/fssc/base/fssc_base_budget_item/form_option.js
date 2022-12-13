var formOption = {
    formName: 'fsscBaseBudgetItemForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItem'

    ,
    dialogs: {
        fssc_base_budget_item_fdBudgetItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItem',
            sourceUrl: '/fssc/base/fssc_base_budget_item/fsscBaseBudgetItemData.do?method=fdBudgetItem'
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