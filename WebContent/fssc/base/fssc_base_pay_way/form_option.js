var formOption = {
    formName: 'fsscBasePayWayForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },

        fssc_base_accounts_com_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
            sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdAccount&fdType=add'
        },

        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank&fdType=add'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};