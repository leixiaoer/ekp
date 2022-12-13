
var formOption = {
    formName: 'fsscCashierPaymentForm',
    modelName: 'com.landray.kmss.fssc.cashier.model.FsscCashierPayment'


    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_pay_way_fdPayWay: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay',
            sourceUrl: '/fssc/base/fssc_base_pay_way/fsscBasePayWayData.do?method=fdPayWay'
        },

        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },
        fssc_cmb_city_code: {
        	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbCityCode',
             sourceUrl: '/fssc/cmb/fssc_cmb_city_code/fsscCmbCityCodeData.do?method=fdCityCode'
         }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};