/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAssetCard"], function(declare,msg) {
  return declare("km.asset.CardAssetPropertyMixin", null, {
    modelName: "com.landray.kmss.km.asset.model.KmAssetCategory",
    filters: [
      {
          filterType: "FilterSearch",
          name: "fdAddress",
          subject: msg['kmAssetCard.fdAssetAddress']
      },
      {
          filterType: "FilterSearch",
          name: "fdCode",
          subject: msg['kmAssetCard.fdCode']
      },
    ]
  })
})
