var formOption = {
    formName: 'fsscBaseItemBudgetForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseItemBudget'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },

        fssc_base_budget_scheme_fdCategory: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetScheme',
            sourceUrl: '/fssc/base/fssc_base_budget_scheme/fsscBaseBudgetSchemeData.do?method=fdCategory'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};