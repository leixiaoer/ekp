var formOption = {
    formName: 'fsscExpenseMainForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseMain',
    templateName: 'com.landray.kmss.fssc.expense.model.FsscExpenseCategory',
    subjectField: 'docSubject',
    mode: 'main_scategory'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },

        fssc_base_cost_center_selectCostCenter: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCostCenter',
            sourceUrl: '/fssc/base/fssc_base_cost_center/fsscBaseCostCenterData.do?method=selectCostCenter'
        },
        
        fssc_base_expense_item_selectExpenseItem: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },


        fssc_base_project_project: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseProject',
            sourceUrl: '/fssc/base/fssc_base_project/fsscBaseProjectData.do?method=project'
        },

        fssc_base_currency_fdCurrency: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCurrency',
            sourceUrl: '/fssc/base/fssc_base_currency/fsscBaseCurrencyData.do?method=fdCurrency'
        },

        fssc_base_vehicle_fdVehicle: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseVehicle',
            sourceUrl: '/fssc/base/fssc_base_vehicle/fsscBaseVehicleData.do?method=fdVehicle'
        },
        
        fssc_base_expense_wbs_selectWbs: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseWbs',
            sourceUrl: '/fssc/base/fssc_base_wbs/fsscBaseWbsData.do?method=fdParent'
        },
        
        fssc_base_expense_order_selectInnerOrder: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscInnerOrder',
            sourceUrl: '/fssc/base/fssc_base_inner_order/fsscBaseInnerOrderData.do?method=fdParent'
        },

        fssc_base_berth_fdBerth: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseBerth',
            sourceUrl: '/fssc/base/fssc_base_berth/fsscBaseBerthData.do?method=fdBerth'
        },

        fssc_base_pay_way_getPayWay: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayWay',
            sourceUrl: '/fssc/base/fssc_base_pay_way/fsscBasePayWayData.do?method=fdPayWay'
        },
        
        fssc_base_pay_bank_fdBank: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank',
            sourceUrl: '/fssc/base/fssc_base_pay_bank/fsscBasePayBankData.do?method=fdBank'
        },

        fssc_base_expense_item_fdParent: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseExpenseItem',
            sourceUrl: '/fssc/base/fssc_base_expense_item/fsscBaseExpenseItemData.do?method=fdParent'
        },

        fssc_base_account_fdAccount: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccount',
            sourceUrl: '/fssc/base/fssc_base_account/fsscBaseAccountData.do?method=fdAccount'
        },
        fssc_ledger_fdInvoice: {
        	modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerInvoice',
        	sourceUrl: '/fssc/ledger/fssc_ledger_invoice/fsscLedgerInvoiceData.do?method=fdInvoice'
        },

        fssc_base_tax_rate_getTaxRate: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseTaxRate',
            sourceUrl: '/fssc/base/fssc_base_tax_rate/fsscBaseTaxRateData.do?method=getTaxRate'
        },
        
        fssc_expense_main_selectFee: {
            modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseMain',
            sourceUrl: '/fssc/expense/fssc_expense_main/fsscExpenseMainData.do?method=selectFee'
        },
        fssc_expense_main_selectProapp: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/expense/fssc_expense_main/fsscExpenseMainData.do?method=selectProapp'
        },
        fssc_cmb_city_code: {
       	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbCityCode',
            sourceUrl: '/fssc/cmb/fssc_cmb_city_code/fsscCmbCityCodeData.do?method=fdCityCode'
       },
       fssc_expense_detail_selectNote:{
   		modelName:'com.landray.kmss.fssc.expense.model.FsscExpenseDetail',
   		sourceUrl:'/fssc/expense/fssc_expense_main/fsscExpenseMainData.do?method=selectNote'
       },
       fssc_expense_selectAuthorize:{
      		modelName:'com.landray.kmss.sys.organization.model.SysOrgPerson',
      		sourceUrl:'/fssc/base/fssc_base_authorize/fsscBaseAuthorize.do?method=selectAuthorize'
       },
       fssc_base_input_tax_getInputTax:{
     		modelName:'com.landray.kmss.fssc.base.model.FsscBaseInputTax',
     		sourceUrl:'/fssc/base/fssc_base_input_tax/fsscBaseInputTax.do?method=getInputTax'
      }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};