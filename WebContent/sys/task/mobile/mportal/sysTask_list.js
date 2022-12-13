define(["mui/util"], function(util) {
  function portletLoad(params, load) {

    var rowsize = util.getUrlParameter(params, "rowsize");
    var type = util.getUrlParameter(params, "type");
    
    var html = '<ul class="muiPortalTaskSimple"' 
   	 +'data-dojo-type="sys/mportal/mobile/card/JsonStoreCardList"'
   	 +'data-dojo-mixins="sys/task/mobile/mportal/js/TaskListMixin"'
   	 +"data-dojo-props=\"url:'/sys/task/sys_task_main/sysTaskIndex.do?method=list&orderby=docCreateTime&ordertype=down&rowsize=!{rowsize}',lazy:false,type:'!{type}'\">"
   	 +'</ul>';
    
    html = util.urlResolver(html, {
      rowsize: rowsize,
      type: type
    });
    
    load({
        html: html,
        cssUrls: ["/sys/task/mobile/resource/css/list.css"]
    }); 
    
  }

  return {
    load: function(params, require, load) {
      portletLoad(params, load)
    },
    dependences: [
      "/sys/mportal/mobile/card/JsonStoreCardList.js",
      "/sys/task/mobile/mportal/js/TaskListMixin.js",
      "/sys/task/mobile/resource/js/list/CalendarItemListMixin.js",
      "/sys/task/mobile/resource/js/list/item/CalendarItemMixin.js",
      "/sys/mobile/js/mui/openProxyMixin.js"
    ]
  }
})