var formOption = {
    formName: 'fsscBudgetMainForm',
    modelName: 'com.landray.kmss.fssc.budget.model.FsscBudgetMain',
    templateName: '',
    subjectField: 'fdDesc',
    mode: ''

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=getCompanyByPerson&type=byScheme'
        },
        fssc_base_finanac_company_fdCompany: {
        	modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
        	sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=getCompanyByPerson&type=transfer'
        },

        fssc_base_cost_center_group_selectCostCenterGroup: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=fdParent'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_cost_center_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=fdParent'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },

        fssc_base_budget_item_com_fdBudgetItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBudgetItemCom',
            sourceUrl: '/fssc/base/fssc_base_budget_item_com/fsscBaseBudgetItemComData.do?method=fdBudgetItem'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project&type=budget'
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