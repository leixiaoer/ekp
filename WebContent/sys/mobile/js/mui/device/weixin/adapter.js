/**
 * 用于微信客户端对应功能接口调用
 */
define(["lib/weixin/weixin","dojo/request","dojo/_base/lang","mui/util","mui/coordtransform",
			"mui/i18n/i18n!sys-attachment","mui/dialog/Tip","dojo/Deferred","dojo/topic","mui/device/device","mui/map"],
		function(wx ,request,lang, util, coordtransform, Msg,Tip ,Deferred,topic,device,map) {
		var ___ready___ = false,
			___readyfail___ = false;
	
		var adapter = {
			
			__readyCallbacks : [],
				
			__readyfailCallbacks : [],
				
			__hasListener__ : false,	
			
			/**
			 * 内部ready,需要授权的功能都要先调用此ready,回调中this已`修正`
			 * @param callback
			 * 		企业微信授权成功回调函数
			 * @param failcallback
			 * 		企业微信授权失败回调函数，该回调函数尝试给开发者一个机会去调用父类(web端)的基座能力,父类基座能力可以采用$super$XXX的方式调用
			 */
			ready : function(callback,failcallback){
				if(___readyfail___){
					failcallback && failcallback.call(this);
					return;
				}
				if(___ready___){
					callback && callback.call(this);
					return;
				}
				this.__readyCallbacks.push(callback);
				this.__readyfailCallbacks.push(failcallback);
				if(!this.__hasListener__){
					this.__hasListener__ = true;
					topic.subscribe('/third/wxwork/ready',lang.hitch(this,function(){
						var cb = null;
						while(cb = this.__readyCallbacks.shift()){
							cb && cb.call(this);
						}
					}));
					topic.subscribe('/third/wxwork/readyfail',lang.hitch(this,function(){
						var failcb = null;
						while(failcb = this.__readyfailCallbacks.shift()){
							failcb && failcb.call(this);
						}
					}));
				}
			},
				
			/**
			 * 关闭窗口，表现为返回到企业微信工作台
			 */
			closeWindow : function(){
				this.ready(function(){
					wx.closeWindow();
				},function(){
					if(WeixinJSBridge){
						 WeixinJSBridge.call('closeWindow');
					}else{
						this['$super$closeWindow'] && this['$super$closeWindow'].call(this);
					}
				});
				return {};
			},
			sign : function(scallback,fcallback,soptions,foptions){
				var jsApiList =  ['startRecord','stopRecord','translateVoice','scanQRCode','getLocation','openLocation','openEnterpriseChat','selectEnterpriseContact','login'];

				var defer = new Deferred(),
				url = dojoConfig.baseUrl + 'third/wxwork/jsapi/wxJsapi.do?method=jsapiSignature',
				option = { data : { url : location.href }, handleAs : 'json' };
				
				console.log(" location.href:"+ location.href)
				//后端获取签名信息
				request.post(url ,option).response.then(function(rtn){
					var signInfo = rtn.data;
					if(signInfo && signInfo.appId){
						wx.config({
							appId : signInfo.appId,
							timestamp : signInfo.timestamp,
							nonceStr : signInfo.noncestr,
							signature : signInfo.signature,
							jsApiList : jsApiList
						});
						wx.ready(function(){
							scallback(soptions);
						});
						wx.error(function(){
						});
					}else{
						fcallback();
						console.log('signInfo appId empty(wxwork)');
					}
				},function(){
					fcallback();
					console.log(JSON.stringify(arguments));
				});
			},
			
			/**
			 * 企业微信图片预览
			 */
			imagePreview : function(options) {				
				//alert(options.curSrc)
				if(options.curSrc.indexOf("blob:")==0){
					this['$super$imagePreview'] && this['$super$imagePreview'].call(this,options);
					//兼容  148888 企业微信手机客户端在ekp流程上传图片后再打卡显示“图片加载失败”
					document.getElementsByClassName("muiRtfPicSlider")[0].style.zIndex="999";
				}else{
					var t = this['$super$imagePreview'];
					var ti = this;
					this.sign(function(soptions){
						wx.previewImage({
							current : soptions.curSrc, // 当前显示图片的http链接
							urls : soptions.srcList, // 需要预览的图片http链接列表
							success:function(){},
							fail:function(msg){
								t&&t.call(ti,options);
								console.log("error:"+msg.errMsg)
							}
						});
					},function(){
						t&&t.call(ti,options);
					},options,options);
				
				}
			},
			
			/**
			 * 附件预览
			 */
			fileView:function(options){
				
			},
			
			/**
			 * 企业微信下载
			 */
			download : function(options) {
				var isIOS = function(){
					var ua = navigator.userAgent.toLowerCase();
					if (/(iPhone|iPad|iPod|iOS)/i.test(ua)) { 
						return true;
					}
					return false;
				};	
				
				//安卓微信
				var isWechatAndriod = function() {
					var ua = navigator.userAgent.toLowerCase();
					if (ua.indexOf('android') > -1 && ua.indexOf('micromessenger') > -1) {
						return true;
					} 
					return false;
				};
				if(isIOS()){
					var name = options.name.toLowerCase(),
						fileExt = name.substring(name.lastIndexOf(".") + 1);
					if(fileExt == 'zip' || fileExt == 'rar'){
						Tip.fail({
							text : '暂不支持此文件类型打开'
						});
						return;
					}
				}
				
				//微信会跳出浏览器 #163279
				var downloadUrl = util.formatUrl(options.href);
				$.ajaxSettings.async = false;
				if(isWechatAndriod()){
					$.post(dojoConfig.baseUrl+'sys/attachment/sys_att_main/sysAttMain.do?method=getSignDownload',{
	                    'fdAttMainId': options.fdId
	                },function(result){
	                    if(result.hasAtt == true){
	                        if(result.hasRest){
	                            downloadUrl = result.downloadUrl;
	                            //console.log("downloadUrl:",downloadUrl);
	                        }else{
	                           Tip.fail({
	                                text : "未配置附件rest服务访问策略" 
	                            });
	                        }
	                    }else{
	                       Tip.fail({
	                            text : "附件不存在" 
	                        });
	                    }
	                });
				}
				$.ajaxSettings.async = true;
				
				location.href = downloadUrl;
				return;
//				//修复  #102604  企业微信附件泄露问题
//				var url = util
//						.formatUrl("/resource/third/weixin/attachment.do?method=download&fdId="
//								+ options.fdId);
//				location.href = url;
//				return;
			},
			
			/**
			 * 拉起企业微信扫码
			 */
			scanQRCode : function(callback){
				this.ready(function(){
					wx.scanQRCode({
					    desc: 'scanQRCode desc',
					    needResult : 1,
					    scanType: ["qrCode","barCode"],//一维码、二维码
					    success: function (res) {
					    	callback && callback({ text : res.text || res.resultStr });
					    },
					    error: function(res){
					    	if(res.errMsg.indexOf('function_not_exist') > 0){
					    		Tip.tip({ icon : 'mui mui-warn',  text : '微信版本过低请升级' });
					    	}
					     }
					});
				},function(){
					this['$super$scanQRCode'] && this['$super$scanQRCode'].call(this,callback);
				})
				return true;
			},
			
			/**
			 * 企业微信中获取地理坐标
			 */
			getCurrentCoord : function(callback,error,options){
				this.ready(function(){
					var that = this;
					wx.getLocation({
						type:'gcj02',
						success:function(res){
					        var rs ={ lat:res.latitude, lng:res.longitude,coordType:5 };
					        callback && callback(rs);
						},
						cancel:function(){
							Tip.tip({
				    			icon : 'mui mui-warn',
								text : '只有授权才允许地理定位'
							});
							error && error();
						},
						fail: function(res){
							if(window.console){
								window.console.log(res.errMsg);
								window.console.log('微信地理定位失败');
							}
							//error && error();
							//#153547 修复 微信端（微信或企业微信）扫码签到无法定位
							that['$super$getCurrentCoord'] && that['$super$getCurrentCoord'].call(that,callback,error);
					     }
					});
				},function(){
					// #105983 修复 企业微信打开签到应用报错显示“调用微信坐标定位接口授权失败”
					var that = this;
					//再次鉴权
					this.sign(function(soptions){
						wx.getLocation({
							type:'gcj02',
							success:function(res){
						        var rs ={ lat:res.latitude, lng:res.longitude,coordType:5 };
						        callback && callback(rs);
							},
							cancel:function(){
								Tip.tip({
					    			icon : 'mui mui-warn',
									text : '只有授权才允许地理定位'
								});
								error && error();
							},
							fail: function(res){
								console.log(res);
								if(window.console){
									window.console.log(res.errMsg);
									window.console.log('微信地理定位失败');
								}
								//#135457 用企业微信或者微信扫码会议签到，扫码签到时提示定位失败
								that['$super$getCurrentCoord'] && that['$super$getCurrentCoord'].call(that,callback,error);
						     }
						});
						
					},function(){
						that['$super$getCurrentCoord'] && that['$super$getCurrentCoord'].call(that,callback,error);
					},options,options);
					
				});
			},
			
			/**
			 *  企业微信中获取地理位置信息
			 */
			getCurrentPosition: function(callback,error,options){
				options = options || {};
				this.ready(function(){
					this.getCurrentCoord(function(res){
						map.getMapLocation(lang.mixin(res,options),callback,error);
					},error,options);
				},function(){
					if(window.console)
						window.console.log('调用微信定位接口失败');
					this['$super$getCurrentPosition'] && this['$super$getCurrentPosition'].call(this,callback,error);
				});
			},
			
			/**
			 * 开始录音
			 */
			startRecord : function(cb) {
				this.ready(function(){
					function failed(e) {
						// 只支持企业号，简单微信扫码直接提示错误信息
						if (this.failTipTimer)
							clearTimeout(this.failTipTimer);
						this.failTipTimer = setTimeout(function() {
							alert(e.errMsg);
						}, 100);
					}
					// 首次触发用户认证，不当做录音操作
					if (!localStorage.__allowRecord
							|| localStorage.__allowRecord !== 'true') {
						wx.startRecord({
							success : function() {
								localStorage.__allowRecord = 'true';
								wx.stopRecord();
							},
							fail : function(e) {
								failed(e);
							}
						});
						return;
					}
					this.timer = setTimeout(function() {
						wx.startRecord({
							fail : function(e) {
								failed(e);
							}
						});
						cb();
					}, 200)
				},function(){
					this['$super$startRecord'] && this['$super$startRecord'].call(this,cb);
				});
			},
			
			/**
			 * 结束录音
			 */
			stopRecord : function(sc, fc) {
				this.ready(function(){
					if (this.timer)
						clearTimeout(this.timer);
					setTimeout(function() {
						wx.stopRecord({
							success : function(res) {
								if (sc) sc(res);
							},
							fail : function(res) {
								if (fc) fc(res);
							}
						});
					}, 200);
				},function(){
					this['$super$stopRecord'] && this['$super$stopRecord'].call(this,sc, fc);
				});
			},
			
			/**
			 * 翻译录音
			 */
			stopRecordByTranslate : function(beforeTranslate, afterTranslate) {
				this.ready(function(){
					if (beforeTranslate)
						beforeTranslate();
					this.stopRecord(function(res) {
						var localId = res.localId;
						if (localId)
							wx.translateVoice({
								localId : localId,
								isShowProgressTips : 1,
								success : function(res) {
									if (afterTranslate)
										afterTranslate(res);
								}
							});
					})
				},function(){
					this['$super$stopRecordByTranslate'] && this['$super$stopRecordByTranslate'].call(this,beforeTranslate, afterTranslate);
				});
			},
			
			/** 企业微信的打开会话窗口返回后跳到工作台，体验极差，暂时不启用
			 * 
			openChat : function(options){
				var clientType = device.getClientType(),
				 	defer = new Deferred();
				options.userId = options.loginName;
				if(!options.userId && options.ekpId){
					var url = (clientType == 6 ? '/third/weixin/user' : '/third/weixin/work/user' );
					url = util.formatUrl(url + '.do?method=getUserId&fdId=' +options.ekpId);
					request(url,{handleAs : 'json'}).then(function(result){
						options.userId = result.userId;
						defer.resolve(options);
					});
				}else{
					defer.resolve(options);
				}
				defer.then(function(__options){
					wx.openEnterpriseChat({
					    userIds: __options.userId,    
					    groupName: ''
					});
				});
			}
			 */
			
			/*
			 * 企业微信通讯录选人：selectEnterpriseContact
			 */
			selectEnterpriseContact : function(options, callback){
				//alert("企业微信通讯录选人23");
				this.sign(function(options){
					wx.invoke("selectEnterpriseContact", {
		                "fromDepartmentId": 0,// 必填，表示打开的通讯录从指定的部门开始展示，-1表示自己所在部门开始, 0表示从最上层开始
		                "mode": "multi",// 必填，选择模式，single表示单选，multi表示多选
		                "type": ["user"],// 必填，选择限制类型，指定department、user中的一个或者多个
		                "selectedDepartmentIds": [],// 非必填，已选部门ID列表。用于多次选人时可重入，single模式下请勿填入多个id
		                "selectedUserIds": options.pickedUsers// 非必填，已选用户ID列表。用于多次选人时可重入，single模式下请勿填入多个id
			        },function(res){
		                if (res.err_msg == "selectEnterpriseContact:ok")
		                {
	                        if(typeof res.result == 'string')
	                        {
	                                res.result = JSON.parse(res.result) //由于目前各个终端尚未完全兼容，需要开发者额外判断result类型以保证在各个终端的兼容性
	                        }
	                        callback && callback({
					    		users : res.result.userList
							});
		                }
			        }
					);
				},function(){
					console.log('企业微信ready 失败')
				},options,options);
				
			},
			
			//发起群聊
			openEnterpriseChat:function(options, callback){
				console.log(this.sign);
				this.sign(function(options){
					wx.openEnterpriseChat({
				        // 注意：userIds和externalUserIds至少选填一个。内部群最多2000人；外部群最多500人；如果有微信联系人，最多40人
					    userIds: options.emplIds,    //参与会话的企业成员列表，格式为userid1;userid2;...，用分号隔开。
					    externalUserIds: '', // 参与会话的外部联系人列表，格式为userId1;userId2;…，用分号隔开。
					    groupName: options.groupName,  // 会话名称。单聊时该参数传入空字符串""即可。
					    chatId: options.chatId, // 若要打开已有会话，需指定此参数。如果是新建会话，chatId必须为空串
					    success: function(res) {
					         var chatId = res.chatId; //返回当前群聊ID，仅当使用agentConfig注入该接口权限时才返回chatId
					         console.log("chatId:",chatId);
					        // 回调
					         callback && callback({
					        	 chatId : chatId
							 });
					    },
					    fail: function(res) {
					        if(res.errMsg.indexOf('function not exist') > -1){
					            alert('版本过低请升级');
					        }
					    }
					});
				},function(){
					console.log("ready 失败！无法发起群聊")
				},options,options)
			},
			
			openViewMap : function(options, callback, failcallback){
				this.ready(function(){
					var tCoord = [options.lng, options.lat];
					//如果坐标系为百度,尝试做下非标准转换让坐标在腾讯地图上显示位置更精准
					if(options.coordType == 'bd09'){
						tCoord = coordtransform.bd09togcj02(options.lng, options.lat);
					}
					wx.openLocation({
						longitude : tCoord[0],
						latitude : tCoord[1],
						name : options.value || '',
						address : options.detailValue || ''
					});
					callback && callback();
				},function(){
					this['$super$openViewMap'] && this['$super$openViewMap'].call(this,options, callback, failcallback);
				});
			}
			
		};
		
		/**
		 * 签名授权验证
		 */
		(function(){
			var deviceType = device.getClientType();
			if (deviceType != 6 && deviceType != 12) return;
			if (!wx) return;
			
			signature2wxwork().then(function(){
				//企业微信中已获得签名,无需到企业号中去验证签名
				___ready___ = true;
				topic.publish('/third/wxwork/ready');
			},function(){
				//企业微信中获取签名出错，尝试从企业号中获取
				signature2wx().then(function(){
					___ready___ = true;
					topic.publish('/third/wxwork/ready');
				},function(){
					___ready___ = false;
					___readyfail___ = true;
					topic.publish('/third/wxwork/readyfail');
				});
			});
			
			var jsApiList =  ['startRecord','stopRecord','translateVoice','scanQRCode','getLocation','openLocation','openEnterpriseChat','selectEnterpriseContact'];
			
			//从企业微信中获取签名信息
			function signature2wxwork(){
				var defer = new Deferred(),
					url = dojoConfig.baseUrl + 'third/wxwork/jsapi/wxJsapi.do?method=jsapiSignature',
					option = { data : { url : location.href }, handleAs : 'json' };
				//后端获取签名信息
				request.post(url ,option).response.then(function(rtn){
					var signInfo = rtn.data;
					if(signInfo && signInfo.appId){
						wx.config({
							beta: true,// 必须这么写，否则wx.invoke调用形式的jsapi会有问题
							//debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
							appId : signInfo.appId,
							timestamp : signInfo.timestamp,
							nonceStr : signInfo.noncestr,
							signature : signInfo.signature,
							jsApiList : jsApiList
						});
						wx.ready(function(){
							defer.resolve();
						});
						wx.error(function(){
							defer.reject();
							console.log(JSON.stringify(arguments));
						});
					}else{
						defer.reject();
						console.log('signInfo appId empty(wxwork)');
					}
				},function(){
					defer.reject();
					console.log(JSON.stringify(arguments));
				});
				return defer;
			}
			
			//从企业号组件中获取签名信息
			function signature2wx(){
				var defer = new Deferred(),
					url = dojoConfig.baseUrl + 'third/wx/jsapi/wxJsapi.do?method=jsapiSignature',
					option = { data : { url : location.href }, handleAs : 'json' };
				//后端获取签名信息
				request.post(url ,option).response.then(function(rtn){
					var signInfo = rtn.data;
					if(signInfo && signInfo.appId){
						wx.config({
							appId : signInfo.appId,
							timestamp : signInfo.timestamp,
							nonceStr : signInfo.noncestr,
							signature : signInfo.signature,
							jsApiList : jsApiList
						});
						wx.ready(function(){
							defer.resolve();
						});
						wx.error(function(){
							defer.reject();
							console.log(JSON.stringify(arguments));
						});
					}else{
						defer.reject();
						console.log('signInfo appId empty(wx)');
					}
				},function(){
					defer.reject();
					console.log(JSON.stringify(arguments));
				});
				return defer;
			}
			
		})();
		
		return adapter;
	});
