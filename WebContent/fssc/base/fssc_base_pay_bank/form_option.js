var formOption = {
    formName: 'fsscBasePayBankForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBasePayBank'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany&type=base_auth'
         },
        fssc_cmb_account_area:{
       	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbAccountArea',
            sourceUrl: '/fssc/cmb/fssc_cmb_account_area/fsscCmbAccountAreaData.do?method=fdAccountArea'
       },
	     fssc_base_accounts_com_fdAccount: {
	         modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccountsCom',
	         sourceUrl: '/fssc/base/fssc_base_accounts_com/fsscBaseAccountsComData.do?method=fdAccount&fdType=add'
	     }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};