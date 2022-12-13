/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!geesun-oitems:geesunOitems"], function(declare,msg) {
  return declare("km.Oitem.OitemPropertyWaitToDoMixin", null, {
    filters: [
      {
          filterType: "FilterRadio",
          name: "fdType",
          subject: msg["geesunOitems.tree.application.type"],
          options: [
             {name: msg["geesunOitems.tree.dept.application"], value: "1"}
            ,{name: msg["geesunOitems.tree.person.application"], value: "2"}
          ]
        },
        {
            filterType: "FilterDatetime",
            type: "date",
            name: "docCreateTime",
            subject: msg["geesunOitemsBudgerApplication.docCreateTime"]
        }
    ]
  })
})
