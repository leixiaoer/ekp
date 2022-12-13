define([
  'dojo/_base/declare',
  'dojo/dom-construct',
  'mui/device/device',
  'mui/device/adapter',
  'mui/dialog/Tip',
  'dojox/mobile/sniff',
  'sys/attachment/mobile/js/_AttachmentItem',
  'mui/i18n/i18n!sys-attachment:mui',
  'mui/i18n/i18n!sys-attachment:sysAttMain.button.cancelAll',
  'dojo/dom-attr',
  'dojo/touch',
  'dojo/topic',
  'dojo/dom-class',
  'mui/form/_AlignMixin',
], function (
  declare,
  domConstruct,
  device,
  adapter,
  Tip,
  has,
  AttachmentItem,
  Msg,
  Msg2,
  domAttr,
  touch,
  topic,
  domClass,
  _AlignMixin
) {
  return declare(
    'sys.attachment.mobile.js.AttachmentOptListItem',
    [AttachmentItem, _AlignMixin],
    {
      isForm: true,
      baseClass: 'muiAttachmentEditItem muiAttachmentEditOptItem',
      customSubject: '',
      capture: '',
      aligin: '',
      showStatus: 'edit',

      getIconClass: function () {
        if ('pic' == this._fdAttType) {
          return 'muis-images-upload';
        }
        return 'muis-uploader';
      },

      buildRendering: function () {
        this.inherited(arguments);
        if ('right' == this.align) {
          domClass.add(this.domNode, 'muiRight');
        }
        this.domNode.dojoClick = !has('ios');
      },

      buildHItem: function () {
        this.attItemTop = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentItemT',
          },
          this.containerNode
        );

        var attItemIcon = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentItemIcon',
          },
          this.attItemTop
        );
        this.uploadDom = domConstruct.create(
          'i',
          {
            className: 'fontmuis ' + this.getIconClass(),
          },
          attItemIcon
        );

        domConstruct.create(
          'div',
          {
            className: 'muiAttachmentItemText',
          },
          this.attItemTop
        );
      },

      buildVItem: function () {
        domClass.add(this.domNode, 'muiAttachmentEditVOptItem');
        this.attItemTop = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentItemTV',
          },
          this.containerNode
        );

        var attItemIcon = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentItemTVIcon',
          },
          this.attItemTop
        );
        this.uploadDom = domConstruct.create(
          'i',
          {
            className: 'fontmuis ' + this.getIconClass(),
          },
          attItemIcon
        );
      },

      buildItem: function () {
        if (this.orient == 'vertical') {
          this.buildVItem();
        } else {
          this.buildHItem();
        }

        var devType = device.getClientType();
        if (devType > 6 && devType < 11) {
          //kk客户端
          if (this.capture.toLowerCase().indexOf('camera') == -1) {
            // 明细表内的附件无法触发click，这里用touch代替
            this.connect(this.uploadDom, touch.press, '_onKKppload');
          } else {
            this.connect(this.uploadDom, 'click', '_onCamera');
          }
        } else {
          var inputAtt = {
            type: 'file',
            className: 'muiAttachmentUploadFile',
          };
          // 暂时只支持图片类型的筛选 by zhugr 2017-08-28
          if (
            this.getParent().fdAttType &&
            this.getParent().fdAttType == 'pic'
          ) {
            //#50944 修复微信浏览器不支持image/gif,image/jpeg,image/bmp,image/png by hzk
            if (devType == 6) {
              inputAtt.accept = 'image/*';
            } else {
              inputAtt.accept = 'image/gif,image/jpeg,image/bmp,image/png';
            }
          } else {
            if (this.getParent().enabledFileType) {
              //文件类型
              var enableFiles = this.formatEnabledFileType(
                this.getParent().enabledFileType
              );

              inputAtt.accept = '*';
              if (enableFiles != null) {
                $.ajax({
                  url: Com_Parameter.ContextPath + 'sys/attachment/js/mime.jsp',
                  dataType: 'json',
                  data: 'extFileNames=' + enableFiles,
                  type: 'POST',
                  async: false,
                  success: function (res) {
                    if (res.status == 1) {
                      inputAtt.accept = res.message.join(',');
                    }
                  },
                  error: function (xhr, status, errorInfo) {
                    if (window.console) window.console.error(errorInfo);
                  },
                });
              }
            }
          }
          if (this.getParent().fdMulti == true) {
            inputAtt.multiple = true;
          }
          if (has('ios') && has('ios') < 6) {
            this.connect(this.uploadDom, 'click', function () {
              Tip.tip({
                icon: 'mui mui-warn',
                time: 2000,
                text: '不支持附件上传，请升级到IOS6.0以上',
              });
            });
          } else if (has('android') && has('android') < 4) {
            this.connect(this.uploadDom, 'click', function () {
              Tip.tip({
                icon: 'mui mui-warn',
                time: 2000,
                text: '不支持附件上传，请升级到ANDROID4.0以上',
              });
            });
          } else {
            this.uploadDom = domConstruct.create(
              'input',
              inputAtt,
              this.attItemTop
            );
            if (has('android')) {
              //处理andriod下弹出两次选择文件对话框的情况
              this.connect(this.uploadDom, 'click', function (evt) {
                if (evt.stopPropagation) evt.stopPropagation();
                if (evt.cancelBubble) evt.cancelBubble = true;
                if (evt.preventDefault) evt.preventDefault();
                if (evt.returnValue) evt.returnValue = false;
              });
            }
            this.connect(this.uploadDom, 'click', '_onValueClear');
            this.connect(this.uploadDom, 'change', '_onUpload');
          }
        }
      },
      formatEnabledFileType: function (enabledFileType) {
        if (enabledFileType == null || enabledFileType == '') return null;
        enabledFileType = enabledFileType.replace(/\|/g, ',');
        //这里兼容格式: *.ppt;*.doc，应该是用,隔开，webuploader的格式为 doc,ppt,xls
        enabledFileType = enabledFileType.replace(/\;/g, ',');
        enabledFileType = enabledFileType.replace(/[\.|\*]/g, '');

        return enabledFileType;
      },
      startup: function () {
        this.inherited(arguments);
        // 初始化的时候，处理附件单个时隐藏的问题 by zhugr 2017-09-06
        this._onUploadChange();
        this.subscribe(
          'attachmentObject_' + this.getParent().fdKey + '_addItem',
          '_onUploadChange'
        );
        this.subscribe(
          'attachmentObject_' + this.getParent().fdKey + '_del',
          '_onUploadChange'
        );
      },
      _onValueClear: function () {
        this.uploadDom.value = '';
      },
      _onKKppload: function (evt) {
//		 var nowTime = new Date().getTime();
//		 var clickTime = this.ctime;
//		 if( clickTime != 'undefined' && (nowTime - clickTime < 500)){
//		     return false;
//		  }
//		 this.ctime = nowTime;  
    	  
        if (this.selectDiv) return;
        this.selectDiv = domConstruct.create(
          'div',
          { className: 'muiAttachmentUploadArea' },
          document.body,
          'last'
        );
        var bak = domConstruct.create(
          'div',
          { className: 'muiAttachmentUploadbak' },
          this.selectDiv
        );
        this.connect(bak, 'click', '_onCancel');
        var optDiv = domConstruct.create(
          'div',
          { className: 'muiAttachmentUploadOpt' },
          this.selectDiv
        );
        var choseDiv = domConstruct.create(
          'div',
          { className: 'muiAttachmentUploadSelect' },
          optDiv
        );
        var camera = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentUploadCamera',
            innerHTML: Msg['mui.sysAttMain.photograph'],
          },
          choseDiv
        );
        this.connect(camera, 'click', '_onCamera');
        var images = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentUploadFiles',
            innerHTML: Msg['mui.sysAttMain.picture'],
          },
          choseDiv
        );
        domAttr.set(images, 'feature', 'album');
        this.connect(images, 'click', '_onUpload');
        if (this.getParent().fdAttType != 'pic') {
          var files = domConstruct.create(
            'div',
            {
              className: 'muiAttachmentUploadFiles',
              innerHTML: Msg['mui.sysAttMain.file.manager'],
            },
            choseDiv
          );
          domAttr.set(files, 'feature', 'file_manager');
          this.connect(files, 'click', '_onUpload');
        }
        var cancel = domConstruct.create(
          'div',
          {
            className: 'muiAttachmentUploadCancel',
            innerHTML: Msg2['sysAttMain.button.cancelAll'],
          },
          optDiv
        );
        this.connect(cancel, 'click', '_onCancel');
      },

      _onCancel: function (evt) {
    	  
    	  var nowTime = new Date().getTime();
          var clickTime = this.ctime;
          if( clickTime != 'undefined' && (nowTime - clickTime < 500)){
              return false;
           }
          this.ctime = nowTime;
    	  
        if (this.selectDiv) {
          domConstruct.destroy(this.selectDiv);
          this.selectDiv = null;
        }
      },

      _onCamera: function (evt) {
        this._onCancel(evt);
        adapter.openCamera({ options: this.getParent() });
      },

      _onUpload: function (evt) {
//	    var nowTime = new Date().getTime();
//	    var clickTime = this.ctime;
//	    if( clickTime != 'undefined' && (nowTime - clickTime < 500)){
//	      return false;
//	   }
//	    this.ctime = nowTime;
        var target = evt.target;
        if (target) target.blur();
        this._onCancel(evt);
        adapter.selectFile({
          options: this.getParent(),
          evt: evt,
          feature: domAttr.get(target, 'feature'),
        });
      },

      _onUploadChange: function () {
        // 根据是否多附件隐藏操作按钮
        var parentWgt = this.getParent();
        if (parentWgt && !parentWgt.fdMulti) {
          //如果单附件上传
          var childNodes = parentWgt.getChildren();
          if (childNodes.length > 2) {
            // 使用visible，虽然隐藏了，但是还是会占页面控件 by zhugr 2017-09-06
            this.containerNode.style.display = 'none';
            return;
          }
        }
        this.containerNode.style.display = 'inline-block';
        topic.publish('/mui/list/resize', this);
      },
    }
  );
});
