/**
 * 导师面板
 */
define(["mui/createUtils","mui/i18n/i18n!km-supervise:*"], function(createUtils,msg) {
  return {
    icon: "muis-supervise-mine",
    text: msg["mobile.home.my"],
    createView: function() {
      return {
        cards: [
          {
            title: {text: "", href: ""},
            contents: [
              {
                tmpl: createUtils.createTemplate(null, {
                  dojoType: "sys/mportal/module/mobile/elements/Functional",
                  dojoMixins: "km/supervise/mobile/module/js/MySupervise/Functional"
                })
              }
            ]
          }
        ]
      }
    }
  }
})
