var formOption = {
    formName: 'fsscBaseSwitchForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSwitch'


    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },
        fssc_base_switch_module: {
        	modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSwitch',
        	sourceUrl: '/fssc/base/fssc_base_switch/fsscBaseSwitch.do?method=fdModule'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};