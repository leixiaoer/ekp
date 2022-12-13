/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!geesun-oitems:geesunOitems"], function(declare,msg) {
  return declare("km.Oitem.OitemPropertyMixin", null, {
    filters: [
      {
        filterType: "FilterRadio",
        name: "fdType",
        subject: msg['geesunOitems.tree.application.type'],
        options: [
           {name: msg['geesunOitems.tree.dept.application'], value: "1"}
          ,{name: msg['geesunOitems.tree.person.application'], value: "2"}
        ]
      },
      {
          filterType: "FilterRadio",
          name: "docStatus",
          subject: msg['geesunOitems.geesunOitemsBudgerApplication.docStatus'],
          options: [
             {name: msg['geesunOitems.tree.draft'], value: "10"}
            ,{name: msg['geesunOitems.tree.wait'], value: "20"}
            ,{name: msg['geesunOitems.tree.refuse'], value: "11"}
            ,{name: msg['geesunOitems.tree.discard'], value: "00"}
            ,{name: msg['geesunOitems.tree.receive.status1'], value: "30"}
            ,{name: msg['geesunOitems.tree.receive.status2'], value: "31"}
          ]
        },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "docCreateTime",
          subject: msg['geesunOitemsBudgerApplication.docCreateTime']
      },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "fdOutTime",
          subject: msg['geesunOitemsBudgerApplication.fdOutTime']
      }
    ]
  })
})
