var formOption = {
    formName: 'fsscBaseSupplierForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSupplier'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },
        
        fssc_cmb_city_code: {
         	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbCityCode',
            sourceUrl: '/fssc/cmb/fssc_cmb_city_code/fsscCmbCityCodeData.do?method=fdCityCode'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};