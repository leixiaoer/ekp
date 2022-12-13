var formOption = {
    formName: 'fsscBaseInnerOrderForm',
    modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInnerOrder'

    ,
    dialogs: {
        fssc_base_company_fdCompany: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseCompany',
            sourceUrl: '/fssc/base/fssc_base_company/fsscBaseCompanyData.do?method=fdCompany'
        },
        fssc_base_inner_order_fdParent: {
        	modelName: 'com.landray.kmss.fssc.base.model.FsscBaseInnerOrder',
        	sourceUrl: '/fssc/base/fssc_base_inner_order/fsscBaseInnerOrderData.do?method=fdParent'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    linkValidates: [],
    dataType: {}
};