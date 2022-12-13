var formOption = {
    formName: 'fsscBaseAccountsForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccounts'

    ,
    dialogs: {
        fssc_base_accounts_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccounts',
            sourceUrl: '/fssc/base/fssc_base_accounts/fsscBaseAccountsData.do?method=fdAccount'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};