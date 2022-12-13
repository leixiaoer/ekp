
var formOption = {
    formName: 'fsscLoanRepaymentForm',
    modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanRepayment',
    templateName: 'com.landray.kmss.fssc.loan.model.FsscLoanReCategory',
    subjectField: 'docSubject',
    mode: 'main_scategory'

    ,
    dialogs: {
        fssc_loan_main_getLoanMain: {
            modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanMain',
            sourceUrl: '/fssc/loan/fssc_loan_main/fsscLoanMainData.do?method=getLoanMain&type=repayment'
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