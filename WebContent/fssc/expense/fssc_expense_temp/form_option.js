
var formOption = {
    formName: 'fsscExpenseTempForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseTemp',
    templateName: '',
    subjectField: 'fdMainId',
    mode: '',
	dialogs:{
		fssc_base_expense_item_selectExpenseItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },
        fssc_base_tax_rate_getTaxRate: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseTaxRate',
            sourceUrl: '/fssc/base/fssc_base_tax_rate/fsscBaseTaxRateData.do?method=getTaxRate'
        },
        fssc_ledger_fdInvoice: {
        	modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice',
        	sourceUrl: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoiceData.do?method=fdInvoice'
        }
	},
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    detailTables: [],
    dataType: {},
    detailNotNullProp: {
        fdInvoiceListTemp_Form: {
            text: [],
            textarea: []
        }
    }
};