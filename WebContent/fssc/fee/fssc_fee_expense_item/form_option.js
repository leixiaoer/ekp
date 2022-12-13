
var formOption = {
    formName: 'fsscFeeExpenseItemForm',
    modelName: 'com.landray.kmss.fssc.fee.model.FsscFeeExpenseItem'

    ,
    dialogs: {
        fssc_fee_template_getTemplate: {
            modelName: 'com.landray.kmss.fssc.fee.model.FsscFeeTemplate',
            sourceUrl: '/fssc/fee/fssc_fee_template/fsscFeeTemplateData.do?method=getTemplate'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
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