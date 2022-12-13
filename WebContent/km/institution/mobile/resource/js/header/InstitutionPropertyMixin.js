/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare", "mui/i18n/i18n!km-institution:mobile"], function(declare, msg) {
  return declare("sys.news.NewsPropertyMixin", null, {
	modelName: "com.landray.kmss.km.institution.model.KmInstitutionTemplate",  
    filters: [
      {
        filterType: "FilterRadio",
        name: "docStatus",
        subject: msg['mobile.kmInstitution.status'],
        options: [
              {name: msg['mobile.kmInstitution.status.draft'], value: "10"},
              {name: msg['mobile.kmInstitution.status.pending'], value: "20"},
              {name: msg['mobile.kmInstitution.status.overrule'], value: "11"},
              {name: msg['mobile.kmInstitution.status.publish'] , value: "30"},
              {name: msg['mobile.kmInstitution.status.abolishAndFiling'] , value: "50"}
        ]
      },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "docCreateTime",
          subject: msg['mobile.kmInstitution.entryTime']
      },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "docPublishTime",
          subject: msg['mobile.kmInstitution.effectiveTime']
      }
    ]
  })
})
