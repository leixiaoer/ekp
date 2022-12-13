
var formOption = {
    formName: 'fsscLedgerInvoiceForm',
    modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice',
    templateName: '',
    subjectField: 'fdInvoiceNumber',
    mode: ''


    ,
    dialogs: {
        eop_basedata_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
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