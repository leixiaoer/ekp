/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAssetApplyBase","mui/i18n/i18n!sys-lbpmperson:lbpmperson.status"], function(declare,msg,msg2) {
  return declare("km.asset.ApplyAssetPropertyMixin", null, {
    modelName: "com.landray.kmss.km.asset.model.KmAssetCategory",
    filters: [
      {
        filterType: "FilterRadio",
        name: "docStatus",
        subject: msg['kmAssetApplyBase.status'],
        options: [
          {name: msg2["lbpmperson.status.draft"], value: "10"},
          {name: msg2["lbpmperson.status.append"], value: "20"},
          {name: msg2["lbpmperson.status.refuse"], value: "11"},
          {name: msg2["lbpmperson.status.publish"], value: "30"}
        ]
      },
      {
          filterType: "FilterSearch",
          name: "fdNo",
          subject: msg['kmAssetApplyBase.fdNo']
      },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "fdCreateDate",
          subject: msg['kmAssetApplyBase.fdCreateDate']
      }
    ]
  })
})
