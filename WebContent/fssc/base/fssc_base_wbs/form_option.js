var formOption = {
    formName: 'fsscBaseWbsForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },
        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        },
        fssc_base_wbs_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs',
            sourceUrl: '/fssc/base/fssc_base_wbs/fsscBaseWbsData.do?method=fdParent'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};