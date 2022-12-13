
var formOption = {
    formName: 'fsscBudgetingAuthForm',
    modelName: 'com.landray.kmss.fssc.budgeting.model.FsscBudgetingAuth'

    ,
    dialogs: {
    	fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },
    	fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectAllCostCenter'
        },

        fssc_base_budget_item_fdBudgetItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItem',
            sourceUrl: '/fssc/base/fssc_base_budget_item/fsscBaseBudgetItemData.do?method=fdBudgetItem&query=all'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=selectAllProject'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};