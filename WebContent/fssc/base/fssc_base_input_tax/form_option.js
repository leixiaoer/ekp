
var formOption = {
    formName: 'fsscBaseInputTaxForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInputTax'

    ,
    dialogs: {
        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },

        fssc_base_accounts_com_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
            sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdAccount'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    detailTables: [],
    dataType: {}
};