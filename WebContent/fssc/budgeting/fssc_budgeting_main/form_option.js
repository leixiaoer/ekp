
var formOption = {
    formName: 'fsscBudgetingMainForm',
    modelName: 'com.landray.kmss.fssc.budgeting.model.FsscBudgetingMain',
    templateName: '',
    subjectField: 'fdYear',
    mode: ''

    ,
    dialogs: {
    	fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=getCompanyByPerson'
        },
    	fssc_base_budget_item_com_fdBudgetItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom',
            sourceUrl: '/fssc/base/fssc_base_budget_item_com/fsscBaseBudgetItemComData.do?method=fdBudgetItem&type=budgeting'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project&type=budgeting'
        },

        fssc_base_inner_order_fdInnerOrder: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInnerOrder',
            sourceUrl: '/fssc/base/fssc_base_inner_order/fsscBaseInnerOrderData.do?method=fdInnerOrder'
        },

        fssc_base_wbs_fdWbs: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs',
            sourceUrl: '/fssc/base/fssc_base_wbs/fsscBaseWbsData.do?method=fdWbs'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};