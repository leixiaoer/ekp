var formOption = {
    formName: 'fsscBaseAccountForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccount',
    
    	 dialogs: {
    		  fssc_base_account_fdAccount: {
    	            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseAccount',
    	            sourceUrl: '/fssc/base/fssc_base_account/fsscBaseAccountData.do?method=fdAccount'
    	        },
    	        fssc_cmb_city_code: {
    	          	 modelName: 'com.landray.kmss.fssc.cmb.model.FsscCmbCityCode',
    	               sourceUrl: '/fssc/cmb/fssc_cmb_city_code/fsscCmbCityCodeData.do?method=fdCityCode'
    	          }
    	    },

    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};