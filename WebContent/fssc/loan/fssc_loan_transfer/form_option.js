
var formOption = {
    formName: 'fsscLoanTransferForm',
    modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanTransfer',
    templateName: '',
    subjectField: 'docSubject',
    mode: ''

    ,
    dialogs: {
        fssc_loan_main_getLoanMain: {
            modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanMain',
            sourceUrl: '/fssc/loan/fssc_loan_main/fsscLoanMainData.do?method=getLoanMain&type=transfer'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};