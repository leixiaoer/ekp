/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!sys-news:sysNewsPublishCategory.fdImportance","mui/i18n/i18n!km-pindagate:mobile"], function(declare,fdImportanceMsg,msg) {
  return declare("sys.news.NewsPropertyMixin", null, {
	  modelName: "com.landray.kmss.sys.news.model.SysNewsTemplate",  
    filters: [              
      {
        filterType: "FilterRadio",
        name: "docStatus",
        subject: msg['mobile.kmPindagate.tree.status'],
        options: [
          {name: msg['mobile.kmPindagate.tree.status.indagating'], value: "31"},
          {name: msg['mobile.kmPindagate.tree.status.complete'], value: "32"}
        ]
      }     
    ]
  })
})