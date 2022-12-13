
var formOption = {
    formName: 'fsscVoucherRuleConfigForm',
    modelName: 'com.landray.kmss.fssc.voucher.model.FsscVoucherRuleConfig'

    ,
    dialogs: {
        fssc_voucher_model_config_fdModel: {
            modelName: 'com.landray.kmss.fssc.voucher.model.FsscVoucherModelConfig',
            sourceUrl: '/fssc/voucher/fssc_voucher_model_config/fsscVoucherModelConfigData.do?method=fdModel'
        },
        fssc_voucher_model_config_fdCategory: {
            modelName: 'com.landray.kmss.fssc.voucher.model.FsscVoucherModelConfig',
            sourceUrl: '/fssc/voucher/fssc_voucher_model_config/fsscVoucherModelConfigData.do?method=fdCategory'
        },
        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },

        fssc_base_cash_flow_getCashFlow: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCashFlow',
            sourceUrl: '/fssc/base/fssc_base_cash_flow/fsscBaseCashFlowData.do?method=fdParent'
        },

        fssc_base_wbs_fdWbs: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs',
            sourceUrl: '/fssc/base/fssc_base_wbs/fsscBaseWbsData.do?method=fdWbs'
        },

        fssc_base_inner_order_fdInnerOrder: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInnerOrder',
            sourceUrl: '/fssc/base/fssc_base_inner_order/fsscBaseInnerOrderData.do?method=fdInnerOrder'
        },

        fssc_base_accounts_com_fdMinLevel: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
            sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdMinLevel'
        },

        fssc_base_supplier_getSupplier: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseSupplier',
            sourceUrl: '/fssc/base/fssc_base_supplier/fsscBaseSupplierData.do?method=getSupplier'
        },

        fssc_base_voucher_type_getVoucherType: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVoucherType',
            sourceUrl: '/fssc/base/fssc_base_voucher_type/fsscBaseVoucherTypeData.do?method=getVoucherType'
        },

        fssc_base_erp_person_fdERPPerson: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVoucherType',
            sourceUrl: '/fssc/base/fssc_base_erp_person/fsscBaseErpPersonData.do?method=fdERPPerson'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        },

        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank'
        },

        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};