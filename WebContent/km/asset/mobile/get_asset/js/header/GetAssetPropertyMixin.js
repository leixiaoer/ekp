/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAssetApply"], function(declare,msg) {
  return declare("km.asset.GetAssetPropertyMixin", null, {
    modelName: "com.landray.kmss.km.asset.model.KmAssetCategory",
    filters: [
      {
        filterType: "FilterRadio",
        name: "mydoc",
        subject: msg['kmAssetApply.my'],
        options: [
          {name: msg['kmAssetApply.create.my'], value: "create"},
          {name: msg['kmAssetApply.approval.my'], value: "approval"},
          {name: msg['kmAssetApply.approved.my'], value: "approved"}
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
