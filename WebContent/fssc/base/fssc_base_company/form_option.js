var formOption = {
    formName: 'fsscBaseCompanyForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany'

    ,
    dialogs: {
        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_company_group_fdGroup: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompanyGroup',
            sourceUrl: '/fssc/base/fssc_base_company_group/fsscBaseCompanyGroupData.do?method=fdGroup'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};