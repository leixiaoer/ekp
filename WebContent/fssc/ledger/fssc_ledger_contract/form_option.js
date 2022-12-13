
var formOption = {
    formName: 'fsscLedgerContractForm',
    modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerContract',
    templateName: '',
    subjectField: 'fdContractName',
    mode: ''

    ,
    dialogs: {
        fssc_base_supplier_getSupplier: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSupplier',
            sourceUrl: '/fssc/base/fssc_base_supplier/fsscBaseSupplierData.do?method=getSupplier'
        },
        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
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