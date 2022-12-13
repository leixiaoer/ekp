
var formOption = {
    formName: 'geesunBasePayForm',
    modelName: 'com.landray.kmss.geesun.base.model.GeesunBasePay',
    templateName: '',
    subjectField: 'fdPeriod',
    mode: ''

    ,
    dialogs: {
        km_review_main_selectReview: {
            modelName: 'com.landray.kmss.km.review.model.KmReviewMain',
            sourceUrl: '/km/review/km_review_main/kmReviewMainData.do?method=selectReview'
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