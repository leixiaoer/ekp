!function(){var e;try{function t(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}function n(e){return(n=Object.setPrototypeOf?Object.getPrototypeOf:function(e){return e.__proto__||Object.getPrototypeOf(e)})(e)}function r(e,t){return(r=Object.setPrototypeOf||function(e,t){return e.__proto__=t,e})(e,t)}function i(){if("undefined"==typeof Reflect||!Reflect.construct)return!1;if(Reflect.construct.sham)return!1;if("function"==typeof Proxy)return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],(function(){}))),!0}catch(e){return!1}}function o(e,t,n){return(o=i()?Reflect.construct:function(e,t,n){var i=[null];i.push.apply(i,t);var o=new(Function.bind.apply(e,i));return n&&r(o,n.prototype),o}).apply(null,arguments)}function a(e){return(a=function(e){if(null===e||(t=e,-1===Function.toString.call(t).indexOf("[native code]")))return e;var t;if("function"!=typeof e)throw new TypeError("Super expression must either be null or a function");function i(){return o(e,arguments,n(this).constructor)}return i.prototype=Object.create(e.prototype,{constructor:{value:i,enumerable:!1,writable:!0,configurable:!0}}),r(i,e)})(e)}var u="u0556rIo1I8sb+EV9LyEkB60L8BcwDssciwXg8k1ssvrTGOv1ty70IfqmkrWkyekU9ioVzKiCAzlUnwVwdVnbyp8Wt6xeOm2mN6c8I0b6w1nU/z/ZZH/9Nf7hI5ICIr7kzfr78gsIUu2BqyMhRbFww==",c="wwopendata.web.js@210224-173237-485",l=window.encodeURIComponent;function s(){}function f(){return Math.random()}var p=location.origin||location.protocol+"//"+location.host,d="https://open.work.weixin.qq.com",h=d+"/wwopen/openData/frame/index#origin="+l(p),v="xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx".replace(/[xy]/g,(function(e){var t=16*Math.random()|0;return("x"===e?t:3&t|8).toString(16)})),w=[];function y(e){w.unshift({level:2,msg:e})}function g(e){w.unshift({level:4,msg:e}),m()}function m(){0!==w.length&&(function(e,t){var n=new XMLHttpRequest;"withCredentials"in n||(n=new XDomainRequest);for(var r=[],i=t.length,o=0;o<i;o++)r.push(["msg["+o+"]="+l(t[o].msg),"level["+o+"]="+t[o].level].join("&"));r.push("count="+i),n.open("POST",e),n.setRequestHeader("Content-type","application/x-www-form-urlencoded"),n.send(r.join("&"))}("https://aegis.qq.com/collect?id=LsKWKztteVKOjNJGsl&uin="+u+"&from="+p+"&sessionId="+v+"&version="+l(c),w.reverse()),w=[])}var b={};function x(e,t){b.hasOwnProperty(e)||(b[e]=[]),b[e].push(t)}function E(e,t){if(b.hasOwnProperty(e)){var n=b[e],r=n.indexOf(t);r>=0&&n.splice(r,1)}}function O(e,t,n){if(void 0===n&&(n=!1),b.hasOwnProperty(e))if(n){var r={type:e,detail:t};b[e].forEach((function(e){try{e(r)}catch(e){}}))}else O(e,t,!0)}function _(e,t){return function(){try{return t.apply(this,arguments)}catch(t){A(t,e),O("error",t)}}}e={captureException:A};var S=j((function(){}),y),C=j((function(){}),g);function A(e,t){g("["+t+"] "+T(e))}function j(e,t){return function(){for(var n=[],r=0,i=arguments.length;r<i;r++)n.push(D(arguments[r]));t(n.join(" ")),e.apply(void 0,arguments)}}function D(e){return e?"object"!=typeof e?e:"string"==typeof e.stack?T(C):JSON.stringify(e):e}function T(e){return e.name+" "+e.message+" "+e.stack}function k(e,t,n){Object.defineProperty(e,t,{value:n,enumerable:!0})}function P(e){var t=Object.create(null);return Object.getOwnPropertyNames(e).forEach((function(n){if("prototype"!==n){var r=Object.getOwnPropertyDescriptor(e,n),i=Object.create(null);k(i,"value",r.value),k(i,"get",r.get),k(i,"set",r.set),k(t,n,Object.freeze(i))}})),t}var R,M,F,N=function(){var e={JSON:window.JSON,Promise:window.Promise,Uint8Array:window.Uint8Array,Function:window.Function,Object:window.Object,Array:window.Array,String:window.String,WeakMap:window.WeakMap,Element:window.Element,ShadowRoot:window.ShadowRoot,Image:window.Image,Node:window.Node,EventTarget:window.EventTarget,HTMLIFrameElement:window.HTMLIFrameElement,CanvasRenderingContext2D:window.CanvasRenderingContext2D},t={fetch:window.fetch,parseInt:window.parseInt,setTimeout:window.setTimeout},n=Object.create(null);return k(n,"protected",Object.create(null)),k(n,"singleton",Object.create(null)),Object.keys(e).forEach((function(t){e[t]&&(k(n.singleton,t,e[t]),k(n.protected,t,P(e[t])),e[t].prototype&&(k(n.protected[t],"prototype",P(e[t].prototype)),Object.freeze(n.protected[t].prototype)),Object.freeze(n.protected[t]))})),Object.keys(t).forEach((function(e){k(n.singleton,e,t[e])})),k(n.singleton,"call",Function.prototype.call.bind(Function.prototype.call)),Object.defineProperty(n,"__version__",{value:c}),Object.freeze(n.protected),Object.freeze(n.singleton),Object.freeze(n),n}(),W=null==N?void 0:N.protected,I=null==N?void 0:N.singleton,q=(null==I?void 0:I.call)||Function.prototype.call.bind(Function.prototype.call),L=function(e){return e&&q(J,z,e)},J=le(W,"Function.prototype.bind"),z=le(W,"Function.prototype.call"),H=(le(W,"Object.create"),le(W,"Object.defineProperty")),U=le(I,"setTimeout","direct"),B=L(le(W,"Object.prototype.hasOwnProperty")),K=(L(le(W,"Array.prototype.push")),L(le(W,"Array.prototype.forEach"))),V=L(le(W,"String.prototype.indexOf")),X=L(le(W,"String.prototype.slice")),G=(le(I,"Image","direct"),L(le(W,"Image.prototype.src","set"))||L(le(W,"HTMLImageElement.prototype.src","set"))||function(e,t){e.src=t}),Y=L(le(W,"HTMLIframeElement.prototype.contentWindow","get"))||function(e){return e.contentWindow},Q=L(le(W,"HTMLIframeElement.prototype.contentDocument","get"))||function(e){return e.contentDocument},Z=L(le(W,"EventTarget.prototype.addEventListener"))||function(e,t,n){e.addEventListener(t,n)},$=L(le(W,"CanvasRenderingContext2D.prototype.fillText")),ee=L(le(W,"CanvasRenderingContext2D.prototype.drawImage")),te=L(le(W,"CanvasRenderingContext2D.prototype.strokeText")),ne=L(le(W,"CanvasRenderingContext2D.prototype.measureText")),re=le(I,"WeakMap","direct"),ie=L(le(W,"WeakMap.prototype.get")),oe=L(le(W,"WeakMap.prototype.set")),ae=L(le(W,"Element.prototype.attachShadow")),ue=L(le(W,"Node.prototype.textContent","set"));function ce(e){for(var t=le(W,"JSON.parse"),n=le(I,"Uint8Array","direct"),r=le(W,"String.fromCodePoint"),i=r,o=new n(e),a="",u=0,c=o.length;u<c;){var l=o[u++];if(l<=127)a+=i(l);else{var s=63&o[u++];if(l<=223)a+=i((31&l)<<6|s);else{var f=63&o[u++];if(l<=239)a+=i((15&l)<<12|s<<6|f);else{var p=63&o[u++];r?a+=i((7&l)<<18|s<<12|f<<6|p):(a+=i(63),u+=3)}}}}return t(a)}function le(e,t,n){var r,i,o,a,u;void 0===n&&(n="value");var c=(null==W||null==(r=W.String)?void 0:r.prototype.split.value)||window.String.prototype.split,l=(null==W||null==(i=W.Array)?void 0:i.prototype.pop.value)||window.Array.prototype.pop,s=(null==W||null==(o=W.Array)?void 0:o.prototype.forEach.value)||window.Array.prototype.forEach,f=(null==W||null==(a=W.Object)?void 0:a.getOwnPropertyDescriptor.value)||Object.getOwnPropertyDescriptor,p=q(c,t,"."),d=q(l,p),h=e,v=window;if(q(s,p,(function(e){h&&(h=h[e]),v&&(v=v[e])})),h&&h[d]){if(h=h[d],"direct"===n)return h;if(h[n])return h[n]}if(v)return"direct"===n||"value"===n?v[d]:null==(u=f(v,d))?void 0:u[n]}var se=(null==(R=window.crypto)?void 0:R.subtle)||(null==(M=window.crypto)?void 0:M.webkitSubtle);function fe(e,t){if(B(e,t))return e[t]}function pe(e,t,n){H(e,t,{value:n,writable:!0,enumerable:!0,configurable:!0})}function de(e,t,n,r,i){if(window.fetch)window.fetch(e,{method:"POST",credentials:"include",headers:{"Content-Type":"application/json"},body:JSON.stringify(t)}).then((function(e){if(200===e.status)return i?e.arrayBuffer():e.json();throw new Error("Invalid response status "+e.status)})).then(n,r);else{var o=new XMLHttpRequest;o.open("POST",e),o.withCredentials=!0,i&&(o.responseType="arraybuffer"),o.setRequestHeader("Content-Type","application/json"),o.onreadystatechange=function(){if(o.readyState===XMLHttpRequest.DONE)if(200===o.status)if(i)n(o.response);else try{n(JSON.parse(o.responseText))}catch(e){r(new Error("Parse response error"))}else r(new Error("Invalid response status "+o.status))},o.onerror=function(){r(new Error("Request error"))},o.send(JSON.stringify(t))}}var he={},ve=1,we={};function ye(e,t){var n=""+ve++;pe(he,n,t),function(e,t){var n=f(),r=d+"/wwopen/openData/getOpenData?f=json&r="+n;S("[fetchData] begin #"+t+" ("+n+")");var i=F||(F=se.importKey("raw",function(e){for(var t=le(I,"Uint8Array","direct"),n=le(I,"parseInt","direct"),r=L(le(W,"String.prototype.substring")),i=new t(e.length/2),o=0,a=e.length;o<a;o+=2)i[o/2]=n(r(e,o,o+2),16);return i}("f94cc0285099944ad6068cf51eab70687aaf45dcd4efb85620b26a36eed573bb"),"AES-CBC",!1,["decrypt"]));function o(r){C("[fetchData] fetch fail #"+t,e,r),ge(t,{items:[]}),O("error",{errMsg:"wwapp.fetchOpenData:fail",rand:n})}!function(e,t,n,r){de(e,t,n,r,!0)}(r,{items:e,sid:u},(function(n){S("[fetchData] fetch res #"+t),i.then((function(e){return se.decrypt({name:"AES-CBC",iv:new Uint8Array(16)},e,n)})).then(ce).then((function(n){S("[fetchData] fetch parsed #"+t+" "+JSON.stringify(e)),ge(t,n)})).catch(o)}),o)}(e,n)}function ge(e,t){var n=fe(he,e);if(delete he[e],n)if(t){var r=fe(t,"items");r?(K(r,(function(e){var t=fe(e,"type"),n=fe(e,"id"),r=fe(e,"corpid");pe(we,be(t,n,r),e)})),n(null,t)):n(new Error("Fetch data failed, missing items"))}else n(new Error("Fetch data failed, missing response"))}function me(e,t,n){return fe(we,be(e,t,n))}function be(e,t,n){return e+"::"+t+"::"+(n||"")}var xe=new Image,Ee=!1,Oe=null,_e=[];function Se(){var e=_e;_e=[],K(e,(function(e){e(Oe)}))}Z(xe,"load",(function(){Ee=!0,U(Se,1)})),Z(xe,"error",(function(){Oe=new Error("Failed to load crossorigin image"),U(Se,1)})),G(xe,"https://wwcdn.weixin.qq.com/node/wework/images/1x1-00000000.91e42db1c6.png");var Ce=String.fromCharCode(8204),Ae=String.fromCharCode(8205),je=String.fromCharCode(8203),De=[String.fromCharCode(8206),String.fromCharCode(8207),Ce,Ae,je],Te={},ke=0;function Pe(e){var t=fe(e,"encrypt_token");if(t)return t;var n=fe(e,"data"),r=fe(e,"encrypt_text_data");if(n&&r){for(var i=(ke++).toString(5),o="",a=0,u=i.length;a<u;a++)o+=De[i[a]];var c="\ufeff"+r+o+"\ufeff";return pe(Te,c,n),pe(e,"encrypt_token",c),c}}function Re(e){var t=V(e,"\ufeff",0);if(-1===t)return e;for(var n=X(e,0,t);-1!==t;){var r=V(e,"\ufeff",t+1);if(-1===r)break;var i=fe(Te,X(e,t,r+1));i?(n+=i,t=r+1):(n+=X(e,t,r),t=r)}return n+X(e,t)}var Me=re&&new re,Fe=!1,Ne=!1;function We(e){ie(Me,e)||(Ne||ee(e,xe,0,0),oe(Me,e,!0))}function Ie(e,t){var n=null;try{n=Q(e)}catch(e){}if(null!==n)throw new Error("Missing cross origin");Y(e).postMessage(t,d)}var qe,Le,Je=function(){function e(){var e=this;this.iframe=document.createElement("iframe"),this.state="loading",this.queue=[],this.timeout=null,this.iframe.onload=_("MainFrame.onload",(function(){S("[MainFrame] onload"),e.state="ready",e.fetchData()})),this.iframe.onerror=function(t){A((null==t?void 0:t.error)||new Error("MainFrame load error"),"MainFrame.onerror"),e.state="error"},this.iframe.style.display="none",this.iframe.referrerPolicy="origin",this.iframe.src=h}var t=e.prototype;return t.enqueueFetch=function(e){var t=this;this.queue.push(e),this.timeout||(this.timeout=setTimeout(_("MainFrame.timeout",(function(){"ready"===t.state&&t.fetchData()})),20))},t.fetchData=function(){var e={},t=[];this.queue.forEach((function(n){var r=n.type+"::"+n.id+"::"+(n.corpid||"");e[r]||(e[r]=!0,t.push(n))})),t.length&&(this.timeout=null,this.queue=[],S("[MainFrame] fetchData"),Ie(this.iframe,JSON.stringify({type:"fetch",items:t,sid:u})))},e}(),ze=["fontFamily","fontSize","fontWeight","fontStyle","fontVariant","fontStretch","fontSizeAdjust","color","cursor"],He=function(){function e(e,t){this.renderType="emtpy",this.renderEl=null,this.container=e,this.mainFrame=t}var t=e.prototype;return t.update=function(){var e=this.getItem();if(!e.type||!e.id)return this.renderEmpty();this.renderText(e)},t.renderEmpty=function(){this.setChild("empty")},t.renderText=function(e){var t=this;if("frame"!==this.renderType||"error"===this.loadState){var n=document.createElement("iframe");n.onload=_("Frame.onload",(function(){t.renderEl===n&&(t.loadState="ready",t.notifyUpdate())})),n.onerror=function(e){t.renderEl===n&&(A((null==e?void 0:e.error)||new Error("Frame load error"),"Frame.onerror"),t.loadState="error")};var r=l(e.type+"::"+e.id+"::"+(e.corpid||""));n.frameBorder=0,n.referrerPolicy="origin",n.src=h+"&init="+r,this.loadState="loading",this.setChild("frame",n)}this.mainFrame.enqueueFetch(e),"ready"===this.loadState&&this.notifyUpdate(e)},t.setChild=function(e,t){void 0===t&&(t=null);for(var n=this.container;n.firstChild;)n.removeChild(n.firstChild);t&&n.appendChild(t),this.renderEl=t,this.renderType=e},t.getItem=function(){return{type:this.container.getAttribute("type"),id:this.container.getAttribute("openid"),corpid:this.container.getAttribute("corpid")}},t.notifyUpdate=function(e){if(void 0===e&&(e=this.getItem()),e.type&&e.id){var t={},n=getComputedStyle(this.container);ze.forEach((function(e){t[e]=n[e]})),Ie(this.renderEl,JSON.stringify({type:"update",item:e,style:t}))}},e}();function Ue(e){e&&(e.__WW_OPENDATA_RENDER__||(e.__WW_OPENDATA_RENDER__=new He(e,qe)),e.__WW_OPENDATA_RENDER__.update())}var Be={};function Ke(e){if(e.origin===d){var t,n,r;try{t=JSON.parse(e.data)}catch(e){}t&&Be[t.type]&&(n=document.querySelectorAll("ww-open-data iframe"),r=function(n){n.contentWindow===e.source&&Be[t.type](e,t,n)},Array.prototype.forEach.call(n,r))}}Be["ww.opendata.event"]=function(e,t,n){"click"===t.eventType&&n.parentNode.click()},Be["ww.opendata.resize"]=function(e,t,n){var r=t.size;n.style.width=r.width,n.style.height=r.height,O("update",{el:n.parentNode,hasData:!!r.width})};var Ve=re&&new re;function Xe(e){var t=ie(Ve,e);if(t)return t;try{var n=ae(e,{mode:"closed"});return oe(Ve,e,n),n}catch(e){O("error",e)}}var Ge=[],Ye=null;function Qe(e){if(e&&e.getAttribute){var t=e.getAttribute("type");if(t){var n=e.getAttribute("openid");if(n){var r=e.getAttribute("corpid"),i=Xe(e);if(i){var o=me(t,n,r);if(o){var a=fe(o,"data");if(ue(i,a||""),O("update",{element:e,hasData:!!a}),a)return}Ge.indexOf(e)<0&&Ge.push(e),Ye||(Ye=setTimeout(_("bindPending",Ze),20))}}}}}function Ze(){var e=Ge;Ye=null,Ge=[];var t=[],n={};K(e,(function(e){var r=e.getAttribute("type");if(r){var i=e.getAttribute("openid");if(i){var o=e.getAttribute("corpid"),a=be(r,i,o);n[a]||(n[a]=!0,t.push({type:r,id:i,corpid:o}))}}})),t.length&&ye(t,(function(t){t?O("error",t):K(e,(function(e){var t=Xe(e),n=e.getAttribute("type");if(n){var r=e.getAttribute("openid");if(r){var i=me(n,r,e.getAttribute("corpid"));if(i){var o=fe(i,"data");ue(t,o||""),O("update",{element:e,hasData:!!o})}}}}))}))}var $e=0;ae||($e|=1),se||($e|=2),"http:"===document.location.protocol&&($e|=4);var et,tt=0,nt=navigator.userAgent,rt=/miniProgram/i.test(nt)||"miniprogram"===window.__wxjs_environment;/wxwork/i.test(nt)&&!rt&&(tt|=4),(null==(et=window.wx)?void 0:et.agentConfig)&&(tt|=2),window.WeixinSandBox&&!rt&&(tt|=1);var it=_("bind",$e?Ue:Qe),ot=_("bindAll",$e?function(e){Array.prototype.forEach.call(e,Ue)}:function(e){K(e,Qe)});function at(e){if(void 0===e&&(e={}),!(e.corpid&&e.agentid&&e.timestamp&&e.nonceStr&&e.signature&&e.jsApiList)){var t={err_Info:"fail",errMsg:"agentConfig:fail",hint:"Missing params"};return null==e.fail||e.fail(t),void(null==e.complete||e.complete(t))}var n={corpid:e.corpid+"",agentid:e.agentid+"",timestamp:e.timestamp+"",nonceStr:e.nonceStr+"",signature:e.signature+"",jsApiList:e.jsApiList,url:window.location.href};ut("agentConfig",{config:n,sid:u},e,(function(){ot(document.querySelectorAll("ww-open-data")),S("[user config] #"+JSON.stringify(n))}))}function ut(e,t,n,r){void 0===n&&(n={}),void 0===r&&(r=s);var i=f();S("[invoke] "+e+" begin #"+i),function(e,t,n,r){de(e,t,n,r,!1)}(d+"/wwopen/openData/"+e+"?f=json",t,(function(t){var o=t.data||{errMsg:e+":fail"};o.errMsg===e+":ok"?(S("[invoke] "+e+" succ #"+i),r(o),null==n.success||n.success(o)):(C("[invoke] "+e+" fail #"+i),null==n.fail||n.fail(o)),null==n.complete||n.complete(o)}),(function(t){C("[invoke] "+e+" fail #"+i,t);var r={errMsg:e+":fail"};null==n.fail||n.fail(r),null==n.complete||n.complete(r)}))}if(!tt){if(S("[renderer] #"+$e),$e&&function(){window.addEventListener?window.addEventListener("message",_("dispatchMessage",Ke)):window.attachEvent("onmessage",_("dispatchMessage",Ke));var e=document.querySelector("head");Le=document.createElement("style"),e.appendChild(Le),qe=new Je,e.appendChild(qe.iframe);var t=Le.sheet;t.insertRule("ww-open-data {\n    display: inline-block;\n    vertical-align: text-bottom;\n    overflow: hidden;\n  }",0),t.insertRule("ww-open-data img {\n    display: block;\n    width: 100%;\n    height: 100%;\n  }",1),t.insertRule("ww-open-data iframe {\n    display: block;\n    width: 0;\n    height: 0;\n  }",2)}(),window.wx&&window.wx.agentConfig,window.wx||(window.wx={}),window.wx.agentConfig||H(window.wx,"agentConfig",{value:_("agentConfig",at)}),!window.WWOpenData){var ct={};H(ct,"bindAll",{value:ot,enumerable:!0}),H(ct,"bind",{value:it,enumerable:!0}),H(ct,"on",{value:x,enumerable:!0}),H(ct,"once",{value:function(e,t){x(e,(function e(n){E("name",e),t(n)}))},enumerable:!0}),H(ct,"off",{value:E,enumerable:!0}),H(ct,"report",{value:function(){y("Sentry report"),m()},enumerable:!0}),H(ct,"checkSession",{value:function(e){void 0===e&&(e={}),ut("checkSession",{sid:u},e)},enumerable:!0}),H(ct,"initCanvas",{value:function(){var e;if(Fe)return!0;var t=null==(e=window.CanvasRenderingContext2D)?void 0:e.prototype;return!!t&&(t.strokeText=function(e,t,n,r){if(!Ee)return null==r?te(this,e,t,n):te(this,e,t,n,r);var i=Re(e);return i!==e&&We(this),null==r?te(this,i,t,n):te(this,i,t,n,r)},t.fillText=function(e,t,n,r){if(!Ee)return null==r?$(this,e,t,n):$(this,e,t,n,r);var i=Re(e);return i!==e&&We(this),null==r?$(this,i,t,n):$(this,i,t,n,r)},t.measureText=function(e){return ne(this,Ee?Re(e):e)},Fe=!0,!0)},enumerable:!0}),H(ct,"enableCanvasSharing",{value:function(){Ne=!0},enumerable:!0}),H(ct,"disableCanvasSharing",{value:function(){Ne=!1},enumerable:!0}),H(ct,"prefetch",{value:function(e,t){var n=e.items;ye(n,(function(e){if(e)return t(e);var r=[];K(n,(function(e){var t=me(e.type,e.id,e.corpid);t&&1===fe(t,"datakind")&&r.push({type:e.type,id:e.id,corpid:e.corpid,data:Pe(t)})})),function(e){Ee?e():Oe?e(Oe):_e.push(e)}((function(e){e?t(e):t(null,{items:r})}))}))},enumerable:!0}),H(ct,"__version__",{value:c}),H(ct,"agentConfig",{value:_("agentConfig",at)}),H(window,"WWOpenData",{value:ct,enumerable:!0})}if("customElements"in window&&!customElements.get("ww-open-data"))try{var lt=function(e){var n,r,i,o;function a(){var t;return st(function(e){if(void 0===e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return e}(t=e.call(this)||this)),t}return r=e,(n=a).prototype=Object.create(r.prototype),n.prototype.constructor=n,n.__proto__=r,a.prototype.attributeChangedCallback=function(){this._current.type===this.getAttribute("type")&&this._current.id===this.getAttribute("openid")&&this._current.corpid===this.getAttribute("corpid")||st(this)},i=a,o=[{key:"observedAttributes",get:function(){return["type","openid","corpid"]}}],null&&t(i.prototype,null),o&&t(i,o),a}(a(HTMLElement));customElements.define("ww-open-data",lt)}catch(g){A(g,"register custom element")}}function st(e){e._current={type:e.getAttribute("type"),id:e.getAttribute("openid"),corpid:e.getAttribute("corpid")},it(e)}}catch(g){e.captureException(g,"?")}}();