
var formOption = {
    formName: 'fsscExpenseBalanceForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseBalance',
    templateName: '',
    subjectField: 'docSubject',
    mode: ''

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },
        
        fssc_base_voucher_type_selectVoucherType: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVoucherType',
            sourceUrl: '/fssc/base/fssc_base_voucher_type/fsscBaseVoucherTypeData.do?method=getVoucherType'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent&type=all'
        },

        fssc_base_accounts_com_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
            sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdAccount'
        },

        fssc_base_cash_flow_getCashFlow: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCashFlow',
            sourceUrl: '/fssc/base/fssc_base_cash_flow/fsscBaseCashFlowData.do?method=fdParent'
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