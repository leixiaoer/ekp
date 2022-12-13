/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-oitems:kmOitems"], function(declare,msg) {
  return declare("km.Oitem.OitemPropertyMixin", null, {
    filters: [
      {
        filterType: "FilterRadio",
        name: "fdType",
        subject: msg['kmOitems.tree.application.type'],
        options: [
           {name: msg['kmOitems.tree.dept.application'], value: "1"}
          ,{name: msg['kmOitems.tree.person.application'], value: "2"}
        ]
      },
      {
          filterType: "FilterRadio",
          name: "docStatus",
          subject: msg['kmOitems.kmOitemsBudgerApplication.docStatus'],
          options: [
             {name: msg['kmOitems.tree.draft'], value: "10"}
            ,{name: msg['kmOitems.tree.wait'], value: "20"}
            ,{name: msg['kmOitems.tree.refuse'], value: "11"}
            ,{name: msg['kmOitems.tree.discard'], value: "00"}
            ,{name: msg['kmOitems.tree.receive.status1'], value: "30"}
            ,{name: msg['kmOitems.tree.receive.status2'], value: "31"}
          ]
        },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "docCreateTime",
          subject: msg['kmOitemsBudgerApplication.docCreateTime']
      },
      {
          filterType: "FilterDatetime",
          type: "date",
          name: "fdOutTime",
          subject: msg['kmOitemsBudgerApplication.fdOutTime']
      }
    ]
  })
})
