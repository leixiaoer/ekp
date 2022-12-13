
var formOption = {
    formName: 'geesunAnnualUseForm',
    modelName: 'com.landray.kmss.geesun.annual.model.GeesunAnnualUse',
    templateName: '',
    subjectField: 'docSubject',
    mode: ''

    ,
    dialogs: {
        geesun_annual_main_selectAnnual: {
            modelName: 'com.landray.kmss.geesun.annual.model.GeesunAnnualMain',
            sourceUrl: '/geesun/annual/geesun_annual_main/geesunAnnualMainData.do?method=selectAnnual'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    detailTables: [],
    dataType: {},
    detailNotNullProp: {}
};