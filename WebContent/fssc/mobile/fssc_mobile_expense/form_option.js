var formOption = {
    formName: 'fsscExpenseMainForm',
    modelName: 'com.landray.kmss.fssc.expense.model.FsscExpenseMain',
    templateName: 'com.landray.kmss.fssc.expense.model.FsscExpenseCategory',
    subjectField: 'docSubject',
    mode: 'main_scategory'
    ,
    url: {
    	getFsscBaseCostCenter:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFsscBaseCostCenter',
    	
    	getFsscBaseExpenseItem:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFsscBaseExpenseItem',
    	
    	getLoanData:'fssc/expense/fssc_expense_main/fsscExpenseMain.do?method=getLoanData',
    	
    	getWbsList:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getWbsList',
    	
    	getOrderList:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getOrderList',
    	
    	getCurrencyData:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getCurrencyData',
    	
    	getFsBaseTaxrate:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFsBaseTaxrate',
    	
    	getFsBasePay: 'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFsBasePay',
    	
    	getFsCompany: 'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getCompany&fdModelName=com.landray.kmss.fssc.expense.model.FsscExpenseMain',
    	
    	getFeeMain:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFeeMain',
    	
    	getFdProject:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getFdProject',
    	
    	getGeneratorId:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getGeneratorId',
    	
    	getVehicleData:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getVehicleData',
    	
    	getNoteByIds:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getNoteByIds',
    	
    	getAccountInfo:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getAccountInfo',
    	
    	getCityData:'fssc/mobile/fssc_mobile_note/fsscMobileNote.do?method=getCityData',
    	
    	getFdClaimant:'fssc/expense/fssc_expense_mobile/fsscExpenseMobile.do?method=getFdClaimant',
    	
    	getFdInputTax:'fssc/expense/fssc_expense_mobile/fsscExpenseMobile.do?method=getFdInputTax'
    	
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    dataType: {}
};