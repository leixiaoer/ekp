var formOption = {
    formName: 'fsscBaseTaxRateForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseTaxRate'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
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