var formOption = {
    formName: 'fsscBaseCashFlowForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCashFlow'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },
        fssc_base_cashFlow_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCashFlow',
            sourceUrl: '/fssc/base/fssc_base_cash_flow/fsscBaseCashFlowData.do?method=fdParent&fdType=add'
        },
        fssc_base_accounts_com_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
            sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdAccount&fdType=add'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};