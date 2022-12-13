var formOption = {
    formName: 'fsscExpenseShareMainForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseShareMain',
    templateName: 'com.landray.kmss.fssc.expense.model.FsscExpenseShareCategory',
    subjectField: 'docSubject',
    mode: 'main_scategory'

    ,
    dialogs: {
        fssc_expense_main_getExpenseMain: {
            modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseMain',
            sourceUrl: '/fssc/expense/fssc_expense_main/fsscExpenseMainData.do?method=getExpenseMain'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },
        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};