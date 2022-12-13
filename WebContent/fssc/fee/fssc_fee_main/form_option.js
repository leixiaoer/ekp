var formOption = {
    formName: 'fsscFeeMainForm',
    modelName: 'com.landray.kmss.fssc.fee.model.FsscFeeMain',
    templateName: 'com.landray.kmss.fssc.fee.model.FsscFeeTemplate',
    subjectField: 'docSubject',
    mode: 'main_template'
    , dialogs: {
    	fssc_fee_to_expense: {
             modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseCategory',
             sourceUrl: '/fssc/fee/fssc_fee_template/fsscFeeTemplateData.do?method=getExpenseCategory'
         }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};