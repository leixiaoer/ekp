/**
 * （待我审的）筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAssetApplyBase"], function(declare,msg) {
  return declare("km.asset.ApplyAssetPropertyMixin", null, {
    modelName: "com.landray.kmss.km.asset.model.KmAssetCategory",
    filters: [
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
