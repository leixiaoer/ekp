/**
 * “待我审的” 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-institution:mobile"], function(declare, msg) {
  return declare("km.institution.ApprovalPropertyMixin", null, {
    modelName: "com.landray.kmss.km.institution.model.KmInstitutionTemplate",
    filters: [
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "docCreateTime",
          subject: msg['mobile.kmInstitution.entryTime']
      }
    ]
  })
})
