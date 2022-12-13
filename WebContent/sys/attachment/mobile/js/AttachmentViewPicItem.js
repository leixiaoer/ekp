define([
  "dojo/_base/declare",
  "dojo/dom-construct",
  "mui/util",
  "dojo/_base/lang",
  "dojo/dom-style",
  "sys/attachment/mobile/js/_AttachmentItem",
  "sys/attachment/mobile/js/_AttachmentLinkItem",
  "sys/attachment/mobile/js/_AttachmentViewOnlineMixin"
], function(
  declare,
  domConstruct,
  util,
  lang,
  domStyle,
  AttachmentItem,
  AttachmentLinkItem,
  _AttachmentViewOnlineMixin
) {
  //图片附件项展示类
  return declare(
    "sys.attachment.mobile.js.AttachmentViewPicItem",
    [AttachmentItem, AttachmentLinkItem, _AttachmentViewOnlineMixin],
    {
      width: null,

      height: null,

      fdId: null,

      iconUrl:
        "/sys/attachment/sys_att_main/sysAttMain.do?method=view&picthumb=small&fdId=!{fdId}",

      mobilePicDisplaythumb: "false",

      baseClass: "muiAttachmentPicItem",

      buildItem: function() {
        if (this.width != null) {
          domStyle.set(this.containerNode, {
            width: this.width + "px"
          });
        }
        if (this.height != null) {
          domStyle.set(this.containerNode, {
            height: this.height + "px"
          });
        }
        var imgWidth = this.mobilePicDisplaythumb == "true" ? "70px" : "100%";

        if (!this.icon) {
          this.icon = this.iconUrl.replace("!{fdId}", this.fdId);
        }

        var imgItem = domConstruct.create(
          "img",
          {
            className: "muiAttachmentPicImg",
            src: util.formatUrl(this.icon),
            width: imgWidth // 默认百分百，以免图片过宽 by zhugr 2017-08-29
          },
          this.containerNode
        );
        var imgSrc = util.formatUrl(this.icon);
        this.fdId = this.getParamsFromUrl(imgSrc).fdId;
        this.canRead = true;
        this.connect(imgItem, "click", lang.hitch(this.view));
        imgItem.dojoClick = true;
      },

      getParamsFromUrl: function(url) {
        if (url.indexOf("?") != -1) {
          var index = url.indexOf("?") + 1;
          // 得到？后的字符串
          var str = url.substr(index); // postid=10457794&actiontip=保存修改成功')
          var paramsObj = {};
          // 字符串通过&标识，转为数组
          arrs = str.split("&"); // ["postid=10457794", "actiontip=保存修改成功"]
          for (var i = 0; i < arrs.length; i++) {
            // 分别将 = 左右两边拆分为数组, 动态变为键值对
            paramsObj[arrs[i].split("=")[0]] = arrs[i].split("=")[1];
            //  arrs[i].split("=")   ["postid", "10457794"]
          }
        }
        return paramsObj;
      }
    }
  );
});
