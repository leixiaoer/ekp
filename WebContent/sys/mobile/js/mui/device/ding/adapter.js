/**
 * 用于钉钉客户端对应功能接口调用
 */
define(["https://g.alicdn.com/dingding/open-develop/1.6.9/dingtalk.js",
		"dojo/_base/lang","mui/device/device","dojo/request","mui/util","mui/coordtransform", 
		"mui/i18n/i18n!sys-attachment","mui/dialog/Tip","dojo/Deferred","dojo/topic","mui/map"], 
		function(dd,lang,device,request, util, coordtransform, Msg ,Tip ,Deferred,topic,map) {
	
		var ___ready___ = false,
			___readyfail___ = false;
	
		var adapter = {
			
			__readyCallbacks : [],
			
			__readyfailCallbacks : [],
			
			__hasListener__ : false,
			
			/**
			 * 内部ready,需要授权的功能都要先调用此ready,回调中this已`修正`
			 * @param callback
			 * 		钉钉授权成功回调函数
			 * @param failcallback
			 * 		钉钉授权失败回调函数，该回调函数尝试给开发者一个机会去调用父类(web端)的基座能力,父类基座能力可以采用$super$XXX的方式调用
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
					topic.subscribe('/third/ding/ready',lang.hitch(this,function(){
						var cb = null;
						while(cb = this.__readyCallbacks.shift()){
							cb && cb.call(this);
						}
					}));
					topic.subscribe('/third/ding/readyfail',lang.hitch(this,function(){
						var failcb = null;
						while(failcb = this.__readyfailCallbacks.shift()){
							failcb && failcb.call(this);
						}
					}));
				}
			},
			
			/**
			 * 关闭当前窗口，表现为回到钉钉工作台
			 */
			closeWindow : function(){
				this.ready(function(){
					dd.biz.navigation.close();
				},function(){
					dd.biz.navigation.close(); //修复 #100907
					//this['$super$closeWindow'] && this['$super$closeWindow'].apply(this);
				});
				return {};
			},
			
			/**
			 * 注册钉钉resume事件：当页面重新可见并可交互时，钉钉会产生回调，开发者可监听此resume事件，并处理开发者自己的业务逻辑。
			 * @param callback
			 */
			resume: function(callback){
				console.log("注册钉钉resume事件监听")
				document.addEventListener('resume', callback);
			},
			
			/**
			 * 设置标题；服气，设置个标题都要调api
			 */
			setTitle: function(title){
				
				if (!title) {
					title = "";
				}
				title = title.trim();
				this.ready(function(){  //修复 #107617
					dd.biz.navigation.setTitle({
						title : title,
						onSuccess : function(result) {
					    },
					    onFail : function(err) {
					    }
					});
				},function(){
					//#114854
					console.log("ready失败！")
					dd.biz.navigation.setTitle({
						title : title,
						onSuccess : function(result) {
					    },
					    onFail : function(err) {
					    }
					});
				});
				// 这个也得手动设置下，否则调用setTitle后使用document.title获取标题错误
				document.title = title;
			},
			
			imagePreview3 : function(options){
				this['$super$imagePreview'] && this['$super$imagePreview'].call(this,options);
				return {};
			},
			
			/**
			 * 调用钉钉图片预览接口
			 */
			imagePreview : function(options){
				console.log(options);
				if(options.curSrc.indexOf("blob:")==0){
					this['$super$imagePreview'] && this['$super$imagePreview'].call(this,options);
				}else{
					dd.biz.util.previewImage({
					    current: options.curSrc , // 当前显示图片的http链接
					    urls: options.srcList, // 需要预览的图片http链接列表
					    onSuccess : function(result) {
	                        /**/
	                    },
	                    onFail : function(err) {
	                    	console.log("previewImage失败");
	                    	this['$super$imagePreview'] && this['$super$imagePreview'].call(this,options);
	                    }
					});
				}
				return {};
			},
			
			sleep : function(time) {
			    var startTime = new Date().getTime() + parseInt(time, 10);
			    while(new Date().getTime() < startTime) {}
			},
			
			downloadToDing : function(options,repeat){
				var _url='';
				var _corpid='';
				var errmsg='';
				var timestamp = options.time;
				
				$.ajaxSettings.async = false;
	            $.post(dojoConfig.baseUrl+'sys/attachment/sys_att_main/sysAttMain.do?method=downloadToOther',{
	            	'fdId': options.fdId,
	            	'key': 'ding',
	            	't': timestamp
		        },null);
	            $.ajaxSettings.async = true;
	            
	            if(repeat){
		            var isSuccess = false;
		            var count=0;
		            while(count < 3){
		            	$.ajaxSettings.async = false;
			            $.post(dojoConfig.baseUrl+'sys/attachment/sys_att_main/sysAttMain.do?method=isSuccess',{
			            	'fdId': options.fdId,
			            	'key': 'ding',
			            	't': timestamp,
			            	'type': '0'
				        },function(result){
				        	if(result.status == "0"){
				        		isSuccess = true;
				        		_url=result['msg'].url;
				        		_corpid=result['msg'].corpId;
					        	_name=result['msg'].name;
				        	}
				        });
			            $.ajaxSettings.async = true;
			            if(isSuccess){
			            	break;
			            }
			            count=Number(count)+1;
			            if(count==3){
			            	Tip.tip({
			            		time : 5000,
								text : Msg['mui.sysAttMain.download.oversize']
							});
			            }else{
			            	this.sleep(5000);
			            }
		            }
		            
		            if(_url != '' && _corpid != ''){
		            	var options = {
		    					corpId:_corpid,
		    					url:_url,
		    				    name:_name
		    			};			
		    			this.saveFile(options);
		            }else{
		            	//alert("保存失败！");
		            }
	            }
			},	
			
			isSuccess : function(fdId,timestamp){
		    	var isSuccess = false;
		    	$.ajaxSettings.async = false;
		        $.post(dojoConfig.baseUrl+'sys/attachment/sys_att_main/sysAttMain.do?method=isSuccess',{
		        	'fdId': fdId,
		        	'key': 'ding',
		        	't': timestamp,
		        	'type': '0'
		        },function(result){
		        	if(result.status == "0"){
		        		isSuccess = true;
		        	}
		        });
		        $.ajaxSettings.async = true;
		        
		        return isSuccess;
			},
			
			downloadFromDing : function(options){
				dd.ready(function() {
				    dd.runtime.permission.requestAuthCode({
				        corpId:options.corpId, // 企业id
				        onSuccess: function (info) {
				                  var code = info.code // 通过该免登授权码可以获取用户身份
				                  dd.biz.util.uploadAttachment({
				      			    space:{corpId:options.corpId,isCopy:0 , max:1},
				      			    types:["space"],//PC端支持["photo","file","space"]
				      			    onSuccess : function(result) {
				      			    	$.post(dojoConfig.baseUrl+'third/ding/third_ding_cspace/thirdDingCspace.do?method=download',{
				      			        	'code':code,
				      			        	'spaceId':result.data[0].spaceId,
				      			        	'fileId':result.data[0].fileId,
				      			        	'fileName':result.data[0].fileName,
				      			        	'fileType':result.data[0].fileType
				      			        },function(result){
				      			        	alert(result);
				      			        });
				      			    	
				      			    },
				      			    onFail : function(err) {}
				      			});
				        }});
				});
	            
			},	
			
			
			saveFile : function(options){
				this.ready(function(){
					dd.biz.cspace.saveFile({
				        corpId:options.corpId,
				        url:options.url,  // 文件在第三方服务器地址， 也可为通过服务端接口上传文件得到的media_id，详见参数说明
				        name:options.name,
				        onSuccess: function(data) {
				                },
				        onFail: function(err) {
				            // alert(JSON.stringify(err));
				        }
				    });					
				},function(){
					Tip.fail({
						text : 'ready失败'
					});
				});
			},			
			
			/**
			 * 打开页面
			 */
			open : function(url, target, context){
				if(url.indexOf("/")==0){
					url=util.getHost()+url;
				}
				try{
					// #147454 使用window.open在钉钉上打开，返回时有兼容问题，所以open页面全部使用openLink打开
					dd.biz.util.openLink({
						url : url,
						onFail : function(err){
							window.open(url, '_self');
						}
					});
					return;
				}catch(e){
					window.open(url, '_self');
					return;
				}
			},
			
			/**
			 * 拉起钉钉会话窗口
			 */
			openChat : function(options){
				this.ready(function(){
					var defer = this._fetchUserId(options);
					defer.then(function(__options){
						dd.biz.chat.openSingleChat(__options);
					});
				},function(){
					this['$super$openChat'] && this['$super$openChat'].call(this,options);
				});
			},
			
			/**
			 * 打开钉钉员工信息页面
			 */
			openUserCard : function(options){
				this.ready(function(){
					var defer = this._fetchUserId(options),
						self = this;
					defer.then(function(__options){
						dd.biz.util.open({
							name : 'profile',
							params: {
								id : __options.userId,
								corpId : __options.corpId
							},
							onFail : function(err){
								console.log('errorMessage:' + err.errorMessage);
								self['$super$openUserCard'] && self['$super$openUserCard'].call(self,options);
							}
						});
					});
				},function(){
					this['$super$openUserCard'] && this['$super$openUserCard'].call(this,options);
				});
			},
			
			_fetchUserId : function(options){
				options.userId = options.loginName;
				var defer = new Deferred();
				if(!options.userId && options.ekpId){
					//--------获取当前使用的集成组件--------------
					var prefix = null;
					// 优化同步方法
					var getUrl = dojoConfig.baseUrl + 'sys/mobile/adapter.do?method=getDingPrefix',
					getOption = { data : { url : location.href },  handleAs : 'json'};
					request.post(getUrl ,getOption).response.then(function(rtn){
						var info = rtn.data;
						prefix = info.url;
						
						var url = util.formatUrl("/" + prefix + '/user.do?method=getUserId&fdId=' + options.ekpId);
						request(url,{handleAs : 'json'}).then(function(result){
							options.userId = result.userId;
							options.corpId = result.corpId;
							defer.resolve(options);
						});
						
					},function(){
						console.log("请求失败！");
					});
					
					
				}else{
					defer.resolve(options);
				}
				return defer;
			},
				
			/**
			 * 钉钉客户端下载
			 */
			download : function(options) {
				var isIOS = function(){
					var ua = navigator.userAgent.toLowerCase();
					if (/(iPhone|iPad|iPod|iOS)/i.test(ua)) { 
						return true;
					}
					return false;
				};
				var isAndriod = function() {
					var ua = navigator.userAgent.toLowerCase();
					if (ua.indexOf('android') > -1) {
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
				
				//IOS直接下载
				if (!isAndriod()){
					location.href = util.formatUrl(options.href);
					return;
				}
				console.log(options);
			
				var downloadUrl = util.formatUrl(options.href);
				$.ajaxSettings.async = false;
				$.post(dojoConfig.baseUrl+'sys/attachment/sys_att_main/sysAttMain.do?method=getSignDownload',{
                    'fdAttMainId': options.fdId
                },function(result){
                    if(result.hasAtt == true){
                        if(result.hasRest){
                            downloadUrl = result.downloadUrl; //3分钟内匿名下载
                           // console.log("downloadUrl:",downloadUrl);
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
				$.ajaxSettings.async = true;
				
				this.open(downloadUrl, '_blank');
                return;
			},
			
			/**
			 * 拉起钉钉扫码
			 */
			scanQRCode : function(callback){
				this.ready(function(){
					dd.biz.util.scan({
						type: 'qrCode',
					    onSuccess: function(data) {
					    	callback && callback({
					    		text : data.text
					    	});
					    },
					   onFail : function(err) {
					   }
					});
				},function(){
					this['$super$scanQRCode'] && this['$super$scanQRCode'].call(this,callback);
				});
				return true;
			},
			
			openViewMap : function(options, callback, failcallback){
				this.ready(function(){
					var tCoord = [options.lng, options.lat];
					//如果坐标系为百度,尝试做下非标准转换让坐标在高德地图上显示位置更精准
					if(options.coordType == 'bd09'){
						tCoord = coordtransform.bd09togcj02(options.lng, options.lat);
					}
					dd.biz.map.view({
						longitude : tCoord[0],
						latitude : tCoord[1],
						title : options.value
					});
					callback && callback();
				},function(){
					this['$super$openViewMap'] && this['$super$openViewMap'].call(this,options, callback, failcallback);
				});
			},
			
			openEditMap : function(options,callback, failcallback){
				this.ready(function(){
					var tCoord = [options.lng, options.lat];
					//如果坐标系为百度,尝试做下非标准转换让坐标在高德地图上显示位置更精准
					if(options.coordType == 'bd09' && options.lng && options.lat){
						tCoord = coordtransform.bd09togcj02(options.lng, options.lat);
					}
					dd.biz.map.locate({
						longitude : tCoord[0],
						latitude : tCoord[1],
						onSuccess : function(result){
							var point = {
								lat : result.latitude,
								lng : result.longitude
							};
							if(options.coordType == 'bd09' ){
								var coord = coordtransform.gcj02tobd09(point.lng, point.lat);
								point.lng = coord[0];
								point.lat = coord[1];
							}
							callback && callback({
								point : point,
								value : result.title,
								detail : result.snippet
							})
						}
					})
				},function(){
					this['$super$openEditMap'] && this['$super$openEditMap'].call(this,options, callback, failcallback);
				});
			},
			
			/**
			 * 获取网络类型(wifi 2g 3g 4g unknown none, none表示离线)
			 */
			getNetworkType : function(callback){
				this.ready(function(){
					dd.device.connection.getNetworkType({
						onSuccess : function(data){
							callback && callback({
								networkType : data.result
							});
						},
						onFail : function(err) {
							callback && callback();
						}
					});
				},function(){
					this['$super$getNetworkType'] && this['$super$getNetworkType'].call(this,callback);
				});
			},
			
			/**
			 * 获取接入热点信息
			 */
			getWifiInfo : function(callback){
				var self = this;
				this.ready(function(){
					dd.device.base.getInterface({
						onSuccess : function(data){
							callback && callback({
								ssid  : data.ssid,
								macIp : self._fixMacIp(data.macIp)
							});
						},
						onFail : function(err) {
							Tip.fail({
								text : '获取WIFI信息失败:'+err
							});
							callback && callback();
						}
					});
				},function(){
					Tip.fail({
						text : '调用钉钉wifi接口授权失败'
					});
					this['$super$getWifiInfo'] && this['$super$getWifiInfo'].call(this,callback);
				});
			},
			
			// IOS端获取的wifi mac地址少了低位0
			_fixMacIp : function(macIp){
				var formatMapIp = '';
				if(macIp){
					var blocks = macIp.split('\:');
					var bitsArr = [];
					for(var i in blocks){
						var bits = blocks[i] || '';
						if(bits.length == 0){
							bits = '00';
						} else if(bits.length == 1){
							bits = '0' + bits[0];
						}
						bitsArr.push(bits);
					}
					formatMapIp = bitsArr.join(':')
				}
				return formatMapIp;
			},
			
			getDeviceInfo : function(callback){
				this.ready(function(){
					dd.device.base.getUUID({
					    onSuccess : function(data) {
					       callback && callback({
								deviceId : data.uuid
							});
					    },
					    onFail : function(err) {
							callback && callback();
						}
					});
				});
			},
			
			//创建钉钉群聊  第一步 调用钉钉 选择选择部门和人员jsapi  第二步发起群聊
			complexPicker : function(options, callback){
				this.ready(function(){
					dd.biz.contact.complexPicker({
					    title:options.title,            //标题
					    corpId:options.corpId,              //企业的corpId
					    multiple:true,            //是否多选
					    limitTips:"超出了",          //超过限定人数返回提示
					    maxUsers:1000,            //最大可选人数
					    pickedUsers:options.pickedUsers,            //已选用户
					    pickedDepartments:[],          //已选部门
					    disabledUsers:[],            //不可选用户
					    disabledDepartments:[],        //不可选部门
					    requiredUsers:[],            //必选用户（不可取消选中状态）
					    requiredDepartments:[],        //必选部门（不可取消选中状态）
					    appId:options.appId,              //微应用的Id
					    permissionType:"GLOBAL",          //选人权限，目前只有GLOBAL这个参数
					    responseUserOnly:true,        //返回人，或者返回人和部门 true表示返回人，false返回人和部门
					    startWithDepartmentId:0 ,   // 0表示从企业最上层开始
					    onSuccess: function(result) {
					        /**
					        {
					            selectedCount:1,                              //选择人数
					            users:[{"name":"","avatar":"","emplId":""}]，//返回选人的列表，列表中的对象包含name（用户名），avatar（用户头像），emplId（用户工号）三个字段
					            departments:[{"id":,"name":"","number":}]//返回已选部门列表，列表中每个对象包含id（部门id）、name（部门名称）、number（部门人数）
					        }
					        */
					    	callback && callback({
					    		users : result.users
							});
					    },
					   onFail : function(err) {
						   console.log(err);
					   }
					});
				},function(){
					Tip.tip({
		    			icon : 'mui mui-warn',
						text : '调钉钉jsapi:dd.biz.contact.complexPicker失败'
					});
				});
			},
			
			//发起群聊
			createGroup : function(options, callback){
				this.ready(function(){
					dd.biz.contact.createGroup({
					    corpId: options.corpId, //企业id，可选，配置该参数即在指定企业创建群聊天
					    users: options.emplIds, //默认选中的用户工号列表，可选；使用此参数必须指定corpId
					    onSuccess: function(result) {
					    	callback && callback({
					    		groupID : result.id
							});
					    },
					    onFail: function(err) {
						   Tip.fail({
								text : err.errorMessage
							});
					    }
					});
				});
			},
			
			//打开钉钉群
			openGroup : function(options){
				this.ready(function(){
					dd.biz.chat.toConversation({
					    corpId: options.corpId, //企业id
					    chatId: options.chatId,//会话Id
					    onSuccess : function() {},
					    onFail : function() {}
					})
				});
			},
			
			//根据corpid选择会话
			chooseConversationByCorpId : function(corpId, callback){
				this.ready(function(){
					dd.biz.chat.chooseConversationByCorpId({
					    corpId: corpId, //企业id
					    onSuccess : function() {
					        /*{
					            chatId: 'xxxx',
					            title:'xxx'
					        }*/
					    	callback && callback({
					    		chatId : result.chatId
							});
					},
					    onFail : function() {}
					})
				});
			},
			
			//开始录音
			startRecord : function(){
				this.ready(function(){
					dd.device.audio.startRecord({
					    onSuccess : function () {
					    },
					    onFail : function (err) {
					    	Tip.fail({
								text : err.errorMessage
							});
					    }
					});
				});
			},
			
			//结束录音
			stopRecord : function(){
			/*	var attSetting = context.options;
				if(!window.AttachmentList)
					window.AttachmentList = {};
				var attachmentObj = window.AttachmentList[attSetting.fdKey];
				if(!attachmentObj){
					attachmentObj = new Attachment(attSetting);
					window.AttachmentList[attSetting.fdKey] = attachmentObj;
				}*/
				this.ready(function(){
					dd.device.audio.stopRecord({
					    onSuccess : function(res){
					        //res.mediaId; // 返回音频的MediaID，可用于本地播放和音频下载
					        //res.duration; // 返回音频的时长，单位：秒
					    	download(res.mediaId);
					        //attachmentObj.startUploadFile(file);
					    },
					    onFail : function (err) {
					    	Tip.fail({
								text : err.errorMessage
							});
					    }
					});
				});
			},
			
			//下载录音
			audioDownload : function(mediaId){
				this.ready(function(){
					dd.device.audio.download({
					    mediaId : mediaId,
					    onSuccess : function(res) {
					        res.localAudioId;
					    },
					    onFail : function (err) {
					    	Tip.fail({
								text : err.errorMessage
							});
					    }
					});
				});
			},
			
			//播放录音
			play : function(localAudioId){
				this.ready(function(){
					dd.device.audio.play({
					    localAudioId : localAudioId,
					    onSuccess : function () {
					 
					    },
					    onFail : function (err) {
					    	Tip.fail({
								text : err.errorMessage
							});
					    }
					});
				});
			},
			
			//创建Ding
			createDing : function(options){
				this.ready(function(){
					dd.biz.ding.create(options);
				});
			},
			
			
			//拨打钉钉电话
			call : function(users, corpId){
				this.ready(function(){
					dd.biz.telephone.call({
					    users: users, //用户列表，工号
					    corpId: corpId, //企业id
					    onSuccess : function() {},
					    onFail : function() {}
					})
				});
			},
			
			getCurrentCoord : function(callback,error,options){
				this.ready(function(){
					dd.device.geolocation.get({
					    targetAccuracy : 200,
					    coordinate : 1,
					    withReGeocode : false,
					    useCache: false, 
					    onSuccess : function(res) {
					    	var rs = { lat:res.latitude, lng:res.longitude,coordType:5 };
					    	callback && callback(rs);
					    },
					    onFail : function(err) {
					    	if(window.console)
								window.console.log(err);
							Tip.tip({
				    			icon : 'mui mui-warn',
								text : '钉钉地理定位失败'
							});
					    	error && error(err);
					    }
					});
				}, function(){
					if(window.console)
						window.console.log('调用钉钉坐标定位接口授权失败');
					this['$super$getCurrentCoord'] && this['$super$getCurrentCoord'].call(this,callback,error);
				});
			},
			
			getCurrentPosition: function(callback,error,options){
				options = options || {};
				this.ready(function(){
					this.getCurrentCoord(function(res){
						map.getMapLocation(lang.mixin(res,options),callback,error);
					},error,options);
				},function(){
					if(window.console)
						window.console.log('调用钉钉定位接口失败');
					this['$super$getCurrentPosition'] && this['$super$getCurrentPosition'].call(this,callback,error);
				});
			},
			
		};
		
		
		
		/**
		 * 签名校验验证
		 */
		(function(){
			var deviceType = device.getClientType();
			if (deviceType != 11) return;
			if (!dd) return;
			
			var queryUrl = location.href;
			if(window.oldLocaHrefUrl 
					&& (window.oldLocaHrefUrl.indexOf("knowledge") > -1 
					|| window.oldLocaHrefUrl.indexOf("multidoc") > -1)) {
				queryUrl = window.oldLocaHrefUrl
			}
			var url = dojoConfig.baseUrl,
			option = { data : { url : queryUrl },  handleAs : 'json' };
			
			//--------获取当前使用的集成组件--------------
			var getUrl = dojoConfig.baseUrl + 'sys/mobile/adapter.do?method=getDingPrefix',			
			getOption = { data : { url : location.href },  handleAs : 'json'};			
			request.post(getUrl ,getOption).response.then(function(rtn){
				var info = rtn.data;
				url = url + info.url + '/jsapi.do?method=jsapiSignature';
				request.post(url ,option).response.then(function(rtn){
					var signInfo = rtn.data;
					if(signInfo){
						dd.config({
							appId: signInfo.appId,
							agentId:signInfo.appId,
							corpId: signInfo.corpId,
						    timeStamp: signInfo.timeStamp,
						    nonceStr: signInfo.nonceStr,
						    signature: signInfo.signature,
						    jsApiList: ['biz.chat.openSingleChat','biz.util.open','biz.util.openLink','biz.map.locate','biz.map.view','device.connection.getNetworkType','device.base.getInterface','device.base.getUUID','biz.contact.complexPicker','biz.contact.createGroup','biz.chat.toConversation','biz.chat.chooseConversationByCorpId','device.audio.startRecord','device.audio.stopRecord','device.audio.download','device.audio.play','biz.ding.create','biz.telephone.call','device.geolocation.get','biz.chat.pickConversation','biz.navigation.quit','biz.navigation.setTitle','biz.cspace.saveFile','biz.util.uploadAttachment']
						});
						dd.ready(function(){
							___ready___ = true;
							topic.publish('/third/ding/ready');
						});
						dd.error(function(error){
							console.log(error.message);
							var error_message = JSON.stringify(error.message);
							var start = error_message.indexOf('url:[')
							var end = error_message.indexOf('],ticketList:')
							var error_url = error_message.substring(start+5,end);
							console.log("error_url:"+error_url);
							console.log(JSON.stringify(signInfo));
							console.log('location.href:' + location.href);
							console.log('errCode:' + error['errorCode']);
							console.log('-------- errMsg:' + error['message']);
							//修复 #115117 #126021
							if(error_url != ""){
								console.log('error_url:' + location.href);
								option = { data : { url : error_url },  handleAs : 'json' };
								request.post(url ,option).response.then(function(rtn){
										var signInfo = rtn.data;
										if(signInfo){
											dd.config({
												appId: signInfo.appId,
												agentId:signInfo.appId,
												corpId: signInfo.corpId,
											    timeStamp: signInfo.timeStamp,
											    nonceStr: signInfo.nonceStr,
											    signature: signInfo.signature,
											    jsApiList: ['biz.chat.openSingleChat','biz.util.open','biz.util.openLink','biz.map.locate','biz.map.view','device.connection.getNetworkType','device.base.getInterface','device.base.getUUID','biz.contact.complexPicker','biz.contact.createGroup','biz.chat.toConversation','biz.chat.chooseConversationByCorpId','device.audio.startRecord','device.audio.stopRecord','device.audio.download','device.audio.play','biz.ding.create','biz.telephone.call','device.geolocation.get','biz.chat.pickConversation','biz.navigation.quit','biz.navigation.setTitle','biz.cspace.saveFile','biz.util.uploadAttachment']
											});
											console.log(JSON.stringify(signInfo));
											dd.ready(function(){
												___ready___ = true;
												topic.publish('/third/ding/ready');
											});
											dd.error(function(error){
												___readyfail___ = true;
												topic.publish('/third/ding/readyfail');
												console.log('url:' + error_url);
												console.log('errCode:' + error['errorCode']);
												console.log('22 errMsg:' + error['message']);
											});
										}else{
											___readyfail___ = true;
											topic.publish('/third/ding/readyfail');
											console.log('signInfo empty(ding)');
										}
									},function(){
										___readyfail___ = true;
										topic.publish('/third/ding/readyfail');
										console.log(JSON.stringify(arguments));
									});
									
							}else{
								___readyfail___ = true;
								topic.publish('/third/ding/readyfail');
							}
						});
					}else{
						___readyfail___ = true;
						topic.publish('/third/ding/readyfail');
						console.log('signInfo empty(ding)');
					}
				},function(){
					___readyfail___ = true;
					topic.publish('/third/ding/readyfail');
					console.log(JSON.stringify(arguments));
				});
			},function(e){
				console.log("请求失败！"+e);
			});
			//后端获取签名信息
		})();
		
		return adapter;
	});
