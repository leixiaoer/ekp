define(
		[ "dojo/_base/declare", "mui/form/editor/EditorUtil", "mui/util",
				"dojo/_base/json", "dojo/topic", "dijit/registry",
				"dojo/_base/lang","sys/evaluation/mobile/js/EvaluationReplyPopupMixin" ],
		function(declare, EditorUtil, util, json, topic, registry, lang,EvaluationReplyPopupMixin) {
			var item = declare(
					"sys.evaluation.EvaluationReplyPostMixin",
					EvaluationReplyPopupMixin,
					{

						replyPostUrl : '/sys/evaluation/sys_evaluation_main/sysEvaluationReply.do?method=save',

						// 回复事件
						_onReplyClick : function(datas) {
							var self = this, parent = self.getParent();
							var forumValidates = [];
							var data = {
								plugin : [ 'face' ],
								limitNum : 1000
							};
							lang.mixin(data, datas);
							
							var callback=function(data) {
								if (data.status == 200) {
									topic.publish(
											'/mui/list/toTop',
											this, {
												time : 0
											});
									this
											.defer(
													function() {
														topic
																.publish(
																		"/mui/list/onPull",
																		registry
																				.byId('eval_scollView'));
													}, 100);
								}
							}
							
							var config = {_url : self.replyPostUrl,afterHideMask : callback};
							config = lang.mixin(config,data ? data : {});
							var editor = new EvaluationReplyPopupMixin(config);
							editor.onEditorClick.call(editor);
							

						}

					});
			return item;
		});