define(["dojo/_base/declare", "mui/i18n/i18n!km-pindagate:mobile", "dojo/topic", "dojo/dom", "dojo/query", 'dijit/registry', "dojo/dom-class", "dojo/dom-style"],
    function (declare, msg, topic, dom, query, registry, domClass, domStyle) {

        return declare("km.pindagate.common.RelationResponseMixin", null, {

/**        // ================== 题目关联样例 =================== //
             {
    "1": {						// 题目1（单关联）
        "0": {					// 第1个关联设置
            "showTopic": 1,		// 需要显示的题目（从0开始，这里的1表示显示第2题）
            "relationItem": ["1"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationSel": "",
            "relationFlag": "",	// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 0			// 关联的题目（从0开始，这里的0表示关联第1题）
        }
    },
    "2": {						// 题目2（单关联）
        "0": {					// 第1个关联设置
            "showTopic": 2,
            "relationItem": ["2"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationSel": "",
            "relationFlag": "",	// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 0
        }
    },
    "3": {						// 题目3（双关联，多题关系为：或）
        "0": {					// 第1个关联设置
            "showTopic": 3,
            "relationItem": ["1"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationSel": "",
            "relationFlag": "1",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 0
        },
        "1": {					// 第2个关联设置
            "showTopic": 3,
            "relationItem": ["0", "1"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationOpt": "1",	// 匹配结果：（1：已选择，2：未选择），仅多选
            "relationSel": "1", // 匹配类型：（1：其中一个，2：全部匹配），仅多选
            "relationFlag": "1",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 2
        }
    },
    "4": {						// 题目4（双关联，多题关系为：且）
        "0": {					// 第1个关联设置
            "showTopic": 4,
            "relationItem": ["2"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationSel": "",
            "relationFlag": "0",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 0
        },
        "1": {					// 第2个关联设置
            "showTopic": 4,
            "relationItem": ["0", "1"], // 关联的选择值，目前只有单选和多选可以配置关联
            "relationOpt": "2",	// 匹配结果：（1：已选择，2：未选择），仅多选
            "relationSel": "2", // 匹配类型：（1：其中一个，2：全部匹配），仅多选
            "relationFlag": "0",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 2
        }
    },
    "5": {						// 题目5（双关联，多题关系为：且）
        "0": {					// 第1个关联设置
            "showTopic": 5,
            "relationItem": ["2"],
            "relationSel": "",
            "relationFlag": "0",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 0
        },
        "1": {					// 第2个关联设置
            "showTopic": 5,
            "relationItem": ["1", "2"],	// 匹配的选项值
            "relationOpt": "1",	// 匹配结果：（1：已选择，2：未选择），仅多选
            "relationSel": "2",	// 匹配类型：（1：其中一个，2：全部匹配），仅多选
            "relationFlag": "0",// 多个题目关联时的关系：0或“”为且，1为或
            "topic": 2
        }
    }
}
*/
            // 是否全匹配
            is_all_match: function (items, anser) {
                if (!items || !anser) {
                    // 如果其中一个数组没有值，直接返回false
                    return false;
                }
				// 全部匹配时，选择的答案必须要大于或等于设置的选项
				if(anser.length < items.length) {
					return false;
				}
                for (var n in items) {
                    if (anser.indexOf(items[n]) < 0) {
                        // 有数据没有匹配上，返回false
                        return false;
                    }
                }
                // 数据匹配成功
                return true;
            },
            // 是否有其中1个匹配
            is_in_match: function (items, anser) {
                if (!items || !anser) {
                    // 如果其中一个数组没有值，直接返回false
                    return false;
                }
                for (var n in items) {
                    if (anser.indexOf(items[n]) > -1) {
                        // 找到一个匹配的数据直接返回true
                        return true;
                    }
                }
                // 没有找到能够匹配的数据
                return false;
            },
            // 是否全不匹配
            is_all_no_match: function (items, anser) {
                if (!items || !anser) {
                    // 如果其中一个数组没有值，直接返回true
                    return true;
                }
                for (var n in items) {
                    if (anser.indexOf(items[n]) > -1) {
                        // 找到一个，表示并不是全不匹配，返回false
                        return false;
                    }
                }
                // 数据匹配成功
                return true;
            },
            // 是否有其中1个不匹配
            is_in_no_match: function (items, anser) {
                if (!items || !anser) {
                    // 如果其中一个数组没有值，直接返回false
                    return true;
                }
                for (var n in items) {
                    if (anser.indexOf(items[n]) < 0) {
                        // 找到一个不匹配的数据直接返回true
                        return true;
                    }
                }
                // 没有找到能够匹配的数据
                return false;
            },
            // 答案匹配（根据传入的关联关系，匹配是否需要显示）
            answer_match: function (relation) {
                // 获取当前题目的关联选项值
                var items = relation.relationItem,
                    // 获取已经选择的答案
                    anserVal = query("input[name='fdItems[" + relation.topic + "].fdAnswer']").val(),
                    // 匹配结果
                    flag = false;
                // 如果题目没有选择，直接返回false
                if (anserVal.length < 1) {
                    return false;
                }
                // 已选中结果拆分
                anserVal = anserVal.split(";");
                // 答案匹配
                var sel = relation.relationSel,		// 1：其中一个，2：全部匹配
                    opt = relation.relationOpt;		// 1：已选择，2：未选择
                if (opt && opt == "2") {			// 匹配未选择的数据
                    if (sel && sel == "2") {		// 必须所有匹配才行
                        if (items.length > 1) {	// 多选
                            flag = this.is_all_no_match(items, anserVal);
                        } else {				// 单选
                            if (anserVal.indexOf(items[0]) > -1) {
                                // 匹配成功
                                flag = true;
                            }
                        }
                    } else {					// 只要匹配上一个就行
                        if (items.length > 1) {	// 多选
                            flag = this.is_in_no_match(items, anserVal);
                        } else {				// 单选
                            if (anserVal.indexOf(items[0]) > -1) {
                                // 匹配成功
                                flag = true;
                            }
                        }
                    }
                } else {						// 匹配已经选择的数据
                    if (sel && sel == "2") {		// 必须所有匹配才行
                        if (items.length > 1) {	// 多选
                            flag = this.is_all_match(items, anserVal);
                        } else {				// 单选
                            if (anserVal.indexOf(items[0]) > -1) {
                                // 匹配成功
                                flag = true;
                            }
                        }
                    } else {					// 只要匹配上一个就行
                        if (items.length > 1) {	// 多选
                            flag = this.is_in_match(items, anserVal);
                        } else {				// 单选
                            if (anserVal.indexOf(items[0]) > -1) {
                                // 匹配成功
                                flag = true;
                            }
                        }
                    }
                }
                return flag;
            },

            // 显示题目
            showTopic: function () {
                // 获取关联逻辑（所有的关联逻辑保存到一个大字段中，一次性加载）
                fdRelationCheck = dom.byId("fdRelationCheck");
                if (fdRelationCheck) {
                    fdRelationCheck = fdRelationCheck.value;
                }
                var self = this;
                topic.subscribe('km/pindagate/relation', function (widget, args) {
                	//#145909 修复 微信扫码填写时，填写第一题就可以提交了
                	var fdRelationValue = dom.byId("fdRelationCheck").value;
                    if (fdRelationValue) {
                        // 获取所有关联逻辑，JSON对象，数据结构同上
                        relationShow = JSON.parse(fdRelationValue);
                        // 循环所有关联题目
                        for (var f in relationShow) {
                            // 获取每题的关联信息（每个题目可能会关联多个题目，并且有“且”和“或”的组合条件）
                            var single = JSON.parse(relationShow[f]),
                                sing = true; // 组合条件
                            // 循环每题的多个关联（一个题目可以关联多个题目）
                            for (var g in single) {
                                // 每个关联
                                var s = single[g];
                                // 多个题目关联时的关系：0或“”为且，1为或
                                if (s.relationFlag && (s.relationFlag == "" || s.relationFlag == "0")) {
                                    // 多题关联，组合条件为：且（所有匹配才能显示）
                                    if (!sing) {
                                        // 如果上一次匹配失败，并且所有题目是“且”的关系，那么后续就不用再匹配了，因为条件已经不满足了
                                        break;
                                    }
                                }
                                // 答案匹配中
                                sing = self.answer_match(s);
                                // 多个题目关联时，如果是“或”关系，只要1题通过，就返回true，并结束
                                if (s.relationFlag && s.relationFlag == "1") {
                                    if (sing) {
                                        break;
                                    }
                                }
                            }
                            // 该题目的所有关联关系都匹配完了，结果就保存在sing中，true表示匹配成功，false表示匹配失败
                            // 修复全局对象，将该题目设置为可显示
                            window.allTopics[f].isShow = sing;
                        }
                        // 设置显示的题目
                        var navSgin = [];
                        for (var n in allTopics) {
							var _tip = allTopics[n];
							var topicId = document.querySelector("[name='questionResoinseKey" + _tip.topic + "']");
                            if (_tip.isShow) {
								topicId.style.display = "block";
                            } else {
								topicId.style.display = "none";
								navSgin.push(_tip.topic + 1);
								// 清除已经选中的答案
								query("input[name='fdItems[" + n + "].fdAnswer']").val("");
                                query("input[name='fdItems[" + n + "].fdAnswerTxt']").val("");
                                query("textarea[name='fdItems[" + n + "].fdAnswer']").val("");
							}
                        }
                        query("input[name='navSgin']").val(JSON.stringify(navSgin));
                        // 发布分页事件
                        topic.publish('km/pindagate/paging', {
                            currentPage: widget.index + 1,
                            totalPage: allTopics.length,
                            pageType: 'custom',
                            showType: 'now'
                        });
                    }
                });

            }

        });

    });