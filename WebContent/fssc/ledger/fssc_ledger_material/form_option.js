
var formOption = {
    formName: 'fsscLedgerMaterialForm',
    modelName: 'com.landray.kmss.fssc.ledger.model.FsscLedgerMaterial',
    templateName: '',
    subjectField: 'fdCode',
    mode: ''

    ,
    dialogs: {
        fssc_base_material_type_selectType: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseMaterialType',
            sourceUrl: '/fssc/base/fssc_base_material_type/fsscBaseMaterialTypeData.do?method=selectType'
        },

        fssc_base_material_info_selectMaterial: {
            modelName: 'com.landray.kmss.fssc.base.model.FsscBaseMaterialInfo',
            sourceUrl: '/fssc/base/fssc_base_material_info/fsscBaseMaterialInfoData.do?method=selectMaterial'
        }
    },
    dialogLinks: [],
    valueLinks: [],
    attrLinks: [],
    optionLinks: [],
    linkValidates: [],
    detailTables: [],
    dataType: {}
};