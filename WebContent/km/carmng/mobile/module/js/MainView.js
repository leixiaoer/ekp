define(["mui/createUtils", "mui/i18n/i18n!km-carmng:*"], function(createUtils, Msg) {
  return {
    createView: function() {
      return {
        header: {
          tmpl: createUtils.createTemplate(
            null,
            {
              dojoType: "sys/mportal/module/mobile/containers/Header",
              dojoProps: {
                userName: dojoConfig.CurrentUserName
              }
            },
            createUtils.createTemplate(null, {
              dojoType: "sys/mportal/module/mobile/elements/Statistical",
              dojoMixins: "km/carmng/mobile/module/js/MainView/Statistical"
            })
          )
        },
        cards: [
          {
            title: {text: "", href: ""},
            contents: [
              {
                tmpl: createUtils.createTemplate(null, {
                  dojoType: "sys/mportal/module/mobile/elements/Functional",
                  dojoMixins: "km/carmng/mobile/module/js/MainView/Functional"
                })
              }
            ]
          }
        ],
        button: {
        	text: Msg["kmCarmng.tree.application"],
        	href: "/km/carmng/km_carmng_application/kmCarmngApplication.do?method=add"
        }
      }
    }
  }
})
