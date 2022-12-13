/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-asset:kmAssetApply","mui/i18n/i18n!sys-lbpmperson:lbpmperson.status","mui/i18n/i18n!km-asset:enumeration_km_asset_apply_task_fd"], function(declare,msg,msg2,msg3) {
  return declare("km.asset.TaskAssetPropertyMixin", null, {
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
          filterType: "FilterDatetime",
          type: "date",
          name: "fdCreateDate",
          subject: msg['kmAssetApplyBase.fdCreateDate']
      },
      {
          filterType: "FilterCheckBox",
          name: "fdPurchaseTime",
          subject: msg['kmAssetApplyTask.fdPurchaseTime'],
          options: [
            {name: msg3["enumeration_km_asset_apply_task_fd_purchase_time_1"], value: "1"},
            {name: msg3["enumeration_km_asset_apply_task_fd_purchase_time_2"], value: "2"}
          ]
      },
      {
          filterType: "FilterCheckBox",
          name: "fdStatus",
          subject: msg['kmAssetApplyTask.fdStatus'],
          options: [
            {name: msg3["enumeration_km_asset_apply_task_fd_status_1"], value: "1"},
            {name: msg3["enumeration_km_asset_apply_task_fd_status_2"], value: "2"},
            {name: msg3["enumeration_km_asset_apply_task_fd_status_3"], value: "3"}
          ]
      },
      {
          filterType: "FilterSearch",
          name: "fdDescription",
          subject: msg['kmAssetApplyTask.fdDescription']
      }
    ]
  })
})
