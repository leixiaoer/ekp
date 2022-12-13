var formOption = {
    formName: 'fsscBasePaymentForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayment',
    templateName: '',
    subjectField: 'fdSubject',
    mode: ''

    ,
    dialogs: {
        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },
        fssc_base_pay_way_getPayWay: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay',
            sourceUrl: '/fssc/base/fssc_base_pay_way/fsscBasePayWayData.do?method=fdPayWay'
        },
        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};