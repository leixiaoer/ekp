var formOption = {
    formName: 'fsscExpenseItemConfigForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseItemConfig'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_expense_category_getCategory: {
            modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseCategory',
            sourceUrl: '/fssc/expense/fssc_expense_category/fsscExpenseCategoryData.do?method=getCategory'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent&type=all'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};