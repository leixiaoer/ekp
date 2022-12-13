
var formOption = {
    formName: 'fsscLoanMainForm',
    modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanMain',
    templateName: 'com.landray.kmss.fssc.loan.model.FsscLoanCategory',
    subjectField: 'docSubject',
    mode: 'main_scategory'

    ,
    dialogs: {
        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },

        fssc_base_company_getCompanyByPerson: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=loanSearch'
        },

        fssc_base_pay_way_fdPayWay: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay',
            sourceUrl: '/fssc/base/fssc_base_pay_way/fsscBasePayWayData.do?method=fdPayWay'
        },

        fssc_base_account_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccount',
            sourceUrl: '/fssc/base/fssc_base_account/fsscBaseAccountData.do?method=fdAccount'
        },

        fssc_base_wbs_fdWbs: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs',
            sourceUrl: '/fssc/base/fssc_base_wbs/fsscBaseWbsData.do?method=fdWbs'
        },

        fssc_base_inner_order_fdInnerOrder: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInnerOrder',
            sourceUrl: '/fssc/base/fssc_base_inner_order/fsscBaseInnerOrderData.do?method=fdInnerOrder'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        },

        fssc_loan_fee_main_getFeeMain: {
            modelName: 'com.landray.kmss.fssc.loan.model.FsscLoanMain',
            sourceUrl: '/fssc/loan/fssc_loan_main/fsscLoanFeeData.do?method=getFeeMain'
        },
        fssc_cmb_city_code: {
          	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbCityCode',
             sourceUrl: '/fssc/cmb/fssc_cmb_city_code/fsscCmbCityCodeData.do?method=fdCityCode'
        },
        fssc_loan_selectAuthorize:{
      		modelName:'com.landray.kmss.sys.organization.model.SysOrgPerson',
      		sourceUrl:'/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=selectAuthorize'
        }

    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};