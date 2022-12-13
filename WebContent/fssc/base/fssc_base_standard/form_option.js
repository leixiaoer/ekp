var formOption = {
    formName: 'fsscBaseStandardForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseStandard'

    ,
    dialogs: {
        fssc_base_level_fdLevel: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseLevel',
            sourceUrl: '/fssc/base/fssc_base_level/fsscBaseLevelData.do?method=fdLevel'
        },

        fssc_base_area_fdArea: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseArea',
            sourceUrl: '/fssc/base/fssc_base_area/fsscBaseAreaData.do?method=fdArea&fdTypeArea=fdTypeArea'
        },

        fssc_base_vehicle_fdVehicle: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVehicle',
            sourceUrl: '/fssc/base/fssc_base_vehicle/fsscBaseVehicleData.do?method=fdVehicle'
        },

        fssc_base_berth_fdBerth: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBerth',
            sourceUrl: '/fssc/base/fssc_base_berth/fsscBaseBerthData.do?method=fdBerth'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },
        fssc_base_special_item: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSpecialItem',
            sourceUrl: '/fssc/base/fssc_base_special_item/fsscBaseSpecialItemData.do?method=fdSpecialItem'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};