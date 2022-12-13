(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.DingTalkPC = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client");exports.config=require("./libs/config"),exports.ready=require("./libs/ready").ready,exports.error=require("./libs/error").error,exports.device={},exports.device.notification={},exports.device.notification.alert=require("./libs/device/notification/alert"),exports.device.notification.confirm=require("./libs/device/notification/confirm"),exports.device.notification.toast=require("./libs/device/notification/toast"),exports.device.notification.prompt=require("./libs/device/notification/prompt"),exports.device.notification.actionSheet=require("./libs/device/notification/actionSheet"),exports.biz={},exports.biz.util={},exports.biz.util.open=require("./libs/biz/util/open"),exports.biz.util.openModal=require("./libs/biz/util/openModal"),exports.biz.util.openSlidePanel=require("./libs/biz/util/openSlidePanel"),exports.biz.util.uploadImage=require("./libs/biz/util/uploadImage"),exports.biz.util.downloadFile=require("./libs/biz/util/downloadFile"),exports.biz.util.openLocalFile=require("./libs/biz/util/openLocalFile"),exports.biz.util.isLocalFileExist=require("./libs/biz/util/isLocalFileExist"),exports.biz.util.previewImage=require("./libs/biz/util/previewImage"),exports.biz.util.previewFile=require("./libs/biz/util/previewFile"),exports.biz.util.openLink=require("./libs/biz/util/openLink"),exports.biz.navigation={},exports.biz.navigation.setTitle=require("./libs/biz/navigation/setTitle"),exports.biz.navigation.quit=require("./libs/biz/navigation/quit"),exports.biz.navigation.setLeft=require("./libs/biz/navigation/setLeft"),exports.biz.oauth={},exports.biz.oauth.authorize=require("./libs/biz/oauth/authorize"),exports.biz.contact={},exports.biz.contact.choose=require("./libs/biz/contact/choose"),exports.biz.customContact={},exports.biz.customContact.choose=require("./libs/biz/customContact/choose"),exports.biz.customContact.multipleChoose=require("./libs/biz/customContact/multipleChoose"),exports.biz.chat={},exports.biz.chat.chooseConversation=require("./libs/biz/chat/chooseConversation"),exports.biz.ding={},exports.biz.ding.post=require("./libs/biz/ding/post"),exports.ua=require("./libs/ua/ua"),exports.runtime={},exports.runtime.permission={},exports.runtime.permission.requestAuthCode=require("./libs/runtime/permission/requestAuthCode"),exports.addEventListener=frameTalkClient.addEventListener,document.addEventListener("click",function(i){require("./libs/_private/event")({event:"click"})},!1);
},{"./libs/_private/event":2,"./libs/biz/chat/chooseConversation":3,"./libs/biz/contact/choose":4,"./libs/biz/customContact/choose":5,"./libs/biz/customContact/multipleChoose":6,"./libs/biz/ding/post":7,"./libs/biz/navigation/quit":8,"./libs/biz/navigation/setLeft":9,"./libs/biz/navigation/setTitle":10,"./libs/biz/oauth/authorize":11,"./libs/biz/util/downloadFile":12,"./libs/biz/util/isLocalFileExist":13,"./libs/biz/util/open":14,"./libs/biz/util/openLink":15,"./libs/biz/util/openLocalFile":16,"./libs/biz/util/openModal":17,"./libs/biz/util/openSlidePanel":18,"./libs/biz/util/previewFile":19,"./libs/biz/util/previewImage":20,"./libs/biz/util/uploadImage":21,"./libs/config":22,"./libs/device/notification/actionSheet":23,"./libs/device/notification/alert":24,"./libs/device/notification/confirm":25,"./libs/device/notification/prompt":26,"./libs/device/notification/toast":27,"./libs/error":28,"./libs/ready":29,"./libs/runtime/permission/requestAuthCode":30,"./libs/ua/ua":31,"@ali/frame-talk/client":32}],2:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="_private.event";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],3:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.chat.chooseConversation";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],4:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.contact.choose";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],5:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.customContact.choose";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],6:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.customContact.multipleChoose";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],7:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.ding.post";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],8:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.navigation.quit";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],9:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.navigation.setLeft";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],10:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.navigation.setTitle";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],11:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.oauth.authorize";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],12:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.downloadFile";module.exports=function(e){var r=e.onProgress||function(){};delete e.onProgress;var n=frameTalkClient.invokeAPI(methodName,e);return n.addEventListener("onProgress",function(e){r(e)}),n};


},{"@ali/frame-talk/client":32}],13:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.isLocalFileExist";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],14:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.open";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],15:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.openLink",ua=require("../../ua/ua");module.exports=function(e){return ua.isDesktop?frameTalkClient.invokeAPI(methodName,e):e.url?(window.open(e.url),{result:Promise.resolve()}):{result:Promise.reject()}};


},{"../../ua/ua":31,"@ali/frame-talk/client":32}],16:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.openLocalFile";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],17:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.openModal";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],18:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.openSlidePanel";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],19:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.previewFile";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],20:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.previewImage";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],21:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="biz.util.uploadImage";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],22:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),changeToReady=require("./ready").changeToReady,changeToError=require("./error").changeToError,methodName="config";module.exports=function(e){e.version=require("../package.json").version,e.url=window.location.href.split("#")[0];var r=frameTalkClient.invokeAPI(methodName,e);r.result.then(function(e){changeToReady(e)},function(e){changeToError(e)})};


},{"../package.json":45,"./error":28,"./ready":29,"@ali/frame-talk/client":32}],23:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="device.notification.actionSheet";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],24:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="device.notification.alert";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],25:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="device.notification.confirm";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],26:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="device.notification.prompt";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],27:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="device.notification.toast";module.exports=function(e){return frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],28:[function(require,module,exports){
"use strict";var cacheCallbacks=[],errorState=0,_errMsg,changeToError=function(r){_errMsg=r,errorState=1,cacheCallbacks.forEach(function(r){setTimeout(function(){r(_errMsg)},0)})},error=function(r){1===errorState?setTimeout(function(){r(_errMsg)},0):cacheCallbacks.push(r)};exports.error=error,exports.changeToError=changeToError;


},{}],29:[function(require,module,exports){
"use strict";var cacheCallbacks=[],readyState=0,_res,changeToReady=function(e){_res=e,readyState=1,cacheCallbacks.forEach(function(e){setTimeout(function(){e(_res)},0)})},ready=function(e){1===readyState?setTimeout(function(){e(_res)},0):cacheCallbacks.push(e)};exports.ready=ready,exports.changeToReady=changeToReady;


},{}],30:[function(require,module,exports){
"use strict";var frameTalkClient=require("@ali/frame-talk/client"),methodName="runtime.permission.requestAuthCode";module.exports=function(e){return e.url=window.location.href.split("#")[0],frameTalkClient.invokeAPI(methodName,e)};


},{"@ali/frame-talk/client":32}],31:[function(require,module,exports){
var ua=window.navigator.userAgent,isMac=-1!==ua.indexOf("Mac"),isNw=-1!==ua.indexOf("nw"),isWin=-1!==ua.indexOf("Win"),frameName=window.name,containerId=null;try{if(frameName){var frameConf=JSON.parse(frameName);containerId=frameConf.containerId}}catch(e){}module.exports={isDesktop:isNw,isInDingTalk:!!containerId,isWeb:!isNw,isWin:isWin,isMac:isMac};


},{}],32:[function(require,module,exports){
"use strict";var genMsgId=function(){return(new Date).getTime()+Math.ceil(1e3*Math.random())},_cloneDeep=require("lodash.clonedeep"),pendingMsgs={},isTrust=!1,hostOrigin="",containerId=null,trustTopDomain=".dingtalk.com",frameConf={};try{var frameConf=JSON.parse(window.name)}catch(e){frameConf={}}if(frameConf.hostOrigin){var hostName=frameConf.hostOrigin.split(":")[1];hostName.slice(0-trustTopDomain.length)===trustTopDomain&&frameConf.containerId&&(isTrust=!0,hostOrigin=frameConf.hostOrigin,containerId=frameConf.containerId)}var ClientMessage=function(e){this._msgForSend=e,this._p={};var n=this;this.result=new Promise(function(e,t){n._p._resolve=e,n._p._reject=t}),this._eventsHandle={},this._init()};ClientMessage.prototype._receiveResponse=function(e,n){var n=!!n;n?(this._p._reject(e),this.callbacks&&this.callbacks.onFail&&this.callbacks.onFail(e)):(this._p._resolve(e),this.callbacks&&this.callbacks.onSuccess&&this.callbacks.onSuccess(e))},ClientMessage.prototype._init=function(){var e=this._msgForSend.body,n={};e&&"object"==typeof e&&Object.keys(e).forEach(function(t){"function"==typeof e[t]&&(n[t]=e[t],delete e[t])}),this.callbacks=n},ClientMessage.prototype._receiveEvent=function(e,n){Array.isArray(this._eventsHandle[e])&&this._eventsHandle[e].forEach(function(e){try{e(n)}catch(t){console.error(n)}});var t="on"+e.charAt(0).toUpperCase()+e.slice(1);this.callbacks[t]&&this.callbacks[t](n)},ClientMessage.prototype.addEventListener=function(e,n){if(!e||"function"!=typeof n)throw"eventName is null or handle is not a function, addEventListener fail";Array.isArray(this._eventsHandle[e])||(this._eventsHandle[e]=[]),this._eventsHandle[e].push(n)},ClientMessage.prototype.removeEventListener=function(e,n){if(!e||!n)throw"eventName is null or handle is null, invoke removeEventListener fail";if(Array.isArray(this._eventsHandle[e])){var t=this._eventsHandle[e].indexOf(n);-1!==t&&this._eventsHandle[e].splice(t,1)}},window.addEventListener("message",function(e){var n=e.data,t=e.origin;if(t===hostOrigin)if("response"===n.type&&n.msgId){var s=n.msgId;pendingMsgs[s]&&(pendingMsgs[s]._receiveResponse(n.body,!n.success),delete pendingMsgs[s])}else if("event"===n.type&&n.msgId){var s=n.msgId;pendingMsgs[s]&&pendingMsgs[s]._receiveEvent(n.eventName,n.body)}}),exports.invokeAPI=function(e,n){var t=genMsgId(),s={msgId:t,methodName:e,containerId:containerId,body:_cloneDeep(n)},i=new ClientMessage(s);return isTrust&&(window.parent.postMessage(s,hostOrigin),pendingMsgs[t]=i),i};var INIT_EVENT_SERVICE_NAME="SYS_openAPIContainerInitEvent",eventClientMsg=null;exports.addEventListener=function(e,n){eventClientMsg||(eventClientMsg=exports.invokeAPI(INIT_EVENT_SERVICE_NAME,{})),eventClientMsg.addEventListener(e,n)},exports.removeEventListener=function(e,n){eventClientMsg&&eventClientMsg.removeEventListener(e,n)};


},{"lodash.clonedeep":33}],33:[function(require,module,exports){
function cloneDeep(e,l,n){return"function"==typeof l?baseClone(e,!0,bindCallback(l,n,3)):baseClone(e,!0)}var baseClone=require("lodash._baseclone"),bindCallback=require("lodash._bindcallback");module.exports=cloneDeep;


},{"lodash._baseclone":34,"lodash._bindcallback":44}],34:[function(require,module,exports){
(function (global){
function baseClone(a,e,r,n,t,o,g){var c;if(r&&(c=t?r(a,n,t):r(a)),void 0!==c)return c;if(!isObject(a))return a;var l=isArray(a);if(l){if(c=initCloneArray(a),!e)return arrayCopy(a,c)}else{var s=objToString.call(a),T=s==funcTag;if(s!=objectTag&&s!=argsTag&&(!T||t))return cloneableTags[s]?initCloneByTag(a,s,e):t?a:{};if(c=initCloneObject(T?{}:a),!e)return baseAssign(c,a)}o||(o=[]),g||(g=[]);for(var b=o.length;b--;)if(o[b]==a)return g[b];return o.push(a),g.push(c),(l?arrayEach:baseForOwn)(a,function(n,t){c[t]=baseClone(n,e,r,t,a,o,g)}),c}function baseForOwn(a,e){return baseFor(a,e,keys)}function bufferClone(a){var e=new ArrayBuffer(a.byteLength),r=new Uint8Array(e);return r.set(new Uint8Array(a)),e}function initCloneArray(a){var e=a.length,r=new a.constructor(e);return e&&"string"==typeof a[0]&&hasOwnProperty.call(a,"index")&&(r.index=a.index,r.input=a.input),r}function initCloneObject(a){var e=a.constructor;return"function"==typeof e&&e instanceof e||(e=Object),new e}function initCloneByTag(a,e,r){var n=a.constructor;switch(e){case arrayBufferTag:return bufferClone(a);case boolTag:case dateTag:return new n(+a);case float32Tag:case float64Tag:case int8Tag:case int16Tag:case int32Tag:case uint8Tag:case uint8ClampedTag:case uint16Tag:case uint32Tag:var t=a.buffer;return new n(r?bufferClone(t):t,a.byteOffset,a.length);case numberTag:case stringTag:return new n(a);case regexpTag:var o=new n(a.source,reFlags.exec(a));o.lastIndex=a.lastIndex}return o}function isObject(a){var e=typeof a;return!!a&&("object"==e||"function"==e)}var arrayCopy=require("lodash._arraycopy"),arrayEach=require("lodash._arrayeach"),baseAssign=require("lodash._baseassign"),baseFor=require("lodash._basefor"),isArray=require("lodash.isarray"),keys=require("lodash.keys"),argsTag="[object Arguments]",arrayTag="[object Array]",boolTag="[object Boolean]",dateTag="[object Date]",errorTag="[object Error]",funcTag="[object Function]",mapTag="[object Map]",numberTag="[object Number]",objectTag="[object Object]",regexpTag="[object RegExp]",setTag="[object Set]",stringTag="[object String]",weakMapTag="[object WeakMap]",arrayBufferTag="[object ArrayBuffer]",float32Tag="[object Float32Array]",float64Tag="[object Float64Array]",int8Tag="[object Int8Array]",int16Tag="[object Int16Array]",int32Tag="[object Int32Array]",uint8Tag="[object Uint8Array]",uint8ClampedTag="[object Uint8ClampedArray]",uint16Tag="[object Uint16Array]",uint32Tag="[object Uint32Array]",reFlags=/\w*$/,cloneableTags={};cloneableTags[argsTag]=cloneableTags[arrayTag]=cloneableTags[arrayBufferTag]=cloneableTags[boolTag]=cloneableTags[dateTag]=cloneableTags[float32Tag]=cloneableTags[float64Tag]=cloneableTags[int8Tag]=cloneableTags[int16Tag]=cloneableTags[int32Tag]=cloneableTags[numberTag]=cloneableTags[objectTag]=cloneableTags[regexpTag]=cloneableTags[stringTag]=cloneableTags[uint8Tag]=cloneableTags[uint8ClampedTag]=cloneableTags[uint16Tag]=cloneableTags[uint32Tag]=!0,cloneableTags[errorTag]=cloneableTags[funcTag]=cloneableTags[mapTag]=cloneableTags[setTag]=cloneableTags[weakMapTag]=!1;var objectProto=Object.prototype,hasOwnProperty=objectProto.hasOwnProperty,objToString=objectProto.toString,ArrayBuffer=global.ArrayBuffer,Uint8Array=global.Uint8Array;module.exports=baseClone;


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"lodash._arraycopy":35,"lodash._arrayeach":36,"lodash._baseassign":37,"lodash._basefor":39,"lodash.isarray":40,"lodash.keys":41}],35:[function(require,module,exports){
function arrayCopy(r,a){var o=-1,y=r.length;for(a||(a=Array(y));++o<y;)a[o]=r[o];return a}module.exports=arrayCopy;


},{}],36:[function(require,module,exports){
function arrayEach(r,a){for(var e=-1,n=r.length;++e<n&&a(r[e],e,r)!==!1;);return r}module.exports=arrayEach;


},{}],37:[function(require,module,exports){
function baseAssign(e,s){return null==s?e:baseCopy(s,keys(s),e)}var baseCopy=require("lodash._basecopy"),keys=require("lodash.keys");module.exports=baseAssign;


},{"lodash._basecopy":38,"lodash.keys":41}],38:[function(require,module,exports){
function baseCopy(e,o,r){r||(r={});for(var a=-1,n=o.length;++a<n;){var t=o[a];r[t]=e[t]}return r}module.exports=baseCopy;


},{}],39:[function(require,module,exports){
function createBaseFor(e){return function(t,r,o){for(var n=toObject(t),c=o(t),a=c.length,u=e?a:-1;e?u--:++u<a;){var b=c[u];if(r(n[b],b,n)===!1)break}return t}}function toObject(e){return isObject(e)?e:Object(e)}function isObject(e){var t=typeof e;return!!e&&("object"==t||"function"==t)}var baseFor=createBaseFor();module.exports=baseFor;


},{}],40:[function(require,module,exports){
function isObjectLike(t){return!!t&&"object"==typeof t}function getNative(t,r){var e=null==t?void 0:t[r];return isNative(e)?e:void 0}function isLength(t){return"number"==typeof t&&t>-1&&t%1==0&&MAX_SAFE_INTEGER>=t}function isFunction(t){return isObject(t)&&objToString.call(t)==funcTag}function isObject(t){var r=typeof t;return!!t&&("object"==r||"function"==r)}function isNative(t){return null==t?!1:isFunction(t)?reIsNative.test(fnToString.call(t)):isObjectLike(t)&&reIsHostCtor.test(t)}var arrayTag="[object Array]",funcTag="[object Function]",reIsHostCtor=/^\[object .+?Constructor\]$/,objectProto=Object.prototype,fnToString=Function.prototype.toString,hasOwnProperty=objectProto.hasOwnProperty,objToString=objectProto.toString,reIsNative=RegExp("^"+fnToString.call(hasOwnProperty).replace(/[\\^$.*+?()[\]{}|]/g,"\\$&").replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g,"$1.*?")+"$"),nativeIsArray=getNative(Array,"isArray"),MAX_SAFE_INTEGER=9007199254740991,isArray=nativeIsArray||function(t){return isObjectLike(t)&&isLength(t.length)&&objToString.call(t)==arrayTag};module.exports=isArray;


},{}],41:[function(require,module,exports){
function baseProperty(e){return function(t){return null==t?void 0:t[e]}}function isArrayLike(e){return null!=e&&isLength(getLength(e))}function isIndex(e,t){return e="number"==typeof e||reIsUint.test(e)?+e:-1,t=null==t?MAX_SAFE_INTEGER:t,e>-1&&e%1==0&&t>e}function isLength(e){return"number"==typeof e&&e>-1&&e%1==0&&MAX_SAFE_INTEGER>=e}function shimKeys(e){for(var t=keysIn(e),r=t.length,n=r&&e.length,s=!!n&&isLength(n)&&(isArray(e)||isArguments(e)),o=-1,i=[];++o<r;){var u=t[o];(s&&isIndex(u,n)||hasOwnProperty.call(e,u))&&i.push(u)}return i}function isObject(e){var t=typeof e;return!!e&&("object"==t||"function"==t)}function keysIn(e){if(null==e)return[];isObject(e)||(e=Object(e));var t=e.length;t=t&&isLength(t)&&(isArray(e)||isArguments(e))&&t||0;for(var r=e.constructor,n=-1,s="function"==typeof r&&r.prototype===e,o=Array(t),i=t>0;++n<t;)o[n]=n+"";for(var u in e)i&&isIndex(u,t)||"constructor"==u&&(s||!hasOwnProperty.call(e,u))||o.push(u);return o}var getNative=require("lodash._getnative"),isArguments=require("lodash.isarguments"),isArray=require("lodash.isarray"),reIsUint=/^\d+$/,objectProto=Object.prototype,hasOwnProperty=objectProto.hasOwnProperty,nativeKeys=getNative(Object,"keys"),MAX_SAFE_INTEGER=9007199254740991,getLength=baseProperty("length"),keys=nativeKeys?function(e){var t=null==e?void 0:e.constructor;return"function"==typeof t&&t.prototype===e||"function"!=typeof e&&isArrayLike(e)?shimKeys(e):isObject(e)?nativeKeys(e):[]}:shimKeys;module.exports=keys;


},{"lodash._getnative":42,"lodash.isarguments":43,"lodash.isarray":40}],42:[function(require,module,exports){
function isObjectLike(t){return!!t&&"object"==typeof t}function getNative(t,o){var e=null==t?void 0:t[o];return isNative(e)?e:void 0}function isFunction(t){return isObject(t)&&objToString.call(t)==funcTag}function isObject(t){var o=typeof t;return!!t&&("object"==o||"function"==o)}function isNative(t){return null==t?!1:isFunction(t)?reIsNative.test(fnToString.call(t)):isObjectLike(t)&&reIsHostCtor.test(t)}var funcTag="[object Function]",reIsHostCtor=/^\[object .+?Constructor\]$/,objectProto=Object.prototype,fnToString=Function.prototype.toString,hasOwnProperty=objectProto.hasOwnProperty,objToString=objectProto.toString,reIsNative=RegExp("^"+fnToString.call(hasOwnProperty).replace(/[\\^$.*+?()[\]{}|]/g,"\\$&").replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g,"$1.*?")+"$");module.exports=getNative;


},{}],43:[function(require,module,exports){
function isObjectLike(e){return!!e&&"object"==typeof e}function baseProperty(e){return function(r){return null==r?void 0:r[e]}}function isArrayLike(e){return null!=e&&isLength(getLength(e))}function isLength(e){return"number"==typeof e&&e>-1&&e%1==0&&MAX_SAFE_INTEGER>=e}function isArguments(e){return isObjectLike(e)&&isArrayLike(e)&&hasOwnProperty.call(e,"callee")&&!propertyIsEnumerable.call(e,"callee")}var objectProto=Object.prototype,hasOwnProperty=objectProto.hasOwnProperty,propertyIsEnumerable=objectProto.propertyIsEnumerable,MAX_SAFE_INTEGER=9007199254740991,getLength=baseProperty("length");module.exports=isArguments;


},{}],44:[function(require,module,exports){
function bindCallback(n,t,r){if("function"!=typeof n)return identity;if(void 0===t)return n;switch(r){case 1:return function(r){return n.call(t,r)};case 3:return function(r,e,u){return n.call(t,r,e,u)};case 4:return function(r,e,u,c){return n.call(t,r,e,u,c)};case 5:return function(r,e,u,c,i){return n.call(t,r,e,u,c,i)}}return function(){return n.apply(t,arguments)}}function identity(n){return n}module.exports=bindCallback;


},{}],45:[function(require,module,exports){
module.exports={
  "name": "dingtalk-pc-api",
  "version": "2.3.1",
  "description": "",
  "main": "index.js",
  "scripts": {
    "prestart": "tnpm install",
    "start": "./node_modules/.bin/ding-server -s -S 8443 -N dev2.dingtalk.com -n g2-assets.daily.taobao.net",
    "start-nossl":"./node_modules/.bin/ding-server -p 8443 -N dev2.dingtalk.com -n g2-assets.daily.taobao.net",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "dingTalk": {
    "mode": "browserify",
    "entry": [
      "example/index.js",
      "example/slidePanel.js",
      "example/modal.js"
    ],
    "cssOutput": [
      "example/index.css"
    ],
    "UMDEntry": [
      {
        "fpath": "./index.js",
        "namespace": "DingTalkPC"
      }
    ],
    "htmlRoot": "example"
  },
  "dingTalkUMD": {
    "namespace": "DingTalkPC",
    "src": "./index.js"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "@ali/ding-server": "~2.7.0"
  },
  "dependencies": {
    "@ali/frame-talk": "~2.1.2",
    "codemirror": "~5.7.0",
    "jquery": "~2.1.4",
    "js-beautify": "~1.5.10",
    "lodash": "~3.10.0",
    "lodash.clonedeep": "~3.0.2"
  }
}

},{}]},{},[1])(1)
});