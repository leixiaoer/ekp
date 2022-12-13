
var formOption = {
    formName: 'fsscCashierRuleConfigForm',
    modelName: 'com.landray.kmss.fssc.cashier.model.FsscCashierRuleConfig'

    ,
    dialogs: {
        fssc_cashier_model_config_fdCashierPaymentModelConfig: {
            modelName: 'com.landray.kmss.fssc.cashier.model.FsscCashierModelConfig',
            sourceUrl: '/fssc/cashier/fssc_cashier_model_config/fsscCashierModelConfigData.do?method=fdCashierPaymentModelConfig'
        },
        fssc_cashier_model_config_fdCategory: {
            modelName: 'com.landray.kmss.fssc.cashier.model.FsscCashierModelConfig',
            sourceUrl: '/fssc/cashier/fssc_cashier_model_config/fsscCashierModelConfigData.do?method=fdCategory'
        },
        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank'
        },
        fssc_base_pay_way_fdPayWay: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay',
            sourceUrl: '/fssc/base/fssc_base_pay_way/fsscBasePayWayData.do?method=fdPayWay'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};