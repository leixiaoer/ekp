/**
 * 主面板
 */
define(["mui/createUtils"], function(createUtils) {

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
              dojoMixins: "km/asset/mobile/module/js/main/Statistical"
            })
          )
        },
        cards: [
                {
                    contents: [
                      {
                        tmpl: createUtils.createTemplate(null, {
                          dojoType: "sys/mportal/module/mobile/elements/ConciseGridFunctional",
                          dojoMixins:
                            "km/asset/mobile/module/js/main/ConciseGridFunctional"
                        })
                      }
                    ]
                }                
        ]
      }
    }
  }
})
