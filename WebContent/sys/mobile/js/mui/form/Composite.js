/**
 * 复合组件
 */
define([
  "dojo/_base/declare",
  "dijit/_WidgetBase",
  "dojo/dom-class",
  "dijit/_Container",
  "dojo/dom-construct"
], function(declare, WidgetBase, domClass, _Container, domConstruct) {
  var claz = declare("mui.form.Composite", [WidgetBase, _Container], {
    required: false,

    //校验
    validate: null,

    requiredChildren: [], // 必填的子组件

    buildRendering: function() {
      this.inherited(arguments);
      domClass.add(this.domNode, "muiFormComposite");
      this.requiredNode = domConstruct.create(
        "div",
        { className: "muiFormRequiredShow muiFormRequired", innerHTML: "*" },
        this.domNode,
        "last"
      );
    },

    startup: function() {
      this.inherited(arguments);
      this.adapterValidater();
    },
    orient: "horizontal",

    // 移除子组件的必填并记录（每个子组件的必填都会在组件后面加了*号，影响样式）
    adapterValidater: function() {
      var orient = "horizontal";
      var children = this.getChildren();
      this.requiredChildren = [];
      for (var i = 0; i < children.length; i++) {
        var childWgt = children[i];
        if (childWgt.edit && childWgt.get("required") === true) {
          this.requiredChildren.push(childWgt);
        }
        if ("vertical" == childWgt.get("orient")) {
          orient = "vertical";
        }
      }

      if (this.requiredChildren.length > 0) {
        this.set("required", true);
      } else {
        this.set("required", false);
      }

      // 用于调整分隔符大小
      domClass.add(
        this.domNode,
        "muiFormComposite" + orient.charAt(0).toUpperCase() + orient.slice(1)
      );
    },

    _setRequiredAttr: function(value) {
      this._set("required", value);
      this._initText();
    },

    _initText: function() {
      domClass.toggle(this.requiredNode, "muiFormRequiredShow", this.required);
    }
  });

  return claz;
});
