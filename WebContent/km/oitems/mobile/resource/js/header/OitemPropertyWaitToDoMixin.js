/**
 * 筛选静态数据源
 */
define(["dojo/_base/declare","mui/i18n/i18n!km-oitems:kmOitems"], function(declare,msg) {
  return declare("km.Oitem.OitemPropertyWaitToDoMixin", null, {
    filters: [
      {
          filterType: "FilterRadio",
          name: "fdType",
          subject: msg["kmOitems.tree.application.type"],
          options: [
             {name: msg["kmOitems.tree.dept.application"], value: "1"}
            ,{name: msg["kmOitems.tree.person.application"], value: "2"}
          ]
        },
        {
            filterType: "FilterDatetime",
            type: "date",
            name: "docCreateTime",
            subject: msg["kmOitemsBudgerApplication.docCreateTime"]
        }
    ]
  })
})
