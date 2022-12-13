var formOption = {
    formName: 'fsscBaseBerthForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBerth'

    ,
    dialogs: {
        fssc_base_vehicle_fdVehicle: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVehicle',
            sourceUrl: '/fssc/base/fssc_base_vehicle/fsscBaseVehicleData.do?method=fdVehicle'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};