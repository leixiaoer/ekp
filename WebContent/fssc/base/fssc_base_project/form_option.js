var formOption = {
    formName: 'fsscBaseProjectForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
        },
		fssc_base_project_fdParent: {
			modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
			sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=fdParent'
		}
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};